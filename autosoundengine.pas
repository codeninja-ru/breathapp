unit AutoSoundEngine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  SoundEngine
  {$IFDEF WINDOWS},WinMMSoundEngine, DirectSoundSoundEngine{$ENDIF}
  {$IFDEF DARWIN},CoreAudioSoundEngine{$ENDIF};

type

  { AutoSoundEngine }

  TAutoSoundEngine = class(ISoundEngine)
  private
    FSoundEngine: ISoundEngine;
  public
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
  end;

implementation

{ AutoSoundEngine }

procedure TAutoSoundEngine.Open;
begin
  FSoundEngine.Open;
end;

procedure TAutoSoundEngine.Close;
begin
  FSoundEngine.Close;
end;

procedure TAutoSoundEngine.Play(AFreq: integer);
begin
  FSoundEngine.Play(AFreq);
end;

constructor TAutoSoundEngine.Create;
begin
  FSoundEngine := nil;
  {$IFDEF WINDOWS}
  if TDirectSoundSoundEngine.IsSupported then FSoundEngine := TDirectSoundSoundEngine.Create
  else if TWinMMSoundEngine.IsSupported then FSoundEngine := TWinMMSoundEngine.Create
  else raise Exception.Create('Cound Not Load Sound Engine (DirectSound, WinMM)');
  {$ENDIF}
  {$IFDEF DARWIN}
  if TCoreAudioSoundEngine.IsSupported then FSoundEngine := TCoreAudioSoundEngine.Create
  else raise Exception.Create('Cound Not Load Sound Engine (CoreAudio)');
  {$ENDIF}
end;

end.
