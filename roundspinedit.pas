unit RoundSpinEdit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, RoundSpinEditTheme, RoundUpDown;

type
  { TRoundSpinEdit }

  TRoundSpinEdit = class(TCustomControl)
  private
    FValue: integer;
    FMaxValue: integer;
    FMinValue: integer;
    FIncrement: integer;

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
    procedure EditChangeBounds(Sender: TObject);

    function GetValue: integer;
  protected
    FDefaultTheme, FTheme: TAbstractRoundSpinEditTheme;
    function GetCurrentTheme: TAbstractRoundSpinEditTheme;
    procedure SetTheme(ATheme: TAbstractRoundSpinEditTheme);
    procedure Paint; override;
    procedure CalculatePreferredSize(var PreferredWidth, PreferredHeight: integer;
      WithThemeSpace: boolean); override;

    procedure SetValue(const AValue: integer);
    procedure SetMaxValue(const AValue: integer);
    procedure SetMinValue(const AValue: integer);
    procedure KeyPress(Sender: TObject; var Key: char);
  public
    procedure UpdateTheme();
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Theme: TAbstractRoundSpinEditTheme read FTheme write SetTheme;
    property MinValue: integer read FMinValue write SetMinValue;
    property MaxValue: integer read FMaxValue write SetMaxValue nodefault;
    property Value: integer read GetValue write SetValue;
    property Increment: integer read FIncrement write FIncrement;
    property Edit: TEdit read FEdit;
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

{ TRoundSpinEdit }

procedure TRoundSpinEdit.ChangeEdit(Sender: TObject);
var
  newValue: integer;
begin
  try
    newValue := StrToInt(FEdit.Text);
  except
    on E: EConvertError do FEdit.Text := IntToStr(FValue);
  end;

  if IntToStr(FValue) <> FEdit.Text then
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

procedure TRoundSpinEdit.EditChangeBounds(Sender: TObject);
begin
  GetCurrentTheme.UpdateControls(FEdit, FUpDown);
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

function TRoundSpinEdit.GetCurrentTheme: TAbstractRoundSpinEditTheme;
begin
  if FTheme <> nil then
    Result := FTheme
  else
    Result := FDefaultTheme;
end;

procedure TRoundSpinEdit.SetTheme(ATheme: TAbstractRoundSpinEditTheme);
begin
  FTheme := ATheme;
  FUpDown.Theme := GetCurrentTheme;
  UpdateTheme();
end;

procedure TRoundSpinEdit.UpdateTheme;
begin
  GetCurrentTheme.UpdateControls(FEdit, FUpDown);
  Invalidate;
end;

procedure TRoundSpinEdit.Paint;
begin
  GetCurrentTheme.PaintBox(Canvas, GetCanvasScaleFactor);
end;

procedure TRoundSpinEdit.CalculatePreferredSize(
  var PreferredWidth, PreferredHeight: integer; WithThemeSpace: boolean);
begin
  inherited CalculatePreferredSize(PreferredWidth, PreferredHeight, WithThemeSpace);
  PreferredHeight := GetCurrentTheme.Height;
  PreferredWidth := 0;
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

constructor TRoundSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDefaultTheme := TDefaultRoundSpinEditTheme.Create();

  with GetControlClassDefaultSize do
    SetInitialBounds(0, 0, 185, 80);

  FValue := 0;

  FEdit := TEdit.Create(Self);
  FEdit.OnEnter := @EnterEdit;
  FEdit.OnExit := @ExitEdit;
  FEdit.OnChange := @ChangeEdit;
  FEdit.OnClick := @ClickEdit;
  FEdit.Align := alClient;
  FEdit.Parent := Self;
  FEdit.SetSubComponent(False);
  FEdit.ControlStyle := FEdit.ControlStyle - [csNoDesignSelectable];
  FEdit.OnKeyPress := @KeyPress;
  FEdit.OnChangeBounds := @EditChangeBounds;
  Self.Value := FValue;

  FUpDown := TRoundUpDown.Create(Self, FDefaultTheme);
  FUpDown.ControlStyle := FEdit.ControlStyle - [csNoDesignSelectable];
  FUpDown.Parent := Self;
  FUpDown.SetSubComponent(False);
  FUpDown.UpButtonOnClick := @UpButtonOnClick;
  FUpDown.DownButtonOnClick := @DownButtonOnClick;

  FDefaultTheme.UpdateControls(FEdit, FUpDown);

  FMaxValue := 100;
  FMinValue := 0;
  FIncrement := 1;
end;

destructor TRoundSpinEdit.Destroy;
begin
  FreeAndNil(FDefaultTheme);
  inherited Destroy;
end;

end.
