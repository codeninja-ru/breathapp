unit PulseAudioSoundEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils, SoundEngine;

type
  TPulseAudioSoundEngine = class(ISoundEngine)
    public
        class function IsSupported: boolean; static;
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
  end;

implementation

end.

