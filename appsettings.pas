unit AppSettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type
  RAppSettings = record
    bg: TColor;
    breathInColor, breathInColorSecond: TColor;
    breathOutColor, breathOutColorSecond: TColor;
    holdColor, holdColorSecond: TColor;
    clockBg: TColor;
    clockStrockSize: Integer;
    clockMarginLeft: Integer;
    clockMarginTop: Integer;
  end;

implementation

end.
