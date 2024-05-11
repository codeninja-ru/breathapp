unit SoundTimer;

{$mode ObjFPC}{$H+}

interface

{$DEFINE DEBUG}

uses
  {$IFDEF DEBUG}
  LazLogger,
  {$ENDIF}
  {$ifdef unix}cthreads,{$endif}
  {$ifdef DEBUG}LazLoggerBase,{$ELSE}LazLoggerDummy,{$ENDIF}
  Forms,
  Classes,
  SysUtils,
  states,
  miniaudio,
  Math, MiniaudioSoundEngine;

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
    isPlaying: boolean;
  end;
  PADSREnvelope = ^ADSREnvelope;

  { TSoundTimer }

  TSoundTimer = class
  private
    deviceConfig: ma_device_config;
    device: ma_device;
    envelope: ADSREnvelope;

    prevSeconds: integer;
    isPlaying: boolean;
    playMutex: TRTLCriticalSection;
    stopMutex: TRTLCriticalSection;
    procedure PlaySound(freq: integer);
    function mtof(m: integer): integer;
    procedure WaitAndStopPlaying();
    procedure StopPlaying();
  public
    constructor Create;
    destructor Destroy;

    procedure PlayEverySecond(State: TState);
  end;

implementation

procedure dataCallback(pDevice: Pma_device; pOutput: pointer;
  pInput: pointer; frameCount: ma_uint32); cdecl;
var
  pEnvelope: PADSREnvelope;
  i, iChannel, idx, channelsCount: integer;
  Value, volume, cursor, time, framesInOsc: single;
  Data: Psingle;
begin
  Data := pOutput;
  pEnvelope := pDevice^.pUserData;
  channelsCount := DEVICE_CHANNELS;
  time := pEnvelope^.time;
  cursor := pEnvelope^.cursor;
  framesInOsc := pEnvelope^.freq / DEVICE_SAMPLE_RATE;
  for i := 0 to frameCount - 1 do
  begin

    if time <= ATTACK then
    begin
      volume := (1 / ATTACK) * time;
    end;

    if (time > ATTACK) and (time <= ATTACK + DECAY) then
    begin
      volume := (-0.5 / DECAY) * time + 1 + (0.5 / DECAY) * ATTACK;
    end;

    if (time > ATTACK + DECAY) and (time <= ATTACK + DECAY + SUSTAIN) then
    begin
      volume := 0.5;
    end;

    if (time >= ATTACK + DECAY + SUSTAIN) and (time <= ATTACK + DECAY +
      SUSTAIN + RELEASE) then
    begin
      volume := (-0.5 / RELEASE) * time + 0.5 + (0.5 / RELEASE) *
        (ATTACK + DECAY + SUSTAIN);
    end;

    if time > ATTACK + DECAY + SUSTAIN + RELEASE then
    begin
      volume := 0;
    end;

    for iChannel := 0 to channelsCount - 1 do
    begin
      idx := i * channelsCount + iChannel;

      Value := sin(2 * Pi * cursor) * AMPLITUDE;

      Data[idx] := Value * volume;
    end;

    cursor := cursor + framesInOsc;
    pEnvelope^.cursor := cursor;
    time := time + 1000 / DEVICE_SAMPLE_RATE;
    pEnvelope^.time := time;

  end;
end;

function sleepAndStopFn(soundTimer: pointer): ptrint;
begin
  TSoundTimer(soundTimer).WaitAndStopPlaying();
  Result := 0;
end;


constructor TSoundTimer.Create;
begin
  isPlaying := False;
  prevSeconds := -1;

  envelope.cursor := 0;
  envelope.freq := FREQ;
  envelope.time := 0;

  deviceConfig := ma_device_config_init(ma_device_type_playback);
  deviceConfig.playback.format := ma_format_f32;
  deviceConfig.playback.channels := DEVICE_CHANNELS;
  deviceConfig.sampleRate := DEVICE_SAMPLE_RATE;
  deviceConfig.dataCallback := @dataCallback;
  deviceConfig.pUserData := @envelope;

  if ma_device_init(nil, @deviceConfig, @device) <> MA_SUCCESS then
  begin
    raise Exception.Create('Failed to open playback device.');
  end;

  InitCriticalSection(playMutex);
  InitCriticalSection(stopMutex);

  inherited Create;
end;

destructor TSoundTimer.Destroy;
begin
  StopPlaying;
  DoneCriticalSection(playMutex);
  DoneCriticalSection(stopMutex);
  ma_device_uninit(@device);
end;

procedure TSoundTimer.PlayEverySecond(State: TState);
var
  sec: integer;
begin
  if not isPlaying then
  begin
    DebugLn('PlayEverySecond started');
    EnterCriticalSection(playMutex);
    DebugLn('PlayEverySecond called: sec = ' + IntToStr(State.Seconds) + ' prevSec = ' + IntToStr(prevSeconds) + ' state = ' + State.GetStateText + ' isPlaying = ' + BoolToStr(isPlaying));
    try
      sec := State.Seconds;
      if prevSeconds <> sec then
      begin
        if sec > 0 then
        begin
            case State.StateType of
              stBreathIn:
                PlaySound(mtof(Round(64 + ((90 - 64) / (State.MaxMSec div 1000)) * State.Seconds)));
              stBreathOut:
                PlaySound(mtof(Round(60 - ((60 - 40) / (State.MaxMSec div 1000)) * State.Seconds)));
              stHoldIn: ;
              //PlaySound(100);
              stHoldOut: ;
              //PlaySound(100);
            end;
        end
        else if State.CurrentMSec = State.MaxMSec then
        begin
          // todo
        end;

        prevSeconds := sec;
      end;
    finally
      LeaveCriticalSection(playMutex);
    end;
    DebugLn('PlayEverySecond finished');
  end;
end;

procedure TSoundTimer.WaitAndStopPlaying;
begin
  DebugLn('WaitAndPlaying started, isPlaying = ' + BoolToStr(isPlaying));
  if ma_device_start(@device) <> MA_SUCCESS then
    begin
      ma_device_uninit(@device);
      isPlaying := false;
      raise Exception.Create('Failed to start playback device.');
    end;
  sleep(NOTE_TIME + 50);
  StopPlaying();
  DebugLn('WaitAndPlaying finished');
end;

procedure TSoundTimer.StopPlaying;
begin
  EnterCriticalSection(stopMutex);
  try
    if isPlaying then
    begin
      ma_device_stop(@device);
      isPlaying := False;
    end;
  finally
    LeaveCriticalSection(stopMutex);
  end;
end;

procedure TSoundTimer.PlaySound(freq: integer);
begin
  DebugLn('PlaySound started, isPlaying = ' + BoolToStr(isPlaying) + ' freq = ' + IntToStr(freq));
  if not isPlaying then
  begin
    isPlaying:=True;
    envelope.freq := freq;
    envelope.cursor := 0;
    envelope.time := 0;
    BeginThread(@sleepAndStopFn, Self);
    DebugLn('PlaySound finished');
  end;
end;

function TSoundTimer.mtof(m: integer): integer;
begin
  Result := Round(440 * power(2, (m - 69) / 12));
end;

end.
