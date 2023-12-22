unit ClockText;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AppSettings, BGRABitmap, BGRABitmapTypes, Graphics, states;

type

  { TClockText }

  TClockText = class(TObject)
  private
    FSecondsBitmap, FStateTextBitmap: TBGRABitmap;
    rect: TRect;
    AppSettings: TAppSettings;
    textBox, stateTextBox: TAffineBox;
    x2, y2, maxSec: integer;
    prevStateText, prevSec: string;
    prevStateType: StateType;
    procedure DrawStateText(State: TState);
    procedure DrawSecondsText(State: TState);
  public
    constructor Create(ARect: TRect; AAppColors: TAppSettings; AMaxSec: integer);
    destructor Destroy; override;

    procedure DrawText(ABitmap: TBGRABitmap; State: TState);
  end;

implementation

constructor TClockText.Create(ARect: TRect; AAppColors: TAppSettings; AMaxSec: integer);
begin
  inherited Create;
  rect := ARect;
  maxSec := AMaxSec;
  AppSettings := AAppColors;
  FSecondsBitmap := TBGRABitmap.Create(rect.Width, rect.Height);
  FSecondsBitmap.Fill(clDontMask);
  FSecondsBitmap.FontAntialias := True;
  FSecondsBitmap.FontHeight := 124;
  FSecondsBitmap.FontName := AppSettings.MainFontName;


  FStateTextBitmap := TBGRABitmap.Create(rect.Width, rect.Height);
  FStateTextBitmap.Fill(clDontMask);
  FStateTextBitmap.FontAntialias := True;
  FStateTextBitmap.FontHeight := 20;
  FStateTextBitmap.FontName := AppSettings.SecondFontName;

  x2 := rect.Width div 2;
  y2 := rect.Height div 2;
end;

destructor TClockText.Destroy;
begin
  FSecondsBitmap.Free;
  inherited Destroy;
end;

procedure TClockText.DrawText(ABitmap: TBGRABitmap; State: TState);
begin
  DrawSecondsText(State);
  DrawStateText(State);
  prevStateType := State.StateType;
  //TODO draw when changed
  ABitmap.EraseMask(rect.Left, rect.Top, FSecondsBitmap);
  ABitmap.EraseMask(rect.Left, rect.Top, FStateTextBitmap);
end;

procedure TClockText.DrawStateText(State: TState);
var
  stateText: string;
begin
  stateText := State.GetStateText();

  if (stateText <> prevStateText) or (prevStateType <> State.StateType) then
  begin
    if prevStateText <> '' then // not the first run
    begin
      FStateTextBitmap.CanvasBGRA.Brush.Color := clDontMask;
      FStateTextBitmap.CanvasBGRA.Pen.Color := clDontMask;
      FStateTextBitmap.CanvasBGRA.Pen.Width := 3;

      FStateTextBitmap.CanvasBGRA.Rectangle(stateTextBox.RectBounds);
    end;

    stateTextBox := FStateTextBitmap.TextAffineBox(stateText);
    stateTextBox.Offset(x2 - Round(stateTextBox.Width / 2),
      FStateTextBitmap.Height - stateTextBox.Height);

    FStateTextBitmap.TextOut(stateTextBox.TopLeft.x,
      stateTextBox.TopLeft.y,
      stateText,
      clMask);
  end;

  prevStateText := stateText;
end;

procedure TClockText.DrawSecondsText(State: TState);
var
  strSec: string;
begin
  strSec := State.SecondsString;
  if (strSec <> prevSec) or (prevStateType <> State.StateType) then
  begin
    strSec := State.SecondsString;
    if prevSec <> '' then // not the first run
    begin
      FSecondsBitmap.FillRect(textBox.RectBounds, clDontMask, dmDrawWithTransparency);
    end;
    textBox := FSecondsBitmap.TextAffineBox(strSec);
    textBox.Offset(x2 - Round(textBox.Width / 2),
      y2 - Round(FSecondsBitmap.Height / 2 + FSecondsBitmap.Height * 0.10));

    FSecondsBitmap.TextOut(textBox.TopLeft.x,
      textBox.TopLeft.y,
      strSec,
      clMask);
  end;
  prevSec := strSec;
end;

end.
