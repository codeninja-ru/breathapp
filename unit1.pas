unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, OpenGLContext, DTAnalogClock, DTAnalogGauge, dtthemedgauge,
  dtthemedclock, BCMaterialDesignButton, BCMDButton, BGRAGraphicControl,
  BGRAVirtualScreen, BGRABitmap, BGRABitmapTypes, BGLVirtualScreen,
  ClockEllipse, ClockText, AppSettings, BGRAOpenGL, BCTypes, states;

type

  { TMainForm }

  TMainForm = class(TForm)
    BgImage: TBGRAGraphicControl;
    Button2: TButton;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    ImgTimer: TTimer;
    TrayMenu: TPopupMenu;
    TrayIcon: TTrayIcon;
    procedure BgImagePaint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgTimerTimer(Sender: TObject);
  private
    ClockEllipse: TClockEllipse;
    ClockText: TClockText;
    AppSettings: RAppSettings;
    FBitmap: TBGRABitmap;
    StateManager : TStateManager;
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
  //TextRect := TRect.Create(124 div 2, 170 div 2, 124 div 2 + 190, 170 div 2 + 190);
  TextRect := ClockEllipse.InnerBoxRect;
  ClockText := TClockText.Create(TextRect, AppSettings, 5);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ClockEllipse.Free;
  ClockText.Free;
  FBitmap.Free;
  StateManager.Free;
end;

procedure TMainForm.ImgTimerTimer(Sender: TObject);
begin
  StateManager.tick(ImgTimer.Interval);
  BgImage.Refresh;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ImgTimer.Enabled := True;
end;

procedure TMainForm.BgImagePaint(Sender: TObject);
begin
  BgImage.Bitmap.Fill(AppSettings.bg); //TODO can be drawn only once
  ClockEllipse.DrawClock(BgImage.Bitmap, StateManager.State);
  ClockText.DrawText(BgImage.Bitmap, StateManager.State);
end;

end.
