unit SoundTimer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uos_flat, states{$ifdef unix}, cthreads{$endif};

type

  { TSoundTimer }

  TSoundTimer = class
  private
    res: integer;
    ordir, opath, PA_FileName: string;
    PlayerIndex1, inindex1: integer;
    prevSeconds: integer;
    procedure PlaySound(freq: integer);
  public
    constructor Create;
    destructor Destroy;

    procedure Play(State: TState);
  end;

implementation

function inThread(playerIndex: pointer): ptrint;
begin
  uos_Play(PInteger(playerIndex)^);
  sleep(150);
  uos_stop(PInteger(playerIndex)^);
  Result := 0;
end;

constructor TSoundTimer.Create;
begin
  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

 {$IFDEF Windows}
     {$if defined(cpu64)}
    PA_FileName := ordir + 'vendor_libs\Windows\64bit\LibPortaudio-64.dll';
     {$else}
    PA_FileName := ordir + 'vendor_libs\Windows\32bit\LibPortaudio-32.dll';
     {$endif}
 {$ENDIF}

  {$if defined(CPUAMD64) and  defined(linux) }
    PA_FileName := ordir + 'vendor_libs/Linux/64bit/LibPortaudio-64.so';
  {$ENDIF}

  {$if defined(cpu86) and defined(linux)}
    PA_FileName := ordir + 'vendor_libs/Linux/32bit/LibPortaudio-32.so';
  {$ENDIF}

  {$if defined(linux) and defined(cpuarm)}
    PA_FileName := ordir + 'vendor_libs/Linux/arm_raspberrypi/libportaudio-arm.so';
  {$ENDIF}

  {$if defined(linux) and defined(cpuaarch64)}
  PA_FileName := ordir + 'vendor_libs/Linux/aarch64_raspberrypi/libportaudio_aarch64.so';
  {$ENDIF}

 {$IFDEF freebsd}
    {$if defined(cpu64)}
    PA_FileName := ordir + 'vendor_libs/FreeBSD/64bit/libportaudio-64.so';
    {$else}
    PA_FileName := ordir + 'vendor_libs/FreeBSD/32bit/libportaudio-32.so';
    {$endif}
  {$ENDIF}

 {$IFDEF Darwin}
  {$IFDEF CPU32}
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    PA_FileName := opath + '/vendor_libs/Mac/32bit/LibPortaudio-32.dylib';
    {$ENDIF}

   {$IFDEF CPU64}
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    PA_FileName := opath + '/vendor_libs/Mac/64bit/LibPortaudio-64.dylib';
    //PA_FileName := opath + 'LibPortaudio-64.dylib';
    PA_FileName := 'system';
    {$ENDIF}
 {$ENDIF}

  // Load the libraries (here only portaudio is needed)
  // function uos_loadlib(PortAudioFileName, SndFileFileName, Mpg123FileName, Mp4ffFileName, FaadFileName, opusfilefilename:: PChar) : LongInt;

  res := uos_LoadLib(PChar(PA_FileName), nil, nil, nil, nil, nil);

  inherited Create;
end;

destructor TSoundTimer.Destroy;
begin
  uos_free;
end;

procedure TSoundTimer.Play(State: TState);
begin
  if prevSeconds <> State.Seconds then
  begin
    case State.StateType of
      stBreathIn:
        PlaySound(430 + 20 * State.Seconds);
      stBreathOut:
        PlaySound(170 - 20 * State.Seconds);
      stHoldIn: ;
        //PlaySound(100);
      stHoldOut: ;
        //PlaySound(100);
    end;

  end;

  prevSeconds := State.Seconds;
end;

procedure TSoundTimer.PlaySound(freq: integer);
begin
  if res = 0 then
  begin

    //// Create the player.
    //// PlayerIndex : from 0 to what your computer can do !
    //// If PlayerIndex exists already, it will be overwriten...

    PlayerIndex1 := 0;
    inindex1 := -1;

    if uos_CreatePlayer(PlayerIndex1) then
      inindex1 :=
        uos_AddFromSynth(PlayerIndex1, -1, -1, -1, freq, freq, -1,
        -1, -1, -1, -1, 0, -1, -1, -1);

{ function uos_AddFromSynth(PlayerIndex: cint32; Channels: integer; WaveTypeL, WaveTypeR: integer;
                           FrequencyL, FrequencyR: float; VolumeL, VolumeR: float;
                           duration : cint32; NbHarmonics: cint32; EvenHarmonics: cint32;
                           OutputIndex: cint32;  SampleFormat: cint32 ;
                           SampleRate: cint32 ; FramesCount : cint32): cint32;

// Add a input from Synthesizer with custom parameters
// Channels: default: -1 (2) (1 = mono, 2 = stereo)
// WaveTypeL: default: -1 (0) (0 = sine-wave 1 = square-wave, used for mono and stereo)
// WaveTypeR: default: -1 (0) (0 = sine-wave 1 = square-wave, used for stereo, ignored for mono)
// FrequencyL: default: -1 (440 htz) (Left frequency, used for mono)
// FrequencyR: default: -1 (440 htz) (Right frequency, used for stereo, ignored for mono)
// VolumeL: default: -1 (= 1) (from 0 to 1) => volume left
// VolumeR: default: -1 (= 1) (from 0 to 1) => volume rigth (ignored for mono)
// Duration: default:  -1 (= 1000)  => duration in msec (0 = endless)
// NbHarmonics: default:  -1 (= 0) Number of Harmonics
// EvenHarmonics: default: -1 (= 0) (0 = all harmonics, 1 = Only even harmonics)
// OutputIndex: Output index of used output
            // -1: all output, -2: no output, other cint32 refer to
            // a existing OutputIndex
            // (if multi-output then OutName = name of each output separeted by ';')
// SampleFormat: default : -1 (0: Float32) (0: Float32, 1:Int32, 2:Int16)
// SampleRate: delault : -1 (44100)
// FramesCount: -1 default : 1024
//  result:  Input Index in array  -1 = error
}

     {$if defined(cpuarm) or defined(cpuaarch64)}  // need a lower latency
      if uos_AddIntoDevOut(PlayerIndex1,-1,0.3,-1,-1, 0,-1,-1) > - 1 then
       {$else}
    if uos_AddIntoDevOut(PlayerIndex1, -1, -1, -1, -1, 0, -1, -1) > -1 then
       {$endif}
      //// add a Output into device with custom parameters
      //////////// PlayerIndex : Index of a existing Player
      //  result : -1 nothing created, otherwise Output Index in array
    begin
      /////// everything is ready, here we are, lets play it...

      BeginThread(@inThread, @PlayerIndex1);

    end;

  end;

end;

end.
