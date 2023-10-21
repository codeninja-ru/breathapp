unit TrayIconTimer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics, BGRABitmap, BGRABitmapTypes, states,
  AppSettings, ExtCtrls;

const
  ICON_SIZE = 32;

type

  { TTrayIconTimer }

  TTrayIconTimer = class
  private
    FAppSettings: TAppSettings;
    FBitmap: TBGRABitmap;
    prevSeconds: integer;
    prevStateType: StateType;
    xr, yr: integer;
  public
    constructor Create(AAppSettings: TAppSettings);
    destructor Destory;

    procedure Draw(Icon: TIcon; State: TState);
  end;

implementation

{ TTrayIconTimer }

constructor TTrayIconTimer.Create(AAppSettings: TAppSettings);
begin
  FAppSettings := AAppSettings;
  prevSeconds := 0;
  FBitmap := TBGRABitmap.Create(ICON_SIZE, ICON_SIZE);
  xr := ICON_SIZE div 2;
  yr := xr;
  FBitmap.FontHeight := 14;
  FBitmap.FontName := 'monospace';
  FBitmap.FontAntialias := false;
  inherited Create;
end;

destructor TTrayIconTimer.Destory;
begin
  FBitmap.Free;
  //inherited Destory;
end;

procedure TTrayIconTimer.Draw(Icon: TIcon; State: TState);
var
  textBox: TAffineBox;
begin
  if (prevSeconds <> State.Seconds) or (prevStateType <> State.StateType) then
  begin
    FBitmap.Fill(clNone);
    FBitmap.FillPie(xr,
      yr,
      10,
      10,
      Pi / 2,
      (Pi / 2) - State.ClockPersent * 2 * Pi,
      State.MainColor);
    textbox := FBitmap.TextAffineBox(State.SecondsString);
    FBitmap.TextOut(xr - Trunc(textBox.Width / 2),
      yr - Trunc(textBox.Height / 2),
      State.SecondsString,
      clWhite);
    Icon.Assign(FBitmap.Bitmap);
  end;

  prevSeconds := State.Seconds;
  prevStateType := State.StateType;
end;

end.
