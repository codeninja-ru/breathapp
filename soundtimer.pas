unit SoundTimer;

{$mode ObjFPC}{$H+}

interface

uses
  Forms,
  Classes,
  SysUtils,
  states,
  math,
  MiniaudioSoundEngine;

type
  { TSoundTimer }

  TSoundTimer = class
  private
    FEngine: TMiniaudioSoundEngine;
    FBeepSound: TMiniaudioBeepSound;
    prevSeconds: integer;

    procedure PlaySound(freq: integer);
    function mtof(m: integer): integer;
  public
    constructor Create;
    destructor Destroy;

    procedure PlayEverySecond(State: TState);
  end;

implementation


constructor TSoundTimer.Create;
begin
  FEngine := TMiniaudioSoundEngine.Create;
  FBeepSound := TMiniaudioBeepSound.Create(FEngine);

  inherited Create;
end;

destructor TSoundTimer.Destroy;
begin
  FreeAndNil(FBeepSound);
  FreeAndNil(FEngine);
end;

procedure TSoundTimer.PlayEverySecond(State: TState);
var
  sec: integer;
begin

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

end;

procedure TSoundTimer.PlaySound(freq: integer);
begin
  if not FBeepSound.IsPlaying then
  begin
    FBeepSound.Frequency:=freq;
    FBeepSound.Play();
  end;

end;

function TSoundTimer.mtof(m: integer): integer;
begin
  Result := Round(440 * power(2, (m - 69) / 12));
end;

end.
