unit OssSoundEngine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, BaseUnix, Unix, SoundWave, SoundEngine;

type
  { TOssSoundEngine }

  TOssSoundEngine = class(ISoundEngine)
  private
    FGenerator: TBeepWaveGenerator;
  private
  const
    DEVICE_CHANNELS    = 2;
    DEVICE_SAMPLE_RATE = 48000;
    DEVICE_BITS        = 16;
    AMPLITUDE          = 30000;
  protected
    function OssOpenDevice: cint;
    procedure OssCloseDevice(fd: cint);
    procedure OssWriteFrames(fd: cint; const Frames: PSmallInt; FrameCount: SizeInt);
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

uses
  termio;

const
  SOUND_MIXER_WRITE_VOLUME = $C0044D00;  // не нужен, но пример
  SNDCTL_DSP_RESET   = $00005000;
  SNDCTL_DSP_SYNC    = $00005001;
  SNDCTL_DSP_SETFMT  = $C0045005;
  SNDCTL_DSP_CHANNELS= $C0045006;
  SNDCTL_DSP_SPEED   = $C0045002;

  AFMT_S16_LE = $00000010;

{$ENDIF}

procedure RaiseOssError(const Msg: string);
begin
  raise Exception.Create(Msg + ' (OSS error: ' + SysErrorMessage(fpgeterrno) + ')');
end;

{ TOssSoundEngine }

function TOssSoundEngine.OssOpenDevice: cint;
{$IFDEF UNIX}
var
  fmt, ch, rate: cint;
begin
  Result := fpopen('/dev/dsp', O_WRONLY);
  if Result < 0 then
    RaiseOssError('Could not open /dev/dsp');

  // reset
  if FpIoctl(Result, SNDCTL_DSP_RESET, nil) < 0 then
    RaiseOssError('OSS reset failed');

  // set format (16 bit little endian)
  fmt := AFMT_S16_LE;
  if FpIoctl(Result, SNDCTL_DSP_SETFMT, @fmt) < 0 then
    RaiseOssError('OSS set format failed');

  // channels
  ch := DEVICE_CHANNELS;
  if FpIoctl(Result, SNDCTL_DSP_CHANNELS, @ch) < 0 then
    RaiseOssError('OSS set channels failed');

  // sample rate
  rate := DEVICE_SAMPLE_RATE;
  if FpIoctl(Result, SNDCTL_DSP_SPEED, @rate) < 0 then
    RaiseOssError('OSS set rate failed');
end;
{$ELSE}
begin
  Result := -1;
end;
{$ENDIF}

procedure TOssSoundEngine.OssCloseDevice(fd: cint);
begin
  if fd >= 0 then
    fpclose(fd);
end;

procedure TOssSoundEngine.OssWriteFrames(fd: cint; const Frames: PSmallInt; FrameCount: SizeInt);
var
  bytes: SizeInt;
  written: SizeInt;
begin
  if fd < 0 then
    raise Exception.Create('OSS device is not open');

  bytes := FrameCount * DEVICE_CHANNELS * SizeOf(SmallInt);
  written := fpwrite(fd, Frames, bytes);
  if written <> bytes then
    RaiseOssError('OSS write failed');

  // sync to ensure playback is finished
  if FpIoctl(fd, SNDCTL_DSP_SYNC, nil) < 0 then
    RaiseOssError('OSS sync failed');
end;

procedure TOssSoundEngine.GenerateBuffer(AFreq: Integer; out Buf: PSmallInt; out Frames: SizeInt);
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

procedure TOssSoundEngine.Open;
begin

end;

procedure TOssSoundEngine.Close;
begin

end;

procedure TOssSoundEngine.Play(AFreq: Integer);
var
  buf: PSmallInt = nil;
  frames: SizeInt = 0;
  fd: cint;
begin
  fd := OssOpenDevice;
  GenerateBuffer(AFreq, buf, frames);
  try
    OssWriteFrames(fd, buf, frames);
  finally
    if buf <> nil then FreeMem(buf);
    OssCloseDevice(fd);
  end;
end;

class function TOssSoundEngine.IsSupported: Boolean;
begin
  Result := fpAccess('/dev/dsp', W_OK) = 0;
end;

constructor TOssSoundEngine.Create;
begin
  if not TOssSoundEngine.IsSupported then
    raise Exception.Create('OSS is not supported on this platform');
  FGenerator := TBeepWaveGenerator.Create(DEVICE_SAMPLE_RATE);
end;

destructor TOssSoundEngine.Destroy;
begin
  FreeAndNil(FGenerator);
  inherited Destroy;
end;

end.

