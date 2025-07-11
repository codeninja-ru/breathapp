unit CoreAudioSoundEngine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, CoreAudio, Dialogs, MacOSAll, CFString, SoundWave;

type

  TSoundClientData = record
    Channels: integer;
    SampleRate: integer;

    Cursor: integer;
    Freq: integer;
    Generator: TBeepWaveGenerator;
  end;

  PSoundClientData = ^TSoundClientData;

  { TCoreAudioSoundEngine }

  TCoreAudioSoundEngine = class
  private
    FOutputDeviceFormat: AudioStreamBasicDescription;
    FDeviceId: AudioObjectID;
    FProcId: AudioDeviceIOProcID;
    FClientData: TSoundClientData;
    FIsPlaying: boolean;
    function GetOutputDeviceName(deviceId: AudioObjectID): shortstring;
    function GetOutputDeviceFormat(deviceId: AudioObjectID): AudioStreamBasicDescription;
    function GetDefaultOutputDevice(): AudioObjectID;
    function RegisterCallback(deviceId: AudioObjectID;
      callback: AudioDeviceIOProc): AudioDeviceIOProcID;
    procedure StartDevice(deviceId: AudioObjectID; procId: AudioDeviceIOProcID);
    procedure StopDevice(deviceId: AudioObjectID; procId: AudioDeviceIOProcID);
  public
    procedure Open;
    procedure Close;
    procedure Play(AFreq: integer);
    constructor Create;
    destructor Destroy;
  end;


implementation

function beepCallback(inDevice: AudioObjectID; const (*var*) inNow: AudioTimeStamp;
  const (*var*) inInputData: AudioBufferList; const (*var*) inInputTime: AudioTimeStamp;
  var outOutputData: AudioBufferList; const (*var*) inOutputTime: AudioTimeStamp;
  inClientData: UnivPtr): OSStatus;  mwpascal;
var
  clientData: PSoundClientData;
  Data: PSingle;
  numBuffers: uint32;
  iBuffer, i, ch: integer;
  buffer: AudioBuffer;
  numSamples: integer;
  channels: integer;
  framesPerChannel: integer;
  generator: TBeepWaveGenerator;
  val: single;
begin
  clientData := PSoundClientData(inClientData);
  generator := clientData^.Generator;
  numBuffers := outOutputData.mNumberBuffers;

  if generator.IsPlaying(clientData^.Cursor) then
  begin
    for iBuffer := 0 to numBuffers - 1 do
    begin
      buffer := outOutputData.mBuffers[iBuffer];
      numSamples := buffer.mDataByteSize div SizeOf(single);
      channels := buffer.mNumberChannels;
      framesPerChannel := numSamples div channels;
      Data := PSingle(buffer.mData);

      for i := 0 to framesPerChannel - 1 do
      begin
        val := generator.GetDataForFrame(clientData^.Cursor, clientData^.Freq);
        for ch := 0 to channels - 1 do
        begin
          Data[i * channels + ch] := val;
        end;
        Inc(ClientData^.Cursor);
      end;

    end;
  end;

  Result := 0;
end;

{ TCoreAudioSoundEngine }

function TCoreAudioSoundEngine.GetOutputDeviceName(deviceId: AudioObjectID): shortstring;
var
  cfs: CFStringRef;
  size: uint32;
  deviceName: shortstring;
const
  prop: AudioObjectPropertyAddress = (
    mSelector: kAudioObjectPropertyName;
    mScope: kAudioDevicePropertyScopeOutput;
    mElement: kAudioObjectPropertyElementMaster);
begin
  size := SizeOf(CFStringRef);
  if AudioObjectGetPropertyData(deviceId, prop, 0, nil, size, @cfs) <> 0 then
    raise Exception.Create('Error getting input device name');
  try
    if not CFStringGetPascalString(cfs, @deviceName, 255,
      CFStringGetSystemEncoding) then
      raise Exception.Create('Error decoding input device name');

  finally
    CFRelease(cfs);
  end;

  Result := deviceName;
end;

function TCoreAudioSoundEngine.GetOutputDeviceFormat(deviceId: AudioObjectID):
AudioStreamBasicDescription;
var
  size: uint32;
const
  req: AudioObjectPropertyAddress = (
    mSelector: kAudioDevicePropertyStreamFormat;
    mScope: kAudioDevicePropertyScopeOutput;
    mElement: kAudioObjectPropertyElementMaster; );
begin
  size := SizeOf(Result);
  if AudioObjectGetPropertyData(deviceId, req, 0, nil, size, @Result) <> 0 then
    raise Exception.Create('Error getting device format');
end;

function TCoreAudioSoundEngine.GetDefaultOutputDevice: AudioObjectID;
var
  size: uint32;
const
  defaultOutput: AudioObjectPropertyAddress = (
    mSelector: kAudioHardwarePropertyDefaultOutputDevice;
    mScope: kAudioObjectPropertyScopeGlobal;
    mElement: kAudioObjectPropertyElementMaster;
    );
begin
  size := SizeOf(AudioObjectID);
  if AudioObjectGetPropertyData(kAudioObjectSystemObject, defaultOutput, 0,
    nil, size, @Result) <> 0 then
    raise Exception.Create('Error getting default output device');
end;

function TCoreAudioSoundEngine.RegisterCallback(deviceId: AudioObjectID;
  callback: AudioDeviceIOProc): AudioDeviceIOProcID;
begin
  Result := nil;
  if AudioDeviceCreateIOProcID(deviceId, callback, @FClientData, Result) <> 0 then
    raise Exception.Create('Error creating IOProcID');
end;

procedure TCoreAudioSoundEngine.StartDevice(deviceId: AudioObjectID;
  procId: AudioDeviceIOProcID);
begin
  if AudioDeviceStart(deviceId, procId) <> 0 then
    raise Exception.Create('Error starting audio device');
end;

procedure TCoreAudioSoundEngine.StopDevice(deviceId: AudioObjectID;
  procId: AudioDeviceIOProcID);
begin
  if AudioDeviceStop(deviceId, procId) <> 0 then
    raise Exception.Create('Error stoping audio device');
end;

procedure TCoreAudioSoundEngine.Open;
begin
  if not FIsPlaying then
  begin
    FDeviceId := GetDefaultOutputDevice();
    FOutputDeviceFormat := GetOutputDeviceFormat(FDeviceId);
    {ShowMessage('DeviceName:' + GetOutputDeviceName(FDeviceId) +
      ' SampleRate = ' + FloatToStr(FOutputDeviceFormat.mSampleRate) +
      ' Channels = ' + IntToStr(FOutputDeviceFormat.mChannelsPerFrame));}
    FClientData.Channels := FOutputDeviceFormat.mChannelsPerFrame;
    FClientData.SampleRate := round(FOutputDeviceFormat.mSampleRate);
    FClientData.Freq := 440;
    FClientData.Cursor := 0;
    FClientData.Generator := TBeepWaveGenerator.Create(FClientData.SampleRate);  {TODO: should be an external dep }
    FProcId := RegisterCallback(FDeviceId, @beepCallback);
    StartDevice(FDeviceId, FProcId);
    FIsPlaying := True;
  end;
end;

procedure TCoreAudioSoundEngine.Close;
begin
  if FIsPlaying then
  begin
    StopDevice(FDeviceId, FProcId);
    AudioDeviceDestroyIOProcID(FDeviceId, FProcId);
    FIsPlaying := False;
    FreeAndNil(FClientData.Generator);
  end;
end;

procedure TCoreAudioSoundEngine.Play(AFreq: integer);
begin
  if not FIsPlaying then
  begin
    Open;
  end;

  FClientData.Freq := AFreq;
  FClientData.Cursor := 0;
end;

constructor TCoreAudioSoundEngine.Create;
begin
  FIsPlaying := False;
end;

destructor TCoreAudioSoundEngine.Destroy;
begin
  Close;
end;

end.
