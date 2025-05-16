unit SoundWave;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TBeepWaveGenerator = class
  private
  const
    ATTACK = 37;
    DECAY = 12;
    SUSTAIN = 50;
    Release = 37;
    AMPLITUDE = 0.5;
    NOTE_TIME = ATTACK + DECAY + SUSTAIN + Release;
  private
    FDeviceSampleRate: integer;
    FFramesInMsec: integer;
  public
    constructor Create(ADeviceSampleRate: integer);
    destructor Destroy;

    function IsPlaying(ACursor: integer): boolean;
    function GetDataForFrame(const ACursor: integer; const AFreq: integer): single;
  end;

implementation

{ TBeepWaveGenerator }

constructor TBeepWaveGenerator.Create(ADeviceSampleRate: integer);
begin
  FDeviceSampleRate := ADeviceSampleRate;
  FFramesInMsec := ADeviceSampleRate div 1000;
end;

destructor TBeepWaveGenerator.Destroy;
begin

end;

function TBeepWaveGenerator.IsPlaying(ACursor: integer): boolean;
begin
  Result := ACursor <= (ATTACK + DECAY + SUSTAIN + Release) * FFramesInMsec;
end;

function TBeepWaveGenerator.GetDataForFrame(const ACursor: integer;
  const AFreq: integer): single;
var
  framesInOsc: integer;
  Value, volume, time: single;
begin
  framesInOsc := FDeviceSampleRate div AFreq;
  time := ACursor / FFramesInMsec;

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

  if (time >= ATTACK + DECAY + SUSTAIN) and (time <= ATTACK +
    DECAY + SUSTAIN + Release) then
  begin
    volume := (-0.5 / Release) * time + 0.5 + (0.5 / Release) *
      (ATTACK + DECAY + SUSTAIN);
  end;

  if time > ATTACK + DECAY + SUSTAIN + Release then
  begin
    volume := 0;
  end;

  Value := sin(2 * Pi * (ACursor mod framesInOsc) / framesInOsc) * AMPLITUDE;

  Result := Value * volume;
end;

end.
