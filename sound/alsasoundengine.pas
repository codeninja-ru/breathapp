unit AlsaSoundEngine;

{$mode ObjFPC}{$H+}
{$DEFINE DYNAMIC_LINK_ALL}

interface

uses
  Classes, SysUtils, SoundWave, SoundEngine
  {$IFDEF UNIX}
  , DynLibs
  {$ENDIF}
  ;

type
  { TAlsaSoundEngine }

  TAlsaSoundEngine = class(ISoundEngine)
  private
    FGenerator: TBeepWaveGenerator;
  private
  const
    DEVICE_CHANNELS   = 2;
    DEVICE_SAMPLE_RATE = 48000;
    DEVICE_BITS       = 16;
    AMPLITUDE         = 30000;
  protected
    function AlsaOpenDevice: Pointer;
    procedure AlsaCloseDevice(FPcm: Pointer);
    procedure AlsaWriteFrames(FPcm: Pointer; const Frames: PSmallInt; FrameCount: SizeInt);
    procedure GenerateBuffer(AFreq: Integer; out Buf: PSmallInt; out Frames: SizeInt);
  public
    // ISoundEngine
    procedure Open;
    procedure Close;
    procedure Play(AFreq: Integer);
    class function IsSupported: Boolean; static;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$IFDEF UNIX}

const
  // stream
  SND_PCM_STREAM_PLAYBACK = 0;
  // mode
  SND_PCM_NONBLOCK = $0001;

  // format
  SND_PCM_FORMAT_S16_LE = 2;

  // access
  SND_PCM_ACCESS_RW_INTERLEAVED = 3;

  libname = 'asound';

type
  snd_pcm_sframes_t = NativeInt;

function snd_pcm_open(var pcm: Pointer; name: PChar; stream: Integer; mode: Integer): Integer; cdecl; external libname;
function snd_pcm_close(pcm: Pointer): Integer; cdecl; external libname;
function snd_pcm_prepare(pcm: Pointer): Integer; cdecl; external libname;
function snd_pcm_drain(pcm: Pointer): Integer; cdecl; external libname;
function snd_pcm_writei(pcm: Pointer; buffer: Pointer; size: NativeUInt): snd_pcm_sframes_t; cdecl; external libname;
function snd_pcm_set_params(pcm: Pointer; format: Integer; access: Integer;
  channels: Cardinal; rate: Cardinal; soft_resample: Integer; latency: Cardinal): Integer; cdecl; external libname;
function snd_strerror(errnum: Integer): PChar; cdecl; external libname;
function snd_pcm_drop(pcm: Pointer): Integer; cdecl; external libname;
function snd_pcm_recover(pcm: Pointer; err: Integer; silent: Integer): Integer; cdecl; external libname;
{$ENDIF}

procedure RaiseAlsaError(const Msg: string; Err: Integer);
begin
  {$IFDEF UNIX}
  raise Exception.CreateFmt('%s (ALSA err=%d: %s)', [Msg, Err, StrPas(snd_strerror(Err))]);
  {$ELSE}
  raise Exception.Create(Msg);
  {$ENDIF}
end;

{ TAlsaSoundEngine }

function TAlsaSoundEngine.AlsaOpenDevice: Pointer;
var
  rc: Integer;
  latencyUs: Cardinal;
begin
  Result := nil;

  rc := snd_pcm_open(Result, PChar('default'), SND_PCM_STREAM_PLAYBACK, 0);
  if rc < 0 then
    RaiseAlsaError('Could not open ALSA device "default"', rc);

  latencyUs := 100000;

  rc := snd_pcm_set_params(
          Result,
          SND_PCM_FORMAT_S16_LE,
          SND_PCM_ACCESS_RW_INTERLEAVED,
          DEVICE_CHANNELS,
          DEVICE_SAMPLE_RATE,
          1 {soft_resample},
          latencyUs
        );
  if rc < 0 then
    RaiseAlsaError('Could not set ALSA params', rc);
end;

procedure TAlsaSoundEngine.AlsaCloseDevice(FPcm: Pointer);
var
  rc: Integer;
begin
    rc := snd_pcm_close(FPcm);
    if rc < 0 then
      RaiseAlsaError('ALSA close failed', rc);
end;

procedure TAlsaSoundEngine.AlsaWriteFrames(FPcm: Pointer; const Frames: PSmallInt; FrameCount: SizeInt);
var
  written, left: snd_pcm_sframes_t;
  p: PSmallInt;
  rc: Integer;
begin
  if FPcm = nil then
    raise Exception.Create('ALSA device is not open');

  rc := snd_pcm_prepare(FPcm);
  if rc < 0 then
    RaiseAlsaError('ALSA prepare failed', rc);

  p := Frames;
  left := FrameCount;

  while left > 0 do
  begin
    written := snd_pcm_writei(FPcm, p, left);
    if written < 0 then
    begin
      rc := snd_pcm_prepare(FPcm);
      if rc < 0 then
        RaiseAlsaError('ALSA recover (prepare) failed', rc);
      continue;
    end;

    Inc(p, written * DEVICE_CHANNELS);
    Dec(left, written);
  end;

  rc := snd_pcm_drain(FPcm);
  if rc < 0 then
    RaiseAlsaError('ALSA drain failed', rc);
end;


procedure TAlsaSoundEngine.GenerateBuffer(AFreq: Integer; out Buf: PSmallInt; out Frames: SizeInt);
var
  totalFrames, i, ch: SizeInt;
  val: SmallInt;
  data: PSmallInt;
begin
  totalFrames := (DEVICE_SAMPLE_RATE * FGenerator.SoundTimeMs) div 1000;
  Frames := totalFrames;

  GetMem(data, totalFrames * DEVICE_CHANNELS * SizeOf(SmallInt));

  for i := 0 to totalFrames - 1 do
  begin
    val := SmallInt(Round(AMPLITUDE * FGenerator.GetDataForFrame(i, AFreq)));
    for ch := 0 to DEVICE_CHANNELS - 1 do
      data[i * DEVICE_CHANNELS + ch] := val;
  end;

  Buf := data;
end;

procedure TAlsaSoundEngine.Open;
begin

end;

procedure TAlsaSoundEngine.Close;
begin

end;

procedure TAlsaSoundEngine.Play(AFreq: Integer);
var
  buf: PSmallInt = nil;
  frames: SizeInt = 0;
  pcm: Pointer;
begin
  pcm := AlsaOpenDevice;
  GenerateBuffer(AFreq, buf, frames);
  try
    AlsaWriteFrames(pcm, buf, frames);
  finally
    if buf <> nil then FreeMem(buf);
  end;
  AlsaCloseDevice(pcm);
end;

class function TAlsaSoundEngine.IsSupported: Boolean;
{$IFDEF UNIX}
var
  dyn_snd_pcm_open: function(var pcm: Pointer; name: PChar; stream: Integer; mode: Integer): Integer; cdecl;
  LibHandle: TLibHandle;
{$ENDIF}
begin
{$IFDEF UNIX}
  LibHandle := LoadLibrary(libname);
  if LibHandle = nil then Exit(False);
  Pointer(dyn_snd_pcm_open) := GetProcedureAddress(LibHandle, 'snd_pcm_open');
  if not Assigned(dyn_snd_pcm_open) then Exit(False);
  Result := True;
{$ELSE}
  Result := False;
{$ENDIF}
end;

constructor TAlsaSoundEngine.Create;
begin
  if not TAlsaSoundEngine.IsSupported then
    raise Exception.Create('ALSA is not supported on this platform');

  FGenerator := TBeepWaveGenerator.Create(DEVICE_SAMPLE_RATE);
end;

destructor TAlsaSoundEngine.Destroy;
begin
  FreeAndNil(FGenerator);
  inherited Destroy;
end;

end.

