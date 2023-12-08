unit SwitchBoxTheme;

{$mode objfpc}{$H+}

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

  { TAbstractSwitchBoxTheme }

  TAbstractSwitchBoxTheme = class abstract
  protected
  const
    SCALE = 2;
  protected
    FWidth: integer;
    FHeight: integer;
  public
    procedure DrawChecked(FBitmap: TBGRABitmap); virtual; abstract;
    procedure DrawUnchecked(FBitmap: TBGRABitmap); virtual; abstract;
    function CreateBitmap: TBGRABitmap;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
  end;

  { TDefaultSwitchBoxTheme }

  TDefaultSwitchBoxTheme = class(TAbstractSwitchBoxTheme)
  private
  const
    WIDGET_WIDTH = 56;
    WIDGET_HEIGHT = 24;
    BITMAP_WIDTH = WIDGET_WIDTH * SCALE;
    BITMAP_HEIGHT = WIDGET_HEIGHT * SCALE;
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
  public
    constructor Create();

    procedure DrawChecked(FBitmap: TBGRABitmap); override;
    procedure DrawUnchecked(FBitmap: TBGRABitmap); override;
  end;

implementation

{ TAbstractSwitchBoxTheme }

function TAbstractSwitchBoxTheme.CreateBitmap: TBGRABitmap;
begin
  Result := TBGRABitmap.Create(Self.Width * SCALE, Self.Height * SCALE);
end;

{ TDefaultSwitchBoxTheme }

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
  FWidth := WIDGET_WIDTH;
  FHeight := WIDGET_HEIGHT;
  // checked
  FPillCheckedStyle.x1 := 0;
  FPillCheckedStyle.y1 := 0;
  FPillCheckedStyle.x2 := BITMAP_WIDTH - 1;
  FPillCheckedStyle.y2 := BITMAP_HEIGHT - 1;
  FPillCheckedStyle.borderRadius := 22;
  FPillCheckedStyle.color := clNone;
  FPillCheckedStyle.borderWidth := 0;
  FPillCheckedStyle.color := RGBToColor(155, 195, 239);

  FKnobCheckedStyle.radius := BITMAP_HEIGHT div 2 - 4;
  FKnobCheckedStyle.x := BITMAP_WIDTH - 4 - FKnobCheckedStyle.radius;
  FKnobCheckedStyle.y := BITMAP_HEIGHT div 2;
  FKnobCheckedStyle.borderColor := clNone;
  FKnobCheckedStyle.borderWidth := 0;
  FKnobCheckedStyle.color := RGBToColor(60, 98, 158);

  FKnobCheckedStyle.shadowEnabled := True;
  FKnobCheckedStyle.shadowXOffset := -2;
  FKnobCheckedStyle.shadowYOffset := 0;
  FKnobCheckedStyle.shadowBlur := 4;

  FTextCheckedStyle.Enabled := True;
  FTextCheckedStyle.color := clWhite;
  FTextCheckedStyle.fontName := 'Arial';
  FTextCheckedStyle.fontSize := 20;
  FTextCheckedStyle.xOffset := 24;
  FTextCheckedStyle.DefaultText := 'ON';

  // unchecked
  FPillUncheckedStyle.x1 := 0;
  FPillUncheckedStyle.y1 := 0;
  FPillUncheckedStyle.x2 := BITMAP_WIDTH - 1;
  FPillUncheckedStyle.y2 := BITMAP_HEIGHT - 1;
  FPillUncheckedStyle.borderRadius := 22;
  FPillUncheckedStyle.color := clNone;
  FPillUncheckedStyle.borderWidth := 0;
  FPillUncheckedStyle.color := RGBToColor(221, 221, 221);

  FKnobUncheckedStyle.radius := BITMAP_HEIGHT div 2 - 4;
  FKnobUncheckedStyle.x := 4 + FKnobUncheckedStyle.radius;
  FKnobUncheckedStyle.y := BITMAP_HEIGHT div 2;
  FKnobUncheckedStyle.borderColor := clNone;
  FKnobUncheckedStyle.borderWidth := 0;
  FKnobUncheckedStyle.color := clWhite;

  FKnobUncheckedStyle.shadowEnabled := True;
  FKnobUncheckedStyle.shadowXOffset := 2;
  FKnobUncheckedStyle.shadowYOffset := 0;
  FKnobUncheckedStyle.shadowBlur := 4;

  FTextUncheckedStyle.Enabled := True;
  FTextUncheckedStyle.color := clWhite;
  FTextUncheckedStyle.fontName := 'Arial';
  FTextUncheckedStyle.fontSize := 20;
  FTextUncheckedStyle.xOffset := 54;
  FTextUncheckedStyle.DefaultText := 'OFF';
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
