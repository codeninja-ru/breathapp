unit MiniaudioSoundEngine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, miniaudio,
  {$ifdef unix}cthreads{$endif};

const
  DEVICE_CHANNELS = 2;
  DEVICE_SAMPLE_RATE = 48000;
  FREQ = 440;

  ATTACK = 37;
  DECAY = 12;
  SUSTAIN = 50;
  RELEASE = 37;
  AMPLITUDE = 0.5;
  NOTE_TIME = ATTACK + DECAY + SUSTAIN + RELEASE;

type
  TSoundSource = class
    public
      procedure DataCallBack(pOutput: pointer; frameCount: integer); virtual; abstract;
  end;

  TBeepDataSource = record
    base: ma_data_source_base;
    cursor: single;
    time: single;
    freq: integer;
  end;
  PBeepDataSource = ^TBeepDataSource;

  { TMiniaudioSoundEngine }

  TMiniaudioSoundEngine = class
  private
    FIsPlaying: boolean;
    FMaEgine: ma_engine;
    FBeepDataSource: TBeepDataSource;

  public
    property IsPlaying: boolean read FIsPlaying;

    procedure Play(ASound: TSoundSource);
    procedure Stop();

    constructor Create;
    destructor Destroy;
  end;


var beepSoundVtable : ma_data_source_vtable;

implementation

function beepSoundOnRead(pDataSource:PBeepDataSource; pFramesOut:pointer;
             frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl;
var
  i, iChannel, idx, channelsCount: integer;
  Value, volume, cursor, time, framesInOsc: single;
  Data: Psingle;
begin
  Data := pFramesOut;
  channelsCount := DEVICE_CHANNELS;
  time := pDataSource^.time;
  cursor := pDataSource^.cursor;
  framesInOsc := pDataSource^.freq / DEVICE_SAMPLE_RATE;
  for i := 0 to frameCount - 1 do
  begin

    if time <= ATTACK then
    begin
      volume := (1 / ATTACK) * time;
    end;

    if (time > ATTACK) and (time <= ATTACK + DECAY) then
    begin
      volume := (-0.5 / DECAY) * time + 1 + (0.5 / DECAY) * ATTACK;
    end;

    if (time > ATTACK + DECAY) and (time <= ATTACK + DECAY + SUSTAIN) then
    begin
      volume := 0.5;
    end;

    if (time >= ATTACK + DECAY + SUSTAIN) and (time <= ATTACK + DECAY +
      SUSTAIN + RELEASE) then
    begin
      volume := (-0.5 / RELEASE) * time + 0.5 + (0.5 / RELEASE) *
        (ATTACK + DECAY + SUSTAIN);
    end;

    if time > ATTACK + DECAY + SUSTAIN + RELEASE then
    begin
      volume := 0;
    end;

    for iChannel := 0 to channelsCount - 1 do
    begin
      idx := i * channelsCount + iChannel;

      Value := sin(2 * Pi * cursor) * AMPLITUDE;

      Data[idx] := Value * volume;
    end;

    cursor := cursor + framesInOsc;
    pDataSource^.cursor := cursor;
    time := time + 1000 / DEVICE_SAMPLE_RATE;
    pDataSource^.time := time;

  end;
end;

function OnSeek(pDataSource:Pma_data_source; frameIndex:ma_uint64):ma_result;cdecl;
begin
  Result := MA_SUCCESS;
end;
function OnGetDataformat(pDataSource:Pma_data_source; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel;
             channelMapCap:size_t):ma_result;cdecl;
begin
  pFormat^:=ma_format_f32;
  pChannels^:= DEVICE_CHANNELS;
  pSampleRate^:=DEVICE_SAMPLE_RATE;
  ma_channel_map_init_standard(ma_standard_channel_map_default, pChannelMap, channelMapCap, DEVICE_CHANNELS);
  Result := MA_SUCCESS;
end;
function OnGetCursor(pDataSource:PBeepDataSource; pCursor:Pma_uint64):ma_result;cdecl;
begin
  // Retrieve the current position of the cursor here. Return MA_NOT_IMPLEMENTED and set *pCursor to 0 if there is no notion of a cursor.
  pCursor^:=pDataSource^.cursor;
  Result := MA_SUCCESS;
end;

function OnGetLength(pDataSource:Pma_data_source; pLength:Pma_uint64):ma_result;cdecl;
begin
  // Retrieve the length in PCM frames here. Return MA_NOT_IMPLEMENTED and set *pLength to 0 if there is no notion of a length or if the length is unknown.
  pLength^:=NOTE_TIME * DEVICE_SAMPLE_RATE;
  Result := MA_SUCCESS;
end;


function beepSound_source_init(pDataSource: PBeepDataSource): ma_result;cdecl;
var baseConfig: ma_data_source_config;
begin
  beepSoundVtable.onGetCursor:=@OnGetCursor;
  beepSoundVtable.onGetDataFormat:=@OnGetDataformat;
  beepSoundVtable.onRead:=@beepSoundOnRead;
  beepSoundVtable.onGetLength:=@OnGetLength;
  beepSoundVtable.onSeek:=@OnSeek;

  baseConfig := ma_data_source_config_init();
  baseConfig.vtable:=@beepSoundVtable;

  Result := ma_data_source_init(@baseConfig, PBeepDataSource(pDataSource)^.base);
  if Result <> MA_SUCCESS then
  begin
    Exit;
  end;
  //begin
  //  raise Exception.Create('could not create datasource');
  //end;

  Result := MA_SUCCESS;
end;

procedure beep_data_source_uninit(pDataSource: PBeepDataSource);
begin
  ma_data_source_init(pDataSource^.base);
end;

{ TMiniaudioSoundEngine }

procedure TMiniaudioSoundEngine.Play(ASound: TSoundSource);
var sound: ma_sound;
begin
  FBeepDataSource.freq := FREQ;
  if beepSound_source_init(@FBeepDataSource) <> MA_SUCCESS then
  begin
    raise Exception.Create('cound not init beep data source');
  end;
  if ma_sound_init_from_data_source(@FMaEgine, @FBeepDataSource, 0, nil, @sound) <> MA_SUCCESS then
  begin
    raise Exception.Create('cound not init beep sound from data source');
  end;
  if ma_sound_start(@sound) <> MA_SUCCESS then
  begin
    raise Exception.Create('cound not start sound');
  end;
  //todo uninit sound
end;

procedure TMiniaudioSoundEngine.Stop;
begin

end;

constructor TMiniaudioSoundEngine.Create;
begin
  FIsPlaying := False;

  if ma_engine_init(NULL, @engine) <> MA_SUCCESS then
  begin
    Exception.Create('Failed to initialize the engine.');
  end;



  inherited Create;
end;

destructor TMiniaudioSoundEngine.Destroy;
begin
  Stop();
  beep_data_source_uninit(@FBeepDataSource);
  ma_engine_uninit(@FMaEgine);
end;

end.

