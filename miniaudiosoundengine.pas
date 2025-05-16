unit MiniaudioSoundEngine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, miniaudio{$ifdef UNIX}, unix{$endif};

const
  DEVICE_CHANNELS = 2;
  DEVICE_SAMPLE_RATE = 48000; // number of pcm frames that are procesed per second
  FREQ = 440;

  ATTACK = 37;
  DECAY = 12;
  SUSTAIN = 50;
  Release = 37;
  AMPLITUDE = 0.5;
  NOTE_TIME = ATTACK + DECAY + SUSTAIN + Release;

type
  TBeepDataSource = record
    base: ma_data_source_base;
    cursor: ma_uint64;
    freq: integer;
  end;
  PBeepDataSource = ^TBeepDataSource;

  { TMiniaudioSound }

  TAbstractSound = class
  protected
    function GetIsPlaying(): boolean; virtual; abstract;
  public
    procedure Play(); virtual; abstract;
    property IsPlaying: boolean read GetIsPlaying;
  end;

  { TMiniaudioSoundEngine }

  TMiniaudioSoundEngine = class
  private
    FMaEgine: ma_engine;

  public
    constructor Create;
    destructor Destroy;
  end;

  { TMiniaudioBeepSound }

  TMiniaudioBeepSound = class(TAbstractSound)
  private
    FSound: ma_sound;
    FEgine: TMiniaudioSoundEngine;
    FBeepDataSource: TBeepDataSource;
    procedure SetFrequency(freq: integer);
    function GetFrequency: integer;
    function GetIsPlaying(): boolean; override;
  public
    property Frequency: integer read GetFrequency write SetFrequency;
    property IsPlaying: boolean read GetIsPlaying;
    procedure Play(); override;

    constructor Create(AEngine: TMiniaudioSoundEngine);
    destructor Destroy;
  end;

implementation

var
  beepSoundVtable: ma_data_source_vtable;

function beepSoundOnRead(pDataSource: Pma_data_source; pFramesOut: pointer;
  frameCount: ma_uint64; pFramesRead: Pma_uint64): ma_result; cdecl;
var
  i, iChannel, idx, channelsCount, framesInOsc, framesInMsec: integer;
  Value, volume, time: single;
  Data: Psingle;
  dataSource: PBeepDataSource;
begin
  dataSource := PBeepDataSource(pDataSource);
  Data := pFramesOut;
  channelsCount := DEVICE_CHANNELS;
  framesInOsc := DEVICE_SAMPLE_RATE div dataSource^.freq;
  framesInMsec := DEVICE_SAMPLE_RATE div 1000;
  if dataSource^.cursor <= (ATTACK + DECAY + SUSTAIN + Release) * framesInMsec then
  begin
    for i := 0 to frameCount - 1 do
    begin
      time := dataSource^.cursor / framesInMsec;
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

      if (time >= ATTACK + DECAY + SUSTAIN) and (time <= ATTACK +
        DECAY + SUSTAIN + Release) then
      begin
        volume := (-0.5 / Release) * time + 0.5 + (0.5 / Release) *
          (ATTACK + DECAY + SUSTAIN);
      end;

      if time > ATTACK + DECAY + SUSTAIN + Release then
      begin
        volume := 0;
      end;

      Value := sin(2 * Pi * (dataSource^.cursor mod framesInOsc) /
        framesInOsc) * AMPLITUDE;
      for iChannel := 0 to channelsCount - 1 do
      begin
        idx := i * channelsCount + iChannel;
        Data[idx] := Value * volume;
      end;

      Inc(dataSource^.cursor);
    end;

    if pFramesRead <> nil then pFramesRead^ := frameCount;
  end;


  Result := MA_SUCCESS;
end;

function OnSeek(pDataSource: Pma_data_source; frameIndex: ma_uint64): ma_result; cdecl;
var
  dataSource: PBeepDataSource;
begin
  dataSource := PBeepDataSource(pDataSource);
  dataSource^.cursor := frameIndex;
  Result := MA_SUCCESS;
end;

function OnGetDataformat(pDataSource: Pma_data_source; pFormat: Pma_format;
  pChannels: Pma_uint32; pSampleRate: Pma_uint32; pChannelMap: Pma_channel;
  channelMapCap: size_t): ma_result; cdecl;
begin
  pFormat^ := ma_format_f32;
  pChannels^ := DEVICE_CHANNELS;
  pSampleRate^ := DEVICE_SAMPLE_RATE;
  ma_channel_map_init_standard(ma_standard_channel_map_default,
    pChannelMap, channelMapCap, DEVICE_CHANNELS);
  Result := MA_SUCCESS;
end;

function OnGetCursor(pDataSource: Pma_data_source;
  pCursor: Pma_uint64): ma_result; cdecl;
begin
  // Retrieve the current position of the cursor here. Return MA_NOT_IMPLEMENTED and set *pCursor to 0 if there is no notion of a cursor.
  pCursor^ := PBeepDataSource(pDataSource)^.cursor;
  Result := MA_SUCCESS;
end;

function OnGetLength(pDataSource: Pma_data_source;
  pLength: Pma_uint64): ma_result; cdecl;
begin
  // Retrieve the length in PCM frames here. Return MA_NOT_IMPLEMENTED and set *pLength to 0 if there is no notion of a length or if the length is unknown.
  pLength^ := (NOTE_TIME * DEVICE_SAMPLE_RATE) div 1000;
  Result := MA_SUCCESS;
end;

function beepSound_source_init(pDataSource: PBeepDataSource): ma_result; cdecl;
var
  baseConfig: ma_data_source_config;
begin
  beepSoundVtable.onGetCursor := @OnGetCursor;
  beepSoundVtable.onGetDataFormat := @OnGetDataformat;
  beepSoundVtable.onRead := @beepSoundOnRead;
  beepSoundVtable.onGetLength := @OnGetLength;
  beepSoundVtable.onSeek := @OnSeek;
  beepSoundVtable.onSetLooping := nil;
  beepSoundVtable.flags := 0;

  baseConfig := ma_data_source_config_init();
  baseConfig.vtable := @beepSoundVtable;

  if ma_data_source_init(@baseConfig, @PBeepDataSource(pDataSource)^.base) <>
    MA_SUCCESS then
  begin
    raise Exception.Create('could not create datasource');
  end;

  Result := MA_SUCCESS;
end;

procedure beep_data_source_uninit(pDataSource: PBeepDataSource);
begin
  ma_data_source_uninit(@PBeepDataSource(pDataSource)^.base);
end;

{ TMiniaudioBeepSound }

procedure TMiniaudioBeepSound.SetFrequency(freq: integer);
begin
  FBeepDataSource.freq := freq;
end;

function TMiniaudioBeepSound.GetFrequency: integer;
begin
  Result := FBeepDataSource.freq;
end;

function TMiniaudioBeepSound.GetIsPlaying: boolean;
begin
  Result := ma_sound_is_playing(@FSound) = MA_TRUE;
end;

procedure TMiniaudioBeepSound.Play;
begin
  ma_sound_seek_to_pcm_frame(@FSound, 0);
  if ma_sound_start(@FSound) <> MA_SUCCESS then
    raise Exception.Create('cound not play sound');
end;

constructor TMiniaudioBeepSound.Create(AEngine: TMiniaudioSoundEngine);
begin
  FEgine := AEngine;

  FBeepDataSource.freq := FREQ;
  if beepSound_source_init(@FBeepDataSource) <> MA_SUCCESS then
  begin
    raise Exception.Create('cound not init beep data source');
  end;
  if ma_sound_init_from_data_source(@FEgine.FMaEgine, @FBeepDataSource,
    0, nil, @FSound) <> MA_SUCCESS then
  begin
    raise Exception.Create('cound not init beep sound from data source');
  end;
end;

destructor TMiniaudioBeepSound.Destroy;
begin
  ma_sound_uninit(@FSound);
  beep_data_source_uninit(@FBeepDataSource);
end;

{ TMiniaudioSoundEngine }

constructor TMiniaudioSoundEngine.Create;
begin
  if ma_engine_init(nil, @FMaEgine) <> MA_SUCCESS then
  begin
    raise Exception.Create('Failed to initialize the engine.');
  end;

  inherited Create;
end;

destructor TMiniaudioSoundEngine.Destroy;
begin
  ma_engine_uninit(@FMaEgine);
end;

end.
