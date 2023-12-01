unit AppSettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics, ColorUtils;

type

  { TAppSettings }

  TAppSettings = class
  private
    FBg: TColor;
    FBreathInColor, FBreathInColorSecond: TColor;
    FBreathOutColor, FBreathOutColorSecond: TColor;
    FHoldColor, FHoldColorSecond: TColor;
    FClockBg: TColor;
    FClockStrockSize: integer;
    FClockMarginLeft: integer;
    FClockMarginTop: integer;
    FMainFontName: string;
    FSecondFontName: string;
    FSoundEnabled: boolean;
    FNightModeEnabled: boolean;

    constructor Create;
  public
    property Bg: TColor read FBg;
    property BreathInColor: TColor read FBreathInColor;
    property BreathInColorSecond: TColor read FBreathInColorSecond;
    property BreathOutColor: TColor read FBreathOutColor;
    property BreathOutColorSecond: TColor read FBreathOutColorSecond;
    property HoldColor: TColor read FHoldColor;
    property HoldColorSecond: TColor read FHoldColorSecond;
    property ClockBg: TColor read FClockBg;
    property ClockStrockSize: integer read FClockStrockSize;
    property ClockMarginLeft: integer read FClockMarginLeft;
    property ClockMarginTop: integer read FClockMarginTop;
    property MainFontName: string read FMainFontName;
    property SecondFontName: string read FSecondFontName;
    property NightModeEnabled: boolean read FNightModeEnabled write FNightModeEnabled;
    property SoundEnabled: boolean read FSoundEnabled write FSoundEnabled;

    constructor CreateDay;
    constructor CreateNight;
    procedure ActivateDayMode;
    procedure ActivateNightMode;
  end;

implementation

{ TAppSettings }

constructor TAppSettings.Create;
begin
  FNightModeEnabled := False;
  FSoundEnabled := True;
end;

constructor TAppSettings.CreateDay;
begin
  Self.Create;
  Self.ActivateDayMode;
end;

constructor TAppSettings.CreateNight;
begin
  Self.Create;
  Self.ActivateNightMode;
end;

procedure TAppSettings.ActivateDayMode;
begin
  with Self do
  begin
    FBg := TColor($eeeeee);
    FBreathInColor := webHSL(217, 62, 62);
    FBreathInColorSecond := webHSL(267, 62, 62);
    FBreathOutColor := webHSL(0, 62, 62);
    FBreathOutColorSecond := webHSL(267, 62, 62);
    FHoldColor := webHSL(146, 62, 62);
    FHoldColorSecond := webHSL(217, 62, 62);
    FClockBg := TColor($e8e8e8);
    FClockStrockSize := 25;
    FClockMarginLeft := 10;
    FClockMarginTop := 60;
    FMainFontName := 'PT Sans Caption';
    FSecondFontName := 'PT Sans';
  end;
end;

procedure TAppSettings.ActivateNightMode;
begin
  with Self do
  begin
    FBg := TColor($111111);
    FBreathInColor := webHSL(217, 62, 62);
    FBreathInColorSecond := webHSL(267, 62, 62);
    FBreathOutColor := webHSL(0, 62, 62);
    FBreathOutColorSecond := webHSL(267, 62, 62);
    FHoldColor := webHSL(146, 62, 62);
    FHoldColorSecond := webHSL(217, 62, 62);
    FClockBg := TColor($171717);
    FClockStrockSize := 25;
    FClockMarginLeft := 10;
    FClockMarginTop := 60;
    FMainFontName := 'PT Sans Caption';
    FSecondFontName := 'PT Sans';
  end;
end;

initialization

end.
