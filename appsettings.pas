unit AppSettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type
  RAppSettings = record
    bg: TColor;
    main: TColor;
    clockBg: TColor;
    clockStrockSize: Integer;
    clockMarginLeft: Integer;
    clockMarginTop: Integer;
  end;

implementation

end.
