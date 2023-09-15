unit states;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AppSettings, Graphics;

type
  BreathStates = (stBreathIn, stHoldIn, stBreathOut, stHoldOut);

  { TState }

  TState = class
  protected
    FState: BreathStates;
    FMaxMSec : integer;
    FCurrentMSec : integer;
    FAppSettings : RAppSettings;
    function GetMainColor : TColor; virtual; abstract;
    function GetBgColor : TColor; virtual;
    function GetBgSecondColor : TColor; virtual;
  public
    property State: BreathStates read FState;
    property MaxMSec: integer read FMaxMSec;
    property CurrentMSec : integer read FCurrentMSec;
    property MainColor : TColor read GetMainColor;
    property BgColor : TColor read GetBgColor;
    property BgSecondColor : TColor read GetBgSecondColor;

    function SecondsString : string;
    function Seconds : integer;
    function ClockPersent : real;

    constructor Create(AState: BreathStates; AMaxMSec : integer; AAppSettings : RAppSettings);
    destructor Destroy;
  end;

  { TBreathInState }

  TBreathInState = class(TState)
  protected
    function GetMainColor : TColor; override;
  end;

  { TBreathOutState }

  TBreathOutState = class(TState)
  protected
    function GetMainColor : TColor; override;
  end;

  { THoldInState }

  THoldInState = class(TState)
  protected
    function GetMainColor : TColor; override;
  end;

  { THoldOutState }

  THoldOutState = class(TState)
  protected
    function GetMainColor : TColor; override;
  end;

  { TStateManager }

  TStateManager = class
  private
    FAppSettings: RAppSettings;
    FCurrentState: BreathStates;
    FCurrentStateObj: TState;
    FCurrentMSec: integer;
    FStateBreathIn, FStateHoldIn, FStateBreathOut, FStateHoldOut : TState;
    function GetState: TState;
    procedure MoveToNextState();
    function NextState(ABreathState: BreathStates) : BreathStates;
    function GetStateObject(AState : BreathStates) : TState;
  public
    constructor Create(AAppSettings: RAppSettings);
    destructor Destory;

    property State: TState read GetState;
    procedure tick(MSecInterval: integer);
  end;

implementation

{ THoldOutState }

function THoldOutState.GetMainColor: TColor;
begin
  Result := FAppSettings.breathInColor; //todo
end;

{ THoldInState }

function THoldInState.GetMainColor: TColor;
begin
  Result := FAppSettings.breathInColor; //todo
end;

{ TBreathOutState }

function TBreathOutState.GetMainColor: TColor;
begin
  Result := FAppSettings.breathOutColor;
end;

{ TBreathInState }

function TBreathInState.GetMainColor: TColor;
begin
  Result := FAppSettings.breathInColor;
end;

{ TStateManager }

function TStateManager.GetState: TState;
begin
  Result := FCurrentStateObj;
end;

procedure TStateManager.MoveToNextState;
var bstate : BreathStates;
  stateObj : TState;
  i : integer;
begin
  bstate := FCurrentState;
  for i := 1 to 4 do
  begin
    bstate := NextState(bstate);
    stateObj := GetStateObject(bstate);
    stateObj.FCurrentMSec := 0;
    if stateObj.MaxMSec <> 0 then
    begin
      FCurrentState:=bstate;
      FCurrentStateObj := stateObj;
      break;
    end;
  end;

  if i = 4 then
     raise Exception.Create('all states have zero max sec');
end;

function TStateManager.NextState(ABreathState: BreathStates): BreathStates;
begin
  case ABreathState of
  stHoldOut: Result := stBreathIn;
  stBreathIn: Result := stHoldIn;
  stHoldIn: Result := stBreathOut;
  stBreathOut: Result := stHoldOut;
  end;
end;

function TStateManager.GetStateObject(AState: BreathStates): TState;
begin
  case AState of
  stHoldOut: Result := FStateHoldOut;
  stBreathIn: Result := FStateBreathIn;
  stHoldIn: Result := FStateHoldIn;
  stBreathOut: Result := FStateBreathOut;
  end;
end;

constructor TStateManager.Create(AAppSettings: RAppSettings);
begin
  inherited Create;

  FCurrentMSec := 0;
  FAppSettings := AAppSettings;
  FStateBreathIn := TBreathInState.Create(stBreathIn, 5000, FAppSettings);
  FStateHoldIn := THoldInState.Create(stHoldIn, 0, FAppSettings);
  FStateBreathOut := TBreathOutState.Create(stBreathOut, 5000, FAppSettings);
  FStateHoldOut := THoldOutState.Create(stHoldOut, 0, FAppSettings);

  FCurrentStateObj := FStateBreathIn;
end;

destructor TStateManager.Destory;
begin
  FStateBreathIn.Free;
  FStateBreathOut.Free;
  FStateHoldIn.Free;
  FStateHoldOut.Free;
  //inherited Destory;
end;

procedure TStateManager.tick(MSecInterval: integer);
begin
  FCurrentMSec := FCurrentMSec + MSecInterval;

  if FCurrentMSec > FCurrentStateObj.MaxMSec then
  begin
    FCurrentMSec:=0;
    MoveToNextState();
  end
  else
  begin
    FCurrentStateObj.FCurrentMSec:=FCurrentMSec;
  end;
end;

{ TState }

function TState.GetBgColor: TColor;
begin
  Result := FAppSettings.bg;
end;

function TState.GetBgSecondColor: TColor;
begin
  Result := FAppSettings.clockBg;
end;

function TState.SecondsString: string;
var maxSec : integer;
begin
  maxSec := FMaxMSec div 1000;
  if (Seconds = 0) or (Seconds = maxSec) then
     Result := IntToStr(maxSec)
  else
    Result := IntToStr(maxSec - Seconds);
end;

function TState.Seconds: integer;
begin
  Result := FCurrentMSec div 1000;
end;

function TState.ClockPersent: real;
begin
  Result := FCurrentMSec / FMaxMSec;
end;

constructor TState.Create(AState: BreathStates; AMaxMSec: integer;
  AAppSettings: RAppSettings);
begin
  inherited Create;

  FState := AState;
  FMaxMSec := AMaxMSec;
  FCurrentMSec:=0;
  FAppSettings:=AAppSettings;
end;

destructor TState.Destroy;
begin
  inherited Destroy;
end;

end.
