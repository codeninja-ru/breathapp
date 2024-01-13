unit RoundUpDown;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Controls, Graphics, Dialogs,
  StdCtrls, RoundSpinEditTheme;

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
      FTheme: TAbstractRoundSpinEditTheme;
    protected
      procedure ButtonMouseEnter(Sender: TObject);
      procedure ButtonMouseLeave(Sender: TObject);
      procedure ButtonMouseUp(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: integer);
      procedure ButtonMouseDown(Sender: TObject; Button: TMouseButton;
        Shift: TShiftState; X, Y: integer);
      procedure CalculatePreferredSize(var PreferredWidth, PreferredHeight: integer;
        WithThemeSpace: boolean); override;
      procedure SetTheme(Value: TAbstractRoundSpinEditTheme);
    public
      property Theme: TAbstractRoundSpinEditTheme write FTheme;

      constructor Create(AOwner: TComponent; ATheme: TAbstractRoundSpinEditTheme);
      destructor Destroy; override;
    end;

    { TUpButton }

    TUpButton = class(TArrowButton)
    protected
      procedure Paint; override;
    end;

    { TDownButton }

    TDownButton = class(TArrowButton)
      procedure Paint; override;
    end;

  private
    FUpButton: TUpButton;
    FDownButton: TDownButton;
    FTheme: TAbstractRoundSpinEditTheme;

  protected
    procedure SetUpButtonOnClick(Value: TNotifyEvent);
    procedure SetDownButtonOnClick(Value: TNotifyEvent);
    procedure SetTheme(Value: TAbstractRoundSpinEditTheme);
  public
    property Theme: TAbstractRoundSpinEditTheme write SetTheme;
    property UpButtonOnClick: TNotifyEvent write SetUpButtonOnClick;
    property DownButtonOnClick: TNotifyEvent write SetDownButtonOnClick;
    property UpButton: TUpButton read FUpButton;
    property DownButton: TDownButton read FDownButton;

    constructor Create(AOwner: TComponent; ATheme: TAbstractRoundSpinEditTheme);
    destructor Destroy; override;
  end;

implementation

{ TRoundUpDown.TDownButton }

procedure TRoundUpDown.TDownButton.Paint;
begin
  if FIsPressed then FTheme.PaintDownArrowButtonPressed(Canvas, GetCanvasScaleFactor)
  else if FIsHover then FTheme.PaintDownArrowButtonHover(Canvas, GetCanvasScaleFactor)
  else
    FTheme.PaintDownArrowButton(Canvas, GetCanvasScaleFactor);
end;

{ TRoundUpDown.TUpButton }

procedure TRoundUpDown.TUpButton.Paint;
begin
  if FIsPressed then FTheme.PaintUpArrowButtonPressed(Canvas, GetCanvasScaleFactor)
  else if FIsHover then FTheme.PaintUpArrowButtonHover(Canvas, GetCanvasScaleFactor)
  else
    FTheme.PaintUpArrowButton(Canvas, GetCanvasScaleFactor);
end;

{ TRoundUpDown.TArrowButton }

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

procedure TRoundUpDown.TArrowButton.CalculatePreferredSize(
  var PreferredWidth, PreferredHeight: integer; WithThemeSpace: boolean);
begin
  PreferredWidth := FTheme.ButtonWidth;
  PreferredHeight := FTheme.ButtonHeight;
end;

procedure TRoundUpDown.TArrowButton.SetTheme(Value: TAbstractRoundSpinEditTheme);
begin
  FTheme := Value;
  Width := FTheme.ButtonWidth;
  Height := FTheme.ButtonHeight;
  Invalidate;
end;

constructor TRoundUpDown.TArrowButton.Create(AOwner: TComponent;
  ATheme: TAbstractRoundSpinEditTheme);
begin
  inherited Create(AOwner);
  FIsHover := False;
  FIsPressed := False;
  Self.OnMouseEnter := @ButtonMouseEnter;
  Self.OnMouseLeave := @ButtonMouseLeave;
  Self.OnMouseUp := @ButtonMouseUp;
  Self.OnMouseDown := @ButtonMouseDown;
  Theme := ATheme;
end;

destructor TRoundUpDown.TArrowButton.Destroy;
begin
  inherited Destroy;
end;

{ TRoundUpDown }

constructor TRoundUpDown.Create(AOwner: TComponent; ATheme: TAbstractRoundSpinEditTheme);
begin
  inherited Create(AOwner);

  FUpButton := TUpButton.Create(Self, ATheme);
  FUpButton.Parent := Self;
  FUpButton.Width := ATheme.ButtonWidth;
  FUpButton.Height := ATheme.ButtonHeight;
  FUpButton.Align := alTop;
  FUpButton.ControlStyle := FUpButton.ControlStyle - [csNoDesignSelectable];
  FUpButton.SetSubComponent(False);

  FDownButton := TDownButton.Create(Self, ATheme);
  FDownButton.Parent := Self;
  FDownButton.Width := ATheme.ButtonWidth;
  FDownButton.Height := ATheme.ButtonHeight;
  FDownButton.Align := alBottom;
  FDownButton.ControlStyle := FDownButton.ControlStyle - [csNoDesignSelectable];
  FDownButton.SetSubComponent(False);
  Self.Width := ATheme.ButtonWidth;
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

procedure TRoundUpDown.SetTheme(Value: TAbstractRoundSpinEditTheme);
begin
  FTheme := Value;
  FUpButton.Theme := Value;
  FDownButton.Theme := Value;
  Self.Width := Value.ButtonWidth;
end;

end.
