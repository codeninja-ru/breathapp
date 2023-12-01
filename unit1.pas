unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls, Menus, ComCtrls,
  StdCtrls, Buttons, Spin, ActnList, BGRAGraphicControl,
  BGRABitmap, BGRABitmapTypes, ClockEllipse, ClockText, AppSettings,
  BCTypes, BCButton, states, ClockTimer, TrayIconTimer, SoundTimer,
  Backgrounds, buttonState;

type

  { TMainForm }

  TMainForm = class(TForm)
    ShowAction: TAction;
    ExitAction: TAction;
    ToggleNightModeEnabledAction: TAction;
    ToggleSoundEnabledAction: TAction;
    SettingsBackAction: TAction;
    FormActionList: TActionList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NightModeCheckBox: TCheckBox;
    SoundCheckBox: TCheckBox;
    HoldOutSpinEdit: TSpinEdit;
    HoldInSpinEdit: TSpinEdit;
    BreathOutSpinEdit: TSpinEdit;
    ImageListButton: TImageList;
    LabelCaption: TLabel;
    MenuItemNightMode: TMenuItem;
    MenuItemExit: TMenuItem;
    PageControl: TPageControl;
    SeparatorExit: TMenuItem;
    BreathInSpinEdit: TSpinEdit;
    SettingsButton: TSpeedButton;
    StartButton: TBCButton;
    BgImage: TBGRAGraphicControl;
    MenuItemShow: TMenuItem;
    MenuItemSound: TMenuItem;
    ImgTimer: TTimer;
    BackButton: TBCButton;
    TabTimer: TTabSheet;
    TabSettings: TTabSheet;
    TrayMenu: TPopupMenu;
    TrayIcon: TTrayIcon;
    procedure ExitActionExecute(Sender: TObject);
    procedure SettingsBackActionExecute(Sender: TObject);
    procedure BgImagePaint(Sender: TObject);
    procedure SettingsButtonClick(Sender: TObject);
    procedure SettingsButtonMouseEnter(Sender: TObject);
    procedure SettingsButtonMouseLeave(Sender: TObject);
    procedure ShowActionExecute(Sender: TObject);
    procedure SpineEditChanged(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgTimerTimer(Sender: TObject);
    procedure ToggleNightModeEnabledActionExecute(Sender: TObject);
    procedure ToggleSoundEnabledActionExecute(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
  private
    ClockEllipse: TClockEllipse;
    ClockText: TClockText;
    ClockTimer: TClockTimer;
    SoundTimer: TSoundTimer;
    FSolidBackground: TSolidBackground;
    FGradientBackground: TGradientBackround;
    AppSettings: TAppSettings;
    FBitmap: TBGRABitmap;
    StateManager: TStateManager;
    TrayIconTimer: TTrayIconTimer;
    MainTrayIcon: TIcon;
    FSettingButtonState: TButtonState;
    procedure SetButtonStateStyle(button: TBCButton; State: TState);
  public
  end;

var
  MainForm: TMainForm;
  MSec: integer;
  TextRect: TRect;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if MenuItemNightMode.Checked then
    AppSettings := TAppSettings.CreateNight
  else
    AppSettings := TAppSettings.CreateDay;
  ToggleSoundEnabledAction.Checked := AppSettings.SoundEnabled;
  ToggleNightModeEnabledAction.Checked := AppSettings.NightModeEnabled;

  MSec := 0;
  TrayIcon.Show();

  FSolidBackground := TSolidBackground.Create;
  FGradientBackground := TGradientBackround.Create(BgImage.Width,
    BgImage.Height, AppSettings);
  FBitmap := TBGRABitmap.Create;
  FBitmap.SetSize(BgImage.Width, BgImage.Height);
  ClockEllipse := TClockEllipse.Create(Self.Width - AppSettings.ClockMarginLeft *
    2, AppSettings);

  StateManager := TStateManager.Create(AppSettings);
  TextRect := ClockEllipse.InnerBoxRect;
  ClockText := TClockText.Create(TextRect, AppSettings, 5);
  ClockTimer := TClockTimer.Create(Self.Width, Self.Height, AppSettings);

  StartButton.Rounding.RoundX := 20;
  StartButton.Rounding.RoundY := 20;
  SetButtonStateStyle(StartButton, StateManager.State);
  SetButtonStateStyle(BackButton, StateManager.State);
  StartButton.Font.Name := AppSettings.MainFontName;
  StartButton.Font.Size := 14;

  TrayIconTimer := TTrayIconTimer.Create(AppSettings);
  MainTrayIcon := TIcon.Create;
  MainTrayIcon.Assign(TrayIcon.Icon);

  SoundTimer := TSoundTimer.Create;

  FSettingButtonState := TButtonState.Create(ImageListButton, AppSettings);
  Self.PageControl.ActivePageIndex := 0;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ClockEllipse.Free;
  ClockText.Free;
  ClockTimer.Free;
  FBitmap.Free;
  StateManager.Free;
  TrayIconTimer.Free;
  MainTrayIcon.Free;
  SoundTimer.Free;
  FSolidBackground.Free;
  FGradientBackground.Free;
  AppSettings.Free;
  FSettingButtonState.Free;
end;

procedure TMainForm.ImgTimerTimer(Sender: TObject);
begin
  StateManager.tick(ImgTimer.Interval);
  SetButtonStateStyle(StartButton, StateManager.State);
  if Self.Visible = True then BgImage.Refresh;
  TrayIconTimer.Draw(TrayIcon.Icon, StateManager.State);
  if ToggleSoundEnabledAction.Checked then
  begin
    SoundTimer.play(StateManager.State);
  end;
end;

procedure TMainForm.ToggleNightModeEnabledActionExecute(Sender: TObject);
begin
  AppSettings.NightModeEnabled := not AppSettings.NightModeEnabled;
  if AppSettings.NightModeEnabled then
    AppSettings.ActivateNightMode
  else
    AppSettings.ActivateDayMode;
  ToggleNightModeEnabledAction.Checked := AppSettings.NightModeEnabled;
  TabTimer.Refresh;
end;

procedure TMainForm.ToggleSoundEnabledActionExecute(Sender: TObject);
begin
  AppSettings.SoundEnabled := not AppSettings.SoundEnabled;
  ToggleSoundEnabledAction.Checked := AppSettings.SoundEnabled;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  Self.Visible := not Self.Visible;
end;

procedure TMainForm.SetButtonStateStyle(button: TBCButton; State: TState);

  procedure setStyle(btnState: TBCButtonState);
  begin
    btnState.Background.Color := clNone;
    btnState.Border.Style := bboSolid;
    btnState.Border.Color := State.MainColor;
    btnState.FontEx.Color := State.MainColor;
    btnState.FontEx.Shadow := False;
    btnState.FontEx.Style := [];
  end;

begin
  if button.StateNormal.Border.Color <> State.MainColor then
  begin
    setStyle(button.StateNormal);
    setStyle(button.StateHover);
    setStyle(button.StateClicked);
  end;
end;

procedure TMainForm.StartButtonClick(Sender: TObject);
begin
  if not ImgTimer.Enabled then
  begin
    StateManager.Reset;
    ImgTimer.Enabled := True;
    StartButton.Caption := 'Stop';
  end
  else
  begin
    ImgTimer.Enabled := False;
    StartButton.Caption := 'Start';
    SetButtonStateStyle(StartButton, StateManager.State);
    if Self.Visible = True then BGImage.Refresh;
    TrayIcon.Icon.Assign(MainTrayIcon);
  end;
end;

procedure TMainForm.BgImagePaint(Sender: TObject);
var
  state: TState;
begin
  state := StateManager.State;
  FSolidBackground.Draw(FBitmap, state);
  FGradientBackground.Draw(BgImage.Bitmap, state);
  ClockEllipse.DrawClock(FBitmap, state);
  ClockText.DrawText(FBitmap, state);
  ClockTimer.Draw(FBitmap, state);
  FSettingButtonState.Draw(state, SettingsButton);

  BgImage.Bitmap.BlendImage(0, 0, FBitmap, boLinearBlend);
end;

procedure TMainForm.SettingsBackActionExecute(Sender: TObject);
begin
  PageControl.PageIndex := 0;
end;

procedure TMainForm.ExitActionExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TMainForm.SettingsButtonClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := 1;
end;

procedure TMainForm.SettingsButtonMouseEnter(Sender: TObject);
begin
  SettingsButton.Cursor := crHandPoint;
  SettingsButton.ImageIndex :=
    FSettingButtonState.GetFocusImageIndex(StateManager.State);
end;

procedure TMainForm.SettingsButtonMouseLeave(Sender: TObject);
begin
  SettingsButton.Cursor := crDefault;
  SettingsButton.ImageIndex :=
    FSettingButtonState.GetDefaultImageIndex(StateManager.State);
end;

procedure TMainForm.ShowActionExecute(Sender: TObject);
begin
  Self.Visible := not Self.Visible;
end;

procedure TMainForm.SpineEditChanged(Sender: TObject);
begin
  StateManager.SetMaxTime(BreathInSpinEdit.Value * 1000, HoldInSpinEdit.Value * 1000,
    BreathOutSpinEdit.Value * 1000, HoldOutSpinEdit.Value * 1000);
end;

end.
