unit BreathClock;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type
TBreathClock = class(TObject)
  private
    pic: TBitmap;
  public
    constructor Create;
    destructor Destory;
  end;

implementation

constructor TBreathClock.Create;
begin
  pic := TBitmap.Create;
end;

destructor TBreathClock.destory;
begin
  pic.Free;
end;

end.
