unit buttonState;

{$mode ObjFPC}{$H+}

{todo rename to SettingButtonState }

interface

uses
  states, Graphics, BGRABitmapTypes, Controls, BGRABitmap, AppSettings,
  Buttons, SysUtils;

const
  DEFAULT_ALPHA_VALUE = 70;

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
    FIsFocused: boolean;
    procedure FillImageListButton;
    procedure SetIsFocused(AValue: boolean);
  public
    function GetDefaultImageIndex(state: TState): integer;
    function GetFocusImageIndex(state: TState): integer;
    procedure Draw(state: TState; button: TSpeedButton);
    constructor Create(AImageList: TImageList; AAppSettings: TAppSettings);

    property Focused: boolean read FIsFocused write SetIsFocused;
  end;

implementation

{ TButtonState }

constructor TButtonState.Create(AImageList: TImageList; AAppSettings: TAppSettings);
begin
  FIsFocused := False;
  FImageList := AImageList;
  FAppSettings := AAppSettings;
  isFirstRun := True;
  FillImageListButton;
end;

procedure TButtonState.FillImageListButton;

  function addColoredButton(bitmap: TBGRABitmap; color: TBGRAPixel): integer;
  var
    colored: TBGRABitmap;
  begin
    colored := TBGRABitmap.Create(FImageList.Width, FImageList.Height);
    try
      colored.FillMask(0, 0, bitmap, color);
      Result := FImageList.Add(colored.Bitmap, nil);
    finally
      colored.Free;
    end;
  end;

var
  imgBitmap: TBitmap;
  bitmap: TBGRABitmap;
begin
  imgBitmap := TBitmap.Create;
  FImageList.GetBitmap(0, imgBitmap);
  bitmap := TBGRABitmap.Create(imgBitmap);

  try
    FDefaultIdx[stBreathIn] :=
      addColoredButton(bitmap, ColorToBGRA(FAppSettings.BreathInColor,
      DEFAULT_ALPHA_VALUE));
    FFocusIdx[stBreathIn] := addColoredButton(bitmap, FAppSettings.BreathInColor);

    FDefaultIdx[stBreathOut] :=
      addColoredButton(bitmap, ColorToBGRA(FAppSettings.BreathOutColor,
      DEFAULT_ALPHA_VALUE));
    FFocusIdx[stBreathOut] := addColoredButton(bitmap, FAppSettings.BreathOutColor);

    FDefaultIdx[stHoldIn] :=
      addColoredButton(bitmap, ColorToBGRA(FAppSettings.HoldColor, DEFAULT_ALPHA_VALUE));
    FFocusIdx[stHoldIn] := addColoredButton(bitmap, FAppSettings.HoldColor);

    FDefaultIdx[stHoldOut] := FDefaultIdx[stHoldIn];
    FFocusIdx[stHoldOut] := FFocusIdx[stHoldOut];
  finally
    bitmap.Free;
    imgBitmap.Free;
  end;
end;

procedure TButtonState.SetIsFocused(AValue: boolean);
begin
  FIsFocused := AValue;
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
    if not FIsFocused then
      button.ImageIndex := GetDefaultImageIndex(state)
    else
      button.ImageIndex := GetFocusImageIndex(state);
    FCurrentState := state.StateType;
  end;

  if isFirstRun then
  begin
    isFirstRun := False;
  end;
end;

end.
