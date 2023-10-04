unit Backgrounds;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, BGRABitmap, BGRABitmapTypes, BGRAGradients,
  AppSettings, Graphics, states;

type

  { TSolidBackground }

  TSolidBackground = class
  public
    procedure Draw(Bitmap: TBGRABitmap; State: TState);

    constructor Create;
    destructor Destory;
  end;

  { TGradientBackround }

  TGradientBackround = class
  private
    FAppSettings: RAppSettings;
    currentBitmap: TBGRABitmap;
    prevStateType: StateType;
  public
    procedure Draw(Bitmap: TBGRABitmap; State: TState);

    constructor Create(AWidth, AHeight: integer; AppSettings: RAppSettings);
    destructor Destory;
  end;

implementation

{ TGradientBackround }

procedure TGradientBackround.Draw(Bitmap: TBGRABitmap; State: TState);
begin
  if prevStateType <> State.StateType then
  begin
    currentBitmap.GradientFill(0, 0,
      currentBitmap.Width - 1,
      currentBitmap.Height - 1,
      State.MainGradienColor1,
      State.MainGradienColor2,
      gtLinear,
      PointF(0, FAppSettings.clockMarginTop),
      PointF(0, currentBitmap.Height - FAppSettings.clockMarginTop),
      dmLinearBlend);
  end;

  Bitmap.BlendImage(0, 0, currentBitmap, boLinearBlend);

  prevStateType := State.StateType;
end;

constructor TGradientBackround.Create(AWidth, AHeight: integer;
  AppSettings: RAppSettings);
begin
  prevStateType := stHoldOut;
  currentBitmap := TBGRABitmap.Create(AWidth, AHeight);
  inherited Create;
end;

destructor TGradientBackround.Destory;
begin
  currentBitmap.Free;
  inherited Destroy;
end;

{ TSolidBackground }

procedure TSolidBackground.Draw(Bitmap: TBGRABitmap; State: TState);
begin
  Bitmap.Fill(State.BgColor);
end;

constructor TSolidBackground.Create;
begin
  inherited Create;
end;

destructor TSolidBackground.Destory;
begin
  inherited Destroy;
end;

end.
