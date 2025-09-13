unit AutoSoundEngine;

{$mode ObjFPC}{$H+}
{$Interfaces CORBA}

interface

uses
  Classes,
  SysUtils,
  SoundEngine, NoSoundEngine
  {$IFDEF WINDOWS},WinMMSoundEngine, DirectSoundSoundEngine{$ENDIF}
  {$IF DEFINED(DARWIN)}
    ,CoreAudioSoundEngine
  {$ELSEIF DEFINED(BSD)}
    ,OssSoundEngine
  {$ENDIF}
  {$IFDEF LINUX},AlsaSoundEngine, PulseAudioSoundEngine, OssSoundEngine{$ENDIF};

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
  else raise Exception.Create('Could Not Load Sound Engine (DirectSound, WinMM)');
  {$ENDIF}
  {$IFDEF LINUX}
  if TPulseAudioSoundEngine.IsSupported then FSoundEngine := TPulseAudioSoundEngine.Create
  else if TAlsaSoundEngine.IsSupported then FSoundEngine := TAlsaSoundEngine.Create
  else if TOssSoundEngine.IsSupported then FSoundEngine := TOssSoundEngine.Create
  else raise Exception.Create('Could Not Load SoundEngine (Alsa, PulseAudio, OSS)');
  {$ENDIF}
  {$IF DEFINED(DARWIN)}
  if TCoreAudioSoundEngine.IsSupported then FSoundEngine := TCoreAudioSoundEngine.Create
  else raise Exception.Create('Could Not Load Sound Engine (CoreAudio)');
  {$ELSEIF DEFINED(BSD)}
  if TOssSoundEngine.IsSupported then FSoundEngine := TOssSoundEngine.Create
  else raise Exception.Create('Could Not Load SoundEngine (OSS)');
  {$ENDIF}

  if FSoundEngine = nil then FSoundEngine := TNoSoundEngine.Create;
end;

end.
