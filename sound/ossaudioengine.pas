unit OSSAudioEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes, SysUtils, SoundEngine;

type

  { TOssSoundEngine }

  TOssSoundEngine = class(ISoundEngine)
  public
    class function IsSupported: boolean; static;
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
  end;

implementation

{ TOssSoundEngine }

class function TOssSoundEngine.IsSupported: boolean;
begin

end;

procedure TOssSoundEngine.Open;
begin

end;

procedure TOssSoundEngine.Close;
begin

end;

procedure TOssSoundEngine.Play(AFreq: integer);
begin

end;

constructor TOssSoundEngine.Create;
begin

end;

end.
