unit SwitchBox;

{$mode ObjFPC}{$H+}
{$R switchboxpackage.res}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LMessages, LCLType, ActnList,
  LazMethodList, SwitchBoxTheme, BGRABitmap;

type

  { TSwitchBox }

  TSwitchBox = class(TCustomControl)
  private
    FBitmap: TBGRABitmap;
    FChecked: boolean;
    FCheckBoxHovered: boolean;
    FCheckFromAction: boolean;

    FCheckedText: string;
    FUncheckedText: string;

    function GetChecked: boolean;
    procedure SetChecked(AValue: boolean);
    procedure SetCheckBoxHovered(AValue: boolean);

  protected
    CheckBoxPressed: boolean;
    FOnChange: TNotifyEvent;
    FTheme: TAbstractSwitchBoxTheme;

    procedure Paint; override;
    procedure Draw;

    function DialogChar(var Message: TLMKey): boolean; override;
    procedure DoClick;
    procedure DoEnter; override;
    procedure DoExit; override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
    procedure KeyUp(var Key: word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    property CheckFromAction: boolean read FCheckFromAction write FCheckFromAction;
    property CheckBoxHovered: boolean read FCheckBoxHovered write SetCheckBoxHovered;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Checked: boolean read GetChecked write SetChecked default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property CheckedText: string read FCheckedText write FCheckedText;
    property UncheckedText: string read FUncheckedText write FUncheckedText;

  published
    property Action;
    //property Align;
    //property Anchors;
    //property AutoSize default True;
    //property BiDiMode;
    //property BorderSpacing;
    //property Caption;
    //property Checked;
    //property Color;
    //property Constraints;
    property Cursor;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    //property Font;
    //property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property Left;
    //property ParentBiDiMode;
    //property ParentColor;
    //property ParentFont;
    //property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Top;
    property Visible;
    //property Width;
    property OnChangeBounds;
    //property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEditingDone;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDrag;
    property OnUTF8KeyPress;
  end;

  TSwitchBoxActionLink = class(TControlActionLink)
  protected
    FClientSwitchBox: TSwitchBox;
    procedure AssignClient(AClient: TObject); override;
    procedure SetChecked(Value: boolean); override;
  public
    function IsCheckedLinked: boolean; override;
  end;

  TSwitchBoxActionLinkClass = class of TSwitchBoxActionLink;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Misc', [TSwitchBox]);
end;

{ TSwitchBox }

function TSwitchBox.GetChecked: boolean;
begin
  Result := FChecked;
end;

procedure TSwitchBox.SetChecked(AValue: boolean);
begin
  if FChecked <> AValue then
  begin
    FChecked := AValue;
    Draw;
  end;

  if Assigned(OnEditingDone) then OnEditingDone(self);
  if Assigned(OnChange) then OnChange(self);
  { Execute only when Action.Checked is changed }
  if not CheckFromAction then
  begin
    if Assigned(OnClick) then
      if not (Assigned(Action) and CompareMethods(
        TMethod(Action.OnExecute), TMethod(OnClick))) then OnClick(self);
    if (Action is TCustomAction) and (TCustomAction(Action).Checked <> AValue) then
      ActionLink.Execute(self);
  end;

  Invalidate;
end;

procedure TSwitchBox.SetCheckBoxHovered(AValue: boolean);
begin
  if FCheckBoxHovered = AValue then exit;
  FCheckBoxHovered := AValue;
  Invalidate;
end;

procedure TSwitchBox.Paint;
begin
  FBitmap.Draw(Canvas, rect(0, 0, Canvas.Width, Canvas.Height), False);
  inherited Paint;
end;

procedure TSwitchBox.Draw;
begin
  if FChecked then
    FTheme.DrawChecked(FBitmap)
  else
    FTheme.DrawUnchecked(FBitmap);
end;

function TSwitchBox.DialogChar(var Message: TLMKey): boolean;
begin
  Result := False;
  if Message.Msg = LM_SYSCHAR then
  begin
    if IsEnabled and IsVisible then
    begin
      if IsAccel(Message.CharCode, Caption) then
      begin
        DoClick;
        SetFocus;
        Result := True;
      end
      else
        Result := inherited DialogChar(Message);
    end;
  end;
end;

procedure TSwitchBox.DoClick;
begin
  Checked := not Checked;
end;

procedure TSwitchBox.DoEnter;
begin
  inherited DoEnter;
  Invalidate;
end;

procedure TSwitchBox.DoExit;
begin
  inherited DoExit;
  Invalidate;
end;

function TSwitchBox.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TSwitchBoxActionLink;
end;

procedure TSwitchBox.KeyDown(var Key: word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key in [VK_RETURN, VK_SPACE]) and not (ssCtrl in Shift) then
  begin
    CheckBoxPressed := True;
    Invalidate;
  end;
end;

procedure TSwitchBox.KeyUp(var Key: word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if (Key in [VK_RETURN, VK_SPACE]) and not (ssCtrl in Shift) then
  begin
    CheckBoxPressed := False;
    DoClick;
  end;
end;

procedure TSwitchBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and CheckBoxHovered then
  begin
    CheckBoxPressed := True;
    Invalidate;
  end;
  SetFocus;
end;

procedure TSwitchBox.MouseEnter;
begin
  inherited MouseEnter;
  CheckBoxHovered := True;
end;

procedure TSwitchBox.MouseLeave;
begin
  inherited MouseLeave;
  CheckBoxHovered := False;
end;

procedure TSwitchBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    DoClick;
    CheckBoxPressed := False;
  end;
end;

constructor TSwitchBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  AccessibleRole := larCheckBox;
  ControlStyle := ControlStyle + [csParentBackground, csReplicatable] -
    [csOpaque] - csMultiClicks - [csClickEvents, csNoStdEvents];
  { inherited Click not used }
  AutoSize := True;
  TabStop := True;

  FChecked := False;
  FTheme := TDefaultSwitchBoxTheme.Create();
  Width := FTheme.Width;
  Height := FTheme.Height;

  FBitmap := FTheme.CreateBitmap;
  Draw;
end;

destructor TSwitchBox.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

{ TSwitchBoxActionLink }

procedure TSwitchBoxActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClientSwitchBox := AClient as TSwitchBox;
end;

function TSwitchBoxActionLink.IsCheckedLinked: boolean;
begin
  Result := inherited IsCheckedLinked and (FClientSwitchBox.Checked =
    (Action as TCustomAction).Checked);
end;

procedure TSwitchBoxActionLink.SetChecked(Value: boolean);
begin
  if IsCheckedLinked then
  begin
    FClientSwitchBox.CheckFromAction := True;
    try
      FClientSwitchBox.Checked := Value;
    finally
      FClientSwitchBox.CheckFromAction := False;
    end;
  end;
end;

end.
