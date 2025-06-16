unit SwitchBoxTheme;

{$mode objfpc}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils, Graphics, BGRABitmap, BGRABitmapTypes, BGRAGradients, ColorUtils;

type
  TSwitchBoxPillStyle = record
    x1, y1, x2, y2: integer;
    color: TColor;
    borderWidth: integer;
    borderRadius: integer;
    borderColor: TColor;
  end;

  TSwitchBoxKnobStyle = record
    color: TColor;
    borderColor: TColor;
    borderWidth: integer;
    x, y: integer;
    radius: integer;
    shadowEnabled: boolean;
    shadowXOffset: integer;
    shadowYOffset: integer;
    shadowBlur: integer;
  end;

  TSwitchBoxTextStyle = record
    Enabled: boolean;
    DefaultText: string;
    color: TColor;
    fontName: string;
    fontSize: integer;
    xOffset: integer;
  end;

  SwitchBoxOverridedProps = record
    Text: string;
  end;

  ISwitchBoxTheme = interface
    function GetWidth: integer;
    function GetHeight: integer;
    property Width: integer read GetWidth;
    property Height: integer read GetHeight;
    procedure DrawChecked(ACanvas: TCanvas; AScaleFactor: double);
    procedure DrawUnchecked(ACanvas: TCanvas; AScaleFactor: double);
  end;

  { TAbstractSwitchBoxTheme }

  TAbstractSwitchBoxTheme = class(ISwitchBoxTheme)
  protected
    procedure DrawChecked(FBitmap: TBGRABitmap); virtual; abstract;
    procedure DrawUnchecked(FBitmap: TBGRABitmap); virtual; abstract;
    procedure updateParams(AScaleFactor: double); virtual; abstract;
  public
    function GetWidth: integer; virtual; abstract;
    function GetHeight: integer; virtual; abstract;
    procedure DrawChecked(ACanvas: TCanvas; AScaleFactor: double);
    procedure DrawUnchecked(ACanvas: TCanvas; AScaleFactor: double);

    property Width: integer read GetWidth;
    property Height: integer read GetHeight;
  end;

  { TDefaultSwitchBoxTheme }

  TDefaultSwitchBoxTheme = class(TAbstractSwitchBoxTheme)
  private
  const
    WIDGET_WIDTH = 56;
    WIDGET_HEIGHT = 24;
  private
    FPillCheckedStyle: TSwitchBoxPillStyle;
    FKnobCheckedStyle: TSwitchBoxKnobStyle;
    FTextCheckedStyle: TSwitchBoxTextStyle;

    FPillUncheckedStyle: TSwitchBoxPillStyle;
    FKnobUncheckedStyle: TSwitchBoxKnobStyle;
    FTextUncheckedStyle: TSwitchBoxTextStyle;
  protected
    procedure DrawControl(FBitmap: TBGRABitmap; pillStyle: TSwitchBoxPillStyle;
      knobStyle: TSwitchBoxKnobStyle; textStyle: TSwitchBoxTextStyle);
    procedure updateParams(AScaleFactor: double); override;
  public
    constructor Create;
    function GetWidth: integer; override;
    function GetHeight: integer; override;
    procedure DrawChecked(FBitmap: TBGRABitmap); override;
    procedure DrawUnchecked(FBitmap: TBGRABitmap); override;
  end;

implementation

{ TAbstractSwitchBoxTheme }

procedure TAbstractSwitchBoxTheme.DrawChecked(ACanvas: TCanvas; AScaleFactor: double);
var
  bitmap: TBGRABitmap;
begin
  updateParams(AScaleFactor);
  bitmap := TBGRABitmap.Create(round(Width * AScaleFactor),
    round(Height * AScaleFactor));
  try
    DrawChecked(bitmap);
    bitmap.Draw(ACanvas, Rect(0, 0, bitmap.Width, bitmap.Height), False);
  finally
    bitmap.Free;
  end;
end;

procedure TAbstractSwitchBoxTheme.DrawUnchecked(ACanvas: TCanvas; AScaleFactor: double);
var
  bitmap: TBGRABitmap;
begin
  updateParams(AScaleFactor);
  bitmap := TBGRABitmap.Create(round(Width * AScaleFactor),
    round(Height * AScaleFactor));
  try
    DrawUnchecked(bitmap);
    bitmap.Draw(ACanvas, Rect(0, 0, bitmap.Width, bitmap.Height), False);
  finally
    bitmap.Free;
  end;
end;

{ TDefaultSwitchBoxTheme }

procedure TDefaultSwitchBoxTheme.updateParams(AScaleFactor: double);
var
  bitmapWidth, bitmapHeight: integer;
begin
  bitmapWidth := round(Width * AScaleFactor);
  bitmapHeight := round(Height * AScaleFactor);
  // checked
  FPillCheckedStyle.x1 := 0;
  FPillCheckedStyle.y1 := 0;
  FPillCheckedStyle.x2 := bitmapWidth - 1;
  FPillCheckedStyle.y2 := bitmapHeight - 1;
  FPillCheckedStyle.borderRadius := round(AScaleFactor * 11);
  FPillCheckedStyle.borderColor := clWhite;
  FPillCheckedStyle.borderWidth := round(AScaleFactor);
  FPillCheckedStyle.color := RGBToColor(155, 195, 239);

  FKnobCheckedStyle.radius := bitmapHeight div 2 - round(AScaleFactor * 2);
  FKnobCheckedStyle.x := bitmapWidth - round(AScaleFactor * 2) -
    FKnobCheckedStyle.radius;
  FKnobCheckedStyle.y := bitmapHeight div 2;
  FKnobCheckedStyle.borderColor := clNone;
  FKnobCheckedStyle.borderWidth := 0;
  FKnobCheckedStyle.color := RGBToColor(60, 98, 158);

  FKnobCheckedStyle.shadowEnabled := True;
  FKnobCheckedStyle.shadowXOffset := round(-1 * AScaleFactor);
  FKnobCheckedStyle.shadowYOffset := 0;
  FKnobCheckedStyle.shadowBlur := round(2 * AScaleFactor);

  FTextCheckedStyle.Enabled := True;
  FTextCheckedStyle.color := clWhite;
  FTextCheckedStyle.fontName := 'Arial';
  FTextCheckedStyle.fontSize := round(10 * AScaleFactor);
  FTextCheckedStyle.xOffset := round(12 * AScaleFactor);
  FTextCheckedStyle.DefaultText := 'ON';

  // unchecked
  FPillUncheckedStyle.x1 := 0;
  FPillUncheckedStyle.y1 := 0;
  FPillUncheckedStyle.x2 := bitmapWidth - 1;
  FPillUncheckedStyle.y2 := bitmapHeight - 1;
  FPillUncheckedStyle.borderRadius := round(AScaleFactor * 11);
  FPillUncheckedStyle.borderColor := clWhite;
  FPillUncheckedStyle.borderWidth := 1;
  FPillUncheckedStyle.color := RGBToColor(221, 221, 221);

  FKnobUncheckedStyle.radius := bitmapHeight div 2 - round(AScaleFactor * 2);
  FKnobUncheckedStyle.x := round(AScaleFactor * 2) + FKnobUncheckedStyle.radius;
  FKnobUncheckedStyle.y := bitmapHeight div 2;
  FKnobUncheckedStyle.borderColor := clNone;
  FKnobUncheckedStyle.borderWidth := 0;
  FKnobUncheckedStyle.color := clWhite;

  FKnobUncheckedStyle.shadowEnabled := True;
  FKnobUncheckedStyle.shadowXOffset := round(AScaleFactor);
  FKnobUncheckedStyle.shadowYOffset := 0;
  FKnobUncheckedStyle.shadowBlur := round(2 * AScaleFactor);

  FTextUncheckedStyle.Enabled := True;
  FTextUncheckedStyle.color := clWhite;
  FTextUncheckedStyle.fontName := 'Arial';
  FTextUncheckedStyle.fontSize := round(10 * AScaleFactor);
  FTextUncheckedStyle.xOffset := round(26 * AScaleFactor);
  FTextUncheckedStyle.DefaultText := 'OFF';
end;

procedure TDefaultSwitchBoxTheme.DrawControl(FBitmap: TBGRABitmap;
  pillStyle: TSwitchBoxPillStyle; knobStyle: TSwitchBoxKnobStyle;
  textStyle: TSwitchBoxTextStyle);
var
  pillCheckedBitmap, knobCheckedBitmap, knobShadowBitmap, knobShadowAppliedBitmap,
  checkedTextBitmap: TBGRABitmap;
begin
  pillCheckedBitmap := TBGRABitmap.Create(FBitmap.Width, FBitmap.Height);
  knobCheckedBitmap := TBGRABitmap.Create(FBitmap.Width, FBitmap.Height);
  knobShadowBitmap := TBGRABitmap.Create(FBitmap.Width, FBitmap.Height);
  checkedTextBitmap := TBGRABitmap.Create(FBitmap.Width, FBitmap.Height);

  FBitmap.Fill(BGRA(0, 0, 0, 0));

  try
    pillCheckedBitmap.RoundRectAntialias(pillStyle.x1,
      pillStyle.y1, pillStyle.x2, pillStyle.y2,
      pillStyle.borderRadius,
      pillStyle.borderRadius, pillStyle.borderColor, pillStyle.borderWidth,
      pillStyle.color, []);


    knobCheckedBitmap.EllipseAntialias(knobStyle.x, knobStyle.y,
      knobStyle.radius, knobStyle.radius, knobStyle.borderColor,
      knobStyle.borderWidth, knobStyle.color);


    knobShadowBitmap.EllipseAntialias(knobStyle.x + knobStyle.shadowXOffset,
      knobStyle.y + knobStyle.shadowYOffset,
      knobStyle.radius, knobStyle.radius, clNone,
      0, BGRA(0, 0, 0, 255 div 2));
    if knobStyle.shadowBlur <> 0 then
      knobShadowAppliedBitmap :=
        knobShadowBitmap.FilterBlurRadial(knobStyle.shadowBlur, rbNormal);

    if textStyle.Enabled then
    begin
      checkedTextBitmap.FontName := textStyle.fontName;
      checkedTextBitmap.FontHeight := textStyle.fontSize;
      checkedTextBitmap.TextOut(textStyle.xOffset, checkedTextBitmap.Height div
        2 - textStyle.fontSize div 2, textStyle.DefaultText, textStyle.color);
    end;


    FBitmap.BlendImage(0, 0, pillCheckedBitmap, boLinearBlend);
    if knobStyle.shadowEnabled then
      FBitmap.BlendImage(0, 0, knobShadowAppliedBitmap, boLinearBlend);
    if textStyle.Enabled then
      FBitmap.BlendImage(0, 0, checkedTextBitmap, boLinearBlend);
    FBitmap.BlendImage(0, 0, knobCheckedBitmap, boLinearBlend);
  finally
    if knobShadowAppliedBitmap <> nil then knobShadowAppliedBitmap.Free;
    pillCheckedBitmap.Free;
    knobCheckedBitmap.Free;
    knobShadowBitmap.Free;
    if checkedTextBitmap <> nil then checkedTextBitmap.Free;
  end;

end;

constructor TDefaultSwitchBoxTheme.Create;
begin
  inherited Create;
  updateParams(2);
end;

function TDefaultSwitchBoxTheme.GetWidth: integer;
begin
  Result := WIDGET_WIDTH;
end;

function TDefaultSwitchBoxTheme.GetHeight: integer;
begin
  Result := WIDGET_HEIGHT;
end;

procedure TDefaultSwitchBoxTheme.DrawChecked(FBitmap: TBGRABitmap);
begin
  DrawControl(FBitmap, FPillCheckedStyle, FKnobCheckedStyle, FTextCheckedStyle);
end;

procedure TDefaultSwitchBoxTheme.DrawUnchecked(FBitmap: TBGRABitmap);
begin
  DrawControl(FBitmap, FPillUncheckedStyle, FKnobUncheckedStyle, FTextUncheckedStyle);
end;

end.
