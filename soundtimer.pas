unit SoundTimer;

{$mode ObjFPC}{$H+}

interface

uses
  {$ifdef unix}cthreads, {$endif}Classes, SysUtils, states, miniaudio;

const
  DEVICE_CHANNELS = 2;
  DEVICE_SAMPLE_RATE = 48000;
  FREQ = 440;

  ATTACK = 37;
  DECAY = 12;
  SUSTAIN = 50;
  RELEASE = 37;
  AMPLITUDE = 0.5;
  NOTE_TIME = ATTACK + DECAY + SUSTAIN + RELEASE;

type
  ADSREnvelope = record
    cursor: single;
    time: single;
    freq: integer;
    pUserData: pointer;
  end;
  PADSREnvelope = ^ADSREnvelope;

  { TSoundTimer }

  TSoundTimer = class
  private
    deviceConfig: ma_device_config;
    device: ma_device;
    envelope: ADSREnvelope;

    prevSeconds: integer;
    procedure PlaySound(freq: integer);
  public
    constructor Create;
    destructor Destroy;

    procedure Play(State: TState);
  end;

implementation

procedure dataCallback(pDevice: Pma_device;
  pOutput: pointer;
  pInput: pointer;
  frameCount: ma_uint32); cdecl;
var pEnvelope: PADSREnvelope;
  i, iChannel, idx, channelsCount: integer;
  value, volume, cursor, time, framesInOsc: single;
  data: Psingle;
begin
  data := pOutput;
  pEnvelope := pDevice^.pUserData;
  channelsCount := DEVICE_CHANNELS;
  time := pEnvelope^.time;
  cursor := pEnvelope^.cursor;
  framesInOsc := pEnvelope^.freq / DEVICE_SAMPLE_RATE;
  for i := 0 to frameCount - 1 do
  begin

    if time <= ATTACK then
    begin
      volume := (1/ATTACK) * time;
    end;

    if (time > ATTACK) and (time <= ATTACK + DECAY) then
    begin
      volume := (-0.5/DECAY) * time + 1 + (0.5/DECAY) * ATTACK;
    end;

    if (time > ATTACK + DECAY) and (time <= ATTACK + DECAY + SUSTAIN) then
    begin
      volume := 0.5;
    end;

    if (time >= ATTACK + DECAY + SUSTAIN) and (time <= ATTACK + DECAY + SUSTAIN + RELEASE) then
    begin
      volume := (-0.5/RELEASE) * time + 0.5 + (0.5 / RELEASE) * (ATTACK + DECAY + SUSTAIN);
    end;

    if time > ATTACK + DECAY + SUSTAIN + RELEASE then
    begin
      volume := 0;
    end;

    for iChannel := 0 to channelsCount - 1 do
    begin
      idx := i * channelsCount + iChannel;

      value := sin(2 * Pi * cursor) * AMPLITUDE;

      data[idx] := value * volume;
    end;

    cursor := cursor + framesInOsc;
    pEnvelope^.cursor := cursor;
    time := time + 1000 / DEVICE_SAMPLE_RATE;
    pEnvelope^.time := time;

  end;
end;

function sleepAndStop(pDevice: pointer): ptrint;
begin
  sleep(NOTE_TIME + 10);
  ma_device_stop(pDevice);

  Result := 0;
end;


constructor TSoundTimer.Create;
begin
  envelope.cursor := 0;
  envelope.freq := FREQ;
  envelope.time := 0;

  deviceConfig := ma_device_config_init(ma_device_type_playback);
  deviceConfig.playback.format   := ma_format_f32;
  deviceConfig.playback.channels := DEVICE_CHANNELS;
  deviceConfig.sampleRate        := DEVICE_SAMPLE_RATE;
  deviceConfig.dataCallback      := @dataCallback;
  deviceConfig.pUserData         := @envelope;

  if ma_device_init(nil, @deviceConfig, @device) <> MA_SUCCESS then
  begin
    raise Exception.Create('Failed to open playback device.');
  end;

  inherited Create;
end;

destructor TSoundTimer.Destroy;
begin
  ma_device_uninit(@device);
end;

procedure TSoundTimer.Play(State: TState);
begin
  if prevSeconds <> State.Seconds then
  begin
    case State.StateType of
      stBreathIn:
        PlaySound(430 + 20 * State.Seconds);
      stBreathOut:
        PlaySound(100 + 20 * State.Seconds);
      stHoldIn: ;
        //PlaySound(100);
      stHoldOut: ;
        //PlaySound(100);
    end;

  end;

  prevSeconds := State.Seconds;
end;

procedure TSoundTimer.PlaySound(freq: integer);
begin
  envelope.freq := freq;
  if ma_device_start(@device) <> MA_SUCCESS then
  begin
    ma_device_uninit(@device);
    raise Exception.Create('Failed to start playback device.');
  end;

  BeginThread(@sleepAndStop, @device);
end;

end.
