unit RoundSpinEdit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin, BGRABitmap, BGRABitmapTypes, BGRAGradients, Buttons;

type

{ TRoundUpDown }

  TRoundUpDown = class(TCustomControl)
  private
    FUpButton: TSpeedButton;
    FDownButton: TSpeedButton;
    FUpBitmap: TBGRABitmap;
    FDownBitmap: TBGRABitmap;
    FBitmap: TBitmap;
  protected const
    ARROW_BUTTON_WIDTH = 18;
    ARROW_BUTTON_HEIGHT = 15;
    UP_DOWN_PADDING = 4;
    procedure DrawUpArrow(Bitmap: TBitmap);
    procedure DrawDownArrow(Bitmap: TBitmap);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  { TRoundSpinEdit }

  TRoundSpinEdit = class(TCustomControl)
  private
    FBitmap: TBGRABitmap;
    FBorderRadius: integer;
    FBorderWidth: integer;
    FBorderColor: TColor;
    FBgColor: TColor;
    FPadding: integer;

    FAccentColor: TColor;
    FDisabledColor: TColor;

    FEdit: TEdit;
    FUpDown: TRoundUpDown;
    FPanel: TPanel;
    FFocused: boolean;
    FOnChange: TNotifyEvent;
    procedure ChangeEdit(Sender: TObject);
    procedure EnterEdit(Sender: TObject);
    procedure ExitEdit(Sender: TObject);
  protected
    procedure Paint; override;
    procedure CalculatePreferredSize(var PreferredWidth, PreferredHeight: integer;
      WithThemeSpace: boolean); override;
  public
    //property Width: integer read GetWidth write SetWidth;

    constructor Create(AOwner: TComponent); override;
  published
    property Color;
    property Edit: TEdit read FEdit;
    property DisabledColor: TColor read FDisabledColor write FDisabledColor;
    property AccentColor: TColor read FAccentColor write FAccentColor;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I roundspinedit_icon.lrs}
  RegisterComponents('Misc',[TRoundSpinEdit]);
end;

{ TRoundUpDown }

constructor TRoundUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FUpBitmap := TBGRABitmap.Create(ARROW_BUTTON_WIDTH, ARROW_BUTTON_HEIGHT);
  FDownBitmap := TBGRABitmap.Create(ARROW_BUTTON_WIDTH, ARROW_BUTTON_HEIGHT);
  //DrawUpArrow(FUpBitmap);

  FUpButton:=TSpeedButton.Create(Self);
  FUpButton.Parent:= Self;
  FUpButton.SetSubComponent(true);
  FUpButton.Width:=ARROW_BUTTON_WIDTH;
  FUpButton.Height:=ARROW_BUTTON_HEIGHT;
  //FUpButton.BorderSpacing.Around:=4;
  FUpButton.Color:=clNone;
  FUpButton.Flat:=true;
  FUpButton.Align:=alTop;

  FDownButton:=TSpeedButton.Create(AOwner);
  FDownButton.Parent:=Self;
  FDownButton.SetSubComponent(true);
  FDownButton.Width:=ARROW_BUTTON_WIDTH;
  FDownButton.Height:=ARROW_BUTTON_HEIGHT;
  FDownButton.Color:=clNone;
  FDownButton.Flat:=true;
  FDownButton.Align:=alBottom;

  Self.Width:= FUpButton.Width;
  FBitmap := TBitmap.Create;
  FBitmap.SetSize(ARROW_BUTTON_WIDTH, ARROW_BUTTON_HEIGHT);

  DrawUpArrow(FBitmap);
  FUpButton.Glyph.Assign(FBitmap);
end;

destructor TRoundUpDown.Destroy;
begin
  FreeAndNil(FUpBitmap);
  FreeAndNil(FDownBitmap);
  inherited Destroy;
end;

procedure TRoundUpDown.DrawUpArrow(Bitmap: TBitmap);
begin
  Bitmap.BeginUpdate(true);
  Bitmap.Canvas.Pen.Width:=0;
  Bitmap.Canvas.Brush.Color := RGBToColor(105, 101, 101);
  Bitmap.Canvas.RoundRect(0, 0, Bitmap.Width, Bitmap.Height, 2, 2);
  Bitmap.Canvas.Brush.Color:=$111111;
  Bitmap.Canvas.Polygon([
    Point(10, 20),
    Point(18, 8),
    Point(27, 20),
    Point(10, 20)
  ]);

  Bitmap.EndUpdate();
end;

procedure TRoundUpDown.DrawDownArrow(Bitmap: TBitmap);
begin

end;

{ TRoundSpinEdit }

procedure TRoundSpinEdit.ChangeEdit(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TRoundSpinEdit.EnterEdit(Sender: TObject);
begin
  FFocused := True;
  Invalidate;
end;

procedure TRoundSpinEdit.ExitEdit(Sender: TObject);
begin
  FFocused := False;
  Invalidate;
end;

procedure TRoundSpinEdit.Paint;
begin
  inherited Paint;

  FBitmap := TBGRABitmap.Create(Width, Height);

  try
    FBitmap.RoundRectAntialias(0, 0,
    FBitmap.Width - 1, FBitmap.Height - 1,
    FBorderRadius, FBorderRadius,
    FBorderColor, FBorderWidth,
    FBgColor);

    FBitmap.Draw(Canvas, 0, 0);

  finally
    FreeAndNil(FBitmap);
  end;
end;

procedure TRoundSpinEdit.CalculatePreferredSize(var PreferredWidth,
  PreferredHeight: integer; WithThemeSpace: boolean);
begin
  PreferredHeight:=FEdit.Font.Height + 2 * FPadding;
end;

constructor TRoundSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  {with GetControlClassDefaultSize do
    SetInitialBounds(0, 0, 80 + 2 * FPadding, 30); }

  FBorderRadius := 5;
  FBorderWidth:=0;
  FBorderColor:=clNone;
  FBgColor := $444444;
  FPadding:=4;

  AccentColor := clHighlight;
  DisabledColor := $00B8AFA8;
  FEdit := TEdit.Create(Self);
  FEdit.BorderStyle:=bsNone;
  //FEdit.Color := Color;
  //FEdit.Font.Color := clBlack;
  FEdit.OnEnter := @EnterEdit;
  FEdit.OnExit := @ExitEdit;
  FEdit.OnChange:=@ChangeEdit;
  //FEdit.Width:=Self.Width;
  FEdit.Align := alClient;
  FEdit.BorderStyle := bsNone;
  //FEdit.TextHint := 'Buscar';
  FEdit.BorderSpacing.Around := 4;
  FEdit.Color := $444444;
  //FEdit.MinValue := 0;
  //FEdit.MaxValue := MaxInt;
  FEdit.Parent := Self;
  FEdit.SetSubComponent(true);
  FEdit.ControlStyle := FEdit.ControlStyle - [csNoDesignSelectable];

  FUpDown:=TRoundUpDown.Create(Self);
  FUpDown.Parent := Self;
  FUpDown.Align:=alRight;
  FUpDown.BorderSpacing.Around:= 4;
  FUpDown.Color:= $444444;
end;

end.
