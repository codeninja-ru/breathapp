unit AlsaSoundEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils, Math, SoundEngine, ctypes, asoundlib, SoundWave;

type

  { TAlsaSoundEngine }

  TAlsaSoundEngine = class(ISoundEngine)
  private
  const
    SAMPLE_RATE = 44100;
    CHANNELS = 1;
    //FORMAT = SND_PCM_FORMAT_S16_LE;  // 16-bit PCM, little endian
    PERIOD_FRAMES = 1024;
    BUFFER_SECONDS = 2;
    FREQUENCY = 440.0;  // Гц
  private
    pcmHandle: Psnd_pcm_t;
    hwParams: Psnd_pcm_hw_params_t;
    FGenerator: TBeepWaveGenerator;
    procedure OpenDevice;
    procedure AllocParams;
    procedure SettupParams;
    procedure DrainAndClose;
  public
    class function IsSupported: boolean; static;
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
    destructor Destroy;
  end;

implementation

{ TAlsaSoundEngine }

procedure TAlsaSoundEngine.AllocParams;
begin
  snd_pcm_hw_params_malloc(@hwParams);
  snd_pcm_hw_params_any(pcmHandle, hwParams);
end;

procedure TAlsaSoundEngine.SettupParams;
var periodSize, avail: snd_pcm_sframes_t;
begin
  snd_pcm_hw_params_set_access(pcmHandle, hwParams,
    SND_PCM_ACCESS_RW_INTERLEAVED);
  snd_pcm_hw_params_set_format(pcmHandle, hwParams, SND_PCM_FORMAT_S16_LE);
  snd_pcm_hw_params_set_rate(pcmHandle, hwParams, SAMPLE_RATE, 0);
  snd_pcm_hw_params_set_channels(pcmHandle, hwParams, CHANNELS);
  snd_pcm_hw_params_set_period_size(pcmHandle, hwParams, periodSize, 0);
  snd_pcm_hw_params(pcmHandle, hwParams);
  snd_pcm_hw_params_free(hwParams);
end;

procedure TAlsaSoundEngine.OpenDevice;
var
  err: cint;
begin
  err := snd_pcm_open(@pcmHandle, 'default', SND_PCM_STREAM_PLAYBACK, 0);
  if err < 0 then
    raise Exception.Create('Alsa error: snd_pcm_open: ' + snd_strerror(err));
end;

procedure TAlsaSoundEngine.DrainAndClose;
begin
  snd_pcm_drain(pcmHandle);
  snd_pcm_close(pcmHandle);
  pcmHandle := nil;
end;

class function TAlsaSoundEngine.IsSupported: boolean;
var h: TLibHandle;
begin
  h := LoadLibrary(libasound);

  Result := h <> NilHandle;
  if h <> NilHandle then FreeAndNil(h);
end;

procedure TAlsaSoundEngine.Open;
begin

end;

procedure TAlsaSoundEngine.Close;
begin

end;

procedure TAlsaSoundEngine.Play(AFreq: integer);
var
  periodSize: snd_pcm_uframes_t = PERIOD_FRAMES;
  bufferFrames: snd_pcm_uframes_t = SAMPLE_RATE * BUFFER_SECONDS;
  buf: array of smallint;
  phase, step: double;
  i, framesToWrite: csize_t;
  err: cint;
begin
  OpenDevice;

  AllocParams;

  SettupParams;

  snd_pcm_prepare(pcmHandle);

  SetLength(buf, bufferFrames);
  step := 2 * Pi * FREQUENCY / SAMPLE_RATE;
  phase := 0.0;
  for i := 0 to High(buf) do
  begin
    buf[i] := Round(32767 * Sin(phase));
    phase += step;
    if phase >= 2 * Pi then phase -= 2 * Pi;
  end;

  // 6. Воспроизводим поток
  i := 0;
  while i < Length(buf) do
  begin
    framesToWrite := Min(csize_t(periodSize), csize_t(Length(buf) - i));
    err := snd_pcm_writei(pcmHandle, @buf[i], framesToWrite);
    if err = -EPIPE then
    begin
      // underrun, переподготовка
      snd_pcm_prepare(pcmHandle);
      Continue;
    end;
    if err < 0 then
    begin
      raise Exception.Create('Alsa: writing error ' + snd_strerror(err));
    end;
    Inc(i, err);
  end;

  DrainAndClose;
end;

constructor TAlsaSoundEngine.Create;
begin
  pcmHandle := nil;
  FGenerator := TBeepWaveGenerator.Create(SAMPLE_RATE);
end;

destructor TAlsaSoundEngine.Destroy;
begin
  if pcmHandle <> nil then Close;
  FreeAndNil(FGenerator);
end;

end.
