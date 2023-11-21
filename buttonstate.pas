unit buttonState;

{$mode ObjFPC}{$H+}

interface

uses
  states, Graphics, BGRABitmapTypes, Controls, BGRABitmap, AppSettings, Buttons;

type
  { TButtonState }

  TButtonState = class
  private
    FCurrentState: StateType;
    FFocusIdx: array[StateType] of integer;
    FDefaultIdx: array[StateType] of integer;
    FImageList: TImageList;
    FAppSettings: TAppSettings;
    isFirstRun: boolean;
    procedure FillImageListButton;
  public
    function GetDefaultImageIndex(state: TState): integer;
    function GetFocusImageIndex(state: TState): integer;

    procedure Draw(state: TState; button: TSpeedButton);

    constructor Create(AImageList: TImageList; AAppSettings: TAppSettings);
  end;

implementation

{ TButtonState }

constructor TButtonState.Create(AImageList: TImageList; AAppSettings: TAppSettings);
begin
  FImageList := AImageList;
  FAppSettings := AAppSettings;
  isFirstRun := True;
  FillImageListButton;
end;

procedure TButtonState.FillImageListButton;
var
  bitmap, colored: TBGRABitmap;

  function addColoredButton(color: TBGRAPixel): integer;
  begin
    colored.FillMask(0, 0, bitmap, color);
    Result := FImageList.Add(colored.Bitmap, colored.Bitmap);
  end;

begin
  bitmap := TBGRABitmap.Create(FImageList.Width, FImageList.Height);
  colored := TBGRABitmap.Create(FImageList.Width, FImageList.Height);
  try
    FImageList.GetBitmap(0, bitmap.Bitmap);
    FDefaultIdx[stBreathIn] :=
      addColoredButton(ColorToBGRA(FAppSettings.BreathInColor, 50));
    FFocusIdx[stBreathIn] := addColoredButton(FAppSettings.BreathInColor);

    FDefaultIdx[stBreathOut] :=
      addColoredButton(ColorToBGRA(FAppSettings.BreathOutColor, 50));
    FFocusIdx[stBreathOut] := addColoredButton(FAppSettings.BreathOutColor);

    FDefaultIdx[stHoldIn] :=
      addColoredButton(ColorToBGRA(FAppSettings.HoldColor, 50));
    FFocusIdx[stHoldIn] := addColoredButton(FAppSettings.HoldColor);

    FDefaultIdx[stHoldOut] := FDefaultIdx[stHoldIn];
    FFocusIdx[stHoldOut] := FDefaultIdx[stHoldOut];
  finally
    bitmap.Free;
    colored.Free;
  end;
end;

function TButtonState.GetDefaultImageIndex(state: TState): integer;
begin
  Result := FDefaultIdx[state.StateType];
end;

function TButtonState.GetFocusImageIndex(state: TState): integer;
begin
  Result := FFocusIdx[state.StateType];
end;

procedure TButtonState.Draw(state: TState; button: TSpeedButton);
begin
  if (state.StateType <> FCurrentState) or (isFirstRun) then
  begin
    button.ImageIndex := GetDefaultImageIndex(state);
    FCurrentState := state.StateType;
  end;

  if isFirstRun then
  begin
    isFirstRun := False;
  end;
end;

end.
