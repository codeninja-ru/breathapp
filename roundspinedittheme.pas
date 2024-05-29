unit RoundSpinEditTheme;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Controls, Graphics, Dialogs,
  StdCtrls, BGRABitmap, BGRABitmapTypes, BGRAGradients
  {$IFDEF LCLGTK2},gtk2, WSProc{$ENDIF};

type

  { TAbstractRoundSpinEditTheme }

  TAbstractRoundSpinEditTheme = class abstract(TPersistent)
  private
    FButtonWidth, FButtonHeight: integer;
    FPadding: integer;
    FBgColor: TColor;
    FFontSize: integer;
    FFontColor: TColor;
  protected
    function GetHeight: integer; virtual; abstract;
  public
    property ButtonHeight: integer read FButtonHeight;
    property ButtonWidth: integer read FButtonWidth;
    property Height: integer read GetHeight;

    procedure PaintBox(Canvas: TCanvas; ScaleFactor: double); virtual; abstract;
    procedure PaintUpArrowButton(Canvas: TCanvas; ScaleFactor: double);
      virtual; abstract;
    procedure PaintDownArrowButton(Canvas: TCanvas; ScaleFactor: double);
      virtual; abstract;
    procedure PaintUpArrowButtonHover(Canvas: TCanvas; ScaleFactor: double);
      virtual; abstract;
    procedure PaintDownArrowButtonHover(Canvas: TCanvas; ScaleFactor: double);
      virtual; abstract;
    procedure PaintUpArrowButtonPressed(Canvas: TCanvas; ScaleFactor: double);
      virtual; abstract;
    procedure PaintDownArrowButtonPressed(Canvas: TCanvas; ScaleFactor: double);
      virtual; abstract;
    procedure UpdateControls(Edit: TEdit; UpDown: TCustomControl); virtual; abstract;
  end;

  { TDefaultRoundSpinEditTheme }

  TDefaultRoundSpinEditTheme = class(TAbstractRoundSpinEditTheme)
  private
    FButtonBgColor, FButtonBgHoverColor: TColor;
    FBorderRadius, FBorderWidth: integer;
    FBorderColor: TColor;
    FButtonBorderRadius, FButtonBorderWidth: integer;
    FButtonBorderColor: TColor;
    FArrowColor: TColor;
  private
    procedure ScalePoints(var Points: array of TPoint; scaleFactor: single);
  protected
  const
    ARROW_BUTTON_WIDTH = 18;
    ARROW_BUTTON_HEIGHT = 15;
    DARK_ARROW_BUTTON_BG_COLOR = TColor($666666);
    ARROW_BUTTON_BG_COLOR = TColor($dddddd);
    DARK_ARROW_BUTTON_HOVER_BG_COLOR = TColor($777777);
    ARROW_BUTTON_HOVER_BG_COLOR = TColor($eeeeee);
    DARK_ARROW_COLOR = TColor($111111);
    ARROW_COLOR = TColor($555555);
    ARROW_PADDING_TOP = 4;
    ARROW_PADDING_LEFT = 5;
    ARROW_BASE = 8;
    ARROW_MEDIAN = 7;
    ARROW_BORDER_RADIUS = 2;
    ARROW_BORDER_COLOR = clNone;
    ARROW_BORDER_WIDTH = 0;
    UP_DOWN_PADDING = 4;
    BG_COLOR = TColor($cccccc);
    DARK_BG_COLOR = TColor($444444);
    DARK_FONT_COLOR = TColor($cccccc);
    FONT_COLOR = TColor($555555);
    FONT_SIZE = 20;
    BOX_PADDING = 4;
    BORDER_COLOR = clNone;
    BORDER_RADIUS = 5;
    BORDER_WIDTH = 0;
  protected
    function GetHeight: integer; override;
    procedure DrawButtonBg(Bitmap: TBGRABitmap; ButtonColor: TColor;
      ScaleFactor: double);
    procedure DrawUpArrow(Bitmap: TBGRABitmap; ScaleFactor: double);
    procedure DrawDownArrow(Bitmap: TBGRABitmap; ScaleFactor: double);
  public
    property BorderRadius: integer read FBorderRadius write FBorderRadius;
    property BorderWidth: integer read FBorderWidth write FBorderWidth;
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property ButtonBorderRadius: integer read FButtonBorderRadius
      write FButtonBorderRadius;
    property ButtonBorderWidth: integer read FButtonBorderWidth write FButtonBorderWidth;
    property ButtonBorderColor: TColor read FButtonBorderColor write FButtonBorderColor;
    property ButtonBgColor: integer read FButtonBgColor write FButtonBgColor;
    property ButtonBgHoverColor: TColor read FButtonBgHoverColor
      write FButtonBgHoverColor;
    property ButtonHeight: integer read FButtonHeight write FButtonHeight;
    property ButtonWidth: integer read FButtonWidth write FButtonWidth;
    property Height: integer read GetHeight;
  public
    procedure PaintBox(Canvas: TCanvas; ScaleFactor: double); override;
    procedure PaintUpArrowButton(Canvas: TCanvas; ScaleFactor: double); override;
    procedure PaintDownArrowButton(Canvas: TCanvas; ScaleFactor: double); override;
    procedure PaintUpArrowButtonHover(Canvas: TCanvas; ScaleFactor: double); override;
    procedure PaintDownArrowButtonHover(Canvas: TCanvas; ScaleFactor: double); override;
    procedure PaintUpArrowButtonPressed(Canvas: TCanvas; ScaleFactor: double); override;
    procedure PaintDownArrowButtonPressed(Canvas: TCanvas; ScaleFactor: double);
      override;
    procedure UpdateControls(Edit: TEdit; UpDown: TCustomControl); override;

    procedure Assign(Source: TPersistent); override;

    constructor Create();
    constructor CreateNightTheme();
    destructor Destroy;
  end;

implementation

{$IFDEF LCLGTK2}
var isGtkResurseInit: boolean;
{$ENDIF}

{ TDefaultRoundSpinEditTheme }

procedure TDefaultRoundSpinEditTheme.ScalePoints(var Points: array of TPoint;
  scaleFactor: single);
var
  i: integer;
begin
  for i := Low(Points) to High(Points) do
  begin
    Points[i].X := round(Points[i].X * scaleFactor);
    Points[i].Y := round(Points[i].Y * scaleFactor);
  end;
end;

function TDefaultRoundSpinEditTheme.GetHeight: integer;
begin
  Result := FFontSize + 2 * FPadding + 2 * FBorderWidth;
end;

procedure TDefaultRoundSpinEditTheme.DrawButtonBg(Bitmap: TBGRABitmap;
  ButtonColor: TColor; ScaleFactor: double);
var
  radius, btnWidth, btnHeight, brdWidth: integer;
begin
  radius := round(FButtonBorderRadius * ScaleFactor);
  btnWidth := round(FButtonWidth * ScaleFactor) - 1;
  btnHeight := round(FButtonHeight * ScaleFactor) - 1;
  brdWidth := round(FButtonBorderWidth * ScaleFactor);
  Bitmap.Fill(FBgColor);
  Bitmap.RoundRectAntialias(0, 0, btnWidth,
    btnHeight, radius, radius, FButtonBorderColor,
    brdWidth, ButtonColor);
end;

procedure TDefaultRoundSpinEditTheme.DrawUpArrow(Bitmap: TBGRABitmap;
  ScaleFactor: double);
var
  points: array of TPoint;
begin
  points := [Point(FButtonWidth div 2, ARROW_PADDING_TOP),
    Point(ARROW_PADDING_LEFT, ARROW_PADDING_TOP + ARROW_MEDIAN),
    Point(FButtonWidth - ARROW_PADDING_LEFT, ARROW_PADDING_TOP + ARROW_MEDIAN),
    Point(FButtonWidth div 2, ARROW_PADDING_TOP)];
  ScalePoints(points, ScaleFactor);
  Bitmap.Canvas.Brush.Color := FArrowColor;
  Bitmap.Canvas.Pen.Width := 0;
  Bitmap.Canvas.AntialiasingMode := amOn;
  Bitmap.Canvas.Polygon(points);
end;

procedure TDefaultRoundSpinEditTheme.DrawDownArrow(Bitmap: TBGRABitmap;
  ScaleFactor: double);
var
  points: array of TPoint;
begin
  points := [Point(ARROW_PADDING_LEFT, ARROW_PADDING_TOP),
    Point(ARROW_PADDING_LEFT + ARROW_BASE, ARROW_PADDING_TOP),
    Point(FButtonWidth div 2, (ARROW_PADDING_TOP) + ARROW_MEDIAN),
    Point(ARROW_PADDING_LEFT, ARROW_PADDING_TOP)];
  ScalePoints(points, ScaleFactor);
  Bitmap.Canvas.Brush.Color := FArrowColor;
  Bitmap.Canvas.Pen.Width := 0;
  Bitmap.Canvas.AntialiasingMode := amOn;
  Bitmap.Canvas.Polygon(points);
end;

procedure TDefaultRoundSpinEditTheme.PaintBox(Canvas: TCanvas; ScaleFactor: double);
var
  bitmap: TBGRABitmap;
  radius: integer;
begin
  bitmap := TBGRABitmap.Create(round(Canvas.Width * ScaleFactor),
    round(Canvas.Height * ScaleFactor));
  radius := round(FBorderRadius * ScaleFactor);

  try
    bitmap.RoundRectAntialias(0, 0,
      bitmap.Width - 1, bitmap.Height - 1,
      radius, radius,
      FBorderColor, FBorderWidth,
      FBgColor);

    bitmap.Draw(Canvas, Rect(0, 0, Canvas.Width, Canvas.Height), False);

  finally
    FreeAndNil(bitmap);
  end;
end;

procedure TDefaultRoundSpinEditTheme.PaintUpArrowButton(Canvas: TCanvas;
  ScaleFactor: double);
var
  w, h: integer;
  bitmap: TBGRABitmap;
begin
  w := round(FButtonWidth * ScaleFactor);
  h := round(FButtonHeight * ScaleFactor);

  bitmap := TBGRABitmap.Create(w, h);
  try
    DrawButtonBg(bitmap, FButtonBgColor, ScaleFactor);
    DrawUpArrow(bitmap, ScaleFactor);
    bitmap.Draw(Canvas, Rect(0, 0, FButtonWidth, FButtonHeight), False);
  finally
    FreeAndNil(bitmap)
  end;
end;

procedure TDefaultRoundSpinEditTheme.PaintDownArrowButton(Canvas: TCanvas;
  ScaleFactor: double);
var
  w, h: integer;
  bitmap: TBGRABitmap;
begin
  w := round(FButtonWidth * ScaleFactor);
  h := round(FButtonHeight * ScaleFactor);

  bitmap := TBGRABitmap.Create(w, h);
  try
    DrawButtonBg(bitmap, FButtonBgColor, ScaleFactor);
    DrawDownArrow(bitmap, ScaleFactor);
    bitmap.Draw(Canvas, Rect(0, 0, FButtonWidth, FButtonHeight), False);
  finally
    FreeAndNil(bitmap)
  end;
end;

procedure TDefaultRoundSpinEditTheme.PaintUpArrowButtonHover(Canvas: TCanvas;
  ScaleFactor: double);
var
  w, h: integer;
  bitmap: TBGRABitmap;
begin
  w := round(FButtonWidth * ScaleFactor);
  h := round(FButtonHeight * ScaleFactor);

  bitmap := TBGRABitmap.Create(w, h);
  try
    DrawButtonBg(bitmap, FButtonBgHoverColor, ScaleFactor);
    DrawUpArrow(bitmap, ScaleFactor);
    bitmap.Draw(Canvas, Rect(0, 0, FButtonWidth, FButtonHeight), False);
  finally
    FreeAndNil(bitmap)
  end;
end;

procedure TDefaultRoundSpinEditTheme.PaintDownArrowButtonHover(Canvas: TCanvas;
  ScaleFactor: double);
var
  w, h: integer;
  bitmap: TBGRABitmap;
begin
  w := round(FButtonWidth * ScaleFactor);
  h := round(FButtonHeight * ScaleFactor);

  bitmap := TBGRABitmap.Create(w, h);
  try
    DrawButtonBg(bitmap, FButtonBgHoverColor, ScaleFactor);
    DrawDownArrow(bitmap, ScaleFactor);
    bitmap.Draw(Canvas, Rect(0, 0, FButtonWidth, FButtonHeight), False);
  finally
    FreeAndNil(bitmap)
  end;
end;

procedure TDefaultRoundSpinEditTheme.PaintUpArrowButtonPressed(Canvas: TCanvas;
  ScaleFactor: double);
var
  w, h: integer;
  bitmap: TBGRABitmap;
begin
  w := round(FButtonWidth * ScaleFactor);
  h := round(FButtonHeight * ScaleFactor);

  bitmap := TBGRABitmap.Create(w, h);
  try
    DrawButtonBg(bitmap, FButtonBgHoverColor, ScaleFactor);
    DrawUpArrow(bitmap, ScaleFactor);
    bitmap.Draw(Canvas, Rect(1, 1, FButtonWidth + 1, FButtonHeight + 1), False);
  finally
    FreeAndNil(bitmap)
  end;
end;

procedure TDefaultRoundSpinEditTheme.PaintDownArrowButtonPressed(Canvas: TCanvas;
  ScaleFactor: double);
var
  w, h: integer;
  bitmap: TBGRABitmap;
begin
  w := round(FButtonWidth * ScaleFactor);
  h := round(FButtonHeight * ScaleFactor);

  bitmap := TBGRABitmap.Create(w, h);
  try
    DrawButtonBg(bitmap, FButtonBgHoverColor, ScaleFactor);
    DrawDownArrow(bitmap, ScaleFactor);
    bitmap.Draw(Canvas, Rect(1, 1, FButtonWidth + 1, FButtonHeight + 1), False);
  finally
    FreeAndNil(bitmap)
  end;
end;

procedure TDefaultRoundSpinEditTheme.UpdateControls(Edit: TEdit;
  UpDown: TCustomControl);
begin
  Edit.BorderStyle := bsNone;
  Edit.Align := alClient;
  Edit.Alignment := taCenter;
  Edit.BorderSpacing.Around := FPadding;
  Edit.BorderSpacing.Left := FButtonWidth - 2 * FPadding;
  Edit.ParentColor := False;
  {$IFDEF LCLGTK2}
  // Color is not working with GTK see https://gitlab.com/freepascal.org/lazarus/lazarus/-/issues/38516
  // https://gitlab.com/freepascal.org/lazarus/lazarus/-/issues/38516
  // gtk theme affects the background style
  // turn off the theme engine
  if not isGtkResurseInit then
  begin
    isGtkResurseInit:=true;
    gtk_rc_parse_string(PChar('style "noengine" {' + LineEnding +
                                     'engine "" {}' + LineEnding +
                                     '}' + LineEnding +
                                     'widget "*.round-spin-edit" style "noengine"'));
  end;
  if WSCheckHandleAllocated(Edit, 'SetColor') then
  begin
    gtk_widget_set_name({%H-}PGtkWidget(Edit.Handle), 'round-spin-edit');
  end;
  {$ENDIF}

  Edit.Color := FBgColor;
  Edit.Font.Size := FFontSize;
  Edit.Font.Color := FFontColor;

  UpDown.BorderSpacing.Around := FPadding;
  UpDown.Color := FBgColor;
  UpDown.Width := FButtonWidth;
  UpDown.Align := alRight;
end;

procedure TDefaultRoundSpinEditTheme.Assign(Source: TPersistent);
begin
  if Source is TDefaultRoundSpinEditTheme then
  begin
    FArrowColor := TDefaultRoundSpinEditTheme(Source).FArrowColor;
    FBorderColor := TDefaultRoundSpinEditTheme(Source).FBorderColor;
    FBorderRadius := TDefaultRoundSpinEditTheme(Source).FBorderRadius;
    FBorderWidth := TDefaultRoundSpinEditTheme(Source).FBorderWidth;
    FButtonBgColor := TDefaultRoundSpinEditTheme(Source).FButtonBgColor;
    FButtonBorderColor := TDefaultRoundSpinEditTheme(Source).FButtonBorderColor;
    FButtonBgHoverColor := TDefaultRoundSpinEditTheme(Source).FButtonBgHoverColor;
    FButtonBorderRadius := TDefaultRoundSpinEditTheme(Source).FButtonBorderRadius;
    FButtonBorderWidth := TDefaultRoundSpinEditTheme(Source).FButtonBorderWidth;
    FBgColor := TDefaultRoundSpinEditTheme(Source).FBgColor;
    FButtonHeight := TDefaultRoundSpinEditTheme(Source).FButtonHeight;
    FButtonWidth := TDefaultRoundSpinEditTheme(Source).FButtonWidth;
    FFontColor := TDefaultRoundSpinEditTheme(Source).FFontColor;
    FFontSize := TDefaultRoundSpinEditTheme(Source).FFontSize;
    FPadding := TDefaultRoundSpinEditTheme(Source).FPadding;
  end
  else
    inherited Assign(Source);
end;

constructor TDefaultRoundSpinEditTheme.Create;
begin
  FButtonWidth := ARROW_BUTTON_WIDTH;
  FButtonHeight := ARROW_BUTTON_HEIGHT;
  FBorderRadius := BORDER_RADIUS;
  FBorderWidth := BORDER_WIDTH;
  FBorderColor := clNone;
  FPadding := BOX_PADDING;
  FBgColor := BG_COLOR;
  FFontSize := FONT_SIZE;
  FFontColor := FONT_COLOR;
  FButtonBgColor := ARROW_BUTTON_BG_COLOR;
  FButtonBgHoverColor := ARROW_BUTTON_HOVER_BG_COLOR;
  FButtonBorderRadius := ARROW_BORDER_RADIUS;
  FButtonBorderWidth := ARROW_BORDER_WIDTH;
  FButtonBorderColor := ARROW_BORDER_COLOR;
end;

constructor TDefaultRoundSpinEditTheme.CreateNightTheme;
begin
  Create();
  FBgColor := DARK_BG_COLOR;
  FFontColor := DARK_FONT_COLOR;
  FButtonBgColor := DARK_ARROW_BUTTON_BG_COLOR;
  FButtonBgHoverColor := DARK_ARROW_BUTTON_HOVER_BG_COLOR;
  FArrowColor := DARK_ARROW_COLOR;
end;

destructor TDefaultRoundSpinEditTheme.Destroy;
begin
  inherited Destroy;
end;

end.
