unit ClockTimer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AppSettings, BGRABitmap, BGRABitmapTypes, Graphics, states;

type

  { TClockTimer }

  TClockTimer = class
    FFormWidth, FFormHeight: integer;
    FAppSettings: TAppSettings;
    FTimeString: string;
    textBox: TAffineBox;
    FTextBitmap: TBGRABitmap;
    PrevStateType: StateType;

    function formatTime(minutes: integer; seconds: integer): string;



  public
    constructor Create(AFormWidth: integer; AFormHeight: integer;
      AAppSettings: TAppSettings);
    destructor Destroy; override;

    procedure Draw(ABitmap: TBGRABitmap; State: TState);
  end;

implementation

{ TClockTimer }

function TClockTimer.formatTime(minutes: integer; seconds: integer): string;

  function pad2(num: string): string;
  begin
    if Length(num) < 2 then
      Result := '0' + num
    else
      Result := num;
  end;

begin
  Result := pad2(IntToStr(minutes)) + ' : ' + pad2(IntToStr(seconds));
end;

constructor TClockTimer.Create(AFormWidth: integer; AFormHeight: integer;
  AAppSettings: TAppSettings);
begin
  FFormWidth := AFormWidth;
  FFormHeight := AFormHeight;
  FAppSettings := AAppSettings;

  FTextBitmap := TBGRABitmap.Create(100, 100);
  FTextBitmap.FontHeight := 24;
  FTextBitmap.FontName := FAppSettings.SecondFontName;
  FTextBitmap.FontAntialias := False;
  textBox := FTextBitmap.TextAffineBox(formatTime(999, 999));
  FTextBitmap.SetSize(Round(textBox.Width) + 2, Round(textBox.Height) + 2);
  PrevStateType := stHoldOut;
end;

destructor TClockTimer.Destroy;
begin
  inherited Destroy;
end;

procedure TClockTimer.Draw(ABitmap: TBGRABitmap; State: TState);
var
  minutes, seconds: integer;
  time: string;
begin
  seconds := Trunc(State.MSecFromStart / 1000) mod 60;
  minutes := Trunc(State.MSecFromStart / 60000);

  time := formatTime(minutes, seconds);

  if (time <> FTimeString) or (PrevStateType <> State.StateType) then
  begin
    if FTimeString <> '' then
    begin
      FTextBitmap.Fill(clNone);
    end;
    textBox := FTextBitmap.TextAffineBox(time);

    FTextBitmap.TextOut(
      Round((FTextBitmap.Width - textBox.Width) / 2),
      0,
      time,
      State.MainColor
      );
  end;

  FTimeString := time;
  ABitmap.BlendImage((ABitmap.Width - FTextBitmap.Width) div 2,
    Round(ABitmap.Height * 0.78),
    FTextBitmap,
    boLinearBlend);
  PrevStateType := State.StateType;
end;

end.
