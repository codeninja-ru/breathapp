unit NoSoundEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  SoundEngine;

type
  
  { TAutoSoundEngine }

  TNoSoundEngine = class(ISoundEngine)
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
  end;

implementation

{ TNoSoundEngine }

procedure TNoSoundEngine.Open;
begin

end;

procedure TNoSoundEngine.Close;
begin

end;

procedure TNoSoundEngine.Play(AFreq: integer);
begin

end;

constructor TNoSoundEngine.Create;
begin

end;

end.

