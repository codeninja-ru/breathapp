unit states;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AppSettings, Graphics, BGRABitmapTypes;

const
  DEFAULT_BREATH_IN_MSEC = 5000;
  DEFAULT_BREATH_OUT_MSEC = 5000;
  DEFAULT_HOLD_IN_MSEC = 0;
  DEFAULT_HOLD_OUT_MSEC = 0;

type
  StateType = (stBreathIn, stHoldIn, stBreathOut, stHoldOut);

  { TState }

  TState = class
  protected
    FStateType: StateType;
    FMaxMSec: integer;
    FCurrentMSec: integer;
    FMSecFromStart: integer;
    FAppSettings: TAppSettings;
    function GetMainColor: TColor; virtual; abstract;
    function GetBgColor: TColor; virtual;
    function GetBgSecondColor: TColor; virtual;
    function GetMainGradienColor1: TColor; virtual;
    function GetMainGradienColor2: TColor; virtual; abstract;
  public
    property StateType: StateType read FStateType;
    property MaxMSec: integer read FMaxMSec;
    property CurrentMSec: integer read FCurrentMSec;
    property MainColor: TColor read GetMainColor;
    property MainGradienColor1: TColor read GetMainGradienColor1;
    property MainGradienColor2: TColor read GetMainGradienColor2;
    property BgColor: TColor read GetBgColor;
    property BgSecondColor: TColor read GetBgSecondColor;
    property MSecFromStart: integer read FMSecFromStart;

    function SecondsString: string;
    function Seconds: integer;
    function ClockPersent: real;
    function GetStateText: string; virtual; abstract;

    constructor Create(AState: StateType; AMaxMSec: integer;
      AAppSettings: TAppSettings);
    destructor Destroy;
  end;

  { TBreathInState }

  TBreathInState = class(TState)
  public
    function GetMainColor: TColor; override;
    function GetMainGradienColor2: TColor; override;
    function GetStateText: string; override;
    constructor Create(AMaxMSec: integer; AAppSettings: TAppSettings);
  end;

  { TBreathOutState }

  TBreathOutState = class(TState)
  public
    function GetMainColor: TColor; override;
    function GetMainGradienColor2: TColor; override;
    function GetStateText: string; override;
    constructor Create(AMaxMSec: integer; AAppSettings: TAppSettings);
  end;

  { TAbstractHoldState }

  TAbstractHoldState = class(TState)
  public
    function GetStateText: string; override;
    function GetMainColor: TColor; override;
    function GetMainGradienColor2: TColor; override;
  end;

  { THoldInState }

  THoldInState = class(TAbstractHoldState)
  public
    constructor Create(AMaxMSec: integer; AAppSettings: TAppSettings);
  end;

  { THoldOutState }

  THoldOutState = class(TAbstractHoldState)
  public
    constructor Create(AMaxMSec: integer; AAppSettings: TAppSettings);
  end;

  { TStateManager }

  TStateManager = class
  private
    FAppSettings: TAppSettings;
    FCurrentState: StateType;
    FCurrentStateObj: TState;
    FCurrentMSec: integer;
    FMSecFromStart: integer;
    FStateBreathIn, FStateHoldIn, FStateBreathOut, FStateHoldOut: TState;
    function GetState: TState;
    procedure MoveToNextState();
    function NextState(ABreathState: StateType): StateType;
    function GetStateObject(AState: StateType): TState;
  public
    constructor Create(AAppSettings: TAppSettings);
    destructor Destory;

    property State: TState read GetState;
    procedure tick(MSecInterval: integer);
    procedure SetMaxTime(maxBreathInMsec, maxHoldInMsec, maxBreathOutMsec,
      maxHoldOutMsec: integer);
    procedure Reset;
  end;

implementation

{ THoldOutState }

constructor THoldOutState.Create(AMaxMSec: integer; AAppSettings: TAppSettings);
begin
  inherited Create(stHoldOut, AMaxMSec, AAppSettings);
end;

{ THoldInState }

constructor THoldInState.Create(AMaxMSec: integer; AAppSettings: TAppSettings);
begin
  inherited Create(stHoldIn, AMaxMSec, AAppSettings);
end;

{ TAbstractHoldState }

function TAbstractHoldState.GetStateText: string;
begin
  Result := 'hold breath';
end;

function TAbstractHoldState.GetMainColor: TColor;
begin
  Result := FAppSettings.HoldColor;
end;

function TAbstractHoldState.GetMainGradienColor2: TColor;
begin
  Result := FAppSettings.HoldColorSecond;
end;

{ TBreathOutState }

function TBreathOutState.GetMainColor: TColor;
begin
  Result := FAppSettings.BreathOutColor;
end;

function TBreathOutState.GetMainGradienColor2: TColor;
begin
  Result := FAppSettings.BreathOutColorSecond;
end;

function TBreathOutState.GetStateText: string;
begin
  Result := 'exhale';
end;

constructor TBreathOutState.Create(AMaxMSec: integer; AAppSettings: TAppSettings);
begin
  inherited Create(stBreathOut, AMaxMSec, AAppSettings);
end;

{ TBreathInState }

function TBreathInState.GetMainColor: TColor;
begin
  Result := FAppSettings.BreathInColor;
end;

function TBreathInState.GetMainGradienColor2: TColor;
begin
  Result := FAppSettings.BreathInColorSecond;
end;

function TBreathInState.GetStateText: string;
begin
  Result := 'inhale';
end;

constructor TBreathInState.Create(AMaxMSec: integer; AAppSettings: TAppSettings);
begin
  inherited Create(stBreathIn, AMaxMSec, AAppSettings);
end;

{ TStateManager }

function TStateManager.GetState: TState;
begin
  Result := FCurrentStateObj;
end;

procedure TStateManager.MoveToNextState;
var
  bstate: StateType;
  stateObj: TState;
  i: integer;
begin
  bstate := FCurrentState;
  for i := 1 to 4 do
  begin
    bstate := NextState(bstate);
    stateObj := GetStateObject(bstate);
    stateObj.FCurrentMSec := 0;
    if stateObj.MaxMSec <> 0 then
    begin
      FCurrentState := bstate;
      FCurrentStateObj := stateObj;
      break;
    end;
  end;

  if i = 4 then
    raise Exception.Create('all states have zero max sec');
end;

function TStateManager.NextState(ABreathState: StateType): StateType;
begin
  case ABreathState of
    stHoldOut: Result := stBreathIn;
    stBreathIn: Result := stHoldIn;
    stHoldIn: Result := stBreathOut;
    stBreathOut: Result := stHoldOut;
  end;
end;

function TStateManager.GetStateObject(AState: StateType): TState;
begin
  case AState of
    stHoldOut: Result := FStateHoldOut;
    stBreathIn: Result := FStateBreathIn;
    stHoldIn: Result := FStateHoldIn;
    stBreathOut: Result := FStateBreathOut;
  end;
end;

constructor TStateManager.Create(AAppSettings: TAppSettings);
begin
  inherited Create;

  FAppSettings := AAppSettings;
  FStateBreathIn := TBreathInState.Create(DEFAULT_BREATH_IN_MSEC, FAppSettings);
  FStateHoldIn := THoldInState.Create(DEFAULT_HOLD_IN_MSEC, FAppSettings);
  FStateBreathOut := TBreathOutState.Create(DEFAULT_BREATH_OUT_MSEC, FAppSettings);
  FStateHoldOut := THoldOutState.Create(DEFAULT_HOLD_OUT_MSEC, FAppSettings);

  Reset;
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
  FMSecFromStart := FMSecFromStart + MSecInterval;

  if FCurrentMSec > FCurrentStateObj.MaxMSec then
  begin
    FCurrentMSec := 0;
    MoveToNextState();
  end
  else
  begin
    FCurrentStateObj.FCurrentMSec := FCurrentMSec;
  end;
  FCurrentStateObj.FMSecFromStart := FMSecFromStart;
end;

procedure TStateManager.SetMaxTime(maxBreathInMsec, maxHoldInMsec,
  maxBreathOutMsec, maxHoldOutMsec: integer);
begin
  FStateBreathIn.FMaxMSec := maxBreathInMsec;
  FStateHoldIn.FMaxMSec := maxHoldInMsec;
  FStateBreathOut.FMaxMSec := maxBreathOutMsec;
  FStateHoldOut.FMaxMSec := maxHoldOutMsec;
end;

procedure TStateManager.Reset;
begin
  FCurrentMSec := 0;
  FCurrentStateObj := FStateBreathIn;
  FCurrentState := stBreathIn;
  FStateBreathIn.FCurrentMSec := 0;
  FStateBreathIn.FMSecFromStart := 0;
  FMSecFromStart := 0;
end;

{ TState }

function TState.GetBgColor: TColor;
begin
  Result := FAppSettings.Bg;
end;

function TState.GetBgSecondColor: TColor;
begin
  Result := FAppSettings.ClockBg;
end;

function TState.GetMainGradienColor1: TColor;
begin
  Result := Self.GetMainColor;
end;

function TState.SecondsString: string;
var
  maxSec: integer;
begin
  maxSec := FMaxMSec div 1000;
  if (Seconds = 0) or (Seconds = maxSec) then
    Result := IntToStr(maxSec)
  else
    Result := IntToStr(maxSec - Seconds);
end;

function TState.Seconds: integer;
begin
  Result := Trunc(FCurrentMSec / 1000);
end;

function TState.ClockPersent: real;
begin
  Result := FCurrentMSec / FMaxMSec;
end;

constructor TState.Create(AState: StateType; AMaxMSec: integer;
  AAppSettings: TAppSettings);
begin
  inherited Create;

  FStateType := AState;
  FMaxMSec := AMaxMSec;
  FCurrentMSec := 0;
  FAppSettings := AAppSettings;
end;

destructor TState.Destroy;
begin
  inherited Destroy;
end;

end.
