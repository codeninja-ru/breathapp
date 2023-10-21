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
    prevState: StateType;
    prevBgSecondColor: TColor;
    x, y, r, w: cardinal;
    AppSettings: TAppSettings;
    procedure DrawBackground(const FBitmap: TBGRABitmap; xx, yy: integer; State: TState);
    function GetInnerBoxRect(): TRect;
  public
    property InnerBoxRect: TRect read GetInnerBoxRect;
    procedure DrawClock(Bitmap: TBGRABitmap; State: TState);

    constructor Create(AWidth: integer; AAppColors: TAppSettings);
    destructor Destroy; override;
  end;

implementation

constructor TClockEllipse.Create(AWidth: integer; AAppColors: TAppSettings);
begin
  inherited Create;

  Self.AppSettings := AAppColors;
  FClockBitmap := TBGRABitmap.Create(AWidth, AWidth);
  FMaskBitmap := TBGRABitmap.Create(AWidth, AWidth);
  FMaskBitmap.Fill(clDontMask);
  r := (AWidth - AppSettings.ClockStrockSize) div 2;
  x := AWidth div 2;
  y := x;
  w := AWidth;
  prevState := stHoldOut;
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
  if prevBgSecondColor <> State.BgSecondColor then
  begin
    FBitmap.Fill(clNone);
  end;
  if (prevState <> State.StateType) or (prevBgSecondColor <> State.BgSecondColor) then
  begin
    FBitmap.EllipseAntialias(xx, yy, r, r, State.BgSecondColor,
      AppSettings.ClockStrockSize + 2);
    prevBgSecondColor := State.BgSecondColor;
  end;
end;

function TClockEllipse.GetInnerBoxRect: TRect;
var
  topx, topy, bottomx, bottomy, a, b, xd, yd: integer;
  rr: real;
begin
  rr := r - AppSettings.ClockStrockSize / 2;
  b := Round(rr * Cos(Pi / 4));
  a := Round(rr * Sin(Pi / 4));
  topx := x - b;
  topy := y - a;

  bottomx := x + b;
  bottomy := y + a;

  xd := AppSettings.ClockMarginLeft;
  yd := AppSettings.ClockMarginTop;

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
        AppSettings.ClockStrockSize,
        False,
        BGRAPixelTransparent);
    end;

  prevState := State.StateType;

  Bitmap.BlendImage(AppSettings.ClockMarginLeft,
    AppSettings.ClockMarginTop,
    FClockBitmap,
    boLinearBlend);
  Bitmap.EraseMask(AppSettings.ClockMarginLeft, AppSettings.ClockMarginTop, FMaskBitmap);
end;

end.
