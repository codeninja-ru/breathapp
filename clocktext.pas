unit ClockText;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AppSettings, BGRABitmap, BGRABitmapTypes, states;

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
    procedure DrawStateText(ABitmap: TBGRABitmap; State: TState);
    procedure DrawSecondsText(ABitmap: TBGRABitmap; State: TState);
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
  FTextBitmap := TBGRABitmap.Create();
  FTextBitmap.SetSize(rect.Width, rect.Height);
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
  DrawSecondsText(ABitmap, State);
  DrawStateText(ABitmap, State);
  ABitmap.BlendImage(rect.Left, rect.Top, FTextBitmap, boLinearBlend);
end;

procedure TClockText.DrawStateText(ABitmap: TBGRABitmap; State: TState);
var
  stateText: string;
begin
  stateText := State.GetStateText();

  if stateText <> prevStateText then
  begin
    FTextBitmap.FontHeight := 18;
    FTextBitmap.FontName := 'PT Caption';
    FTextBitmap.FontAntialias := True;

    if prevStateText <> '' then // not the first run
    begin
      FTextBitmap.CanvasBGRA.Brush.Color := AppSettings.bg;
      FTextBitmap.CanvasBGRA.Pen.Color := AppSettings.bg;
      FTextBitmap.CanvasBGRA.Pen.Width := 3;

      FTextBitmap.CanvasBGRA.Rectangle(stateTextBox.RectBounds);
    end;
    stateTextBox := FTextBitmap.TextAffineBox(stateText);
    stateTextBox.Offset(x2 - Round(stateTextBox.Width / 2), FTextBitmap.Height -
      stateTextBox.Height);

    FTextBitmap.TextOut(stateTextBox.TopLeft.x,
      stateTextBox.TopLeft.y,
      stateText,
      State.MainColor);
  end;

  prevStateText := stateText;
end;

procedure TClockText.DrawSecondsText(ABitmap: TBGRABitmap; State: TState);
var
  strSec: string;
begin
  strSec := State.SecondsString;
  if strSec <> prevSec then
  begin
    FTextBitmap.FontHeight := 124;
    FTextBitmap.FontName := 'PT Caption';
    FTextBitmap.FontAntialias := True;
    strSec := State.SecondsString;
    if prevSec <> '' then // not the first run
    begin
      FTextBitmap.FillRect(textBox.RectBounds, AppSettings.bg, dmDrawWithTransparency);
    end;
    textBox := FTextBitmap.TextAffineBox(strSec);
    textBox.Offset(x2 - Round(textBox.Width / 2),
      y2 - Round(FTextBitmap.Height / 2 + FTextBitmap.Height * 0.10));

    FTextBitmap.TextOut(textBox.TopLeft.x,
      textBox.TopLeft.y,
      strSec,
      State.MainColor);
  end;
  prevSec := strSec;
end;

end.
