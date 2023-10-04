unit ClockText;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AppSettings, BGRABitmap, BGRABitmapTypes, Graphics, states;

type

  { TClockText }

  TClockText = class(TObject)
  private
    FTextBitmap: TBGRABitmap;
    rect: TRect;
    AppSettings: RAppSettings;
    textBox, stateTextBox: TAffineBox;
    x2, y2, maxSec: integer;
    prevStateText, prevSec: string;
    prevStateType: StateType;
    procedure DrawStateText(State: TState);
    procedure DrawSecondsText(State: TState);
  public
    constructor Create(ARect: TRect; AAppColors: RAppSettings; AMaxSec: integer);
    destructor Destroy; override;

    procedure DrawText(ABitmap: TBGRABitmap; State: TState);
  end;

implementation

constructor TClockText.Create(ARect: TRect; AAppColors: RAppSettings; AMaxSec: integer);
begin
  inherited Create;
  rect := ARect;
  maxSec := AMaxSec;
  AppSettings := AAppColors;
  FTextBitmap := TBGRABitmap.Create(rect.Width, rect.Height);
  FTextBitmap.Fill(clDontMask);
  FTextBitmap.FontAntialias := True;
  x2 := rect.Width div 2;
  y2 := rect.Height div 2;
end;

destructor TClockText.Destroy;
begin
  FTextBitmap.Free;
  inherited Destroy;
end;

procedure TClockText.DrawText(ABitmap: TBGRABitmap; State: TState);
begin
  DrawSecondsText(State);
  DrawStateText(State);
  prevStateType := State.StateType;
  ABitmap.EraseMask(rect.Left, rect.Top, FTextBitmap);
end;

procedure TClockText.DrawStateText(State: TState);
var
  stateText: string;
begin
  stateText := State.GetStateText();

  if (stateText <> prevStateText) or (prevStateType <> State.StateType) then
  begin
    FTextBitmap.FontHeight := 18;
    FTextBitmap.FontName := AppSettings.mainFontName;

    if prevStateText <> '' then // not the first run
    begin
      FTextBitmap.CanvasBGRA.Brush.Color := clDontMask;
      FTextBitmap.CanvasBGRA.Pen.Color := clDontMask;
      FTextBitmap.CanvasBGRA.Pen.Width := 3;

      FTextBitmap.CanvasBGRA.Rectangle(stateTextBox.RectBounds);
    end;
    stateTextBox := FTextBitmap.TextAffineBox(stateText);
    stateTextBox.Offset(x2 - Round(stateTextBox.Width / 2), FTextBitmap.Height -
      stateTextBox.Height);

    FTextBitmap.TextOut(stateTextBox.TopLeft.x,
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
    FTextBitmap.FontHeight := 124;
    FTextBitmap.FontName := AppSettings.mainFontName;
    strSec := State.SecondsString;
    if prevSec <> '' then // not the first run
    begin
      FTextBitmap.FillRect(textBox.RectBounds, clDontMask, dmDrawWithTransparency);
    end;
    textBox := FTextBitmap.TextAffineBox(strSec);
    textBox.Offset(x2 - Round(textBox.Width / 2),
      y2 - Round(FTextBitmap.Height / 2 + FTextBitmap.Height * 0.10));

    FTextBitmap.TextOut(textBox.TopLeft.x,
      textBox.TopLeft.y,
      strSec,
      clMask);
  end;
  prevSec := strSec;
end;

end.
