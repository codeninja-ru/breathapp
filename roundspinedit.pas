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
  type

    { TArrowButton }

    TArrowButton = class(TGraphicControl)
    private
      FIsHover: boolean;
      FIsPressed: boolean;
    protected
      FBitmap, FHoverBitmap: TBGRABitmap;
      procedure DrawButton(Bitmap: TBGRABitmap; BgColor: TColor);
      procedure DrawArrow(Bitmap: TBGRABitmap); virtual; abstract;
      procedure Paint; override;
      procedure Draw;
      procedure ButtonMouseEnter(Sender: TObject);
      procedure ButtonMouseLeave(Sender: TObject);
      procedure ButtonMouseUp(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: integer);
      procedure ButtonMouseDown(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: integer);
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
    end;

    { TUpButton }

    TUpButton = class(TArrowButton)
    protected
      procedure DrawArrow(Bitmap: TBGRABitmap); override;
    end;

    { TDownButton }

    TDownButton = class(TArrowButton)
      procedure DrawArrow(Bitmap: TBGRABitmap); override;
    end;

  private
    FUpButton: TUpButton;
    FDownButton: TDownButton;

  protected
  const
    ARROW_BUTTON_WIDTH = 18;
    ARROW_BUTTON_HEIGHT = 15;
    ARROW_BUTTON_BG_COLOR = TColor($666666);
    ARROW_BUTTON_HOVER_BG_COLOR = TColor($777777);
    ARROW_COLOR = TColor($111111);
    ARROW_PADDING_TOP = 4;
    ARROW_PADDING_LEFT = 5;
    ARROW_BASE = 8;
    ARROW_MEDIAN = 7;
    BORDER_RADIUS = 2;
    BORDER_COLOR = clNone;
    BORDER_WIDTH = 0;
    UP_DOWN_PADDING = 4;
    procedure SetUpButtonOnClick(Value: TNotifyEvent);
    procedure SetDownButtonOnClick(Value: TNotifyEvent);
  public
    property UpButtonOnClick: TNotifyEvent write SetUpButtonOnClick;
    property DownButtonOnClick: TNotifyEvent write SetDownButtonOnClick;

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

    FValue: integer;
    FMaxValue: integer;
    FMinValue: integer;
    FIncrement: integer;

    FAccentColor: TColor;
    FDisabledColor: TColor;

    FEdit: TEdit;
    FUpDown: TRoundUpDown;
    FFocused: boolean;
    FOnChange: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    procedure ChangeEdit(Sender: TObject);
    procedure EnterEdit(Sender: TObject);
    procedure ExitEdit(Sender: TObject);
    procedure ClickEdit(Sender: TObject);
    procedure UpButtonOnClick(Sender: TObject);
    procedure DownButtonOnClick(Sender: TObject);

    function GetValue: integer;
  protected
    procedure Paint; override;
    procedure CalculatePreferredSize(var PreferredWidth, PreferredHeight: integer;
      WithThemeSpace: boolean); override;

    procedure SetValue(const AValue: integer);
    procedure SetMaxValue(const AValue: integer);
    procedure SetMinValue(const AValue: integer);
    class function GetControlClassDefaultSize: TSize; override;
    procedure KeyPress(Sender: TObject; var Key: char);
  public
    //property Width: integer read GetWidth write SetWidth;
    constructor Create(AOwner: TComponent); override;
  published
    property MinValue: integer read FMinValue write SetMinValue;
    property MaxValue: integer read FMaxValue write SetMaxValue nodefault;
    property Value: integer read GetValue write SetValue;
    property Increment: integer read FIncrement write FIncrement;
    property Color;
    property Edit: TEdit read FEdit;
    property DisabledColor: TColor read FDisabledColor write FDisabledColor;
    property AccentColor: TColor read FAccentColor write FAccentColor;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I roundspinedit_icon.lrs}
  RegisterComponents('Misc', [TRoundSpinEdit]);
end;

{ TRoundUpDown.TDownButton }

procedure TRoundUpDown.TDownButton.DrawArrow(Bitmap: TBGRABitmap);
begin
  Bitmap.Canvas.Brush.Color := ARROW_COLOR;
  Bitmap.Canvas.Pen.Width := 0;
  Bitmap.Canvas.AntialiasingMode := amOn;
  Bitmap.Canvas.Polygon([Point(ARROW_PADDING_LEFT, ARROW_PADDING_TOP),
    Point(ARROW_PADDING_LEFT + ARROW_BASE, ARROW_PADDING_TOP),
    Point(ARROW_BUTTON_WIDTH div 2, (ARROW_PADDING_TOP) + ARROW_MEDIAN),
    Point(ARROW_PADDING_LEFT, ARROW_PADDING_TOP)]);
end;

{ TRoundUpDown.TUpButton }

procedure TRoundUpDown.TUpButton.DrawArrow(Bitmap: TBGRABitmap);
begin
  Bitmap.Canvas.Brush.Color := ARROW_COLOR;
  Bitmap.Canvas.Pen.Width := 0;
  Bitmap.Canvas.AntialiasingMode := amOn;
  Bitmap.Canvas.Polygon([Point(ARROW_BUTTON_WIDTH div 2, ARROW_PADDING_TOP),
    Point(ARROW_PADDING_LEFT, ARROW_PADDING_TOP + ARROW_MEDIAN),
    Point(ARROW_BUTTON_WIDTH - ARROW_PADDING_LEFT, ARROW_PADDING_TOP + ARROW_MEDIAN),
    Point(ARROW_BUTTON_WIDTH div 2, ARROW_PADDING_TOP)]);
end;

{ TRoundUpDown.TArrowButton }

procedure TRoundUpDown.TArrowButton.DrawButton(Bitmap: TBGRABitmap; BgColor: TColor);
begin
  Bitmap.Fill($444444); //todo replace with const
  Bitmap.RoundRectAntialias(0, 0, ARROW_BUTTON_WIDTH - 1,
    ARROW_BUTTON_HEIGHT - 1, BORDER_RADIUS, BORDER_RADIUS, BORDER_COLOR,
    BORDER_WIDTH, BgColor);
end;

procedure TRoundUpDown.TArrowButton.Paint;
begin
  if FIsPressed then FHoverBitmap.Draw(Self.Canvas, 1, 1)
  else if FIsHover then FHoverBitmap.Draw(Self.Canvas, 0, 0)
  else
    FBitmap.Draw(Self.Canvas, 0, 0);

  inherited Paint;
end;

procedure TRoundUpDown.TArrowButton.Draw;
begin
  DrawButton(FBitmap, ARROW_BUTTON_BG_COLOR);
  DrawArrow(FBitmap);

  DrawButton(FHoverBitmap, ARROW_BUTTON_HOVER_BG_COLOR);
  DrawArrow(FHoverBitmap);
end;

procedure TRoundUpDown.TArrowButton.ButtonMouseEnter(Sender: TObject);
begin
  FIsHover := True;
  Invalidate;
end;

procedure TRoundUpDown.TArrowButton.ButtonMouseLeave(Sender: TObject);
begin
  FIsHover := False;
  Invalidate;
end;

procedure TRoundUpDown.TArrowButton.ButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Button = mbLeft then
    FIsPressed := False;
  Invalidate;
end;

procedure TRoundUpDown.TArrowButton.ButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Button = mbLeft then
    FIsPressed := True;
  Invalidate;
end;

constructor TRoundUpDown.TArrowButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsHover := False;
  FIsPressed := False;
  Self.OnMouseEnter := @ButtonMouseEnter;
  Self.OnMouseLeave := @ButtonMouseLeave;
  Self.OnMouseUp := @ButtonMouseUp;
  Self.OnMouseDown := @ButtonMouseDown;

  FBitmap := TBGRABitmap.Create(ARROW_BUTTON_WIDTH, ARROW_BUTTON_HEIGHT);
  FHoverBitmap := TBGRABitmap.Create(ARROW_BUTTON_WIDTH, ARROW_BUTTON_HEIGHT);
  Draw;
end;

destructor TRoundUpDown.TArrowButton.Destroy;
begin
  FreeAndNil(FBitmap);
  FreeAndNil(FHoverBitmap);
  inherited Destroy;
end;

{ TRoundUpDown }

constructor TRoundUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FUpButton := TUpButton.Create(Self);
  FUpButton.Parent := Self;
  FUpButton.Width := ARROW_BUTTON_WIDTH;
  FUpButton.Height := ARROW_BUTTON_HEIGHT;
  FUpButton.Align := alTop;

  FDownButton := TDownButton.Create(Self);
  FDownButton.Parent := Self;
  FDownButton.Width := ARROW_BUTTON_WIDTH;
  FDownButton.Height := ARROW_BUTTON_HEIGHT;
  FDownButton.Align := alBottom;

  Self.Width := ARROW_BUTTON_WIDTH;
end;

destructor TRoundUpDown.Destroy;
begin
  FreeAndNil(FUpButton);
  FreeAndNil(FDownButton);
  inherited Destroy;
end;

procedure TRoundUpDown.SetUpButtonOnClick(Value: TNotifyEvent);
begin
  FUpButton.OnClick := Value;
end;

procedure TRoundUpDown.SetDownButtonOnClick(Value: TNotifyEvent);
begin
  FDownButton.OnClick := Value;
end;

{ TRoundSpinEdit }

procedure TRoundSpinEdit.ChangeEdit(Sender: TObject);
var
  newValue: integer;
begin
  try
  newValue := StrToInt(FEdit.Text);
  except
    on E: EConvertError do FEdit.Text:=IntToStr(FValue);
  end;

  if (newValue <> FValue) then
  begin
    if (newValue <= FMaxValue) and (newValue >= FMinValue) then
    begin
      FValue := newValue;
      if Assigned(FOnChange) then
        FOnChange(Self);
    end
    else
      FEdit.Text := IntToStr(FValue);
  end;
end;

procedure TRoundSpinEdit.EnterEdit(Sender: TObject);
begin
  FFocused := True;
  Invalidate;
  if Assigned(FOnEnter) then FOnEnter(Self);
end;

procedure TRoundSpinEdit.ExitEdit(Sender: TObject);
begin
  FFocused := False;
  Invalidate;
  if Assigned(FOnExit) then FOnExit(Self);
end;

procedure TRoundSpinEdit.ClickEdit(Sender: TObject);
begin
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TRoundSpinEdit.UpButtonOnClick(Sender: TObject);
begin
  Self.Value := Self.Value + FIncrement;
end;

procedure TRoundSpinEdit.DownButtonOnClick(Sender: TObject);
begin
  Self.Value := Self.Value - FIncrement;
end;

procedure TRoundSpinEdit.KeyPress(Sender: TObject; var Key: char);
begin
  inherited KeyPress(Key);
  if not (Key in ['0'..'9', '+', '-', #8, #9, ^C, ^X, ^V, ^Z]) then Key := #0;
end;

function TRoundSpinEdit.GetValue: integer;
begin
  Result := FValue;
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

procedure TRoundSpinEdit.CalculatePreferredSize(
  var PreferredWidth, PreferredHeight: integer; WithThemeSpace: boolean);
begin
  PreferredHeight := FEdit.Font.Height + 2 * FPadding;
end;

procedure TRoundSpinEdit.SetValue(const AValue: integer);
var
  newValue: string;
begin
  if (AValue > FMaxValue) or (AValue < FMinValue) then exit;
  try
    newValue := IntToStr(AValue);
    if FEdit.Text <> newValue then
    begin
      FEdit.Text := newValue;
      FValue := AValue;
    end;
  except
    //do nothing
  end;
end;

procedure TRoundSpinEdit.SetMaxValue(const AValue: integer);
begin
  FMaxValue := AValue;
  if FMaxValue < FValue then
    Self.Value := FMaxValue;
end;

procedure TRoundSpinEdit.SetMinValue(const AValue: integer);
begin
  FMinValue := AValue;
  if FMinValue > FValue then
    Self.Value := FMinValue;
end;

class function TRoundSpinEdit.GetControlClassDefaultSize: TSize;
begin
  Result.CX := 80;
  Result.CY := 40;
end;

constructor TRoundSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  {with GetControlClassDefaultSize do
    SetInitialBounds(0, 0, 80 + 2 * FPadding, 30); }
  FValue := 0;
  FBorderRadius := 5;
  FBorderWidth := 0;
  FBorderColor := clNone;
  FBgColor := $444444;
  FPadding := 4;

  AccentColor := clHighlight;
  DisabledColor := $00B8AFA8;
  FEdit := TEdit.Create(Self);
  FEdit.BorderStyle := bsNone;
  //FEdit.Color := Color;
  //FEdit.Font.Color := clBlack;
  FEdit.OnEnter := @EnterEdit;
  FEdit.OnExit := @ExitEdit;
  FEdit.OnChange := @ChangeEdit;
  FEdit.OnClick := @ClickEdit;
  //FEdit.Width:=Self.Width;
  FEdit.Align := alClient;
  FEdit.BorderStyle := bsNone;
  //FEdit.TextHint := 'Buscar';
  FEdit.BorderSpacing.Around := 4;
  FEdit.Color := $444444;
  FEdit.Font.Size := 22;
  //FEdit.MinValue := 0;
  //FEdit.MaxValue := MaxInt;
  FEdit.Parent := Self;
  FEdit.SetSubComponent(True);
  FEdit.ControlStyle := FEdit.ControlStyle - [csNoDesignSelectable];
  FEdit.OnKeyPress := @KeyPress;
  Self.Value := FValue;

  FUpDown := TRoundUpDown.Create(Self);
  FUpDown.Parent := Self;
  FUpDown.Align := alRight;
  FUpDown.BorderSpacing.Around := 4;
  FUpDown.Color := $444444; //todo replace with color
  FUpDown.UpButtonOnClick := @UpButtonOnClick;
  FUpDown.DownButtonOnClick := @DownButtonOnClick;

  FMaxValue := 10;
  FMinValue := 0;
  FIncrement := 1;
end;

end.
