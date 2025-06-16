unit SoundTimer;

{$mode ObjFPC}{$H+}
{DEFINE USE_MINIAUDIO}

interface

uses
  Forms,
  Classes,
  SysUtils,
  states,
  Math,
  SoundEngine,
  AutoSoundEngine
  {$IFDEF USE_MINIAUDIO},MiniaudioSoundEngine{$ENDIF};

type
  { TSoundTimer }

  TSoundTimer = class
  private
    {$IFDEF USE_MINIAUDIO}
    FEngine: TMiniaudioSoundEngine;
    FBeepSound: TMiniaudioBeepSound;
    {$ENDIF}
    prevSeconds: integer;
    FSoundEngine: ISoundEngine;

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

  FSoundEngine := TAutoSoundEngine.Create;
  {$IFDEF USE_MINIAUDIO}
  FEngine := TMiniaudioSoundEngine.Create;
  FBeepSound := TMiniaudioBeepSound.Create(FEngine);
  {$ENDIF}
end;

destructor TSoundTimer.Destroy;
begin
  FreeAndNil(FSoundEngine);
  {$IFDEF USE_MINIAUDIO}
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
  FSoundEngine.Open;
  {$IFDEF DARWIN}
  FCoreAudioEngine.Open;
  {$ENDIF}
end;

procedure TSoundTimer.StopDevice;
begin
  FSoundEngine.Close;
end;

procedure TSoundTimer.PlaySound(freq: integer);
begin
  FSoundEngine.Play(freq);
  {$IFDEF USE_MINIAUDIO}
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
