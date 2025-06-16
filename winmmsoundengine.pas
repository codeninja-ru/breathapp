unit WinMMSoundEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils, SoundEngine, Windows, MMSystem, SoundWave;

type

  { TWinMMSoundEngine }

  TWinMMSoundEngine = class(ISoundEngine)
  private
    FGenerator: TBeepWaveGenerator;
    FWaveFormat: TWAVEFORMATEX;
    FWaveOut: HWAVEOUT;
  private
  const
    DEVICE_CHANNELS = 2;
    DEVICE_SAMPLE_RATE = 48000; // number of pcm frames that are procesed per second
    DEVICE_BITS = 16;
    AMPLITUDE = 30000;
  public
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    class function IsSupported: boolean; static;

    constructor Create;
    destructor Destroy;
  end;

implementation

procedure WaveOutCallback(hwo: HWAVEOUT; uMsg: UINT;
  dwInstance, dwParam1, dwParam2: DWORD); stdcall;
var
  pHdr: PWaveHdr;
  code: integer;
begin
  if uMsg = WOM_DONE then
  begin
    pHdr := PWaveHdr(dwParam1);
    code := waveOutUnprepareHeader(hwo, pHdr, SizeOf(TWAVEHDR));
    if code <> MMSYSERR_NOERROR then
      raise Exception.CreateFmt('Cound Not clean up waveOut header. ErrorCode = %s', [IntToHex(code)]);
    FreeMem(pHdr^.lpData);
    Dispose(pHdr);
  end;
end;

{ TWinMMSoundEngine }

procedure TWinMMSoundEngine.Open;
begin
  FillChar(FWaveFormat, SizeOf(FWaveFormat), 0);
  FWaveFormat.wFormatTag := WAVE_FORMAT_PCM;
  FWaveFormat.nChannels := DEVICE_CHANNELS;
  FWaveFormat.nBlockAlign := DEVICE_CHANNELS * DEVICE_BITS div 8;
  FWaveFormat.nSamplesPerSec := DEVICE_SAMPLE_RATE;
  FWaveFormat.nAvgBytesPerSec := DEVICE_SAMPLE_RATE * FWaveFormat.nBlockAlign;
  FWaveFormat.wBitsPerSample := DEVICE_BITS;
  FWaveFormat.cbSize := 0;

  if waveOutOpen(@FWaveOut, WAVE_MAPPER, @FWaveFormat, DWORD(@WaveOutCallback),
    0, CALLBACK_FUNCTION) <> MMSYSERR_NOERROR then
    raise Exception.Create('Could Not open sound device');

end;

procedure TWinMMSoundEngine.Close;
begin
  if waveOutClose(FWaveOut) <> MMSYSERR_NOERROR then
    raise Exception.Create('Cound Not close waveOut device');
end;

procedure TWinMMSoundEngine.Play(AFreq: integer);
var
  sampleCount, i, ch: integer;
  val: smallint;
  pHeader: PWaveHdr;
  pBuffer: PSmallInt;
begin
  New(pHeader);
  FillChar(pHeader^, sizeof(TWaveHdr), 0);
  sampleCount := DEVICE_SAMPLE_RATE * FGenerator.SoundTimeMs div 100;
  GetMem(pBuffer, DEVICE_CHANNELS * sampleCount * sizeof(smallint));

  for i := 0 to sampleCount - 1 do
  begin
    val := smallint(Round(AMPLITUDE * FGenerator.GetDataForFrame(i, AFreq)));
    for ch := 0 to DEVICE_CHANNELS - 1 do
      pBuffer[i * DEVICE_CHANNELS + ch] := val;
  end;

  pHeader^.lpData := PChar(pBuffer);
  pHeader^.dwBufferLength := sampleCount * SizeOf(smallint);
  pHeader^.dwFlags := 0;

  if waveOutPrepareHeader(FWaveOut, pHeader, SizeOf(pHeader^)) <> MMSYSERR_NOERROR then
    raise Exception.Create('Cound Not prepare waveOut header');
  if waveOutWrite(FWaveOut, pHeader, SizeOf(pHeader^)) <> MMSYSERR_NOERROR then
    raise Exception.Create('Cound Not write waveOut header');
end;

class function TWinMMSoundEngine.IsSupported: boolean;
begin
  {$IFDEF WINDOWS}
  Result := true;
  {$ELSE}
  Result := False;
  {$ENDIF}

end;

constructor TWinMMSoundEngine.Create;
begin
  FGenerator := TBeepWaveGenerator.Create(DEVICE_SAMPLE_RATE);
end;

destructor TWinMMSoundEngine.Destroy;
begin
  FreeAndNil(FGenerator);
end;

end.
