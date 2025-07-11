unit DirectSoundSoundEngine;

{$mode ObjFPC}{$H+}
{$DEFINE DYNAMIC_LINK_ALL}

interface

uses
  Classes, SysUtils, Windows, DirectSound, MMSystem, SoundWave, SoundEngine;

type

  { TDirectSoundSoundEngine }

  TDirectSoundSoundEngine = class(ISoundEngine)
  private
    FDs: IDirectSound;
    FDsBufferDesc: TDSBufferDesc;
    FDsBuffer: IDirectSoundBuffer;
    FWaveFormat: TWAVEFORMATEX;
    FGenerator: TBeepWaveGenerator;
  private
  const
    DEVICE_CHANNELS = 2;
    DEVICE_SAMPLE_RATE = 48000; // number of pcm frames that are procesed per second
    DEVICE_BITS = 16;
    AMPLITUDE = 30000;
  protected
    procedure CreateSecondaryBuffer();
    procedure WriteBuffer(AFreq: integer);
    procedure PlayBuffer();
  public
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    class function IsSupported: boolean; static;
    constructor Create;
    destructor Destroy;
  end;

implementation

{ TDirectSoundSoundEngine }

procedure TDirectSoundSoundEngine.CreateSecondaryBuffer;
var
  code: integer;
begin
  // create buffer
  FillChar(FWaveFormat, sizeof(FWaveFormat), 0);
  FWaveFormat.wFormatTag := WAVE_FORMAT_PCM;
  FWaveFormat.nChannels := DEVICE_CHANNELS;
  FWaveFormat.nSamplesPerSec := DEVICE_SAMPLE_RATE;
  FWaveFormat.wBitsPerSample := DEVICE_BITS;
  FWaveFormat.nBlockAlign := DEVICE_CHANNELS * FWaveFormat.wBitsPerSample div 8;
  FWaveFormat.nAvgBytesPerSec := FWaveFormat.nSamplesPerSec * FWaveFormat.nBlockAlign;
  FWaveFormat.cbSize := 0;

  FillChar(FDsBufferDesc, sizeof(FDsBufferDesc), 0);
  FDsBufferDesc.dwSize := sizeof(TDSBufferDesc);
  FDsBufferDesc.dwFlags := DSBCAPS_GLOBALFOCUS;
  FDsBufferDesc.lpwfxFormat := @FWaveFormat;
  FDsBufferDesc.dwBufferBytes :=
    (FWaveFormat.nAvgBytesPerSec * FGenerator.SoundTimeMs) div 1000;
  code := FDs.CreateSoundBuffer(FDsBufferDesc, FDsBuffer, nil);
  if code <> DS_OK then
    raise Exception.CreateFmt('Cound Not create a sound buffer. ErrorCode = %s',
      [IntToHex(code)]);
end;

procedure TDirectSoundSoundEngine.WriteBuffer(AFreq: integer);
var
  p1, p2: PSmallInt;
  pAudioBytes1, pAudioBytes2: DWord;
  i, ch: integer;
  framesPerChannel: integer;
  val: SmallInt;
begin
  if FDsBuffer.Lock(0, FDsBufferDesc.dwBufferBytes, @p1, @pAudioBytes1,
    @p2, @pAudioBytes2, DSBLOCK_ENTIREBUFFER) <> DS_OK then
    raise Exception.Create('Could Not Lock the Buffer');

  // write sound
  framesPerChannel := FDsBufferDesc.dwBufferBytes div (DEVICE_BITS div 8) div
    DEVICE_CHANNELS;
  for i := 0 to framesPerChannel - 1 do
  begin
    val := smallint(Round(AMPLITUDE * FGenerator.GetDataForFrame(i, AFreq)));
    for ch := 0 to DEVICE_CHANNELS - 1 do
    begin
      p1[i * DEVICE_CHANNELS + ch] := val;
    end;
  end;

  if FDsBuffer.Unlock(p1, pAudioBytes1, p2, pAudioBytes2) <> DS_OK then
    raise Exception.Create('Could Not Unock the Buffer');
end;

procedure TDirectSoundSoundEngine.PlayBuffer;
begin
  if FDsBuffer.SetCurrentPosition(0) <> DS_OK then
    raise Exception.Create('Could Not Set Buffer Position');

  if FDsBuffer.Play(0, 0, 0) <> DS_OK then
    raise Exception.Create('Could Not Play the buffer');
end;

procedure TDirectSoundSoundEngine.Open;
begin

end;

procedure TDirectSoundSoundEngine.Close;
begin

end;

procedure TDirectSoundSoundEngine.Play(AFreq: integer);
begin
  WriteBuffer(AFreq);
  PlayBuffer();
end;

class function TDirectSoundSoundEngine.IsSupported: boolean;
begin
  {$IFDEF WINDOWS}
  Result := DirectSoundLoaded() or LoadDirectSound();
  {$ELSE}
  Result := False;
  {$ENDIF}
end;

constructor TDirectSoundSoundEngine.Create;
begin
  if not TDirectSoundSoundEngine.isSupported() then
    raise Exception.Create('DirectSound is not supported');
  if not DirectSoundLoaded() then LoadDirectSound();

  FGenerator := TBeepWaveGenerator.Create(DEVICE_SAMPLE_RATE);

  if DirectSoundCreate(nil, FDs, nil) <> DS_OK then
    raise Exception.Create('Could Not Create Direct Sound Object');

  if Fds.SetCooperativeLevel(GetForegroundWindow(), DSSCL_NORMAL) <> DS_OK then
    raise Exception.Create('Could Not set cooperative level');

  CreateSecondaryBuffer();
end;

destructor TDirectSoundSoundEngine.Destroy;
begin
  if Fds <> nil then FDs._Release;
  if DirectSoundLoaded() then UnLoadDirectSound();

  FreeAndNil(FGenerator);
end;

end.
