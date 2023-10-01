unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ExtCtrls, Menus,
  BGRAGraphicControl, BGRABitmap, BGRABitmapTypes,
  BGLVirtualScreen, ClockEllipse, ClockText, AppSettings, BGRAOpenGL, BCTypes,
  BCButton, states, ClockTimer, TrayIconTimer, SoundTimer;

type

  { TMainForm }

  TMainForm = class(TForm)
    MenuItemExit: TMenuItem;
    StartButton: TBCButton;
    BgImage: TBGRAGraphicControl;
    MenuItemShow: TMenuItem;
    MenuItemSound: TMenuItem;
    ImgTimer: TTimer;
    TrayMenu: TPopupMenu;
    TrayIcon: TTrayIcon;
    procedure BgImagePaint(Sender: TObject);
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
    AppSettings: RAppSettings;
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

const
  DayModeAppSettings: RAppSettings = (
    bg: TColor($eeeeee);
    breathInColor: TColor($00DA9062);
    breathOutColor: TColor($0062DA66); //todo correct the color
    clockBg: TColor($e8e8e8);
    clockStrockSize: 25;
    clockMarginLeft: 10;
    clockMarginTop: 60; );

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppSettings := DayModeAppSettings;
  MSec := 0;
  TrayIcon.Show();

  FBitmap := TBGRABitmap.Create;
  ClockEllipse := TClockEllipse.Create(Self.Width - AppSettings.clockMarginLeft *
    2, AppSettings);

  StateManager := TStateManager.Create(AppSettings);
  TextRect := ClockEllipse.InnerBoxRect;
  ClockText := TClockText.Create(TextRect, AppSettings, 5);
  ClockTimer := TClockTimer.Create(Self.Width, Self.Height, AppSettings);

  StartButton.Rounding.RoundX := 5;
  StartButton.Rounding.RoundY := 5;
  SetButtonStateStyle(StartButton, StateManager.State);
  StartButton.Font.Name := 'PT Caption';
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
  Self.Visible:= not Self.Visible;
end;

procedure TMainForm.SetButtonStateStyle(button: TBCButton; State: TState);

  procedure setStyle(btnState: TBCButtonState);
  begin
    btnState.Border.Width := 2;
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
    ImgTimer.Enabled := True;
    StartButton.Caption := 'Stop';
  end
  else
  begin
    ImgTimer.Enabled := False;
    StartButton.Caption := 'Start';
    StateManager.Reset;
    SetButtonStateStyle(StartButton, StateManager.State);
    if Self.Visible = True then Refresh;
    TrayIcon.Icon.Assign(MainTrayIcon);
  end;
end;

procedure TMainForm.BgImagePaint(Sender: TObject);
begin
  BgImage.Bitmap.Fill(AppSettings.bg); //TODO can be drawn only once
  ClockEllipse.DrawClock(BgImage.Bitmap, StateManager.State);
  ClockText.DrawText(BgImage.Bitmap, StateManager.State);
  ClockTimer.Draw(BgImage.Bitmap, StateManager.State);
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
