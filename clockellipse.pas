unit ClockEllipse;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, BGRABitmap, BGRABitmapTypes, BGRAGradients,
  AppSettings, states, Graphics;

type

  { TClockEllipse }

  TClockEllipse = class(TObject)
  private
    FClockBitmap, FMaskBitmap: TBGRABitmap;
    x, y, r, w: cardinal;
    AppSettings: RAppSettings;
    procedure DrawBackground(const FBitmap: TBGRABitmap; xx, yy: integer; State: TState);
    function GetInnerBoxRect(): TRect;
  public
    property InnerBoxRect: TRect read GetInnerBoxRect;
    procedure DrawClock(Bitmap: TBGRABitmap; State: TState);

    constructor Create(AWidth: integer; AAppColors: RAppSettings);
    destructor Destroy; override;
  end;

implementation

constructor TClockEllipse.Create(AWidth: integer; AAppColors: RAppSettings);
begin
  inherited Create;

  Self.AppSettings := AAppColors;
  FClockBitmap := TBGRABitmap.Create(AWidth, AWidth);
  FMaskBitmap := TBGRABitmap.Create(AWidth, AWidth);
  FMaskBitmap.Fill(clDontMask);
  r := (AWidth - AppSettings.clockStrockSize) div 2;
  x := AWidth div 2;
  y := x;
  w := AWidth;
end;

destructor TClockEllipse.Destroy;
begin
  FClockBitmap.Free;
  FMaskBitmap.Free;
  inherited Destroy;
end;

procedure TClockEllipse.DrawBackground(const FBitmap: TBGRABitmap;
  xx, yy: integer; State: TState);
begin
  FBitmap.EllipseAntialias(xx, yy, r, r, State.BgSecondColor,
    AppSettings.clockStrockSize + 2);
end;

function TClockEllipse.GetInnerBoxRect: TRect;
var
  topx, topy, bottomx, bottomy, a, b, xd, yd: integer;
  rr: real;
begin
  rr := r - AppSettings.clockStrockSize / 2;
  b := Round(rr * Cos(Pi / 4));
  a := Round(rr * Sin(Pi / 4));
  topx := x - b;
  topy := y - a;

  bottomx := x + b;
  bottomy := y + a;

  xd := AppSettings.clockMarginLeft;
  yd := AppSettings.clockMarginTop;

  Result := TRect.Create(topx + xd, topy + yd, bottomx + xd, bottomy + yd);
end;

procedure TClockEllipse.DrawClock(Bitmap: TBGRABitmap; State: TState);
var
  rad: real;
begin
  rad := State.ClockPersent * 2 * Pi;
  DrawBackground(FClockBitmap, x, y, State);
  if rad <> 0 then
    begin
      FMaskBitmap.Fill(clDontMask);
      FMaskBitmap.Arc(x,
        y,
        r,
        r,
        Pi / 2,
        (Pi / 2) - rad,
        clMask,
        AppSettings.clockStrockSize,
        False,
        BGRAPixelTransparent);
    end;


  Bitmap.BlendImage(AppSettings.clockMarginLeft,
    AppSettings.clockMarginTop,
    FClockBitmap,
    boLinearBlend);
  Bitmap.EraseMask(AppSettings.clockMarginLeft, AppSettings.clockMarginTop, FMaskBitmap);
end;

end.
