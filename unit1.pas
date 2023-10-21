unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls, Menus,
  BGRAGraphicControl, BGRABitmap, BGRABitmapTypes,
  BGLVirtualScreen, ClockEllipse, ClockText, AppSettings, BGRAOpenGL, BCTypes,
  BCButton, states, ClockTimer, TrayIconTimer, SoundTimer, Backgrounds;

type

  { TMainForm }

  TMainForm = class(TForm)
    NightModeItem: TMenuItem;
    MenuItemExit: TMenuItem;
    SeparatorExit: TMenuItem;
    StartButton: TBCButton;
    BgImage: TBGRAGraphicControl;
    MenuItemShow: TMenuItem;
    MenuItemSound: TMenuItem;
    ImgTimer: TTimer;
    TrayMenu: TPopupMenu;
    TrayIcon: TTrayIcon;
    procedure BgImagePaint(Sender: TObject);
    procedure NightModeItemClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemShowClick(Sender: TObject);
    procedure MenuItemSoundClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgTimerTimer(Sender: TObject);
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
  if NightModeItem.Checked then
    AppSettings := TAppSettings.CreateNight
  else
    AppSettings := TAppSettings.CreateDay;

  MSec := 0;
  TrayIcon.Show();

  FSolidBackground := TSolidBackground.Create;
  FGradientBackground := TGradientBackround.Create(BgImage.Width, BgImage.Height, AppSettings);
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
  StartButton.Font.Name := AppSettings.MainFontName;
  StartButton.Font.Size := 14;

  TrayIconTimer := TTrayIconTimer.Create(AppSettings);
  MainTrayIcon := TIcon.Create;
  MainTrayIcon.Assign(TrayIcon.Icon);

  SoundTimer := TSoundTimer.Create;
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
end;

procedure TMainForm.ImgTimerTimer(Sender: TObject);
begin
  StateManager.tick(ImgTimer.Interval);
  SetButtonStateStyle(StartButton, StateManager.State);
  if Self.Visible = True then Refresh;
  TrayIconTimer.Draw(TrayIcon.Icon, StateManager.State);
  if MenuItemSound.Checked then
  begin
    SoundTimer.play(StateManager.State);
  end;
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
    if Self.Visible = True then Refresh;
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

  BgImage.Bitmap.BlendImage(0, 0, FBitmap, boLinearBlend);
end;

procedure TMainForm.NightModeItemClick(Sender: TObject);
begin
  NightModeItem.Checked := not NightModeItem.Checked;
  if NightModeItem.Checked then
    AppSettings.ActivateNightMode
  else
    AppSettings.ActivateDayMode;
end;

procedure TMainForm.MenuItemExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TMainForm.MenuItemShowClick(Sender: TObject);
begin
  Self.Visible := not Self.Visible;
end;

procedure TMainForm.MenuItemSoundClick(Sender: TObject);
begin
  MenuItemSound.Checked := not MenuItemSound.Checked;
end;

end.
