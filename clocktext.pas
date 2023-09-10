unit ClockText;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AppSettings, BGRABitmap, BGRABitmapTypes;

type

  { TClockText }

  TClockText = class(TObject)
  private
    TextBitmap: TBGRABitmap;
    rect : TRect;
    prevSec: integer;
    AppSettings: RAppSettings;
    textBox: TAffineBox;
    x2, y2, maxSec : integer;
    procedure UpdateTextBox(num : string);
  public
    constructor Create(ARect : TRect; AAppColors: RAppSettings; AMaxSec : Integer);
    destructor Destroy; override;

    procedure DrawText(FBitmap: TBGRABitmap; MSec: integer);
  end;

implementation

procedure TClockText.UpdateTextBox(num: string);
begin
  textBox := TextBitmap.TextAffineBox(num);
  textBox.Offset(x2 - Round(textBox.Width / 2), y2 - Round(TextBitmap.Height / 2));
end;

constructor TClockText.Create(ARect : TRect; AAppColors: RAppSettings; AMaxSec : Integer);
begin
  inherited Create;
  rect := ARect;
  maxSec := AMaxSec;
  AppSettings := AAppColors;
  TextBitmap := TBGRABitmap.Create();
  TextBitmap.SetSize(rect.Width, rect.Height);
  x2 := rect.Width div 2;
  y2 := rect.Height div 2;
  prevSec := maxSec;
  UpdateTextBox(IntToStr(maxSec));
end;

destructor TClockText.Destroy;
begin
  TextBitmap.Free;
  inherited Destroy;
end;

procedure TClockText.DrawText(FBitmap: TBGRABitmap; MSec: integer);
var
  sec: integer;
  strSec: string;
begin
  sec := Msec div 1000;
  if sec <> prevSec then
  begin
    //TextBitmap.FillRect(0, 0, textBox.Width, textBox.Height, );
    TextBitmap.FontHeight := 124;
    TextBitmap.FontName := 'PT Caption';
    TextBitmap.FontAntialias := True;
    if (sec = 0) or (sec = maxSec) then strSec := IntToStr(maxSec) else strSec := IntToStr(maxSec - sec);
    TextBitmap.FillRect(textBox.RectBounds, AppSettings.bg, dmDrawWithTransparency);
    UpdateTextBox(strSec);
    TextBitmap.TextOut(x2 - Round(textBox.Width / 2),
      y2 - Round(TextBitmap.Height / 2),
      strSec,
      AppSettings.main);
  end;
  prevSec := sec;
  FBitmap.BlendImage(rect.Left, rect.Top, TextBitmap, boLinearBlend);
end;

end.
