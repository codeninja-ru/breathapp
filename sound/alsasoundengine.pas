unit AlsaSoundEngine;

{$mode ObjFPC}{$H+}
{$PACKRECORDS C}

interface

uses
  Classes, SysUtils, SoundWave, SoundEngine, ctypes
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
    DEVICE_CHANNELS = 2;
    DEVICE_SAMPLE_RATE = 48000;
    DEVICE_BITS = 16;
    AMPLITUDE = 30000;
  protected
    function AlsaOpenDevice: Pointer;
    procedure AlsaCloseDevice(FPcm: Pointer);
    procedure AlsaWriteFrames(FPcm: Pointer; const Frames: PSmallInt;
      FrameCount: SizeInt);
    procedure GenerateBuffer(AFreq: integer; out Buf: PSmallInt; out Frames: SizeInt);
  public
    // ISoundEngine
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    class function IsSupported: boolean; static;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$IFDEF UNIX}

type
  // Signed frames quantity
  snd_pcm_sframes_t = cint;

  // PCM handle
  PPsnd_pcm_t = ^Psnd_pcm_t;
  Psnd_pcm_t  = Pointer;

  // PCM stream (direction)
  snd_pcm_stream_t = cint;

  // PCM sample format
  snd_pcm_format_t = cint;

  // PCM access type
  snd_pcm_access_t = cint;

  // Unsigned frames quantity
  snd_pcm_uframes_t = cuint;

const
  // stream
  SND_PCM_STREAM_PLAYBACK: snd_pcm_stream_t = 0;
  // mode
  SND_PCM_NONBLOCK = $0001;

  // format
  SND_PCM_FORMAT_S16_LE = 2;

  // access
  SND_PCM_ACCESS_RW_INTERLEAVED = 3;

  libname = 'libasound.so.2';


var
  snd_pcm_open: function(pcm: PPsnd_pcm_t; Name: PChar; stream: snd_pcm_stream_t; mode: cint): cint; cdecl;
  snd_pcm_set_params: function(pcm: Psnd_pcm_t; format: snd_pcm_format_t; access: snd_pcm_access_t; channels, rate: cuint; soft_resample: cint; latency: cuint): cint; cdecl;
  snd_pcm_writei: function(pcm: Psnd_pcm_t; buffer: Pointer; size: snd_pcm_uframes_t): snd_pcm_sframes_t; cdecl;
  snd_pcm_recover: function(pcm: Psnd_pcm_t; err, silent: cint): cint; cdecl;
  snd_pcm_drain: function(pcm: Psnd_pcm_t): cint; cdecl;
  snd_pcm_close: function(pcm: Psnd_pcm_t): cint; cdecl;
  snd_pcm_prepare: function (pcm: Psnd_pcm_t): Integer; cdecl;
  snd_strerror: function (errnum: Integer): PChar; cdecl;
  snd_pcm_drop: function (pcm: Psnd_pcm_t): Integer; cdecl;
  LibHandle: TLibHandle;
  LibRefCount: integer;

procedure LoadLibraries();
begin
  inc(LibRefCount);
  if LibHandle = NilHandle then
  begin
    LibHandle:=SafeLoadLibrary(libname);
	if LibHandle = 0 then raise Exception.CreateFmt('Could not load Alsa library %s', [libname]);
	Pointer(snd_pcm_open) := GetProcAddress(LibHandle, 'snd_pcm_open');
	Pointer(snd_pcm_close) := GetProcAddress(LibHandle, 'snd_pcm_close');
	Pointer(snd_pcm_prepare) := GetProcAddress(LibHandle, 'snd_pcm_prepare');
	Pointer(snd_pcm_drain) := GetProcAddress(LibHandle, 'snd_pcm_drain');
	Pointer(snd_pcm_writei) := GetProcAddress(LibHandle, 'snd_pcm_writei');
	Pointer(snd_pcm_set_params) := GetProcAddress(LibHandle, 'snd_pcm_set_params');
	Pointer(snd_strerror) := GetProcAddress(LibHandle, 'snd_strerror');
	Pointer(snd_pcm_drop) := GetProcAddress(LibHandle, 'snd_pcm_drop');
	Pointer(snd_pcm_recover) := GetProcAddress(LibHandle, 'snd_pcm_recover');
  end;
end;

procedure FreeLibraries();
begin
  dec(LibRefCount);
  if (LibRefCount = 0) and (LibRefCount <> NilHandle) then FreeLibrary(LibHandle);
end;

{$ENDIF}

procedure RaiseAlsaError(const Msg: string; Err: integer);
begin
  {$IFDEF UNIX}
  raise Exception.CreateFmt('%s (ALSA err=%d: %s)', [Msg, Err, StrPas(snd_strerror(Err))]);
  {$ELSE}
  raise Exception.Create(Msg);
  {$ENDIF}
end;

{ TAlsaSoundEngine }

function TAlsaSoundEngine.AlsaOpenDevice: Pointer;
const
  device = 'default' + #0; // name of sound device
var
  rc: integer;
  latencyUs: cardinal;
  pcm: PPsnd_pcm_t;
begin
  rc := snd_pcm_open(@pcm, @device[1], SND_PCM_STREAM_PLAYBACK, 0);
  if rc < 0 then
    RaiseAlsaError('Could not open ALSA device "default"', rc);

  latencyUs := 100000;

  rc := snd_pcm_set_params(pcm, SND_PCM_FORMAT_S16_LE,
    SND_PCM_ACCESS_RW_INTERLEAVED, DEVICE_CHANNELS, DEVICE_SAMPLE_RATE,
    1 {soft_resample}, latencyUs);
  if rc < 0 then
    RaiseAlsaError('Could not set ALSA params', rc);
  Result := pcm;
end;

procedure TAlsaSoundEngine.AlsaCloseDevice(FPcm: Pointer);
var
  rc: integer;
begin
  rc := snd_pcm_close(FPcm);
  if rc < 0 then
    RaiseAlsaError('ALSA close failed', rc);
end;

procedure TAlsaSoundEngine.AlsaWriteFrames(FPcm: Pointer; const Frames: PSmallInt;
  FrameCount: SizeInt);
var
  written, left: snd_pcm_sframes_t;
  p: PSmallInt;
  rc: integer;
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


procedure TAlsaSoundEngine.GenerateBuffer(AFreq: integer; out Buf: PSmallInt;
  out Frames: SizeInt);
var
  totalFrames, i, ch: SizeInt;
  val: smallint;
  Data: PSmallInt;
begin
  totalFrames := (DEVICE_SAMPLE_RATE * FGenerator.SoundTimeMs) div 1000;
  Frames := totalFrames;

  GetMem(Data, totalFrames * DEVICE_CHANNELS * SizeOf(smallint));

  for i := 0 to totalFrames - 1 do
  begin
    val := smallint(Round(AMPLITUDE * FGenerator.GetDataForFrame(i, AFreq)));
    for ch := 0 to DEVICE_CHANNELS - 1 do
      Data[i * DEVICE_CHANNELS + ch] := val;
  end;

  Buf := Data;
end;

procedure TAlsaSoundEngine.Open;
begin

end;

procedure TAlsaSoundEngine.Close;
begin

end;

procedure TAlsaSoundEngine.Play(AFreq: integer);
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

class function TAlsaSoundEngine.IsSupported: boolean;
  {$IFDEF UNIX}
var
  dyn_snd_pcm_open: function(var pcm: Pointer; name: PChar; stream: Integer; mode: Integer): Integer; cdecl;
  LibHandle: TLibHandle;
  {$ENDIF}
begin
  {$IFDEF UNIX}
  Result := True;
  LibHandle := SafeLoadLibrary(libname);
  if LibHandle = 0 then Exit(False);
  try
    try
      Pointer(dyn_snd_pcm_open) := GetProcedureAddress(LibHandle, 'snd_pcm_open');
      if not Assigned(dyn_snd_pcm_open) then Exit(False);
    except
      Result := False;
    end;
  finally
    FreeLibrary(libHandle);
  end;
  {$ELSE}
  Result := False;
  {$ENDIF}
end;

constructor TAlsaSoundEngine.Create;
begin
  if not TAlsaSoundEngine.IsSupported then
    raise Exception.Create('ALSA is not supported on this platform');
  LoadLibraries();

  FGenerator := TBeepWaveGenerator.Create(DEVICE_SAMPLE_RATE);
end;

destructor TAlsaSoundEngine.Destroy;
begin
  FreeAndNil(FGenerator);
  FreeLibraries();
  inherited Destroy;
end;

end.
