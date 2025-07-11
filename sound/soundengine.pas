unit SoundEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils;

type

  { ISoundEngine }

  ISoundEngine = interface
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    {class function IsSupported: boolean; static;}
  end;

implementation

end.
