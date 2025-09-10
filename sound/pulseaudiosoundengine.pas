unit PulseAudioSoundEngine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SoundWave, SoundEngine
  {$IFDEF UNIX}
  , DynLibs
  {$ENDIF}
  ;

type
  { TPulseAudioSoundEngine }

  TPulseAudioSoundEngine = class(ISoundEngine)
  private
    FGenerator: TBeepWaveGenerator;
  private
  const
    DEVICE_CHANNELS    = 2;
    DEVICE_SAMPLE_RATE = 48000;
    DEVICE_BITS        = 16;
    AMPLITUDE          = 30000;
  protected
    function PulseOpenDevice: Pointer;
    procedure PulseCloseDevice(p: Pointer);
    procedure PulseWriteFrames(p: Pointer; const Frames: PSmallInt; FrameCount: SizeInt);
    procedure GenerateBuffer(AFreq: Integer; out Buf: PSmallInt; out Frames: SizeInt);
  public
    procedure Open;
    procedure Close;
    procedure Play(AFreq: Integer);
    class function IsSupported: Boolean; static;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$IFDEF UNIX}

type
  // минимальное определение структуры pa_sample_spec
  pa_sample_spec = record
    format: Integer;  // используем константы PA_SAMPLE_*
    rate: Cardinal;
    channels: Byte;
    // padding чтобы размер структуры был кратен 4 (безопасно)
    _pad: array[0..2] of Byte;
  end;
  Ppa_sample_spec = ^pa_sample_spec;

  Ppa_simple = Pointer;

const
  PA_STREAM_PLAYBACK = 1;
  PA_SAMPLE_S16LE = 3;

function pa_simple_new(
  server: PChar;
  name: PChar;
  dir: Integer;
  dev: PChar;
  stream_name: PChar;
  const ss: Ppa_sample_spec;
  map: Pointer;
  attr: Pointer;
  var error: Integer
): Ppa_simple; cdecl; external 'pulse-simple';

procedure pa_simple_free(s: Ppa_simple); cdecl; external 'pulse-simple';
function pa_simple_write(s: Ppa_simple; const data: Pointer; bytes: NativeUInt; var error: Integer): Integer; cdecl; external 'pulse-simple';
function pa_simple_drain(s: Ppa_simple; var error: Integer): Integer; cdecl; external 'pulse-simple';

{$ENDIF}

procedure RaisePulseError(const Msg: string; Err: Integer);
begin
  raise Exception.CreateFmt('%s (PulseAudio err=%d)', [Msg, Err]);
end;

{ TPulseAudioSoundEngine }

function TPulseAudioSoundEngine.PulseOpenDevice: Pointer;
{$IFDEF UNIX}
var
  ss: pa_sample_spec;
  err: Integer = 0;
  s: Ppa_simple;
begin
  Result := nil;
  ss.format := PA_SAMPLE_S16LE;
  ss.rate := DEVICE_SAMPLE_RATE;
  ss.channels := DEVICE_CHANNELS;

  // server = nil (default), dev = nil (default device)
  s := pa_simple_new(nil, PChar('PascalApp'), PA_STREAM_PLAYBACK,
                     nil, PChar('beep'), @ss, nil, nil, err);
  if s = nil then
    raise Exception.CreateFmt('PulseAudio: could not open stream (err=%d)', [err]);

  Result := s;
end;
{$ELSE}
begin
  Result := nil;
end;
{$ENDIF}

procedure TPulseAudioSoundEngine.PulseCloseDevice(p: Pointer);
{$IFDEF UNIX}
begin
  if p <> nil then
    pa_simple_free(p);
end;
{$ELSE}
begin
end;
{$ENDIF}

procedure TPulseAudioSoundEngine.PulseWriteFrames(p: Pointer; const Frames: PSmallInt; FrameCount: SizeInt);
{$IFDEF UNIX}
var
  bytes: NativeUInt;
  err: Integer = 0;
  rc: Integer;
begin
  if p = nil then
    raise Exception.Create('PulseAudio stream is not open');

  bytes := FrameCount * DEVICE_CHANNELS * SizeOf(SmallInt);

  rc := pa_simple_write(p, Frames, bytes, err);
  if rc < 0 then
    RaisePulseError('pa_simple_write failed', err);

  rc := pa_simple_drain(p, err);
  if rc < 0 then
    RaisePulseError('pa_simple_drain failed', err);
end;
{$ELSE}
begin
end;
{$ENDIF}

procedure TPulseAudioSoundEngine.GenerateBuffer(AFreq: Integer; out Buf: PSmallInt; out Frames: SizeInt);
var
  totalFrames, i, ch: SizeInt;
  val: SmallInt;
  data: PSmallInt;
begin
  totalFrames := (DEVICE_SAMPLE_RATE * FGenerator.SoundTimeMs) div 1000;
  Frames := totalFrames;

  GetMem(data, totalFrames * DEVICE_CHANNELS * SizeOf(SmallInt));
  try
    for i := 0 to totalFrames - 1 do
    begin
      val := SmallInt(Round(AMPLITUDE * FGenerator.GetDataForFrame(i, AFreq)));
      for ch := 0 to DEVICE_CHANNELS - 1 do
        data[i * DEVICE_CHANNELS + ch] := val;
    end;
  except
    FreeMem(data);
    raise;
  end;

  Buf := data;
end;

procedure TPulseAudioSoundEngine.Open;
begin
  // ничего — открываем в Play
end;

procedure TPulseAudioSoundEngine.Close;
begin
  // ничего — закрываем в Play
end;

procedure TPulseAudioSoundEngine.Play(AFreq: Integer);
var
  buf: PSmallInt = nil;
  frames: SizeInt = 0;
  dev: Pointer;
begin
  dev := PulseOpenDevice;
  GenerateBuffer(AFreq, buf, frames);
  try
    PulseWriteFrames(dev, buf, frames);
  finally
    if buf <> nil then FreeMem(buf);
    PulseCloseDevice(dev);
  end;
end;

class function TPulseAudioSoundEngine.IsSupported: Boolean;
{$IFDEF UNIX}
var
  ss: pa_sample_spec;
  err: Integer = 0;
  s: Ppa_simple;
begin
  ss.format := PA_SAMPLE_S16LE;
  ss.rate := DEVICE_SAMPLE_RATE;
  ss.channels := DEVICE_CHANNELS;

  s := pa_simple_new(nil, PChar('PascalTest'), PA_STREAM_PLAYBACK, nil, PChar('test'), @ss, nil, nil, err);
  if s = nil then
    Exit(False);

  pa_simple_free(s);
  Result := True;
end;
{$ELSE}
begin
  Result := False;
end;
{$ENDIF}

constructor TPulseAudioSoundEngine.Create;
begin
  if not TPulseAudioSoundEngine.IsSupported then
    raise Exception.Create('PulseAudio is not supported or not running');
  FGenerator := TBeepWaveGenerator.Create(DEVICE_SAMPLE_RATE);
end;

destructor TPulseAudioSoundEngine.Destroy;
begin
  FreeAndNil(FGenerator);
  inherited Destroy;
end;

end.

