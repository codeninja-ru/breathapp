unit OSSAudioEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils, SoundEngine;

type
  TOssSoundEngine = class(ISoundEngine)
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
  end;

implementation

end.

