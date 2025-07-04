unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls, Menus, ComCtrls,
  StdCtrls, Buttons, ActnList, BGRAGraphicControl, BGRABitmap, BGRABitmapTypes,
  ClockEllipse, ClockText, AppSettings, BCTypes, BCButton, ColorSpeedButton,
  states, ClockTimer, TrayIconTimer, SoundTimer, Backgrounds, buttonState,
  SwitchBox, RoundSpinEdit, RoundSpinEditTheme, unit2;

type

  { TMainForm }

  TMainForm = class(TForm)
    SettingsButton: TColorSpeedButton;
    SettingsPanel: TPanel;
    TimerPanel: TPanel;
    ShowAboutFormAction: TAction;
    BreathInSpinEdit: TRoundSpinEdit;
    BreathOutSpinEdit: TRoundSpinEdit;
    HoldInSpinEdit: TRoundSpinEdit;
    HoldOutSpinEdit: TRoundSpinEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Separator1: TMenuItem;
    SoundLabel: TLabel;
    NightModeLabel: TLabel;
    ShowMainAction: TAction;
    ExitAction: TAction;
    NightModeSwitchBox: TSwitchBox;
    SoundSwitchBox: TSwitchBox;
    ToggleNightModeEnabledAction: TAction;
    ToggleSoundEnabledAction: TAction;
    SettingsBackAction: TAction;
    FormActionList: TActionList;
    BreathInLabel: TLabel;
    BreathOutLabel: TLabel;
    HoldInLabel: TLabel;
    HoldOutLabel: TLabel;
    ImageListButton: TImageList;
    LabelCaption: TLabel;
    MenuItemNightMode: TMenuItem;
    MenuItemExit: TMenuItem;
    SeparatorExit: TMenuItem;
    StartButton: TBCButton;
    BgImage: TBGRAGraphicControl;
    MenuItemShow: TMenuItem;
    MenuItemSound: TMenuItem;
    ImgTimer: TTimer;
    BackButton: TBCButton;
    TrayMenu: TPopupMenu;
    TrayIcon: TTrayIcon;
    procedure ExitActionExecute(Sender: TObject);
    procedure SettingsBackActionExecute(Sender: TObject);
    procedure BgImagePaint(Sender: TObject);
    procedure SettingsButtonClick(Sender: TObject);
    procedure SettingsButtonMouseEnter(Sender: TObject);
    procedure SettingsButtonMouseLeave(Sender: TObject);
    procedure ShowAboutFormActionExecute(Sender: TObject);
    procedure ShowMainActionExecute(Sender: TObject);
    procedure SpinEditChanged(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgTimerTimer(Sender: TObject);
    procedure ToggleNightModeEnabledActionExecute(Sender: TObject);
    procedure ToggleSoundEnabledActionExecute(Sender: TObject);
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
    NightRoundSpinEditTheme: TDefaultRoundSpinEditTheme;
    DayRoundSpinEditTheme: TDefaultRoundSpinEditTheme;
    procedure SetButtonStateStyle(button: TBCButton; State: TState);
    procedure UpdateFormColors;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppSettings := TAppSettings.Create;
  ToggleSoundEnabledAction.Checked := AppSettings.SoundEnabled;
  ToggleNightModeEnabledAction.Checked := AppSettings.NightModeEnabled;

  TrayIcon.Show();

  FSolidBackground := TSolidBackground.Create;
  FGradientBackground := TGradientBackround.Create(BgImage.Width,
    BgImage.Height, AppSettings);
  FBitmap := TBGRABitmap.Create;
  FBitmap.SetSize(BgImage.Width, BgImage.Height);
  ClockEllipse := TClockEllipse.Create(Self.Width - AppSettings.ClockMarginLeft *
    2, AppSettings);

  StateManager := TStateManager.Create(AppSettings);
  ClockText := TClockText.Create(ClockEllipse.InnerBoxRect, AppSettings, 5);
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

  NightRoundSpinEditTheme := TDefaultRoundSpinEditTheme.CreateNightTheme();
  DayRoundSpinEditTheme := TDefaultRoundSpinEditTheme.Create();

  FSettingButtonState := TButtonState.Create(ImageListButton, AppSettings);
  TimerPanel.Visible := True;
  SettingsPanel.Visible := False;
  UpdateFormColors;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(AppSettings);
  FreeAndNil(FSolidBackground);
  FreeAndNil(FGradientBackground);
  FreeAndNil(FBitmap);
  FreeAndNil(ClockEllipse);
  FreeAndNil(ClockText);
  FreeAndNil(ClockTimer);
  FreeAndNil(StateManager);
  FreeAndNil(TrayIconTimer);
  FreeAndNil(MainTrayIcon);
  FreeAndNil(SoundTimer);
  FreeAndNil(FSettingButtonState);
  FreeAndNil(NightRoundSpinEditTheme);
  FreeAndNil(DayRoundSpinEditTheme);
end;

procedure TMainForm.ImgTimerTimer(Sender: TObject);
begin
  StateManager.tick(ImgTimer.Interval);
  SetButtonStateStyle(StartButton, StateManager.State);
  if Self.Visible = True then BgImage.Refresh;
  TrayIconTimer.Draw(TrayIcon.Icon, StateManager.State);
  if ToggleSoundEnabledAction.Checked then
  begin
    SoundTimer.PlayEverySecond(StateManager.State);
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
  UpdateFormColors;
  TimerPanel.Refresh;
end;

procedure TMainForm.ToggleSoundEnabledActionExecute(Sender: TObject);
begin
  AppSettings.SoundEnabled := not AppSettings.SoundEnabled;
  ToggleSoundEnabledAction.Checked := AppSettings.SoundEnabled;
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

procedure TMainForm.UpdateFormColors;
var
  i: integer;
begin
  MainForm.Color := AppSettings.Bg;
  MainForm.Font.Color := AppSettings.FontColor;
  SettingsButton.Color := AppSettings.Bg;
  SettingsButton.StateActive.Color := AppSettings.Bg;
  SettingsButton.StateDisabled.Color := AppSettings.Bg;
  SettingsButton.StateHover.Color := AppSettings.Bg;
  SettingsButton.StateNormal.Color := AppSettings.Bg;
  SettingsButton.ImageIndex :=
    FSettingButtonState.GetDefaultImageIndex(StateManager.State);
  SettingsButton.Refresh;
  for i := 0 to SettingsPanel.ControlCount - 1 do
  begin
    if not SettingsPanel.Controls[i].IsParentFont then;
    SettingsPanel.Controls[i].Font.Color := AppSettings.FontColor;
  end;

  if AppSettings.NightModeEnabled then
  begin
    BreathInSpinEdit.Theme := NightRoundSpinEditTheme;
    BreathOutSpinEdit.Theme := NightRoundSpinEditTheme;
    HoldInSpinEdit.Theme := NightRoundSpinEditTheme;
    HoldOutSpinEdit.Theme := NightRoundSpinEditTheme;
  end
  else
  begin
    BreathInSpinEdit.Theme := DayRoundSpinEditTheme;
    BreathOutSpinEdit.Theme := DayRoundSpinEditTheme;
    HoldInSpinEdit.Theme := DayRoundSpinEditTheme;
    HoldOutSpinEdit.Theme := DayRoundSpinEditTheme;
  end;
end;

procedure TMainForm.StartButtonClick(Sender: TObject);
begin
  if not ImgTimer.Enabled then
  begin
    StateManager.Reset;
    ImgTimer.Enabled := True;
    StartButton.Caption := 'Stop';
    SoundTimer.StartDevice;
  end
  else
  begin
    ImgTimer.Enabled := False;
    StartButton.Caption := 'Start';
    SetButtonStateStyle(StartButton, StateManager.State);
    if Self.Visible = True then BGImage.Refresh;
    TrayIcon.Icon.Assign(MainTrayIcon);
    SoundTimer.StartDevice;
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
  TimerPanel.Visible := True;
  SettingsPanel.Visible := False;
end;

procedure TMainForm.ExitActionExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TMainForm.SettingsButtonClick(Sender: TObject);
begin
  TimerPanel.Visible := False;
  SettingsPanel.Visible := True;
end;

procedure TMainForm.SettingsButtonMouseEnter(Sender: TObject);
begin
  FSettingButtonState.Focused := True;
  SettingsButton.ImageIndex :=
    FSettingButtonState.GetFocusImageIndex(StateManager.State);
end;

procedure TMainForm.SettingsButtonMouseLeave(Sender: TObject);
begin
  FSettingButtonState.Focused := False;
  SettingsButton.ImageIndex :=
    FSettingButtonState.GetDefaultImageIndex(StateManager.State);
end;

procedure TMainForm.ShowAboutFormActionExecute(Sender: TObject);
begin
  AboutForm.Show;
end;

procedure TMainForm.ShowMainActionExecute(Sender: TObject);
begin
  Self.Visible := not Self.Visible;
end;

procedure TMainForm.SpinEditChanged(Sender: TObject);
begin
  StateManager.SetMaxTime(BreathInSpinEdit.Value * 1000, HoldInSpinEdit.Value * 1000,
    BreathOutSpinEdit.Value * 1000, HoldOutSpinEdit.Value * 1000);
end;

end.
