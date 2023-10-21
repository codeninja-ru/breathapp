unit ColorUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics, BGRABitmapTypes;

function webHSL(hue, saturation, lightness: word) : TColor;

implementation

function webHSL(hue, saturation, lightness: word) : TColor;
begin
  Result := HSLA(hue * 65535 div 360, saturation * 65535 div 100, lightness * 65535 div 100);
end;

end.

