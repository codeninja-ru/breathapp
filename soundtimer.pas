unit SoundTimer;

{$mode ObjFPC}{$H+}

interface

uses
  Forms,
  Classes,
  SysUtils,
  states,
  Math,
  MiniaudioSoundEngine
  {$IFDEF DARWIN},CoreAudioSoundEngine{$ENDIF};

type
  { TSoundTimer }

  TSoundTimer = class
  private
    FEngine: TMiniaudioSoundEngine;
    FBeepSound: TMiniaudioBeepSound;
    prevSeconds: integer;
    {$IFDEF DARWIN}FCoreAudioEngine: TCoreAudioSoundEngine;{$ENDIF}

    procedure PlaySound(freq: integer);
    function mtof(m: integer): integer;
  public
    constructor Create;
    destructor Destroy;

    procedure PlayEverySecond(State: TState);
    procedure StartDevice;
    procedure StopDevice;
  end;

implementation


constructor TSoundTimer.Create;
begin
  inherited Create;

  {$IFDEF DARWIN}FCoreAudioEngine:=TCoreAudioSoundEngine.Create;
  {$ELSE}
  FEngine := TMiniaudioSoundEngine.Create;
  FBeepSound := TMiniaudioBeepSound.Create(FEngine);
  {$ENDIF}
end;

destructor TSoundTimer.Destroy;
begin
  {$IFDEF DARWIN}
  FreeAndNil(FCoreAudioEngine);
  {$ELSE}
  FreeAndNil(FBeepSound);
  FreeAndNil(FEngine);
  {$ENDIF}
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
          PlaySound(mtof(Round(64 + ((90 - 64) / (State.MaxMSec div 1000)) *
            State.Seconds)));
        stBreathOut:
          PlaySound(mtof(Round(60 - ((60 - 40) / (State.MaxMSec div 1000)) *
            State.Seconds)));
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

procedure TSoundTimer.StartDevice;
begin
  {$IFDEF DARWIN}
  FCoreAudioEngine.Start;
  {$ENDIF}
end;

procedure TSoundTimer.StopDevice;
begin
  {$IFDEF DARWIN}
  FCoreAudioEngine.Stop;
  {$ENDIF}
end;

procedure TSoundTimer.PlaySound(freq: integer);
begin
  {$IFDEF DARWIN}
  FCoreAudioEngine.Play(freq);
  {$ELSE}
  if not FBeepSound.IsPlaying then
  begin
    FBeepSound.Frequency := freq;
    FBeepSound.Play();
  end;
  {$ENDIF}


end;

function TSoundTimer.mtof(m: integer): integer;
begin
  Result := Round(440 * power(2, (m - 69) / 12));
end;

end.
