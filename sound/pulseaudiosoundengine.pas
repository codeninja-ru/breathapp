unit PulseAudioSoundEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils, SoundEngine;

type

  { TPulseAudioSoundEngine }

  TPulseAudioSoundEngine = class(ISoundEngine)
  public
    class function IsSupported: boolean; static;
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
  end;

implementation

{ TPulseAudioSoundEngine }

class function TPulseAudioSoundEngine.IsSupported: boolean;
begin

end;

procedure TPulseAudioSoundEngine.Open;
begin

end;

procedure TPulseAudioSoundEngine.Close;
begin

end;

procedure TPulseAudioSoundEngine.Play(AFreq: integer);
begin

end;

constructor TPulseAudioSoundEngine.Create;
begin

end;

end.
