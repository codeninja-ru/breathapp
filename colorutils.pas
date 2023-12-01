unit ColorUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics, BGRABitmapTypes;

function webHSL(hue, saturation, lightness: word): TColor;

function IsDarkTheme: boolean;

implementation

function webHSL(hue, saturation, lightness: word): TColor;
begin
  Result := HSLA(hue * 65535 div 360, saturation * 65535 div 100,
    lightness * 65535 div 100);
end;

// by "Hansaplast" & "Alextp" from Lazarus forum
function IsDarkTheme: boolean;

  function _Level(C: TColor): double;
  begin
    Result := Red(C) * 0.3 + Green(C) * 0.59 + Blue(C) * 0.11;
  end;

begin
  Result := _Level(ColorToRGB(clWindow)) < _Level(ColorToRGB(clWindowText));
end;

end.
