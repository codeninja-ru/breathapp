
unit miniaudio;
interface

uses Ctypes{$ifdef UNIX},unix{$endif};

{
  Automatically converted by H2Pas 1.0.0 from miniaudio.h
  The following command line parameters were used:
    miniaudio.h
}

{$ifdef windows}
    {$ifdef cpu64}
	    { apt install mingw-w64-x86-64-dev }
	    {$linklib /usr/x86_64-w64-mingw32/lib/libkernel32.a}
	    {linklib /usr/x86_64-w64-mingw32/lib/libmsvcrt.a}
	    {$linklib /usr/x86_64-w64-mingw32/lib/libmingwex.a}
	    {$linklib /usr/x86_64-w64-mingw32/lib/libmingw32.a}
	    {$linklib /usr/x86_64-w64-mingw32/lib/libsynchronization.a}
	    {linklib /usr/x86_64-w64-mingw32/lib/libucrt.a}
	    {linklib /usr/x86_64-w64-mingw32/lib/libmingwex.a}
	    {$linklib /usr/x86_64-w64-mingw32/lib/libmsvcr120d.a}
    {$endif}
    {{$ifdef cpu32}
	    { apt install mingw-w64-i686-dev }
	    {$linklib /usr/lib/gcc-cross/i686-linux-gnu/12/libgcc.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libkernel32.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libwinpthread.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libwindowsapp.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libwinstorecompat.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libwindowsappcompat.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmsvcrt.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmsvcrt40.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmsvcrt20.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmsvcrt10.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmsvcrt-os.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmingwex.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmingw32.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libsynchronization.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libucrt.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmingwex.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmsvcr120d.a}
	    {$linklib /usr/i686-w64-mingw32/lib/libmincore.a}
    {$endif} }
{$endif}

{$ifdef CPU64}
  {$ifdef LINUX}{$L miniaudio_lib-linux-x86_64.o}{$endif}
  {$ifdef WIN64}{$L miniaudio_lib-win64-x86_64.o}{$endif}
  {$ifdef DARWIN}{$L miniaudio_lib-darwin-x86_64.o}{$endif}
{$endif}

{$ifdef CPU32}
  {$ifdef WIN32}{$L miniaudio_lib-win32-i686.o}{$endif}
  {$ifdef LINUX}{$L miniaudio_lib-linux-i686.o}{$endif}
{$endif}

{//$L miniaudio_lib.o}
{$ifdef LINUX}
{$linklib c}
{$linklib m}
{$endif}

    const MA_MAX_LOG_CALLBACKS = 4;
{$if defined(cpu64)}

  const
    MA_SIZEOF_PTR = 8;    
{$else}

  const
    MA_SIZEOF_PTR = 4;    
{$endif}
  const
    MA_TRUE = 1;    
    MA_FALSE = 0;    
  { These float types are not used universally by miniaudio. It's to simplify some macro expansion for atomic types.  }
{$if defined(SIZE_MAX)}

  const
    MA_SIZE_MAX = SIZE_MAX;    
{$else}
  { When SIZE_MAX is not defined by the standard library just default to the maximum 32-bit unsigned integer.  }

  const
    MA_SIZE_MAX = $FFFFFFFF;    
{$endif}
{$ifndef MA_MAX_DEVICE_NAME_LENGTH}

  const
    MA_MAX_DEVICE_NAME_LENGTH = 255;    
{$endif}

  const
    MA_MIN_CHANNELS = 1;    

{$ifndef MA_MAX_CHANNELS}

  const
    MA_MAX_CHANNELS = 254;    
{$endif}
{$ifndef MA_MAX_FILTER_ORDER}

  const
    MA_MAX_FILTER_ORDER = 8;    
{$endif}
  { Must never exceed 254.  }
{$ifndef MA_MAX_NODE_BUS_COUNT}

  const
    MA_MAX_NODE_BUS_COUNT = 254;    
{$endif}
  { Used internally by miniaudio for memory management. Must never exceed MA_MAX_NODE_BUS_COUNT.  }
{$ifndef MA_MAX_NODE_LOCAL_BUS_COUNT}

  const
    MA_MAX_NODE_LOCAL_BUS_COUNT = 2;    
{$endif}
{$ifndef MA_RESOURCE_MANAGER_MAX_JOB_THREAD_COUNT}

  const
    MA_RESOURCE_MANAGER_MAX_JOB_THREAD_COUNT = 64;    
{$endif}
{$ifndef MA_ENGINE_MAX_LISTENERS}

  const
    MA_ENGINE_MAX_LISTENERS = 4;    
{$endif}
    //MA_BACKEND_COUNT = ma_backend_null+1;    
  const
    MA_SOUND_SOURCE_CHANNEL_COUNT = $FFFFFFFF;    



  Type
    wchar_t = cint;
  Pchar  = ^char;
  Pma_allocation_callbacks  = ^ma_allocation_callbacks;
  Pma_async_notification  = ^ma_async_notification;
  Pma_async_notification_event  = ^ma_async_notification_event;
  Pma_async_notification_poll  = ^ma_async_notification_poll;
  Pma_audio_buffer  = ^ma_audio_buffer;
  PPma_audio_buffer  = ^Pma_audio_buffer;
  Pma_audio_buffer_config  = ^ma_audio_buffer_config;
  Pma_audio_buffer_ref  = ^ma_audio_buffer_ref;
  Pma_backend  = ^ma_backend;
  Pma_backend_callbacks  = ^ma_backend_callbacks;
  Pma_biquad  = ^ma_biquad;
  Pma_biquad_config  = ^ma_biquad_config;
  Pma_biquad_node  = ^ma_biquad_node;
  Pma_biquad_node_config  = ^ma_biquad_node_config;
  Pma_bpf  = ^ma_bpf;
  Pma_bpf2  = ^ma_bpf2;
  Pma_bpf2_config  = ^ma_bpf2_config;
  Pma_bpf_config  = ^ma_bpf_config;
  Pma_bpf_node  = ^ma_bpf_node;
  Pma_bpf_node_config  = ^ma_bpf_node_config;
  Pma_channel  = ^ma_channel;
  Pma_channel_converter  = ^ma_channel_converter;
  Pma_channel_converter_config  = ^ma_channel_converter_config;
  Pma_context  = ^ma_context;
  Pma_context_config  = ^ma_context_config;
  Pma_data_converter  = ^ma_data_converter;
  Pma_data_converter_config  = ^ma_data_converter_config;
  Pma_data_source  = ^ma_data_source;
  PPma_data_source  = ^Pma_data_source;
  Pma_data_source_config  = ^ma_data_source_config;
  Pma_data_source_node  = ^ma_data_source_node;
  Pma_data_source_node_config  = ^ma_data_source_node_config;
  Pma_decoder  = ^ma_decoder;
  Pma_decoder_config  = ^ma_decoder_config;
  Pma_decoding_backend_config  = ^ma_decoding_backend_config;
  Pma_default_vfs  = ^ma_default_vfs;
  Pma_delay  = ^ma_delay;
  Pma_delay_config  = ^ma_delay_config;
  Pma_delay_node  = ^ma_delay_node;
  Pma_delay_node_config  = ^ma_delay_node_config;
  Pma_device  = ^ma_device;
  Pma_device_config  = ^ma_device_config;
  Pma_device_descriptor  = ^ma_device_descriptor;
  Pma_device_id  = ^ma_device_id;
  Pma_device_info  = ^ma_device_info;
  PPma_device_info  = ^Pma_device_info;
  Pma_device_job_thread  = ^ma_device_job_thread;
  Pma_device_job_thread_config  = ^ma_device_job_thread_config;
  Pma_device_notification  = ^ma_device_notification;
  Pma_duplex_rb  = ^ma_duplex_rb;
  Pma_encoder  = ^ma_encoder;
  Pma_encoder_config  = ^ma_encoder_config;
  Pma_engine  = ^ma_engine;
  Pma_engine_config  = ^ma_engine_config;
  Pma_engine_node  = ^ma_engine_node;
  Pma_engine_node_config  = ^ma_engine_node_config;
  Pma_event  = ^ma_event;
  Pma_fader  = ^ma_fader;
  Pma_fader_config  = ^ma_fader_config;
  Pma_fence  = ^ma_fence;
  Pma_file_info  = ^ma_file_info;
  Pma_format  = ^ma_format;
  Pma_gainer  = ^ma_gainer;
  Pma_gainer_config  = ^ma_gainer_config;
  Pma_hishelf2  = ^ma_hishelf2;
  Pma_hishelf2_config  = ^ma_hishelf2_config;
  Pma_hishelf_config  = ^ma_hishelf_config;
  Pma_hishelf_node  = ^ma_hishelf_node;
  Pma_hishelf_node_config  = ^ma_hishelf_node_config;
  Pma_hpf  = ^ma_hpf;
  Pma_hpf1  = ^ma_hpf1;
  Pma_hpf1_config  = ^ma_hpf1_config;
  Pma_hpf2  = ^ma_hpf2;
  Pma_hpf2_config  = ^ma_hpf2_config;
  Pma_hpf_config  = ^ma_hpf_config;
  Pma_hpf_node  = ^ma_hpf_node;
  Pma_hpf_node_config  = ^ma_hpf_node_config;
  Pma_int16  = ^ma_int16;
  Pma_int32  = ^ma_int32;
  PPma_int32  = ^Pma_int32;
  Pma_int64  = ^ma_int64;
  Pma_job  = ^ma_job;
  Pma_job_queue  = ^ma_job_queue;
  Pma_job_queue_config  = ^ma_job_queue_config;
  Pma_linear_resampler  = ^ma_linear_resampler;
  Pma_linear_resampler_config  = ^ma_linear_resampler_config;
  Pma_log  = ^ma_log;
  Pma_loshelf2  = ^ma_loshelf2;
  Pma_loshelf2_config  = ^ma_loshelf2_config;
  Pma_loshelf_config  = ^ma_loshelf_config;
  Pma_loshelf_node  = ^ma_loshelf_node;
  Pma_loshelf_node_config  = ^ma_loshelf_node_config;
  Pma_lpf  = ^ma_lpf;
  Pma_lpf1  = ^ma_lpf1;
  Pma_lpf1_config  = ^ma_lpf1_config;
  Pma_lpf2  = ^ma_lpf2;
  Pma_lpf2_config  = ^ma_lpf2_config;
  Pma_lpf_config  = ^ma_lpf_config;
  Pma_lpf_node  = ^ma_lpf_node;
  Pma_lpf_node_config  = ^ma_lpf_node_config;
  Pma_mutex  = ^ma_mutex;
  Pma_node  = ^ma_node;
  Pma_node_config  = ^ma_node_config;
  Pma_node_graph  = ^ma_node_graph;
  Pma_node_graph_config  = ^ma_node_graph_config;
  Pma_noise  = ^ma_noise;
  Pma_noise_config  = ^ma_noise_config;
  Pma_notch2  = ^ma_notch2;
  Pma_notch2_config  = ^ma_notch2_config;
  Pma_notch_config  = ^ma_notch_config;
  Pma_notch_node  = ^ma_notch_node;
  Pma_notch_node_config  = ^ma_notch_node_config;
  Pma_paged_audio_buffer  = ^ma_paged_audio_buffer;
  Pma_paged_audio_buffer_config  = ^ma_paged_audio_buffer_config;
  Pma_paged_audio_buffer_data  = ^ma_paged_audio_buffer_data;
  Pma_paged_audio_buffer_page  = ^ma_paged_audio_buffer_page;
  PPma_paged_audio_buffer_page  = ^Pma_paged_audio_buffer_page;
  Pma_panner  = ^ma_panner;
  Pma_panner_config  = ^ma_panner_config;
  Pma_pcm_rb  = ^ma_pcm_rb;
  Pma_peak2  = ^ma_peak2;
  Pma_peak2_config  = ^ma_peak2_config;
  Pma_peak_config  = ^ma_peak_config;
  Pma_peak_node  = ^ma_peak_node;
  Pma_peak_node_config  = ^ma_peak_node_config;
  Pma_pulsewave  = ^ma_pulsewave;
  Pma_pulsewave_config  = ^ma_pulsewave_config;
  Pma_rb  = ^ma_rb;
  Pma_resampler  = ^ma_resampler;
  Pma_resampler_config  = ^ma_resampler_config;
  Pma_resampling_backend  = ^ma_resampling_backend;
  PPma_resampling_backend  = ^Pma_resampling_backend;
  Pma_resource_manager  = ^ma_resource_manager;
  Pma_resource_manager_config  = ^ma_resource_manager_config;
  Pma_resource_manager_data_buffer  = ^ma_resource_manager_data_buffer;
  Pma_resource_manager_data_source  = ^ma_resource_manager_data_source;
  Pma_resource_manager_data_source_config  = ^ma_resource_manager_data_source_config;
  Pma_resource_manager_data_stream  = ^ma_resource_manager_data_stream;
  Pma_resource_manager_pipeline_notifications  = ^ma_resource_manager_pipeline_notifications;
  Pma_slot_allocator  = ^ma_slot_allocator;
  Pma_slot_allocator_config  = ^ma_slot_allocator_config;
  Pma_sound  = ^ma_sound;
  Pma_sound_config  = ^ma_sound_config;
  Pma_sound_group  = ^ma_sound_group;
  Pma_sound_group_config  = ^ma_sound_group_config;
  Pma_spatializer  = ^ma_spatializer;
  Pma_spatializer_config  = ^ma_spatializer_config;
  Pma_spatializer_listener  = ^ma_spatializer_listener;
  Pma_spatializer_listener_config  = ^ma_spatializer_listener_config;
  Pma_spinlock  = ^ma_spinlock;
  Pma_splitter_node  = ^ma_splitter_node;
  Pma_splitter_node_config  = ^ma_splitter_node_config;
  Pma_uint32  = ^ma_uint32;
  Pma_uint64  = ^ma_uint64;
  Pma_uint8  = ^ma_uint8;
  Pma_vec3f  = ^ma_vec3f;
  Pma_vfs  = ^ma_vfs;
  Pma_vfs_file  = ^ma_vfs_file;
  Pma_waveform  = ^ma_waveform;
  Pma_waveform_config  = ^ma_waveform_config;
  Psingle  = ^single;
  PPsingle  = ^Psingle;
  Pdouble  = ^double;
  PPdouble  = ^Pdouble;
  Psize_t  = ^size_t;
  Pwchar_t  = ^wchar_t;
{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  {
  Audio playback and capture library. Choice of public domain or MIT-0. See license statements at the end of this file.
  miniaudio - v0.11.18 - 2023-08-07
  
  David Reid - mackron@gmail.com
  
  Website:       https://miniaud.io
  Documentation: https://miniaud.io/docs
  GitHub:        https://github.com/mackron/miniaudio
   }
  {
  1. Introduction
  ===============
  miniaudio is a single file library for audio playback and capture. To use it, do the following in
  one .c file:
  
      ```c
      #define MINIAUDIO_IMPLEMENTATION
      #include "miniaudio.h"
      ```
  
  You can do `#include "miniaudio.h"` in other parts of the program just like any other header.
  
  miniaudio includes both low level and high level APIs. The low level API is good for those who want
  to do all of their mixing themselves and only require a light weight interface to the underlying
  audio device. The high level API is good for those who have complex mixing and effect requirements.
  
  In miniaudio, objects are transparent structures. Unlike many other libraries, there are no handles
  to opaque objects which means you need to allocate memory for objects yourself. In the examples
  presented in this documentation you will often see objects declared on the stack. You need to be
  careful when translating these examples to your own code so that you don't accidentally declare
  your objects on the stack and then cause them to become invalid once the function returns. In
  addition, you must ensure the memory address of your objects remain the same throughout their
  lifetime. You therefore cannot be making copies of your objects.
  
  A config/init pattern is used throughout the entire library. The idea is that you set up a config
  object and pass that into the initialization routine. The advantage to this system is that the
  config object can be initialized with logical defaults and new properties added to it without
  breaking the API. The config object can be allocated on the stack and does not need to be
  maintained after initialization of the corresponding object.
  
  
  1.1. Low Level API
  ------------------
  The low level API gives you access to the raw audio data of an audio device. It supports playback,
  capture, full-duplex and loopback (WASAPI only). You can enumerate over devices to determine which
  physical device(s) you want to connect to.
  
  The low level API uses the concept of a "device" as the abstraction for physical devices. The idea
  is that you choose a physical device to emit or capture audio from, and then move data to/from the
  device when miniaudio tells you to. Data is delivered to and from devices asynchronously via a
  callback which you specify when initializing the device.
  
  When initializing the device you first need to configure it. The device configuration allows you to
  specify things like the format of the data delivered via the callback, the size of the internal
  buffer and the ID of the device you want to emit or capture audio from.
  
  Once you have the device configuration set up you can initialize the device. When initializing a
  device you need to allocate memory for the device object beforehand. This gives the application
  complete control over how the memory is allocated. In the example below we initialize a playback
  device on the stack, but you could allocate it on the heap if that suits your situation better.
  
      ```c
      void data_callback(ma_device* pDevice, void* pOutput, const void* pInput, ma_uint32 frameCount)
      
          // In playback mode copy data to pOutput. In capture mode read data from pInput. In full-duplex mode, both
          // pOutput and pInput will be valid and you can move data from pInput into pOutput. Never process more than
          // frameCount frames.
      
  
      int main()
      
          ma_device_config config = ma_device_config_init(ma_device_type_playback);
          config.playback.format   = ma_format_f32;   // Set to ma_format_unknown to use the device's native format.
          config.playback.channels = 2;               // Set to 0 to use the device's native channel count.
          config.sampleRate        = 48000;           // Set to 0 to use the device's native sample rate.
          config.dataCallback      = data_callback;   // This function will be called when miniaudio needs more data.
          config.pUserData         = pMyCustomData;   // Can be accessed from the device object (device.pUserData).
  
          ma_device device;
          if (ma_device_init(NULL, &config, &device) != MA_SUCCESS) 
              return -1;  // Failed to initialize the device.
          
  
          ma_device_start(&device);     // The device is sleeping by default so you'll need to start it manually.
  
          // Do something here. Probably your program's main loop.
  
          ma_device_uninit(&device);    // This will stop the device so no need to do that manually.
          return 0;
      
      ```
  
  In the example above, `data_callback()` is where audio data is written and read from the device.
  The idea is in playback mode you cause sound to be emitted from the speakers by writing audio data
  to the output buffer (`pOutput` in the example). In capture mode you read data from the input
  buffer (`pInput`) to extract sound captured by the microphone. The `frameCount` parameter tells you
  how many frames can be written to the output buffer and read from the input buffer. A "frame" is
  one sample for each channel. For example, in a stereo stream (2 channels), one frame is 2
  samples: one for the left, one for the right. The channel count is defined by the device config.
  The size in bytes of an individual sample is defined by the sample format which is also specified
  in the device config. Multi-channel audio data is always interleaved, which means the samples for
  each frame are stored next to each other in memory. For example, in a stereo stream the first pair
  of samples will be the left and right samples for the first frame, the second pair of samples will
  be the left and right samples for the second frame, etc.
  
  The configuration of the device is defined by the `ma_device_config` structure. The config object
  is always initialized with `ma_device_config_init()`. It's important to always initialize the
  config with this function as it initializes it with logical defaults and ensures your program
  doesn't break when new members are added to the `ma_device_config` structure. The example above
  uses a fairly simple and standard device configuration. The call to `ma_device_config_init()` takes
  a single parameter, which is whether or not the device is a playback, capture, duplex or loopback
  device (loopback devices are not supported on all backends). The `config.playback.format` member
  sets the sample format which can be one of the following (all formats are native-endian):
  
      +---------------+----------------------------------------+---------------------------+
      | Symbol        | Description                            | Range                     |
      +---------------+----------------------------------------+---------------------------+
      | ma_format_f32 | 32-bit floating point                  | [-1, 1]                   |
      | ma_format_s16 | 16-bit signed integer                  | [-32768, 32767]           |
      | ma_format_s24 | 24-bit signed integer (tightly packed) | [-8388608, 8388607]       |
      | ma_format_s32 | 32-bit signed integer                  | [-2147483648, 2147483647] |
      | ma_format_u8  | 8-bit unsigned integer                 | [0, 255]                  |
      +---------------+----------------------------------------+---------------------------+
  
  The `config.playback.channels` member sets the number of channels to use with the device. The
  channel count cannot exceed MA_MAX_CHANNELS. The `config.sampleRate` member sets the sample rate
  (which must be the same for both playback and capture in full-duplex configurations). This is
  usually set to 44100 or 48000, but can be set to anything. It's recommended to keep this between
  8000 and 384000, however.
  
  Note that leaving the format, channel count and/or sample rate at their default values will result
  in the internal device's native configuration being used which is useful if you want to avoid the
  overhead of miniaudio's automatic data conversion.
  
  In addition to the sample format, channel count and sample rate, the data callback and user data
  pointer are also set via the config. The user data pointer is not passed into the callback as a
  parameter, but is instead set to the `pUserData` member of `ma_device` which you can access
  directly since all miniaudio structures are transparent.
  
  Initializing the device is done with `ma_device_init()`. This will return a result code telling you
  what went wrong, if anything. On success it will return `MA_SUCCESS`. After initialization is
  complete the device will be in a stopped state. To start it, use `ma_device_start()`.
  Uninitializing the device will stop it, which is what the example above does, but you can also stop
  the device with `ma_device_stop()`. To resume the device simply call `ma_device_start()` again.
  Note that it's important to never stop or start the device from inside the callback. This will
  result in a deadlock. Instead you set a variable or signal an event indicating that the device
  needs to stop and handle it in a different thread. The following APIs must never be called inside
  the callback:
  
      ```c
      ma_device_init()
      ma_device_init_ex()
      ma_device_uninit()
      ma_device_start()
      ma_device_stop()
      ```
  
  You must never try uninitializing and reinitializing a device inside the callback. You must also
  never try to stop and start it from inside the callback. There are a few other things you shouldn't
  do in the callback depending on your requirements, however this isn't so much a thread-safety
  thing, but rather a real-time processing thing which is beyond the scope of this introduction.
  
  The example above demonstrates the initialization of a playback device, but it works exactly the
  same for capture. All you need to do is change the device type from `ma_device_type_playback` to
  `ma_device_type_capture` when setting up the config, like so:
  
      ```c
      ma_device_config config = ma_device_config_init(ma_device_type_capture);
      config.capture.format   = MY_FORMAT;
      config.capture.channels = MY_CHANNEL_COUNT;
      ```
  
  In the data callback you just read from the input buffer (`pInput` in the example above) and leave
  the output buffer alone (it will be set to NULL when the device type is set to
  `ma_device_type_capture`).
  
  These are the available device types and how you should handle the buffers in the callback:
  
      +-------------------------+--------------------------------------------------------+
      | Device Type             | Callback Behavior                                      |
      +-------------------------+--------------------------------------------------------+
      | ma_device_type_playback | Write to output buffer, leave input buffer untouched.  |
      | ma_device_type_capture  | Read from input buffer, leave output buffer untouched. |
      | ma_device_type_duplex   | Read from input buffer, write to output buffer.        |
      | ma_device_type_loopback | Read from input buffer, leave output buffer untouched. |
      +-------------------------+--------------------------------------------------------+
  
  You will notice in the example above that the sample format and channel count is specified
  separately for playback and capture. This is to support different data formats between the playback
  and capture devices in a full-duplex system. An example may be that you want to capture audio data
  as a monaural stream (one channel), but output sound to a stereo speaker system. Note that if you
  use different formats between playback and capture in a full-duplex configuration you will need to
  convert the data yourself. There are functions available to help you do this which will be
  explained later.
  
  The example above did not specify a physical device to connect to which means it will use the
  operating system's default device. If you have multiple physical devices connected and you want to
  use a specific one you will need to specify the device ID in the configuration, like so:
  
      ```c
      config.playback.pDeviceID = pMyPlaybackDeviceID;    // Only if requesting a playback or duplex device.
      config.capture.pDeviceID = pMyCaptureDeviceID;      // Only if requesting a capture, duplex or loopback device.
      ```
  
  To retrieve the device ID you will need to perform device enumeration, however this requires the
  use of a new concept called the "context". Conceptually speaking the context sits above the device.
  There is one context to many devices. The purpose of the context is to represent the backend at a
  more global level and to perform operations outside the scope of an individual device. Mainly it is
  used for performing run-time linking against backend libraries, initializing backends and
  enumerating devices. The example below shows how to enumerate devices.
  
      ```c
      ma_context context;
      if (ma_context_init(NULL, 0, NULL, &context) != MA_SUCCESS) 
          // Error.
      
  
      ma_device_info* pPlaybackInfos;
      ma_uint32 playbackCount;
      ma_device_info* pCaptureInfos;
      ma_uint32 captureCount;
      if (ma_context_get_devices(&context, &pPlaybackInfos, &playbackCount, &pCaptureInfos, &captureCount) != MA_SUCCESS) 
          // Error.
      
  
      // Loop over each device info and do something with it. Here we just print the name with their index. You may want
      // to give the user the opportunity to choose which device they'd prefer.
      for (ma_uint32 iDevice = 0; iDevice < playbackCount; iDevice += 1) 
          printf("%d - %s\n", iDevice, pPlaybackInfos[iDevice].name);
      
  
      ma_device_config config = ma_device_config_init(ma_device_type_playback);
      config.playback.pDeviceID = &pPlaybackInfos[chosenPlaybackDeviceIndex].id;
      config.playback.format    = MY_FORMAT;
      config.playback.channels  = MY_CHANNEL_COUNT;
      config.sampleRate         = MY_SAMPLE_RATE;
      config.dataCallback       = data_callback;
      config.pUserData          = pMyCustomData;
  
      ma_device device;
      if (ma_device_init(&context, &config, &device) != MA_SUCCESS) 
          // Error
      
  
      ...
  
      ma_device_uninit(&device);
      ma_context_uninit(&context);
      ```
  
  The first thing we do in this example is initialize a `ma_context` object with `ma_context_init()`.
  The first parameter is a pointer to a list of `ma_backend` values which are used to override the
  default backend priorities. When this is NULL, as in this example, miniaudio's default priorities
  are used. The second parameter is the number of backends listed in the array pointed to by the
  first parameter. The third parameter is a pointer to a `ma_context_config` object which can be
  NULL, in which case defaults are used. The context configuration is used for setting the logging
  callback, custom memory allocation callbacks, user-defined data and some backend-specific
  configurations.
  
  Once the context has been initialized you can enumerate devices. In the example above we use the
  simpler `ma_context_get_devices()`, however you can also use a callback for handling devices by
  using `ma_context_enumerate_devices()`. When using `ma_context_get_devices()` you provide a pointer
  to a pointer that will, upon output, be set to a pointer to a buffer containing a list of
  `ma_device_info` structures. You also provide a pointer to an unsigned integer that will receive
  the number of items in the returned buffer. Do not free the returned buffers as their memory is
  managed internally by miniaudio.
  
  The `ma_device_info` structure contains an `id` member which is the ID you pass to the device
  config. It also contains the name of the device which is useful for presenting a list of devices
  to the user via the UI.
  
  When creating your own context you will want to pass it to `ma_device_init()` when initializing the
  device. Passing in NULL, like we do in the first example, will result in miniaudio creating the
  context for you, which you don't want to do since you've already created a context. Note that
  internally the context is only tracked by it's pointer which means you must not change the location
  of the `ma_context` object. If this is an issue, consider using `malloc()` to allocate memory for
  the context.
  
  
  1.2. High Level API
  -------------------
  The high level API consists of three main parts:
  
    * Resource management for loading and streaming sounds.
    * A node graph for advanced mixing and effect processing.
    * A high level "engine" that wraps around the resource manager and node graph.
  
  The resource manager (`ma_resource_manager`) is used for loading sounds. It supports loading sounds
  fully into memory and also streaming. It will also deal with reference counting for you which
  avoids the same sound being loaded multiple times.
  
  The node graph is used for mixing and effect processing. The idea is that you connect a number of
  nodes into the graph by connecting each node's outputs to another node's inputs. Each node can
  implement it's own effect. By chaining nodes together, advanced mixing and effect processing can
  be achieved.
  
  The engine encapsulates both the resource manager and the node graph to create a simple, easy to
  use high level API. The resource manager and node graph APIs are covered in more later sections of
  this manual.
  
  The code below shows how you can initialize an engine using it's default configuration.
  
      ```c
      ma_result result;
      ma_engine engine;
  
      result = ma_engine_init(NULL, &engine);
      if (result != MA_SUCCESS) 
          return result;  // Failed to initialize the engine.
      
      ```
  
  This creates an engine instance which will initialize a device internally which you can access with
  `ma_engine_get_device()`. It will also initialize a resource manager for you which can be accessed
  with `ma_engine_get_resource_manager()`. The engine itself is a node graph (`ma_node_graph`) which
  means you can pass a pointer to the engine object into any of the `ma_node_graph` APIs (with a
  cast). Alternatively, you can use `ma_engine_get_node_graph()` instead of a cast.
  
  Note that all objects in miniaudio, including the `ma_engine` object in the example above, are
  transparent structures. There are no handles to opaque structures in miniaudio which means you need
  to be mindful of how you declare them. In the example above we are declaring it on the stack, but
  this will result in the struct being invalidated once the function encapsulating it returns. If
  allocating the engine on the heap is more appropriate, you can easily do so with a standard call
  to `malloc()` or whatever heap allocation routine you like:
  
      ```c
      ma_engine* pEngine = malloc(sizeof(*pEngine));
      ```
  
  The `ma_engine` API uses the same config/init pattern used all throughout miniaudio. To configure
  an engine, you can fill out a `ma_engine_config` object and pass it into the first parameter of
  `ma_engine_init()`:
  
      ```c
      ma_result result;
      ma_engine engine;
      ma_engine_config engineConfig;
  
      engineConfig = ma_engine_config_init();
      engineConfig.pResourceManager = &myCustomResourceManager;   // <-- Initialized as some earlier stage.
  
      result = ma_engine_init(&engineConfig, &engine);
      if (result != MA_SUCCESS) 
          return result;
      
      ```
  
  This creates an engine instance using a custom config. In this particular example it's showing how
  you can specify a custom resource manager rather than having the engine initialize one internally.
  This is particularly useful if you want to have multiple engine's share the same resource manager.
  
  The engine must be uninitialized with `ma_engine_uninit()` when it's no longer needed.
  
  By default the engine will be started, but nothing will be playing because no sounds have been
  initialized. The easiest but least flexible way of playing a sound is like so:
  
      ```c
      ma_engine_play_sound(&engine, "my_sound.wav", NULL);
      ```
  
  This plays what miniaudio calls an "inline" sound. It plays the sound once, and then puts the
  internal sound up for recycling. The last parameter is used to specify which sound group the sound
  should be associated with which will be explained later. This particular way of playing a sound is
  simple, but lacks flexibility and features. A more flexible way of playing a sound is to first
  initialize a sound:
  
      ```c
      ma_result result;
      ma_sound sound;
  
      result = ma_sound_init_from_file(&engine, "my_sound.wav", 0, NULL, NULL, &sound);
      if (result != MA_SUCCESS) 
          return result;
      
  
      ma_sound_start(&sound);
      ```
  
  This returns a `ma_sound` object which represents a single instance of the specified sound file. If
  you want to play the same file multiple times simultaneously, you need to create one sound for each
  instance.
  
  Sounds should be uninitialized with `ma_sound_uninit()`.
  
  Sounds are not started by default. Start a sound with `ma_sound_start()` and stop it with
  `ma_sound_stop()`. When a sound is stopped, it is not rewound to the start. Use
  `ma_sound_seek_to_pcm_frame(&sound, 0)` to seek back to the start of a sound. By default, starting
  and stopping sounds happens immediately, but sometimes it might be convenient to schedule the sound
  the be started and/or stopped at a specific time. This can be done with the following functions:
  
      ```c
      ma_sound_set_start_time_in_pcm_frames()
      ma_sound_set_start_time_in_milliseconds()
      ma_sound_set_stop_time_in_pcm_frames()
      ma_sound_set_stop_time_in_milliseconds()
      ```
  
  The start/stop time needs to be specified based on the absolute timer which is controlled by the
  engine. The current global time time in PCM frames can be retrieved with
  `ma_engine_get_time_in_pcm_frames()`. The engine's global time can be changed with
  `ma_engine_set_time_in_pcm_frames()` for synchronization purposes if required. Note that scheduling
  a start time still requires an explicit call to `ma_sound_start()` before anything will play:
  
      ```c
      ma_sound_set_start_time_in_pcm_frames(&sound, ma_engine_get_time_in_pcm_frames(&engine) + (ma_engine_get_sample_rate(&engine) * 2);
      ma_sound_start(&sound);
      ```
  
  The third parameter of `ma_sound_init_from_file()` is a set of flags that control how the sound be
  loaded and a few options on which features should be enabled for that sound. By default, the sound
  is synchronously loaded fully into memory straight from the file system without any kind of
  decoding. If you want to decode the sound before storing it in memory, you need to specify the
  `MA_SOUND_FLAG_DECODE` flag. This is useful if you want to incur the cost of decoding at an earlier
  stage, such as a loading stage. Without this option, decoding will happen dynamically at mixing
  time which might be too expensive on the audio thread.
  
  If you want to load the sound asynchronously, you can specify the `MA_SOUND_FLAG_ASYNC` flag. This
  will result in `ma_sound_init_from_file()` returning quickly, but the sound will not start playing
  until the sound has had some audio decoded.
  
  The fourth parameter is a pointer to sound group. A sound group is used as a mechanism to organise
  sounds into groups which have their own effect processing and volume control. An example is a game
  which might have separate groups for sfx, voice and music. Each of these groups have their own
  independent volume control. Use `ma_sound_group_init()` or `ma_sound_group_init_ex()` to initialize
  a sound group.
  
  Sounds and sound groups are nodes in the engine's node graph and can be plugged into any `ma_node`
  API. This makes it possible to connect sounds and sound groups to effect nodes to produce complex
  effect chains.
  
  A sound can have it's volume changed with `ma_sound_set_volume()`. If you prefer decibel volume
  control you can use `ma_volume_db_to_linear()` to convert from decibel representation to linear.
  
  Panning and pitching is supported with `ma_sound_set_pan()` and `ma_sound_set_pitch()`. If you know
  a sound will never have it's pitch changed with `ma_sound_set_pitch()` or via the doppler effect,
  you can specify the `MA_SOUND_FLAG_NO_PITCH` flag when initializing the sound for an optimization.
  
  By default, sounds and sound groups have spatialization enabled. If you don't ever want to
  spatialize your sounds, initialize the sound with the `MA_SOUND_FLAG_NO_SPATIALIZATION` flag. The
  spatialization model is fairly simple and is roughly on feature parity with OpenAL. HRTF and
  environmental occlusion are not currently supported, but planned for the future. The supported
  features include:
  
    * Sound and listener positioning and orientation with cones
    * Attenuation models: none, inverse, linear and exponential
    * Doppler effect
  
  Sounds can be faded in and out with `ma_sound_set_fade_in_pcm_frames()`.
  
  To check if a sound is currently playing, you can use `ma_sound_is_playing()`. To check if a sound
  is at the end, use `ma_sound_at_end()`. Looping of a sound can be controlled with
  `ma_sound_set_looping()`. Use `ma_sound_is_looping()` to check whether or not the sound is looping.
  
  
  
  2. Building
  ===========
  miniaudio should work cleanly out of the box without the need to download or install any
  dependencies. See below for platform-specific details.
  
  Note that GCC and Clang require `-msse2`, `-mavx2`, etc. for SIMD optimizations.
  
  If you get errors about undefined references to `__sync_val_compare_and_swap_8`, `__atomic_load_8`,
  etc. you need to link with `-latomic`.
  
  
  2.1. Windows
  ------------
  The Windows build should compile cleanly on all popular compilers without the need to configure any
  include paths nor link to any libraries.
  
  The UWP build may require linking to mmdevapi.lib if you get errors about an unresolved external
  symbol for `ActivateAudioInterfaceAsync()`.
  
  
  2.2. macOS and iOS
  ------------------
  The macOS build should compile cleanly without the need to download any dependencies nor link to
  any libraries or frameworks. The iOS build needs to be compiled as Objective-C and will need to
  link the relevant frameworks but should compile cleanly out of the box with Xcode. Compiling
  through the command line requires linking to `-lpthread` and `-lm`.
  
  Due to the way miniaudio links to frameworks at runtime, your application may not pass Apple's
  notarization process. To fix this there are two options. The first is to use the
  `MA_NO_RUNTIME_LINKING` option, like so:
  
      ```c
      #ifdef __APPLE__
          #define MA_NO_RUNTIME_LINKING
      #endif
      #define MINIAUDIO_IMPLEMENTATION
      #include "miniaudio.h"
      ```
  
  This will require linking with `-framework CoreFoundation -framework CoreAudio -framework AudioToolbox`.
  If you get errors about AudioToolbox, try with `-framework AudioUnit` instead. You may get this when
  using older versions of iOS. Alternatively, if you would rather keep using runtime linking you can
  add the following to your entitlements.xcent file:
  
      ```
      <key>com.apple.security.cs.allow-dyld-environment-variables</key>
      <true/>
      <key>com.apple.security.cs.allow-unsigned-executable-memory</key>
      <true/>
      ```
  
  See this discussion for more info: https://github.com/mackron/miniaudio/issues/203.
  
  
  2.3. Linux
  ----------
  The Linux build only requires linking to `-ldl`, `-lpthread` and `-lm`. You do not need any
  development packages. You may need to link with `-latomic` if you're compiling for 32-bit ARM.
  
  
  2.4. BSD
  --------
  The BSD build only requires linking to `-lpthread` and `-lm`. NetBSD uses audio(4), OpenBSD uses
  sndio and FreeBSD uses OSS. You may need to link with `-latomic` if you're compiling for 32-bit
  ARM.
  
  
  2.5. Android
  ------------
  AAudio is the highest priority backend on Android. This should work out of the box without needing
  any kind of compiler configuration. Support for AAudio starts with Android 8 which means older
  versions will fall back to OpenSL|ES which requires API level 16+.
  
  There have been reports that the OpenSL|ES backend fails to initialize on some Android based
  devices due to `dlopen()` failing to open "libOpenSLES.so". If this happens on your platform
  you'll need to disable run-time linking with `MA_NO_RUNTIME_LINKING` and link with -lOpenSLES.
  
  
  2.6. Emscripten
  ---------------
  The Emscripten build emits Web Audio JavaScript directly and should compile cleanly out of the box.
  You cannot use `-std=c*` compiler flags, nor `-ansi`.
  
  You can enable the use of AudioWorkets by defining `MA_ENABLE_AUDIO_WORKLETS` and then compiling
  with the following options:
  
      -sAUDIO_WORKLET=1 -sWASM_WORKERS=1 -sASYNCIFY
  
  An example for compiling with AudioWorklet support might look like this:
  
      emcc program.c -o bin/program.html -DMA_ENABLE_AUDIO_WORKLETS -sAUDIO_WORKLET=1 -sWASM_WORKERS=1 -sASYNCIFY
  
  To run locally, you'll need to use emrun:
  
      emrun bin/program.html
  
  
  
  2.7. Build Options
  ------------------
  `#define` these options before including miniaudio.h.
  
      +----------------------------------+--------------------------------------------------------------------+
      | Option                           | Description                                                        |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_WASAPI                     | Disables the WASAPI backend.                                       |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_DSOUND                     | Disables the DirectSound backend.                                  |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_WINMM                      | Disables the WinMM backend.                                        |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_ALSA                       | Disables the ALSA backend.                                         |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_PULSEAUDIO                 | Disables the PulseAudio backend.                                   |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_JACK                       | Disables the JACK backend.                                         |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_COREAUDIO                  | Disables the Core Audio backend.                                   |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_SNDIO                      | Disables the sndio backend.                                        |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_AUDIO4                     | Disables the audio(4) backend.                                     |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_OSS                        | Disables the OSS backend.                                          |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_AAUDIO                     | Disables the AAudio backend.                                       |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_OPENSL                     | Disables the OpenSL|ES backend.                                    |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_WEBAUDIO                   | Disables the Web Audio backend.                                    |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_NULL                       | Disables the null backend.                                         |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_ONLY_SPECIFIC_BACKENDS | Disables all backends by default and requires `MA_ENABLE_*` to     |
      |                                  | enable specific backends.                                          |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_WASAPI                 | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the WASAPI backend.                                         |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_DSOUND                 | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the DirectSound backend.                                    |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_WINMM                  | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the WinMM backend.                                          |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_ALSA                   | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the ALSA backend.                                           |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_PULSEAUDIO             | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the PulseAudio backend.                                     |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_JACK                   | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the JACK backend.                                           |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_COREAUDIO              | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the Core Audio backend.                                     |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_SNDIO                  | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the sndio backend.                                          |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_AUDIO4                 | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the audio(4) backend.                                       |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_OSS                    | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the OSS backend.                                            |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_AAUDIO                 | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the AAudio backend.                                         |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_OPENSL                 | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the OpenSL|ES backend.                                      |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_WEBAUDIO               | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the Web Audio backend.                                      |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_ENABLE_NULL                   | Used in conjunction with MA_ENABLE_ONLY_SPECIFIC_BACKENDS to       |
      |                                  | enable the null backend.                                           |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_DECODING                   | Disables decoding APIs.                                            |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_ENCODING                   | Disables encoding APIs.                                            |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_WAV                        | Disables the built-in WAV decoder and encoder.                     |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_FLAC                       | Disables the built-in FLAC decoder.                                |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_MP3                        | Disables the built-in MP3 decoder.                                 |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_DEVICE_IO                  | Disables playback and recording. This will disable `ma_context`    |
      |                                  | and `ma_device` APIs. This is useful if you only want to use       |
      |                                  | miniaudio's data conversion and/or decoding APIs.                  |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_RESOURCE_MANAGER           | Disables the resource manager. When using the engine this will     |
      |                                  | also disable the following functions:                              |
      |                                  |                                                                    |
      |                                  | ```                                                                |
      |                                  | ma_sound_init_from_file()                                          |
      |                                  | ma_sound_init_from_file_w()                                        |
      |                                  | ma_sound_init_copy()                                               |
      |                                  | ma_engine_play_sound_ex()                                          |
      |                                  | ma_engine_play_sound()                                             |
      |                                  | ```                                                                |
      |                                  |                                                                    |
      |                                  | The only way to initialize a `ma_sound` object is to initialize it |
      |                                  | from a data source.                                                |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_NODE_GRAPH                 | Disables the node graph API. This will also disable the engine API |
      |                                  | because it depends on the node graph.                              |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_ENGINE                     | Disables the engine API.                                           |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_THREADING                  | Disables the `ma_thread`, `ma_mutex`, `ma_semaphore` and           |
      |                                  | `ma_event` APIs. This option is useful if you only need to use     |
      |                                  | miniaudio for data conversion, decoding and/or encoding. Some      |
      |                                  | families of APIs require threading which means the following       |
      |                                  | options must also be set:                                          |
      |                                  |                                                                    |
      |                                  |     ```                                                            |
      |                                  |     MA_NO_DEVICE_IO                                                |
      |                                  |     ```                                                            |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_GENERATION                 | Disables generation APIs such a `ma_waveform` and `ma_noise`.      |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_SSE2                       | Disables SSE2 optimizations.                                       |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_AVX2                       | Disables AVX2 optimizations.                                       |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_NEON                       | Disables NEON optimizations.                                       |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_NO_RUNTIME_LINKING            | Disables runtime linking. This is useful for passing Apple's       |
      |                                  | notarization process. When enabling this, you may need to avoid    |
      |                                  | using `-std=c89` or `-std=c99` on Linux builds or else you may end |
      |                                  | up with compilation errors due to conflicts with `timespec` and    |
      |                                  | `timeval` data types.                                              |
      |                                  |                                                                    |
      |                                  | You may need to enable this if your target platform does not allow |
      |                                  | runtime linking via `dlopen()`.                                    |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_DEBUG_OUTPUT                  | Enable `printf()` output of debug logs (`MA_LOG_LEVEL_DEBUG`).     |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_COINIT_VALUE                  | Windows only. The value to pass to internal calls to               |
      |                                  | `CoInitializeEx()`. Defaults to `COINIT_MULTITHREADED`.            |
      +----------------------------------+--------------------------------------------------------------------+
      | MA_API                           | Controls how public APIs should be decorated. Default is `extern`. |
      +----------------------------------+--------------------------------------------------------------------+
  
  
  3. Definitions
  ==============
  This section defines common terms used throughout miniaudio. Unfortunately there is often ambiguity
  in the use of terms throughout the audio space, so this section is intended to clarify how miniaudio
  uses each term.
  
  3.1. Sample
  -----------
  A sample is a single unit of audio data. If the sample format is f32, then one sample is one 32-bit
  floating point number.
  
  3.2. Frame / PCM Frame
  ----------------------
  A frame is a group of samples equal to the number of channels. For a stereo stream a frame is 2
  samples, a mono frame is 1 sample, a 5.1 surround sound frame is 6 samples, etc. The terms "frame"
  and "PCM frame" are the same thing in miniaudio. Note that this is different to a compressed frame.
  If ever miniaudio needs to refer to a compressed frame, such as a FLAC frame, it will always
  clarify what it's referring to with something like "FLAC frame".
  
  3.3. Channel
  ------------
  A stream of monaural audio that is emitted from an individual speaker in a speaker system, or
  received from an individual microphone in a microphone system. A stereo stream has two channels (a
  left channel, and a right channel), a 5.1 surround sound system has 6 channels, etc. Some audio
  systems refer to a channel as a complex audio stream that's mixed with other channels to produce
  the final mix - this is completely different to miniaudio's use of the term "channel" and should
  not be confused.
  
  3.4. Sample Rate
  ----------------
  The sample rate in miniaudio is always expressed in Hz, such as 44100, 48000, etc. It's the number
  of PCM frames that are processed per second.
  
  3.5. Formats
  ------------
  Throughout miniaudio you will see references to different sample formats:
  
      +---------------+----------------------------------------+---------------------------+
      | Symbol        | Description                            | Range                     |
      +---------------+----------------------------------------+---------------------------+
      | ma_format_f32 | 32-bit floating point                  | [-1, 1]                   |
      | ma_format_s16 | 16-bit signed integer                  | [-32768, 32767]           |
      | ma_format_s24 | 24-bit signed integer (tightly packed) | [-8388608, 8388607]       |
      | ma_format_s32 | 32-bit signed integer                  | [-2147483648, 2147483647] |
      | ma_format_u8  | 8-bit unsigned integer                 | [0, 255]                  |
      +---------------+----------------------------------------+---------------------------+
  
  All formats are native-endian.
  
  
  
  4. Data Sources
  ===============
  The data source abstraction in miniaudio is used for retrieving audio data from some source. A few
  examples include `ma_decoder`, `ma_noise` and `ma_waveform`. You will need to be familiar with data
  sources in order to make sense of some of the higher level concepts in miniaudio.
  
  The `ma_data_source` API is a generic interface for reading from a data source. Any object that
  implements the data source interface can be plugged into any `ma_data_source` function.
  
  To read data from a data source:
  
      ```c
      ma_result result;
      ma_uint64 framesRead;
  
      result = ma_data_source_read_pcm_frames(pDataSource, pFramesOut, frameCount, &framesRead);
      if (result != MA_SUCCESS) 
          return result;  // Failed to read data from the data source.
      
      ```
  
  If you don't need the number of frames that were successfully read you can pass in `NULL` to the
  `pFramesRead` parameter. If this returns a value less than the number of frames requested it means
  the end of the file has been reached. `MA_AT_END` will be returned only when the number of frames
  read is 0.
  
  When calling any data source function, with the exception of `ma_data_source_init()` and
  `ma_data_source_uninit()`, you can pass in any object that implements a data source. For example,
  you could plug in a decoder like so:
  
      ```c
      ma_result result;
      ma_uint64 framesRead;
      ma_decoder decoder;   // <-- This would be initialized with `ma_decoder_init_*()`.
  
      result = ma_data_source_read_pcm_frames(&decoder, pFramesOut, frameCount, &framesRead);
      if (result != MA_SUCCESS) 
          return result;  // Failed to read data from the decoder.
      
      ```
  
  If you want to seek forward you can pass in `NULL` to the `pFramesOut` parameter. Alternatively you
  can use `ma_data_source_seek_pcm_frames()`.
  
  To seek to a specific PCM frame:
  
      ```c
      result = ma_data_source_seek_to_pcm_frame(pDataSource, frameIndex);
      if (result != MA_SUCCESS) 
          return result;  // Failed to seek to PCM frame.
      
      ```
  
  You can retrieve the total length of a data source in PCM frames, but note that some data sources
  may not have the notion of a length, such as noise and waveforms, and others may just not have a
  way of determining the length such as some decoders. To retrieve the length:
  
      ```c
      ma_uint64 length;
  
      result = ma_data_source_get_length_in_pcm_frames(pDataSource, &length);
      if (result != MA_SUCCESS) 
          return result;  // Failed to retrieve the length.
      
      ```
  
  Care should be taken when retrieving the length of a data source where the underlying decoder is
  pulling data from a data stream with an undefined length, such as internet radio or some kind of
  broadcast. If you do this, `ma_data_source_get_length_in_pcm_frames()` may never return.
  
  The current position of the cursor in PCM frames can also be retrieved:
  
      ```c
      ma_uint64 cursor;
  
      result = ma_data_source_get_cursor_in_pcm_frames(pDataSource, &cursor);
      if (result != MA_SUCCESS) 
          return result;  // Failed to retrieve the cursor.
      
      ```
  
  You will often need to know the data format that will be returned after reading. This can be
  retrieved like so:
  
      ```c
      ma_format format;
      ma_uint32 channels;
      ma_uint32 sampleRate;
      ma_channel channelMap[MA_MAX_CHANNELS];
  
      result = ma_data_source_get_data_format(pDataSource, &format, &channels, &sampleRate, channelMap, MA_MAX_CHANNELS);
      if (result != MA_SUCCESS) 
          return result;  // Failed to retrieve data format.
      
      ```
  
  If you do not need a specific data format property, just pass in NULL to the respective parameter.
  
  There may be cases where you want to implement something like a sound bank where you only want to
  read data within a certain range of the underlying data. To do this you can use a range:
  
      ```c
      result = ma_data_source_set_range_in_pcm_frames(pDataSource, rangeBegInFrames, rangeEndInFrames);
      if (result != MA_SUCCESS) 
          return result;  // Failed to set the range.
      
      ```
  
  This is useful if you have a sound bank where many sounds are stored in the same file and you want
  the data source to only play one of those sub-sounds. Note that once the range is set, everything
  that takes a position, such as cursors and loop points, should always be relatvie to the start of
  the range. When the range is set, any previously defined loop point will be reset.
  
  Custom loop points can also be used with data sources. By default, data sources will loop after
  they reach the end of the data source, but if you need to loop at a specific location, you can do
  the following:
  
      ```c
      result = ma_data_set_loop_point_in_pcm_frames(pDataSource, loopBegInFrames, loopEndInFrames);
      if (result != MA_SUCCESS) 
          return result;  // Failed to set the loop point.
      
      ```
  
  The loop point is relative to the current range.
  
  It's sometimes useful to chain data sources together so that a seamless transition can be achieved.
  To do this, you can use chaining:
  
      ```c
      ma_decoder decoder1;
      ma_decoder decoder2;
  
      // ... initialize decoders with ma_decoder_init_*() ...
  
      result = ma_data_source_set_next(&decoder1, &decoder2);
      if (result != MA_SUCCESS) 
          return result;  // Failed to set the next data source.
      
  
      result = ma_data_source_read_pcm_frames(&decoder1, pFramesOut, frameCount, pFramesRead);
      if (result != MA_SUCCESS) 
          return result;  // Failed to read from the decoder.
      
      ```
  
  In the example above we're using decoders. When reading from a chain, you always want to read from
  the top level data source in the chain. In the example above, `decoder1` is the top level data
  source in the chain. When `decoder1` reaches the end, `decoder2` will start seamlessly without any
  gaps.
  
  Note that when looping is enabled, only the current data source will be looped. You can loop the
  entire chain by linking in a loop like so:
  
      ```c
      ma_data_source_set_next(&decoder1, &decoder2);  // decoder1 -> decoder2
      ma_data_source_set_next(&decoder2, &decoder1);  // decoder2 -> decoder1 (loop back to the start).
      ```
  
  Note that setting up chaining is not thread safe, so care needs to be taken if you're dynamically
  changing links while the audio thread is in the middle of reading.
  
  Do not use `ma_decoder_seek_to_pcm_frame()` as a means to reuse a data source to play multiple
  instances of the same sound simultaneously. This can be extremely inefficient depending on the type
  of data source and can result in glitching due to subtle changes to the state of internal filters.
  Instead, initialize multiple data sources for each instance.
  
  
  4.1. Custom Data Sources
  ------------------------
  You can implement a custom data source by implementing the functions in `ma_data_source_vtable`.
  Your custom object must have `ma_data_source_base` as it's first member:
  
      ```c
      struct my_data_source
      
          ma_data_source_base base;
          ...
      ;
      ```
  
  In your initialization routine, you need to call `ma_data_source_init()` in order to set up the
  base object (`ma_data_source_base`):
  
      ```c
      static ma_result my_data_source_read(ma_data_source* pDataSource, void* pFramesOut, ma_uint64 frameCount, ma_uint64* pFramesRead)
      
          // Read data here. Output in the same format returned by my_data_source_get_data_format().
      
  
      static ma_result my_data_source_seek(ma_data_source* pDataSource, ma_uint64 frameIndex)
      
          // Seek to a specific PCM frame here. Return MA_NOT_IMPLEMENTED if seeking is not supported.
      
  
      static ma_result my_data_source_get_data_format(ma_data_source* pDataSource, ma_format* pFormat, ma_uint32* pChannels, ma_uint32* pSampleRate, ma_channel* pChannelMap, size_t channelMapCap)
      
          // Return the format of the data here.
      
  
      static ma_result my_data_source_get_cursor(ma_data_source* pDataSource, ma_uint64* pCursor)
      
          // Retrieve the current position of the cursor here. Return MA_NOT_IMPLEMENTED and set *pCursor to 0 if there is no notion of a cursor.
      
  
      static ma_result my_data_source_get_length(ma_data_source* pDataSource, ma_uint64* pLength)
      
          // Retrieve the length in PCM frames here. Return MA_NOT_IMPLEMENTED and set *pLength to 0 if there is no notion of a length or if the length is unknown.
      
  
      static ma_data_source_vtable g_my_data_source_vtable =
      
          my_data_source_read,
          my_data_source_seek,
          my_data_source_get_data_format,
          my_data_source_get_cursor,
          my_data_source_get_length
      ;
  
      ma_result my_data_source_init(my_data_source* pMyDataSource)
      
          ma_result result;
          ma_data_source_config baseConfig;
  
          baseConfig = ma_data_source_config_init();
          baseConfig.vtable = &g_my_data_source_vtable;
  
          result = ma_data_source_init(&baseConfig, &pMyDataSource->base);
          if (result != MA_SUCCESS) 
              return result;
          
  
          // ... do the initialization of your custom data source here ...
  
          return MA_SUCCESS;
      
  
      void my_data_source_uninit(my_data_source* pMyDataSource)
      
          // ... do the uninitialization of your custom data source here ...
  
          // You must uninitialize the base data source.
          ma_data_source_uninit(&pMyDataSource->base);
      
      ```
  
  Note that `ma_data_source_init()` and `ma_data_source_uninit()` are never called directly outside
  of the custom data source. It's up to the custom data source itself to call these within their own
  init/uninit functions.
  
  
  
  5. Engine
  =========
  The `ma_engine` API is a high level API for managing and mixing sounds and effect processing. The
  `ma_engine` object encapsulates a resource manager and a node graph, both of which will be
  explained in more detail later.
  
  Sounds are called `ma_sound` and are created from an engine. Sounds can be associated with a mixing
  group called `ma_sound_group` which are also created from the engine. Both `ma_sound` and
  `ma_sound_group` objects are nodes within the engine's node graph.
  
  When the engine is initialized, it will normally create a device internally. If you would rather
  manage the device yourself, you can do so and just pass a pointer to it via the engine config when
  you initialize the engine. You can also just use the engine without a device, which again can be
  configured via the engine config.
  
  The most basic way to initialize the engine is with a default config, like so:
  
      ```c
      ma_result result;
      ma_engine engine;
  
      result = ma_engine_init(NULL, &engine);
      if (result != MA_SUCCESS) 
          return result;  // Failed to initialize the engine.
      
      ```
  
  This will result in the engine initializing a playback device using the operating system's default
  device. This will be sufficient for many use cases, but if you need more flexibility you'll want to
  configure the engine with an engine config:
  
      ```c
      ma_result result;
      ma_engine engine;
      ma_engine_config engineConfig;
  
      engineConfig = ma_engine_config_init();
      engineConfig.pDevice = &myDevice;
  
      result = ma_engine_init(&engineConfig, &engine);
      if (result != MA_SUCCESS) 
          return result;  // Failed to initialize the engine.
      
      ```
  
  In the example above we're passing in a pre-initialized device. Since the caller is the one in
  control of the device's data callback, it's their responsibility to manually call
  `ma_engine_read_pcm_frames()` from inside their data callback:
  
      ```c
      void playback_data_callback(ma_device* pDevice, void* pOutput, const void* pInput, ma_uint32 frameCount)
      
          ma_engine_read_pcm_frames(&g_Engine, pOutput, frameCount, NULL);
      
      ```
  
  You can also use the engine independent of a device entirely:
  
      ```c
      ma_result result;
      ma_engine engine;
      ma_engine_config engineConfig;
  
      engineConfig = ma_engine_config_init();
      engineConfig.noDevice   = MA_TRUE;
      engineConfig.channels   = 2;        // Must be set when not using a device.
      engineConfig.sampleRate = 48000;    // Must be set when not using a device.
  
      result = ma_engine_init(&engineConfig, &engine);
      if (result != MA_SUCCESS) 
          return result;  // Failed to initialize the engine.
      
      ```
  
  Note that when you're not using a device, you must set the channel count and sample rate in the
  config or else miniaudio won't know what to use (miniaudio will use the device to determine this
  normally). When not using a device, you need to use `ma_engine_read_pcm_frames()` to process audio
  data from the engine. This kind of setup is useful if you want to do something like offline
  processing or want to use a different audio system for playback such as SDL.
  
  When a sound is loaded it goes through a resource manager. By default the engine will initialize a
  resource manager internally, but you can also specify a pre-initialized resource manager:
  
      ```c
      ma_result result;
      ma_engine engine1;
      ma_engine engine2;
      ma_engine_config engineConfig;
  
      engineConfig = ma_engine_config_init();
      engineConfig.pResourceManager = &myResourceManager;
  
      ma_engine_init(&engineConfig, &engine1);
      ma_engine_init(&engineConfig, &engine2);
      ```
  
  In this example we are initializing two engines, both of which are sharing the same resource
  manager. This is especially useful for saving memory when loading the same file across multiple
  engines. If you were not to use a shared resource manager, each engine instance would use their own
  which would result in any sounds that are used between both engine's being loaded twice. By using
  a shared resource manager, it would only be loaded once. Using multiple engine's is useful when you
  need to output to multiple playback devices, such as in a local multiplayer game where each player
  is using their own set of headphones.
  
  By default an engine will be in a started state. To make it so the engine is not automatically
  started you can configure it as such:
  
      ```c
      engineConfig.noAutoStart = MA_TRUE;
  
      // The engine will need to be started manually.
      ma_engine_start(&engine);
  
      // Later on the engine can be stopped with ma_engine_stop().
      ma_engine_stop(&engine);
      ```
  
  The concept of starting or stopping an engine is only relevant when using the engine with a
  device. Attempting to start or stop an engine that is not associated with a device will result in
  `MA_INVALID_OPERATION`.
  
  The master volume of the engine can be controlled with `ma_engine_set_volume()` which takes a
  linear scale, with 0 resulting in silence and anything above 1 resulting in amplification. If you
  prefer decibel based volume control, use `ma_volume_db_to_linear()` to convert from dB to linear.
  
  When a sound is spatialized, it is done so relative to a listener. An engine can be configured to
  have multiple listeners which can be configured via the config:
  
      ```c
      engineConfig.listenerCount = 2;
      ```
  
  The maximum number of listeners is restricted to `MA_ENGINE_MAX_LISTENERS`. By default, when a
  sound is spatialized, it will be done so relative to the closest listener. You can also pin a sound
  to a specific listener which will be explained later. Listener's have a position, direction, cone,
  and velocity (for doppler effect). A listener is referenced by an index, the meaning of which is up
  to the caller (the index is 0 based and cannot go beyond the listener count, minus 1). The
  position, direction and velocity are all specified in absolute terms:
  
      ```c
      ma_engine_listener_set_position(&engine, listenerIndex, worldPosX, worldPosY, worldPosZ);
      ```
  
  The direction of the listener represents it's forward vector. The listener's up vector can also be
  specified and defaults to +1 on the Y axis.
  
      ```c
      ma_engine_listener_set_direction(&engine, listenerIndex, forwardX, forwardY, forwardZ);
      ma_engine_listener_set_world_up(&engine, listenerIndex, 0, 1, 0);
      ```
  
  The engine supports directional attenuation. The listener can have a cone the controls how sound is
  attenuated based on the listener's direction. When a sound is between the inner and outer cones, it
  will be attenuated between 1 and the cone's outer gain:
  
      ```c
      ma_engine_listener_set_cone(&engine, listenerIndex, innerAngleInRadians, outerAngleInRadians, outerGain);
      ```
  
  When a sound is inside the inner code, no directional attenuation is applied. When the sound is
  outside of the outer cone, the attenuation will be set to `outerGain` in the example above. When
  the sound is in between the inner and outer cones, the attenuation will be interpolated between 1
  and the outer gain.
  
  The engine's coordinate system follows the OpenGL coordinate system where positive X points right,
  positive Y points up and negative Z points forward.
  
  The simplest and least flexible way to play a sound is like so:
  
      ```c
      ma_engine_play_sound(&engine, "my_sound.wav", pGroup);
      ```
  
  This is a "fire and forget" style of function. The engine will manage the `ma_sound` object
  internally. When the sound finishes playing, it'll be put up for recycling. For more flexibility
  you'll want to initialize a sound object:
  
      ```c
      ma_sound sound;
  
      result = ma_sound_init_from_file(&engine, "my_sound.wav", flags, pGroup, NULL, &sound);
      if (result != MA_SUCCESS) 
          return result;  // Failed to load sound.
      
      ```
  
  Sounds need to be uninitialized with `ma_sound_uninit()`.
  
  The example above loads a sound from a file. If the resource manager has been disabled you will not
  be able to use this function and instead you'll need to initialize a sound directly from a data
  source:
  
      ```c
      ma_sound sound;
  
      result = ma_sound_init_from_data_source(&engine, &dataSource, flags, pGroup, &sound);
      if (result != MA_SUCCESS) 
          return result;
      
      ```
  
  Each `ma_sound` object represents a single instance of the sound. If you want to play the same
  sound multiple times at the same time, you need to initialize a separate `ma_sound` object.
  
  For the most flexibility when initializing sounds, use `ma_sound_init_ex()`. This uses miniaudio's
  standard config/init pattern:
  
      ```c
      ma_sound sound;
      ma_sound_config soundConfig;
  
      soundConfig = ma_sound_config_init();
      soundConfig.pFilePath   = NULL; // Set this to load from a file path.
      soundConfig.pDataSource = NULL; // Set this to initialize from an existing data source.
      soundConfig.pInitialAttachment = &someNodeInTheNodeGraph;
      soundConfig.initialAttachmentInputBusIndex = 0;
      soundConfig.channelsIn  = 1;
      soundConfig.channelsOut = 0;    // Set to 0 to use the engine's native channel count.
  
      result = ma_sound_init_ex(&soundConfig, &sound);
      if (result != MA_SUCCESS) 
          return result;
      
      ```
  
  In the example above, the sound is being initialized without a file nor a data source. This is
  valid, in which case the sound acts as a node in the middle of the node graph. This means you can
  connect other sounds to this sound and allow it to act like a sound group. Indeed, this is exactly
  what a `ma_sound_group` is.
  
  When loading a sound, you specify a set of flags that control how the sound is loaded and what
  features are enabled for that sound. When no flags are set, the sound will be fully loaded into
  memory in exactly the same format as how it's stored on the file system. The resource manager will
  allocate a block of memory and then load the file directly into it. When reading audio data, it
  will be decoded dynamically on the fly. In order to save processing time on the audio thread, it
  might be beneficial to pre-decode the sound. You can do this with the `MA_SOUND_FLAG_DECODE` flag:
  
      ```c
      ma_sound_init_from_file(&engine, "my_sound.wav", MA_SOUND_FLAG_DECODE, pGroup, NULL, &sound);
      ```
  
  By default, sounds will be loaded synchronously, meaning `ma_sound_init_*()` will not return until
  the sound has been fully loaded. If this is prohibitive you can instead load sounds asynchronously
  by specifying the `MA_SOUND_FLAG_ASYNC` flag:
  
      ```c
      ma_sound_init_from_file(&engine, "my_sound.wav", MA_SOUND_FLAG_DECODE | MA_SOUND_FLAG_ASYNC, pGroup, NULL, &sound);
      ```
  
  This will result in `ma_sound_init_*()` returning quickly, but the sound won't yet have been fully
  loaded. When you start the sound, it won't output anything until some sound is available. The sound
  will start outputting audio before the sound has been fully decoded when the `MA_SOUND_FLAG_DECODE`
  is specified.
  
  If you need to wait for an asynchronously loaded sound to be fully loaded, you can use a fence. A
  fence in miniaudio is a simple synchronization mechanism which simply blocks until it's internal
  counter hit's zero. You can specify a fence like so:
  
      ```c
      ma_result result;
      ma_fence fence;
      ma_sound sounds[4];
  
      result = ma_fence_init(&fence);
      if (result != MA_SUCCESS) 
          return result;
      
  
      // Load some sounds asynchronously.
      for (int iSound = 0; iSound < 4; iSound += 1) 
          ma_sound_init_from_file(&engine, mySoundFilesPaths[iSound], MA_SOUND_FLAG_DECODE | MA_SOUND_FLAG_ASYNC, pGroup, &fence, &sounds[iSound]);
      
  
      // ... do some other stuff here in the mean time ...
  
      // Wait for all sounds to finish loading.
      ma_fence_wait(&fence);
      ```
  
  If loading the entire sound into memory is prohibitive, you can also configure the engine to stream
  the audio data:
  
      ```c
      ma_sound_init_from_file(&engine, "my_sound.wav", MA_SOUND_FLAG_STREAM, pGroup, NULL, &sound);
      ```
  
  When streaming sounds, 2 seconds worth of audio data is stored in memory. Although it should work
  fine, it's inefficient to use streaming for short sounds. Streaming is useful for things like music
  tracks in games.
  
  When loading a sound from a file path, the engine will reference count the file to prevent it from
  being loaded if it's already in memory. When you uninitialize a sound, the reference count will be
  decremented, and if it hits zero, the sound will be unloaded from memory. This reference counting
  system is not used for streams. The engine will use a 64-bit hash of the file name when comparing
  file paths which means there's a small chance you might encounter a name collision. If this is an
  issue, you'll need to use a different name for one of the colliding file paths, or just not load
  from files and instead load from a data source.
  
  You can use `ma_sound_init_copy()` to initialize a copy of another sound. Note, however, that this
  only works for sounds that were initialized with `ma_sound_init_from_file()` and without the
  `MA_SOUND_FLAG_STREAM` flag.
  
  When you initialize a sound, if you specify a sound group the sound will be attached to that group
  automatically. If you set it to NULL, it will be automatically attached to the engine's endpoint.
  If you would instead rather leave the sound unattached by default, you can can specify the
  `MA_SOUND_FLAG_NO_DEFAULT_ATTACHMENT` flag. This is useful if you want to set up a complex node
  graph.
  
  Sounds are not started by default. To start a sound, use `ma_sound_start()`. Stop a sound with
  `ma_sound_stop()`.
  
  Sounds can have their volume controlled with `ma_sound_set_volume()` in the same way as the
  engine's master volume.
  
  Sounds support stereo panning and pitching. Set the pan with `ma_sound_set_pan()`. Setting the pan
  to 0 will result in an unpanned sound. Setting it to -1 will shift everything to the left, whereas
  +1 will shift it to the right. The pitch can be controlled with `ma_sound_set_pitch()`. A larger
  value will result in a higher pitch. The pitch must be greater than 0.
  
  The engine supports 3D spatialization of sounds. By default sounds will have spatialization
  enabled, but if a sound does not need to be spatialized it's best to disable it. There are two ways
  to disable spatialization of a sound:
  
      ```c
      // Disable spatialization at initialization time via a flag:
      ma_sound_init_from_file(&engine, "my_sound.wav", MA_SOUND_FLAG_NO_SPATIALIZATION, NULL, NULL, &sound);
  
      // Dynamically disable or enable spatialization post-initialization:
      ma_sound_set_spatialization_enabled(&sound, isSpatializationEnabled);
      ```
  
  By default sounds will be spatialized based on the closest listener. If a sound should always be
  spatialized relative to a specific listener it can be pinned to one:
  
      ```c
      ma_sound_set_pinned_listener_index(&sound, listenerIndex);
      ```
  
  Like listeners, sounds have a position. By default, the position of a sound is in absolute space,
  but it can be changed to be relative to a listener:
  
      ```c
      ma_sound_set_positioning(&sound, ma_positioning_relative);
      ```
  
  Note that relative positioning of a sound only makes sense if there is either only one listener, or
  the sound is pinned to a specific listener. To set the position of a sound:
  
      ```c
      ma_sound_set_position(&sound, posX, posY, posZ);
      ```
  
  The direction works the same way as a listener and represents the sound's forward direction:
  
      ```c
      ma_sound_set_direction(&sound, forwardX, forwardY, forwardZ);
      ```
  
  Sound's also have a cone for controlling directional attenuation. This works exactly the same as
  listeners:
  
      ```c
      ma_sound_set_cone(&sound, innerAngleInRadians, outerAngleInRadians, outerGain);
      ```
  
  The velocity of a sound is used for doppler effect and can be set as such:
  
      ```c
      ma_sound_set_velocity(&sound, velocityX, velocityY, velocityZ);
      ```
  
  The engine supports different attenuation models which can be configured on a per-sound basis. By
  default the attenuation model is set to `ma_attenuation_model_inverse` which is the equivalent to
  OpenAL's `AL_INVERSE_DISTANCE_CLAMPED`. Configure the attenuation model like so:
  
      ```c
      ma_sound_set_attenuation_model(&sound, ma_attenuation_model_inverse);
      ```
  
  The supported attenuation models include the following:
  
      +----------------------------------+----------------------------------------------+
      | ma_attenuation_model_none        | No distance attenuation.                     |
      +----------------------------------+----------------------------------------------+
      | ma_attenuation_model_inverse     | Equivalent to `AL_INVERSE_DISTANCE_CLAMPED`. |
      +----------------------------------+----------------------------------------------+
      | ma_attenuation_model_linear      | Linear attenuation.                          |
      +----------------------------------+----------------------------------------------+
      | ma_attenuation_model_exponential | Exponential attenuation.                     |
      +----------------------------------+----------------------------------------------+
  
  To control how quickly a sound rolls off as it moves away from the listener, you need to configure
  the rolloff:
  
      ```c
      ma_sound_set_rolloff(&sound, rolloff);
      ```
  
  You can control the minimum and maximum gain to apply from spatialization:
  
      ```c
      ma_sound_set_min_gain(&sound, minGain);
      ma_sound_set_max_gain(&sound, maxGain);
      ```
  
  Likewise, in the calculation of attenuation, you can control the minimum and maximum distances for
  the attenuation calculation. This is useful if you want to ensure sounds don't drop below a certain
  volume after the listener moves further away and to have sounds play a maximum volume when the
  listener is within a certain distance:
  
      ```c
      ma_sound_set_min_distance(&sound, minDistance);
      ma_sound_set_max_distance(&sound, maxDistance);
      ```
  
  The engine's spatialization system supports doppler effect. The doppler factor can be configure on
  a per-sound basis like so:
  
      ```c
      ma_sound_set_doppler_factor(&sound, dopplerFactor);
      ```
  
  You can fade sounds in and out with `ma_sound_set_fade_in_pcm_frames()` and
  `ma_sound_set_fade_in_milliseconds()`. Set the volume to -1 to use the current volume as the
  starting volume:
  
      ```c
      // Fade in over 1 second.
      ma_sound_set_fade_in_milliseconds(&sound, 0, 1, 1000);
  
      // ... sometime later ...
  
      // Fade out over 1 second, starting from the current volume.
      ma_sound_set_fade_in_milliseconds(&sound, -1, 0, 1000);
      ```
  
  By default sounds will start immediately, but sometimes for timing and synchronization purposes it
  can be useful to schedule a sound to start or stop:
  
      ```c
      // Start the sound in 1 second from now.
      ma_sound_set_start_time_in_pcm_frames(&sound, ma_engine_get_time_in_pcm_frames(&engine) + (ma_engine_get_sample_rate(&engine) * 1));
  
      // Stop the sound in 2 seconds from now.
      ma_sound_set_stop_time_in_pcm_frames(&sound, ma_engine_get_time_in_pcm_frames(&engine) + (ma_engine_get_sample_rate(&engine) * 2));
      ```
  
  Note that scheduling a start time still requires an explicit call to `ma_sound_start()` before
  anything will play.
  
  The time is specified in global time which is controlled by the engine. You can get the engine's
  current time with `ma_engine_get_time_in_pcm_frames()`. The engine's global time is incremented
  automatically as audio data is read, but it can be reset with `ma_engine_set_time_in_pcm_frames()`
  in case it needs to be resynchronized for some reason.
  
  To determine whether or not a sound is currently playing, use `ma_sound_is_playing()`. This will
  take the scheduled start and stop times into account.
  
  Whether or not a sound should loop can be controlled with `ma_sound_set_looping()`. Sounds will not
  be looping by default. Use `ma_sound_is_looping()` to determine whether or not a sound is looping.
  
  Use `ma_sound_at_end()` to determine whether or not a sound is currently at the end. For a looping
  sound this should never return true. Alternatively, you can configure a callback that will be fired
  when the sound reaches the end. Note that the callback is fired from the audio thread which means
  you cannot be uninitializing sound from the callback. To set the callback you can use
  `ma_sound_set_end_callback()`. Alternatively, if you're using `ma_sound_init_ex()`, you can pass it
  into the config like so:
  
      ```c
      soundConfig.endCallback = my_end_callback;
      soundConfig.pEndCallbackUserData = pMyEndCallbackUserData;
      ```
  
  The end callback is declared like so:
  
      ```c
      void my_end_callback(void* pUserData, ma_sound* pSound)
      
          ...
      
      ```
  
  Internally a sound wraps around a data source. Some APIs exist to control the underlying data
  source, mainly for convenience:
  
      ```c
      ma_sound_seek_to_pcm_frame(&sound, frameIndex);
      ma_sound_get_data_format(&sound, &format, &channels, &sampleRate, pChannelMap, channelMapCapacity);
      ma_sound_get_cursor_in_pcm_frames(&sound, &cursor);
      ma_sound_get_length_in_pcm_frames(&sound, &length);
      ```
  
  Sound groups have the same API as sounds, only they are called `ma_sound_group`, and since they do
  not have any notion of a data source, anything relating to a data source is unavailable.
  
  Internally, sound data is loaded via the `ma_decoder` API which means by default it only supports
  file formats that have built-in support in miniaudio. You can extend this to support any kind of
  file format through the use of custom decoders. To do this you'll need to use a self-managed
  resource manager and configure it appropriately. See the "Resource Management" section below for
  details on how to set this up.
  
  
  6. Resource Management
  ======================
  Many programs will want to manage sound resources for things such as reference counting and
  streaming. This is supported by miniaudio via the `ma_resource_manager` API.
  
  The resource manager is mainly responsible for the following:
  
    * Loading of sound files into memory with reference counting.
    * Streaming of sound data.
  
  When loading a sound file, the resource manager will give you back a `ma_data_source` compatible
  object called `ma_resource_manager_data_source`. This object can be passed into any
  `ma_data_source` API which is how you can read and seek audio data. When loading a sound file, you
  specify whether or not you want the sound to be fully loaded into memory (and optionally
  pre-decoded) or streamed. When loading into memory, you can also specify whether or not you want
  the data to be loaded asynchronously.
  
  The example below is how you can initialize a resource manager using it's default configuration:
  
      ```c
      ma_resource_manager_config config;
      ma_resource_manager resourceManager;
  
      config = ma_resource_manager_config_init();
      result = ma_resource_manager_init(&config, &resourceManager);
      if (result != MA_SUCCESS) 
          ma_device_uninit(&device);
          printf("Failed to initialize the resource manager.");
          return -1;
      
      ```
  
  You can configure the format, channels and sample rate of the decoded audio data. By default it
  will use the file's native data format, but you can configure it to use a consistent format. This
  is useful for offloading the cost of data conversion to load time rather than dynamically
  converting at mixing time. To do this, you configure the decoded format, channels and sample rate
  like the code below:
  
      ```c
      config = ma_resource_manager_config_init();
      config.decodedFormat     = device.playback.format;
      config.decodedChannels   = device.playback.channels;
      config.decodedSampleRate = device.sampleRate;
      ```
  
  In the code above, the resource manager will be configured so that any decoded audio data will be
  pre-converted at load time to the device's native data format. If instead you used defaults and
  the data format of the file did not match the device's data format, you would need to convert the
  data at mixing time which may be prohibitive in high-performance and large scale scenarios like
  games.
  
  Internally the resource manager uses the `ma_decoder` API to load sounds. This means by default it
  only supports decoders that are built into miniaudio. It's possible to support additional encoding
  formats through the use of custom decoders. To do so, pass in your `ma_decoding_backend_vtable`
  vtables into the resource manager config:
  
      ```c
      ma_decoding_backend_vtable* pCustomBackendVTables[] =
      
          &g_ma_decoding_backend_vtable_libvorbis,
          &g_ma_decoding_backend_vtable_libopus
      ;
  
      ...
  
      resourceManagerConfig.ppCustomDecodingBackendVTables = pCustomBackendVTables;
      resourceManagerConfig.customDecodingBackendCount     = sizeof(pCustomBackendVTables) / sizeof(pCustomBackendVTables[0]);
      resourceManagerConfig.pCustomDecodingBackendUserData = NULL;
      ```
  
  This system can allow you to support any kind of file format. See the "Decoding" section for
  details on how to implement custom decoders. The miniaudio repository includes examples for Opus
  via libopus and libopusfile and Vorbis via libvorbis and libvorbisfile.
  
  Asynchronicity is achieved via a job system. When an operation needs to be performed, such as the
  decoding of a page, a job will be posted to a queue which will then be processed by a job thread.
  By default there will be only one job thread running, but this can be configured, like so:
  
      ```c
      config = ma_resource_manager_config_init();
      config.jobThreadCount = MY_JOB_THREAD_COUNT;
      ```
  
  By default job threads are managed internally by the resource manager, however you can also self
  manage your job threads if, for example, you want to integrate the job processing into your
  existing job infrastructure, or if you simply don't like the way the resource manager does it. To
  do this, just set the job thread count to 0 and process jobs manually. To process jobs, you first
  need to retrieve a job using `ma_resource_manager_next_job()` and then process it using
  `ma_job_process()`:
  
      ```c
      config = ma_resource_manager_config_init();
      config.jobThreadCount = 0;                            // Don't manage any job threads internally.
      config.flags = MA_RESOURCE_MANAGER_FLAG_NON_BLOCKING; // Optional. Makes `ma_resource_manager_next_job()` non-blocking.
  
      // ... Initialize your custom job threads ...
  
      void my_custom_job_thread(...)
      
          for (;;) 
              ma_job job;
              ma_result result = ma_resource_manager_next_job(pMyResourceManager, &job);
              if (result != MA_SUCCESS) 
                  if (result == MA_NO_DATA_AVAILABLE) 
                      // No jobs are available. Keep going. Will only get this if the resource manager was initialized
                      // with MA_RESOURCE_MANAGER_FLAG_NON_BLOCKING.
                      continue;
                   else if (result == MA_CANCELLED) 
                      // MA_JOB_TYPE_QUIT was posted. Exit.
                      break;
                   else 
                      // Some other error occurred.
                      break;
                  
              
  
              ma_job_process(&job);
          
      
      ```
  
  In the example above, the `MA_JOB_TYPE_QUIT` event is the used as the termination
  indicator, but you can use whatever you would like to terminate the thread. The call to
  `ma_resource_manager_next_job()` is blocking by default, but can be configured to be non-blocking
  by initializing the resource manager with the `MA_RESOURCE_MANAGER_FLAG_NON_BLOCKING` configuration
  flag. Note that the `MA_JOB_TYPE_QUIT` will never be removed from the job queue. This
  is to give every thread the opportunity to catch the event and terminate naturally.
  
  When loading a file, it's sometimes convenient to be able to customize how files are opened and
  read instead of using standard `fopen()`, `fclose()`, etc. which is what miniaudio will use by
  default. This can be done by setting `pVFS` member of the resource manager's config:
  
      ```c
      // Initialize your custom VFS object. See documentation for VFS for information on how to do this.
      my_custom_vfs vfs = my_custom_vfs_init();
  
      config = ma_resource_manager_config_init();
      config.pVFS = &vfs;
      ```
  
  This is particularly useful in programs like games where you want to read straight from an archive
  rather than the normal file system. If you do not specify a custom VFS, the resource manager will
  use the operating system's normal file operations.
  
  To load a sound file and create a data source, call `ma_resource_manager_data_source_init()`. When
  loading a sound you need to specify the file path and options for how the sounds should be loaded.
  By default a sound will be loaded synchronously. The returned data source is owned by the caller
  which means the caller is responsible for the allocation and freeing of the data source. Below is
  an example for initializing a data source:
  
      ```c
      ma_resource_manager_data_source dataSource;
      ma_result result = ma_resource_manager_data_source_init(pResourceManager, pFilePath, flags, &dataSource);
      if (result != MA_SUCCESS) 
          // Error.
      
  
      // ...
  
      // A ma_resource_manager_data_source object is compatible with the `ma_data_source` API. To read data, just call
      // the `ma_data_source_read_pcm_frames()` like you would with any normal data source.
      result = ma_data_source_read_pcm_frames(&dataSource, pDecodedData, frameCount, &framesRead);
      if (result != MA_SUCCESS) 
          // Failed to read PCM frames.
      
  
      // ...
  
      ma_resource_manager_data_source_uninit(pResourceManager, &dataSource);
      ```
  
  The `flags` parameter specifies how you want to perform loading of the sound file. It can be a
  combination of the following flags:
  
      ```
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_ASYNC
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_WAIT_INIT
      ```
  
  When no flags are specified (set to 0), the sound will be fully loaded into memory, but not
  decoded, meaning the raw file data will be stored in memory, and then dynamically decoded when
  `ma_data_source_read_pcm_frames()` is called. To instead decode the audio data before storing it in
  memory, use the `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE` flag. By default, the sound file will
  be loaded synchronously, meaning `ma_resource_manager_data_source_init()` will only return after
  the entire file has been loaded. This is good for simplicity, but can be prohibitively slow. You
  can instead load the sound asynchronously using the `MA_RESOURCE_MANAGER_DATA_SOURCE_ASYNC` flag.
  This will result in `ma_resource_manager_data_source_init()` returning quickly, but no data will be
  returned by `ma_data_source_read_pcm_frames()` until some data is available. When no data is
  available because the asynchronous decoding hasn't caught up, `MA_BUSY` will be returned by
  `ma_data_source_read_pcm_frames()`.
  
  For large sounds, it's often prohibitive to store the entire file in memory. To mitigate this, you
  can instead stream audio data which you can do by specifying the
  `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM` flag. When streaming, data will be decoded in 1
  second pages. When a new page needs to be decoded, a job will be posted to the job queue and then
  subsequently processed in a job thread.
  
  For in-memory sounds, reference counting is used to ensure the data is loaded only once. This means
  multiple calls to `ma_resource_manager_data_source_init()` with the same file path will result in
  the file data only being loaded once. Each call to `ma_resource_manager_data_source_init()` must be
  matched up with a call to `ma_resource_manager_data_source_uninit()`. Sometimes it can be useful
  for a program to register self-managed raw audio data and associate it with a file path. Use the
  `ma_resource_manager_register_*()` and `ma_resource_manager_unregister_*()` APIs to do this.
  `ma_resource_manager_register_decoded_data()` is used to associate a pointer to raw, self-managed
  decoded audio data in the specified data format with the specified name. Likewise,
  `ma_resource_manager_register_encoded_data()` is used to associate a pointer to raw self-managed
  encoded audio data (the raw file data) with the specified name. Note that these names need not be
  actual file paths. When `ma_resource_manager_data_source_init()` is called (without the
  `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM` flag), the resource manager will look for these
  explicitly registered data buffers and, if found, will use it as the backing data for the data
  source. Note that the resource manager does *not* make a copy of this data so it is up to the
  caller to ensure the pointer stays valid for it's lifetime. Use
  `ma_resource_manager_unregister_data()` to unregister the self-managed data. You can also use
  `ma_resource_manager_register_file()` and `ma_resource_manager_unregister_file()` to register and
  unregister a file. It does not make sense to use the `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM`
  flag with a self-managed data pointer.
  
  
  6.1. Asynchronous Loading and Synchronization
  ---------------------------------------------
  When loading asynchronously, it can be useful to poll whether or not loading has finished. Use
  `ma_resource_manager_data_source_result()` to determine this. For in-memory sounds, this will
  return `MA_SUCCESS` when the file has been *entirely* decoded. If the sound is still being decoded,
  `MA_BUSY` will be returned. Otherwise, some other error code will be returned if the sound failed
  to load. For streaming data sources, `MA_SUCCESS` will be returned when the first page has been
  decoded and the sound is ready to be played. If the first page is still being decoded, `MA_BUSY`
  will be returned. Otherwise, some other error code will be returned if the sound failed to load.
  
  In addition to polling, you can also use a simple synchronization object called a "fence" to wait
  for asynchronously loaded sounds to finish. This is called `ma_fence`. The advantage to using a
  fence is that it can be used to wait for a group of sounds to finish loading rather than waiting
  for sounds on an individual basis. There are two stages to loading a sound:
  
    * Initialization of the internal decoder; and
    * Completion of decoding of the file (the file is fully decoded)
  
  You can specify separate fences for each of the different stages. Waiting for the initialization
  of the internal decoder is important for when you need to know the sample format, channels and
  sample rate of the file.
  
  The example below shows how you could use a fence when loading a number of sounds:
  
      ```c
      // This fence will be released when all sounds are finished loading entirely.
      ma_fence fence;
      ma_fence_init(&fence);
  
      // This will be passed into the initialization routine for each sound.
      ma_resource_manager_pipeline_notifications notifications = ma_resource_manager_pipeline_notifications_init();
      notifications.done.pFence = &fence;
  
      // Now load a bunch of sounds:
      for (iSound = 0; iSound < soundCount; iSound += 1) 
          ma_resource_manager_data_source_init(pResourceManager, pSoundFilePaths[iSound], flags, &notifications, &pSoundSources[iSound]);
      
  
      // ... DO SOMETHING ELSE WHILE SOUNDS ARE LOADING ...
  
      // Wait for loading of sounds to finish.
      ma_fence_wait(&fence);
      ```
  
  In the example above we used a fence for waiting until the entire file has been fully decoded. If
  you only need to wait for the initialization of the internal decoder to complete, you can use the
  `init` member of the `ma_resource_manager_pipeline_notifications` object:
  
      ```c
      notifications.init.pFence = &fence;
      ```
  
  If a fence is not appropriate for your situation, you can instead use a callback that is fired on
  an individual sound basis. This is done in a very similar way to fences:
  
      ```c
      typedef struct
      
          ma_async_notification_callbacks cb;
          void* pMyData;
       my_notification;
  
      void my_notification_callback(ma_async_notification* pNotification)
      
          my_notification* pMyNotification = (my_notification*)pNotification;
  
          // Do something in response to the sound finishing loading.
      
  
      ...
  
      my_notification myCallback;
      myCallback.cb.onSignal = my_notification_callback;
      myCallback.pMyData     = pMyData;
  
      ma_resource_manager_pipeline_notifications notifications = ma_resource_manager_pipeline_notifications_init();
      notifications.done.pNotification = &myCallback;
  
      ma_resource_manager_data_source_init(pResourceManager, "my_sound.wav", flags, &notifications, &mySound);
      ```
  
  In the example above we just extend the `ma_async_notification_callbacks` object and pass an
  instantiation into the `ma_resource_manager_pipeline_notifications` in the same way as we did with
  the fence, only we set `pNotification` instead of `pFence`. You can set both of these at the same
  time and they should both work as expected. If using the `pNotification` system, you need to ensure
  your `ma_async_notification_callbacks` object stays valid.
  
  
  
  6.2. Resource Manager Implementation Details
  --------------------------------------------
  Resources are managed in two main ways:
  
    * By storing the entire sound inside an in-memory buffer (referred to as a data buffer)
    * By streaming audio data on the fly (referred to as a data stream)
  
  A resource managed data source (`ma_resource_manager_data_source`) encapsulates a data buffer or
  data stream, depending on whether or not the data source was initialized with the
  `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM` flag. If so, it will make use of a
  `ma_resource_manager_data_stream` object. Otherwise it will use a `ma_resource_manager_data_buffer`
  object. Both of these objects are data sources which means they can be used with any
  `ma_data_source_*()` API.
  
  Another major feature of the resource manager is the ability to asynchronously decode audio files.
  This relieves the audio thread of time-consuming decoding which can negatively affect scalability
  due to the audio thread needing to complete it's work extremely quickly to avoid glitching.
  Asynchronous decoding is achieved through a job system. There is a central multi-producer,
  multi-consumer, fixed-capacity job queue. When some asynchronous work needs to be done, a job is
  posted to the queue which is then read by a job thread. The number of job threads can be
  configured for improved scalability, and job threads can all run in parallel without needing to
  worry about the order of execution (how this is achieved is explained below).
  
  When a sound is being loaded asynchronously, playback can begin before the sound has been fully
  decoded. This enables the application to start playback of the sound quickly, while at the same
  time allowing to resource manager to keep loading in the background. Since there may be less
  threads than the number of sounds being loaded at a given time, a simple scheduling system is used
  to keep decoding time balanced and fair. The resource manager solves this by splitting decoding
  into chunks called pages. By default, each page is 1 second long. When a page has been decoded, a
  new job will be posted to start decoding the next page. By dividing up decoding into pages, an
  individual sound shouldn't ever delay every other sound from having their first page decoded. Of
  course, when loading many sounds at the same time, there will always be an amount of time required
  to process jobs in the queue so in heavy load situations there will still be some delay. To
  determine if a data source is ready to have some frames read, use
  `ma_resource_manager_data_source_get_available_frames()`. This will return the number of frames
  available starting from the current position.
  
  
  6.2.1. Job Queue
  ----------------
  The resource manager uses a job queue which is multi-producer, multi-consumer, and fixed-capacity.
  This job queue is not currently lock-free, and instead uses a spinlock to achieve thread-safety.
  Only a fixed number of jobs can be allocated and inserted into the queue which is done through a
  lock-free data structure for allocating an index into a fixed sized array, with reference counting
  for mitigation of the ABA problem. The reference count is 32-bit.
  
  For many types of jobs it's important that they execute in a specific order. In these cases, jobs
  are executed serially. For the resource manager, serial execution of jobs is only required on a
  per-object basis (per data buffer or per data stream). Each of these objects stores an execution
  counter. When a job is posted it is associated with an execution counter. When the job is
  processed, it checks if the execution counter of the job equals the execution counter of the
  owning object and if so, processes the job. If the counters are not equal, the job will be posted
  back onto the job queue for later processing. When the job finishes processing the execution order
  of the main object is incremented. This system means the no matter how many job threads are
  executing, decoding of an individual sound will always get processed serially. The advantage to
  having multiple threads comes into play when loading multiple sounds at the same time.
  
  The resource manager's job queue is not 100% lock-free and will use a spinlock to achieve
  thread-safety for a very small section of code. This is only relevant when the resource manager
  uses more than one job thread. If only using a single job thread, which is the default, the
  lock should never actually wait in practice. The amount of time spent locking should be quite
  short, but it's something to be aware of for those who have pedantic lock-free requirements and
  need to use more than one job thread. There are plans to remove this lock in a future version.
  
  In addition, posting a job will release a semaphore, which on Win32 is implemented with
  `ReleaseSemaphore` and on POSIX platforms via a condition variable:
  
      ```c
      pthread_mutex_lock(&pSemaphore->lock);
      
          pSemaphore->value += 1;
          pthread_cond_signal(&pSemaphore->cond);
      
      pthread_mutex_unlock(&pSemaphore->lock);
      ```
  
  Again, this is relevant for those with strict lock-free requirements in the audio thread. To avoid
  this, you can use non-blocking mode (via the `MA_JOB_QUEUE_FLAG_NON_BLOCKING`
  flag) and implement your own job processing routine (see the "Resource Manager" section above for
  details on how to do this).
  
  
  
  6.2.2. Data Buffers
  -------------------
  When the `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM` flag is excluded at initialization time, the
  resource manager will try to load the data into an in-memory data buffer. Before doing so, however,
  it will first check if the specified file is already loaded. If so, it will increment a reference
  counter and just use the already loaded data. This saves both time and memory. When the data buffer
  is uninitialized, the reference counter will be decremented. If the counter hits zero, the file
  will be unloaded. This is a detail to keep in mind because it could result in excessive loading and
  unloading of a sound. For example, the following sequence will result in a file be loaded twice,
  once after the other:
  
      ```c
      ma_resource_manager_data_source_init(pResourceManager, "my_file", ..., &myDataBuffer0); // Refcount = 1. Initial load.
      ma_resource_manager_data_source_uninit(pResourceManager, &myDataBuffer0);               // Refcount = 0. Unloaded.
  
      ma_resource_manager_data_source_init(pResourceManager, "my_file", ..., &myDataBuffer1); // Refcount = 1. Reloaded because previous uninit() unloaded it.
      ma_resource_manager_data_source_uninit(pResourceManager, &myDataBuffer1);               // Refcount = 0. Unloaded.
      ```
  
  A binary search tree (BST) is used for storing data buffers as it has good balance between
  efficiency and simplicity. The key of the BST is a 64-bit hash of the file path that was passed
  into `ma_resource_manager_data_source_init()`. The advantage of using a hash is that it saves
  memory over storing the entire path, has faster comparisons, and results in a mostly balanced BST
  due to the random nature of the hash. The disadvantages are that file names are case-sensitive and
  there's a small chance of name collisions. If case-sensitivity is an issue, you should normalize
  your file names to upper- or lower-case before initializing your data sources. If name collisions
  become an issue, you'll need to change the name of one of the colliding names or just not use the
  resource manager.
  
  When a sound file has not already been loaded and the `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_ASYNC`
  flag is excluded, the file will be decoded synchronously by the calling thread. There are two
  options for controlling how the audio is stored in the data buffer - encoded or decoded. When the
  `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE` option is excluded, the raw file data will be stored
  in memory. Otherwise the sound will be decoded before storing it in memory. Synchronous loading is
  a very simple and standard process of simply adding an item to the BST, allocating a block of
  memory and then decoding (if `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE` is specified).
  
  When the `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_ASYNC` flag is specified, loading of the data buffer
  is done asynchronously. In this case, a job is posted to the queue to start loading and then the
  function immediately returns, setting an internal result code to `MA_BUSY`. This result code is
  returned when the program calls `ma_resource_manager_data_source_result()`. When decoding has fully
  completed `MA_SUCCESS` will be returned. This can be used to know if loading has fully completed.
  
  When loading asynchronously, a single job is posted to the queue of the type
  `MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_BUFFER_NODE`. This involves making a copy of the file path and
  associating it with job. When the job is processed by the job thread, it will first load the file
  using the VFS associated with the resource manager. When using a custom VFS, it's important that it
  be completely thread-safe because it will be used from one or more job threads at the same time.
  Individual files should only ever be accessed by one thread at a time, however. After opening the
  file via the VFS, the job will determine whether or not the file is being decoded. If not, it
  simply allocates a block of memory and loads the raw file contents into it and returns. On the
  other hand, when the file is being decoded, it will first allocate a decoder on the heap and
  initialize it. Then it will check if the length of the file is known. If so it will allocate a
  block of memory to store the decoded output and initialize it to silence. If the size is unknown,
  it will allocate room for one page. After memory has been allocated, the first page will be
  decoded. If the sound is shorter than a page, the result code will be set to `MA_SUCCESS` and the
  completion event will be signalled and loading is now complete. If, however, there is more to
  decode, a job with the code `MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE` is posted. This job
  will decode the next page and perform the same process if it reaches the end. If there is more to
  decode, the job will post another `MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE` job which will
  keep on happening until the sound has been fully decoded. For sounds of an unknown length, each
  page will be linked together as a linked list. Internally this is implemented via the
  `ma_paged_audio_buffer` object.
  
  
  6.2.3. Data Streams
  -------------------
  Data streams only ever store two pages worth of data for each instance. They are most useful for
  large sounds like music tracks in games that would consume too much memory if fully decoded in
  memory. After every frame from a page has been read, a job will be posted to load the next page
  which is done from the VFS.
  
  For data streams, the `MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_ASYNC` flag will determine whether or
  not initialization of the data source waits until the two pages have been decoded. When unset,
  `ma_resource_manager_data_source_init()` will wait until the two pages have been loaded, otherwise
  it will return immediately.
  
  When frames are read from a data stream using `ma_resource_manager_data_source_read_pcm_frames()`,
  `MA_BUSY` will be returned if there are no frames available. If there are some frames available,
  but less than the number requested, `MA_SUCCESS` will be returned, but the actual number of frames
  read will be less than the number requested. Due to the asynchronous nature of data streams,
  seeking is also asynchronous. If the data stream is in the middle of a seek, `MA_BUSY` will be
  returned when trying to read frames.
  
  When `ma_resource_manager_data_source_read_pcm_frames()` results in a page getting fully consumed
  a job is posted to load the next page. This will be posted from the same thread that called
  `ma_resource_manager_data_source_read_pcm_frames()`.
  
  Data streams are uninitialized by posting a job to the queue, but the function won't return until
  that job has been processed. The reason for this is that the caller owns the data stream object and
  therefore miniaudio needs to ensure everything completes before handing back control to the caller.
  Also, if the data stream is uninitialized while pages are in the middle of decoding, they must
  complete before destroying any underlying object and the job system handles this cleanly.
  
  Note that when a new page needs to be loaded, a job will be posted to the resource manager's job
  thread from the audio thread. You must keep in mind the details mentioned in the "Job Queue"
  section above regarding locking when posting an event if you require a strictly lock-free audio
  thread.
  
  
  
  7. Node Graph
  =============
  miniaudio's routing infrastructure follows a node graph paradigm. The idea is that you create a
  node whose outputs are attached to inputs of another node, thereby creating a graph. There are
  different types of nodes, with each node in the graph processing input data to produce output,
  which is then fed through the chain. Each node in the graph can apply their own custom effects. At
  the start of the graph will usually be one or more data source nodes which have no inputs and
  instead pull their data from a data source. At the end of the graph is an endpoint which represents
  the end of the chain and is where the final output is ultimately extracted from.
  
  Each node has a number of input buses and a number of output buses. An output bus from a node is
  attached to an input bus of another. Multiple nodes can connect their output buses to another
  node's input bus, in which case their outputs will be mixed before processing by the node. Below is
  a diagram that illustrates a hypothetical node graph setup:
  
      ```
      >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Data flows left to right >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  
      +---------------+                              +-----------------+
      | Data Source 1 =----+    +----------+    +----= Low Pass Filter =----+
      +---------------+    |    |          =----+    +-----------------+    |    +----------+
                           +----= Splitter |                                +----= ENDPOINT |
      +---------------+    |    |          =----+    +-----------------+    |    +----------+
      | Data Source 2 =----+    +----------+    +----=  Echo / Delay   =----+
      +---------------+                              +-----------------+
      ```
  
  In the above graph, it starts with two data sources whose outputs are attached to the input of a
  splitter node. It's at this point that the two data sources are mixed. After mixing, the splitter
  performs it's processing routine and produces two outputs which is simply a duplication of the
  input stream. One output is attached to a low pass filter, whereas the other output is attached to
  a echo/delay. The outputs of the the low pass filter and the echo are attached to the endpoint, and
  since they're both connected to the same input bus, they'll be mixed.
  
  Each input bus must be configured to accept the same number of channels, but the number of channels
  used by input buses can be different to the number of channels for output buses in which case
  miniaudio will automatically convert the input data to the output channel count before processing.
  The number of channels of an output bus of one node must match the channel count of the input bus
  it's attached to. The channel counts cannot be changed after the node has been initialized. If you
  attempt to attach an output bus to an input bus with a different channel count, attachment will
  fail.
  
  To use a node graph, you first need to initialize a `ma_node_graph` object. This is essentially a
  container around the entire graph. The `ma_node_graph` object is required for some thread-safety
  issues which will be explained later. A `ma_node_graph` object is initialized using miniaudio's
  standard config/init system:
  
      ```c
      ma_node_graph_config nodeGraphConfig = ma_node_graph_config_init(myChannelCount);
  
      result = ma_node_graph_init(&nodeGraphConfig, NULL, &nodeGraph);    // Second parameter is a pointer to allocation callbacks.
      if (result != MA_SUCCESS) 
          // Failed to initialize node graph.
      
      ```
  
  When you initialize the node graph, you're specifying the channel count of the endpoint. The
  endpoint is a special node which has one input bus and one output bus, both of which have the
  same channel count, which is specified in the config. Any nodes that connect directly to the
  endpoint must be configured such that their output buses have the same channel count. When you read
  audio data from the node graph, it'll have the channel count you specified in the config. To read
  data from the graph:
  
      ```c
      ma_uint32 framesRead;
      result = ma_node_graph_read_pcm_frames(&nodeGraph, pFramesOut, frameCount, &framesRead);
      if (result != MA_SUCCESS) 
          // Failed to read data from the node graph.
      
      ```
  
  When you read audio data, miniaudio starts at the node graph's endpoint node which then pulls in
  data from it's input attachments, which in turn recursively pull in data from their inputs, and so
  on. At the start of the graph there will be some kind of data source node which will have zero
  inputs and will instead read directly from a data source. The base nodes don't literally need to
  read from a `ma_data_source` object, but they will always have some kind of underlying object that
  sources some kind of audio. The `ma_data_source_node` node can be used to read from a
  `ma_data_source`. Data is always in floating-point format and in the number of channels you
  specified when the graph was initialized. The sample rate is defined by the underlying data sources.
  It's up to you to ensure they use a consistent and appropriate sample rate.
  
  The `ma_node` API is designed to allow custom nodes to be implemented with relative ease, but
  miniaudio includes a few stock nodes for common functionality. This is how you would initialize a
  node which reads directly from a data source (`ma_data_source_node`) which is an example of one
  of the stock nodes that comes with miniaudio:
  
      ```c
      ma_data_source_node_config config = ma_data_source_node_config_init(pMyDataSource);
  
      ma_data_source_node dataSourceNode;
      result = ma_data_source_node_init(&nodeGraph, &config, NULL, &dataSourceNode);
      if (result != MA_SUCCESS) 
          // Failed to create data source node.
      
      ```
  
  The data source node will use the output channel count to determine the channel count of the output
  bus. There will be 1 output bus and 0 input buses (data will be drawn directly from the data
  source). The data source must output to floating-point (`ma_format_f32`) or else an error will be
  returned from `ma_data_source_node_init()`.
  
  By default the node will not be attached to the graph. To do so, use `ma_node_attach_output_bus()`:
  
      ```c
      result = ma_node_attach_output_bus(&dataSourceNode, 0, ma_node_graph_get_endpoint(&nodeGraph), 0);
      if (result != MA_SUCCESS) 
          // Failed to attach node.
      
      ```
  
  The code above connects the data source node directly to the endpoint. Since the data source node
  has only a single output bus, the index will always be 0. Likewise, the endpoint only has a single
  input bus which means the input bus index will also always be 0.
  
  To detach a specific output bus, use `ma_node_detach_output_bus()`. To detach all output buses, use
  `ma_node_detach_all_output_buses()`. If you want to just move the output bus from one attachment to
  another, you do not need to detach first. You can just call `ma_node_attach_output_bus()` and it'll
  deal with it for you.
  
  Less frequently you may want to create a specialized node. This will be a node where you implement
  your own processing callback to apply a custom effect of some kind. This is similar to initializing
  one of the stock node types, only this time you need to specify a pointer to a vtable containing a
  pointer to the processing function and the number of input and output buses. Example:
  
      ```c
      static void my_custom_node_process_pcm_frames(ma_node* pNode, const float** ppFramesIn, ma_uint32* pFrameCountIn, float** ppFramesOut, ma_uint32* pFrameCountOut)
      
          // Do some processing of ppFramesIn (one stream of audio data per input bus)
          const float* pFramesIn_0 = ppFramesIn[0]; // Input bus @ index 0.
          const float* pFramesIn_1 = ppFramesIn[1]; // Input bus @ index 1.
          float* pFramesOut_0 = ppFramesOut[0];     // Output bus @ index 0.
  
          // Do some processing. On input, `pFrameCountIn` will be the number of input frames in each
          // buffer in `ppFramesIn` and `pFrameCountOut` will be the capacity of each of the buffers
          // in `ppFramesOut`. On output, `pFrameCountIn` should be set to the number of input frames
          // your node consumed and `pFrameCountOut` should be set the number of output frames that
          // were produced.
          //
          // You should process as many frames as you can. If your effect consumes input frames at the
          // same rate as output frames (always the case, unless you're doing resampling), you need
          // only look at `ppFramesOut` and process that exact number of frames. If you're doing
          // resampling, you'll need to be sure to set both `pFrameCountIn` and `pFrameCountOut`
          // properly.
      
  
      static ma_node_vtable my_custom_node_vtable =
      
          my_custom_node_process_pcm_frames, // The function that will be called to process your custom node. This is where you'd implement your effect processing.
          NULL,   // Optional. A callback for calculating the number of input frames that are required to process a specified number of output frames.
          2,      // 2 input buses.
          1,      // 1 output bus.
          0       // Default flags.
      ;
  
      ...
  
      // Each bus needs to have a channel count specified. To do this you need to specify the channel
      // counts in an array and then pass that into the node config.
      ma_uint32 inputChannels[2];     // Equal in size to the number of input channels specified in the vtable.
      ma_uint32 outputChannels[1];    // Equal in size to the number of output channels specified in the vtable.
  
      inputChannels[0]  = channelsIn;
      inputChannels[1]  = channelsIn;
      outputChannels[0] = channelsOut;
  
      ma_node_config nodeConfig = ma_node_config_init();
      nodeConfig.vtable          = &my_custom_node_vtable;
      nodeConfig.pInputChannels  = inputChannels;
      nodeConfig.pOutputChannels = outputChannels;
  
      ma_node_base node;
      result = ma_node_init(&nodeGraph, &nodeConfig, NULL, &node);
      if (result != MA_SUCCESS) 
          // Failed to initialize node.
      
      ```
  
  When initializing a custom node, as in the code above, you'll normally just place your vtable in
  //static space. The number of input and output buses are specified as part of the vtable. If you need
  a variable number of buses on a per-node bases, the vtable should have the relevant bus count set
  to `MA_NODE_BUS_COUNT_UNKNOWN`. In this case, the bus count should be set in the node config:
  
      ```c
      static ma_node_vtable my_custom_node_vtable =
      
          my_custom_node_process_pcm_frames, // The function that will be called process your custom node. This is where you'd implement your effect processing.
          NULL,   // Optional. A callback for calculating the number of input frames that are required to process a specified number of output frames.
          MA_NODE_BUS_COUNT_UNKNOWN,  // The number of input buses is determined on a per-node basis.
          1,      // 1 output bus.
          0       // Default flags.
      ;
  
      ...
  
      ma_node_config nodeConfig = ma_node_config_init();
      nodeConfig.vtable          = &my_custom_node_vtable;
      nodeConfig.inputBusCount   = myBusCount;        // <-- Since the vtable specifies MA_NODE_BUS_COUNT_UNKNOWN, the input bus count should be set here.
      nodeConfig.pInputChannels  = inputChannels;     // <-- Make sure there are nodeConfig.inputBusCount elements in this array.
      nodeConfig.pOutputChannels = outputChannels;    // <-- The vtable specifies 1 output bus, so there must be 1 element in this array.
      ```
  
  In the above example it's important to never set the `inputBusCount` and `outputBusCount` members
  to anything other than their defaults if the vtable specifies an explicit count. They can only be
  set if the vtable specifies MA_NODE_BUS_COUNT_UNKNOWN in the relevant bus count.
  
  Most often you'll want to create a structure to encapsulate your node with some extra data. You
  need to make sure the `ma_node_base` object is your first member of the structure:
  
      ```c
      typedef struct
      
          ma_node_base base; // <-- Make sure this is always the first member.
          float someCustomData;
       my_custom_node;
      ```
  
  By doing this, your object will be compatible with all `ma_node` APIs and you can attach it to the
  graph just like any other node.
  
  In the custom processing callback (`my_custom_node_process_pcm_frames()` in the example above), the
  number of channels for each bus is what was specified by the config when the node was initialized
  with `ma_node_init()`. In addition, all attachments to each of the input buses will have been
  pre-mixed by miniaudio. The config allows you to specify different channel counts for each
  individual input and output bus. It's up to the effect to handle it appropriate, and if it can't,
  return an error in it's initialization routine.
  
  Custom nodes can be assigned some flags to describe their behaviour. These are set via the vtable
  and include the following:
  
      +-----------------------------------------+---------------------------------------------------+
      | Flag Name                               | Description                                       |
      +-----------------------------------------+---------------------------------------------------+
      | MA_NODE_FLAG_PASSTHROUGH                | Useful for nodes that do not do any kind of audio |
      |                                         | processing, but are instead used for tracking     |
      |                                         | time, handling events, etc. Also used by the      |
      |                                         | internal endpoint node. It reads directly from    |
      |                                         | the input bus to the output bus. Nodes with this  |
      |                                         | flag must have exactly 1 input bus and 1 output   |
      |                                         | bus, and both buses must have the same channel    |
      |                                         | counts.                                           |
      +-----------------------------------------+---------------------------------------------------+
      | MA_NODE_FLAG_CONTINUOUS_PROCESSING      | Causes the processing callback to be called even  |
      |                                         | when no data is available to be read from input   |
      |                                         | attachments. When a node has at least one input   |
      |                                         | bus, but there are no inputs attached or the      |
      |                                         | inputs do not deliver any data, the node's        |
      |                                         | processing callback will not get fired. This flag |
      |                                         | will make it so the callback is always fired      |
      |                                         | regardless of whether or not any input data is    |
      |                                         | received. This is useful for effects like         |
      |                                         | echos where there will be a tail of audio data    |
      |                                         | that still needs to be processed even when the    |
      |                                         | original data sources have reached their ends. It |
      |                                         | may also be useful for nodes that must always     |
      |                                         | have their processing callback fired when there   |
      |                                         | are no inputs attached.                           |
      +-----------------------------------------+---------------------------------------------------+
      | MA_NODE_FLAG_ALLOW_NULL_INPUT           | Used in conjunction with                          |
      |                                         | `MA_NODE_FLAG_CONTINUOUS_PROCESSING`. When this   |
      |                                         | is set, the `ppFramesIn` parameter of the         |
      |                                         | processing callback will be set to NULL when      |
      |                                         | there are no input frames are available. When     |
      |                                         | this is unset, silence will be posted to the      |
      |                                         | processing callback.                              |
      +-----------------------------------------+---------------------------------------------------+
      | MA_NODE_FLAG_DIFFERENT_PROCESSING_RATES | Used to tell miniaudio that input and output      |
      |                                         | frames are processed at different rates. You      |
      |                                         | should set this for any nodes that perform        |
      |                                         | resampling.                                       |
      +-----------------------------------------+---------------------------------------------------+
      | MA_NODE_FLAG_SILENT_OUTPUT              | Used to tell miniaudio that a node produces only  |
      |                                         | silent output. This is useful for nodes where you |
      |                                         | don't want the output to contribute to the final  |
      |                                         | mix. An example might be if you want split your   |
      |                                         | stream and have one branch be output to a file.   |
      |                                         | When using this flag, you should avoid writing to |
      |                                         | the output buffer of the node's processing        |
      |                                         | callback because miniaudio will ignore it anyway. |
      +-----------------------------------------+---------------------------------------------------+
  
  
  If you need to make a copy of an audio stream for effect processing you can use a splitter node
  called `ma_splitter_node`. This takes has 1 input bus and splits the stream into 2 output buses.
  You can use it like this:
  
      ```c
      ma_splitter_node_config splitterNodeConfig = ma_splitter_node_config_init(channels);
  
      ma_splitter_node splitterNode;
      result = ma_splitter_node_init(&nodeGraph, &splitterNodeConfig, NULL, &splitterNode);
      if (result != MA_SUCCESS) 
          // Failed to create node.
      
  
      // Attach your output buses to two different input buses (can be on two different nodes).
      ma_node_attach_output_bus(&splitterNode, 0, ma_node_graph_get_endpoint(&nodeGraph), 0); // Attach directly to the endpoint.
      ma_node_attach_output_bus(&splitterNode, 1, &myEffectNode,                          0); // Attach to input bus 0 of some effect node.
      ```
  
  The volume of an output bus can be configured on a per-bus basis:
  
      ```c
      ma_node_set_output_bus_volume(&splitterNode, 0, 0.5f);
      ma_node_set_output_bus_volume(&splitterNode, 1, 0.5f);
      ```
  
  In the code above we're using the splitter node from before and changing the volume of each of the
  copied streams.
  
  You can start and stop a node with the following:
  
      ```c
      ma_node_set_state(&splitterNode, ma_node_state_started);    // The default state.
      ma_node_set_state(&splitterNode, ma_node_state_stopped);
      ```
  
  By default the node is in a started state, but since it won't be connected to anything won't
  actually be invoked by the node graph until it's connected. When you stop a node, data will not be
  read from any of it's input connections. You can use this property to stop a group of sounds
  atomically.
  
  You can configure the initial state of a node in it's config:
  
      ```c
      nodeConfig.initialState = ma_node_state_stopped;
      ```
  
  Note that for the stock specialized nodes, all of their configs will have a `nodeConfig` member
  which is the config to use with the base node. This is where the initial state can be configured
  for specialized nodes:
  
      ```c
      dataSourceNodeConfig.nodeConfig.initialState = ma_node_state_stopped;
      ```
  
  When using a specialized node like `ma_data_source_node` or `ma_splitter_node`, be sure to not
  modify the `vtable` member of the `nodeConfig` object.
  
  
  7.1. Timing
  -----------
  The node graph supports starting and stopping nodes at scheduled times. This is especially useful
  for data source nodes where you want to get the node set up, but only start playback at a specific
  time. There are two clocks: local and global.
  
  A local clock is per-node, whereas the global clock is per graph. Scheduling starts and stops can
  only be done based on the global clock because the local clock will not be running while the node
  is stopped. The global clocks advances whenever `ma_node_graph_read_pcm_frames()` is called. On the
  other hand, the local clock only advances when the node's processing callback is fired, and is
  advanced based on the output frame count.
  
  To retrieve the global time, use `ma_node_graph_get_time()`. The global time can be set with
  `ma_node_graph_set_time()` which might be useful if you want to do seeking on a global timeline.
  Getting and setting the local time is similar. Use `ma_node_get_time()` to retrieve the local time,
  and `ma_node_set_time()` to set the local time. The global and local times will be advanced by the
  audio thread, so care should be taken to avoid data races. Ideally you should avoid calling these
  outside of the node processing callbacks which are always run on the audio thread.
  
  There is basic support for scheduling the starting and stopping of nodes. You can only schedule one
  start and one stop at a time. This is mainly intended for putting nodes into a started or stopped
  state in a frame-exact manner. Without this mechanism, starting and stopping of a node is limited
  to the resolution of a call to `ma_node_graph_read_pcm_frames()` which would typically be in blocks
  of several milliseconds. The following APIs can be used for scheduling node states:
  
      ```c
      ma_node_set_state_time()
      ma_node_get_state_time()
      ```
  
  The time is absolute and must be based on the global clock. An example is below:
  
      ```c
      ma_node_set_state_time(&myNode, ma_node_state_started, sampleRate*1);   // Delay starting to 1 second.
      ma_node_set_state_time(&myNode, ma_node_state_stopped, sampleRate*5);   // Delay stopping to 5 seconds.
      ```
  
  An example for changing the state using a relative time.
  
      ```c
      ma_node_set_state_time(&myNode, ma_node_state_started, sampleRate*1 + ma_node_graph_get_time(&myNodeGraph));
      ma_node_set_state_time(&myNode, ma_node_state_stopped, sampleRate*5 + ma_node_graph_get_time(&myNodeGraph));
      ```
  
  Note that due to the nature of multi-threading the times may not be 100% exact. If this is an
  issue, consider scheduling state changes from within a processing callback. An idea might be to
  have some kind of passthrough trigger node that is used specifically for tracking time and handling
  events.
  
  
  
  7.2. Thread Safety and Locking
  ------------------------------
  When processing audio, it's ideal not to have any kind of locking in the audio thread. Since it's
  expected that `ma_node_graph_read_pcm_frames()` would be run on the audio thread, it does so
  without the use of any locks. This section discusses the implementation used by miniaudio and goes
  over some of the compromises employed by miniaudio to achieve this goal. Note that the current
  implementation may not be ideal - feedback and critiques are most welcome.
  
  The node graph API is not *entirely* lock-free. Only `ma_node_graph_read_pcm_frames()` is expected
  to be lock-free. Attachment, detachment and uninitialization of nodes use locks to simplify the
  implementation, but are crafted in a way such that such locking is not required when reading audio
  data from the graph. Locking in these areas are achieved by means of spinlocks.
  
  The main complication with keeping `ma_node_graph_read_pcm_frames()` lock-free stems from the fact
  that a node can be uninitialized, and it's memory potentially freed, while in the middle of being
  processed on the audio thread. There are times when the audio thread will be referencing a node,
  which means the uninitialization process of a node needs to make sure it delays returning until the
  audio thread is finished so that control is not handed back to the caller thereby giving them a
  chance to free the node's memory.
  
  When the audio thread is processing a node, it does so by reading from each of the output buses of
  the node. In order for a node to process data for one of it's output buses, it needs to read from
  each of it's input buses, and so on an so forth. It follows that once all output buses of a node
  are detached, the node as a whole will be disconnected and no further processing will occur unless
  it's output buses are reattached, which won't be happening when the node is being uninitialized.
  By having `ma_node_detach_output_bus()` wait until the audio thread is finished with it, we can
  simplify a few things, at the expense of making `ma_node_detach_output_bus()` a bit slower. By
  doing this, the implementation of `ma_node_uninit()` becomes trivial - just detach all output
  nodes, followed by each of the attachments to each of it's input nodes, and then do any final clean
  up.
  
  With the above design, the worst-case scenario is `ma_node_detach_output_bus()` taking as long as
  it takes to process the output bus being detached. This will happen if it's called at just the
  wrong moment where the audio thread has just iterated it and has just started processing. The
  caller of `ma_node_detach_output_bus()` will stall until the audio thread is finished, which
  includes the cost of recursively processing it's inputs. This is the biggest compromise made with
  the approach taken by miniaudio for it's lock-free processing system. The cost of detaching nodes
  earlier in the pipeline (data sources, for example) will be cheaper than the cost of detaching
  higher level nodes, such as some kind of final post-processing endpoint. If you need to do mass
  detachments, detach starting from the lowest level nodes and work your way towards the final
  endpoint node (but don't try detaching the node graph's endpoint). If the audio thread is not
  running, detachment will be fast and detachment in any order will be the same. The reason nodes
  need to wait for their input attachments to complete is due to the potential for desyncs between
  data sources. If the node was to terminate processing mid way through processing it's inputs,
  there's a chance that some of the underlying data sources will have been read, but then others not.
  That will then result in a potential desynchronization when detaching and reattaching higher-level
  nodes. A possible solution to this is to have an option when detaching to terminate processing
  before processing all input attachments which should be fairly simple.
  
  Another compromise, albeit less significant, is locking when attaching and detaching nodes. This
  locking is achieved by means of a spinlock in order to reduce memory overhead. A lock is present
  for each input bus and output bus. When an output bus is connected to an input bus, both the output
  bus and input bus is locked. This locking is specifically for attaching and detaching across
  different threads and does not affect `ma_node_graph_read_pcm_frames()` in any way. The locking and
  unlocking is mostly self-explanatory, but a slightly less intuitive aspect comes into it when
  considering that iterating over attachments must not break as a result of attaching or detaching a
  node while iteration is occurring.
  
  Attaching and detaching are both quite simple. When an output bus of a node is attached to an input
  bus of another node, it's added to a linked list. Basically, an input bus is a linked list, where
  each item in the list is and output bus. We have some intentional (and convenient) restrictions on
  what can done with the linked list in order to simplify the implementation. First of all, whenever
  something needs to iterate over the list, it must do so in a forward direction. Backwards iteration
  is not supported. Also, items can only be added to the start of the list.
  
  The linked list is a doubly-linked list where each item in the list (an output bus) holds a pointer
  to the next item in the list, and another to the previous item. A pointer to the previous item is
  only required for fast detachment of the node - it is never used in iteration. This is an
  important property because it means from the perspective of iteration, attaching and detaching of
  an item can be done with a single atomic assignment. This is exploited by both the attachment and
  detachment process. When attaching the node, the first thing that is done is the setting of the
  local "next" and "previous" pointers of the node. After that, the item is "attached" to the list
  by simply performing an atomic exchange with the head pointer. After that, the node is "attached"
  to the list from the perspective of iteration. Even though the "previous" pointer of the next item
  hasn't yet been set, from the perspective of iteration it's been attached because iteration will
  only be happening in a forward direction which means the "previous" pointer won't actually ever get
  used. The same general process applies to detachment. See `ma_node_attach_output_bus()` and
  `ma_node_detach_output_bus()` for the implementation of this mechanism.
  
  
  
  8. Decoding
  ===========
  The `ma_decoder` API is used for reading audio files. Decoders are completely decoupled from
  devices and can be used independently. Built-in support is included for the following formats:
  
      +---------+
      | Format  |
      +---------+
      | WAV     |
      | MP3     |
      | FLAC    |
      +---------+
  
  You can disable the built-in decoders by specifying one or more of the following options before the
  miniaudio implementation:
  
      ```c
      #define MA_NO_WAV
      #define MA_NO_MP3
      #define MA_NO_FLAC
      ```
  
  miniaudio supports the ability to plug in custom decoders. See the section below for details on how
  to use custom decoders.
  
  A decoder can be initialized from a file with `ma_decoder_init_file()`, a block of memory with
  `ma_decoder_init_memory()`, or from data delivered via callbacks with `ma_decoder_init()`. Here is
  an example for loading a decoder from a file:
  
      ```c
      ma_decoder decoder;
      ma_result result = ma_decoder_init_file("MySong.mp3", NULL, &decoder);
      if (result != MA_SUCCESS) 
          return false;   // An error occurred.
      
  
      ...
  
      ma_decoder_uninit(&decoder);
      ```
  
  When initializing a decoder, you can optionally pass in a pointer to a `ma_decoder_config` object
  (the `NULL` argument in the example above) which allows you to configure the output format, channel
  count, sample rate and channel map:
  
      ```c
      ma_decoder_config config = ma_decoder_config_init(ma_format_f32, 2, 48000);
      ```
  
  When passing in `NULL` for decoder config in `ma_decoder_init*()`, the output format will be the
  same as that defined by the decoding backend.
  
  Data is read from the decoder as PCM frames. This will output the number of PCM frames actually
  read. If this is less than the requested number of PCM frames it means you've reached the end. The
  return value will be `MA_AT_END` if no samples have been read and the end has been reached.
  
      ```c
      ma_result result = ma_decoder_read_pcm_frames(pDecoder, pFrames, framesToRead, &framesRead);
      if (framesRead < framesToRead) 
          // Reached the end.
      
      ```
  
  You can also seek to a specific frame like so:
  
      ```c
      ma_result result = ma_decoder_seek_to_pcm_frame(pDecoder, targetFrame);
      if (result != MA_SUCCESS) 
          return false;   // An error occurred.
      
      ```
  
  If you want to loop back to the start, you can simply seek back to the first PCM frame:
  
      ```c
      ma_decoder_seek_to_pcm_frame(pDecoder, 0);
      ```
  
  When loading a decoder, miniaudio uses a trial and error technique to find the appropriate decoding
  backend. This can be unnecessarily inefficient if the type is already known. In this case you can
  use `encodingFormat` variable in the device config to specify a specific encoding format you want
  to decode:
  
      ```c
      decoderConfig.encodingFormat = ma_encoding_format_wav;
      ```
  
  See the `ma_encoding_format` enum for possible encoding formats.
  
  The `ma_decoder_init_file()` API will try using the file extension to determine which decoding
  backend to prefer.
  
  
  8.1. Custom Decoders
  --------------------
  It's possible to implement a custom decoder and plug it into miniaudio. This is extremely useful
  when you want to use the `ma_decoder` API, but need to support an encoding format that's not one of
  the stock formats supported by miniaudio. This can be put to particularly good use when using the
  `ma_engine` and/or `ma_resource_manager` APIs because they use `ma_decoder` internally. If, for
  example, you wanted to support Opus, you can do so with a custom decoder (there if a reference
  Opus decoder in the "extras" folder of the miniaudio repository which uses libopus + libopusfile).
  
  A custom decoder must implement a data source. A vtable called `ma_decoding_backend_vtable` needs
  to be implemented which is then passed into the decoder config:
  
      ```c
      ma_decoding_backend_vtable* pCustomBackendVTables[] =
      
          &g_ma_decoding_backend_vtable_libvorbis,
          &g_ma_decoding_backend_vtable_libopus
      ;
  
      ...
  
      decoderConfig = ma_decoder_config_init_default();
      decoderConfig.pCustomBackendUserData = NULL;
      decoderConfig.ppCustomBackendVTables = pCustomBackendVTables;
      decoderConfig.customBackendCount     = sizeof(pCustomBackendVTables) / sizeof(pCustomBackendVTables[0]);
      ```
  
  The `ma_decoding_backend_vtable` vtable has the following functions:
  
      ```
      onInit
      onInitFile
      onInitFileW
      onInitMemory
      onUninit
      ```
  
  There are only two functions that must be implemented - `onInit` and `onUninit`. The other
  functions can be implemented for a small optimization for loading from a file path or memory. If
  these are not specified, miniaudio will deal with it for you via a generic implementation.
  
  When you initialize a custom data source (by implementing the `onInit` function in the vtable) you
  will need to output a pointer to a `ma_data_source` which implements your custom decoder. See the
  section about data sources for details on how to implement this. Alternatively, see the
  "custom_decoders" example in the miniaudio repository.
  
  The `onInit` function takes a pointer to some callbacks for the purpose of reading raw audio data
  from some arbitrary source. You'll use these functions to read from the raw data and perform the
  decoding. When you call them, you will pass in the `pReadSeekTellUserData` pointer to the relevant
  parameter.
  
  The `pConfig` parameter in `onInit` can be used to configure the backend if appropriate. It's only
  used as a hint and can be ignored. However, if any of the properties are relevant to your decoder,
  an optimal implementation will handle the relevant properties appropriately.
  
  If memory allocation is required, it should be done so via the specified allocation callbacks if
  possible (the `pAllocationCallbacks` parameter).
  
  If an error occurs when initializing the decoder, you should leave `ppBackend` unset, or set to
  NULL, and make sure everything is cleaned up appropriately and an appropriate result code returned.
  When multiple custom backends are specified, miniaudio will cycle through the vtables in the order
  they're listed in the array that's passed into the decoder config so it's important that your
  initialization routine is clean.
  
  When a decoder is uninitialized, the `onUninit` callback will be fired which will give you an
  opportunity to clean up and internal data.
  
  
  
  9. Encoding
  ===========
  The `ma_encoding` API is used for writing audio files. The only supported output format is WAV.
  This can be disabled by specifying the following option before the implementation of miniaudio:
  
      ```c
      #define MA_NO_WAV
      ```
  
  An encoder can be initialized to write to a file with `ma_encoder_init_file()` or from data
  delivered via callbacks with `ma_encoder_init()`. Below is an example for initializing an encoder
  to output to a file.
  
      ```c
      ma_encoder_config config = ma_encoder_config_init(ma_encoding_format_wav, FORMAT, CHANNELS, SAMPLE_RATE);
      ma_encoder encoder;
      ma_result result = ma_encoder_init_file("my_file.wav", &config, &encoder);
      if (result != MA_SUCCESS) 
          // Error
      
  
      ...
  
      ma_encoder_uninit(&encoder);
      ```
  
  When initializing an encoder you must specify a config which is initialized with
  `ma_encoder_config_init()`. Here you must specify the file type, the output sample format, output
  channel count and output sample rate. The following file types are supported:
  
      +------------------------+-------------+
      | Enum                   | Description |
      +------------------------+-------------+
      | ma_encoding_format_wav | WAV         |
      +------------------------+-------------+
  
  If the format, channel count or sample rate is not supported by the output file type an error will
  be returned. The encoder will not perform data conversion so you will need to convert it before
  outputting any audio data. To output audio data, use `ma_encoder_write_pcm_frames()`, like in the
  example below:
  
      ```c
      framesWritten = ma_encoder_write_pcm_frames(&encoder, pPCMFramesToWrite, framesToWrite);
      ```
  
  Encoders must be uninitialized with `ma_encoder_uninit()`.
  
  
  
  10. Data Conversion
  ===================
  A data conversion API is included with miniaudio which supports the majority of data conversion
  requirements. This supports conversion between sample formats, channel counts (with channel
  mapping) and sample rates.
  
  
  10.1. Sample Format Conversion
  ------------------------------
  Conversion between sample formats is achieved with the `ma_pcm_*_to_*()`, `ma_pcm_convert()` and
  `ma_convert_pcm_frames_format()` APIs. Use `ma_pcm_*_to_*()` to convert between two specific
  formats. Use `ma_pcm_convert()` to convert based on a `ma_format` variable. Use
  `ma_convert_pcm_frames_format()` to convert PCM frames where you want to specify the frame count
  and channel count as a variable instead of the total sample count.
  
  
  10.1.1. Dithering
  -----------------
  Dithering can be set using the ditherMode parameter.
  
  The different dithering modes include the following, in order of efficiency:
  
      +-----------+--------------------------+
      | Type      | Enum Token               |
      +-----------+--------------------------+
      | None      | ma_dither_mode_none      |
      | Rectangle | ma_dither_mode_rectangle |
      | Triangle  | ma_dither_mode_triangle  |
      +-----------+--------------------------+
  
  Note that even if the dither mode is set to something other than `ma_dither_mode_none`, it will be
  ignored for conversions where dithering is not needed. Dithering is available for the following
  conversions:
  
      ```
      s16 -> u8
      s24 -> u8
      s32 -> u8
      f32 -> u8
      s24 -> s16
      s32 -> s16
      f32 -> s16
      ```
  
  Note that it is not an error to pass something other than ma_dither_mode_none for conversions where
  dither is not used. It will just be ignored.
  
  
  
  10.2. Channel Conversion
  ------------------------
  Channel conversion is used for channel rearrangement and conversion from one channel count to
  another. The `ma_channel_converter` API is used for channel conversion. Below is an example of
  initializing a simple channel converter which converts from mono to stereo.
  
      ```c
      ma_channel_converter_config config = ma_channel_converter_config_init(
          ma_format,                      // Sample format
          1,                              // Input channels
          NULL,                           // Input channel map
          2,                              // Output channels
          NULL,                           // Output channel map
          ma_channel_mix_mode_default);   // The mixing algorithm to use when combining channels.
  
      result = ma_channel_converter_init(&config, NULL, &converter);
      if (result != MA_SUCCESS) 
          // Error.
      
      ```
  
  To perform the conversion simply call `ma_channel_converter_process_pcm_frames()` like so:
  
      ```c
      ma_result result = ma_channel_converter_process_pcm_frames(&converter, pFramesOut, pFramesIn, frameCount);
      if (result != MA_SUCCESS) 
          // Error.
      
      ```
  
  It is up to the caller to ensure the output buffer is large enough to accommodate the new PCM
  frames.
  
  Input and output PCM frames are always interleaved. Deinterleaved layouts are not supported.
  
  
  10.2.1. Channel Mapping
  -----------------------
  In addition to converting from one channel count to another, like the example above, the channel
  converter can also be used to rearrange channels. When initializing the channel converter, you can
  optionally pass in channel maps for both the input and output frames. If the channel counts are the
  same, and each channel map contains the same channel positions with the exception that they're in
  a different order, a simple shuffling of the channels will be performed. If, however, there is not
  a 1:1 mapping of channel positions, or the channel counts differ, the input channels will be mixed
  based on a mixing mode which is specified when initializing the `ma_channel_converter_config`
  object.
  
  When converting from mono to multi-channel, the mono channel is simply copied to each output
  channel. When going the other way around, the audio of each output channel is simply averaged and
  copied to the mono channel.
  
  In more complicated cases blending is used. The `ma_channel_mix_mode_simple` mode will drop excess
  channels and silence extra channels. For example, converting from 4 to 2 channels, the 3rd and 4th
  channels will be dropped, whereas converting from 2 to 4 channels will put silence into the 3rd and
  4th channels.
  
  The `ma_channel_mix_mode_rectangle` mode uses spacial locality based on a rectangle to compute a
  simple distribution between input and output. Imagine sitting in the middle of a room, with
  speakers on the walls representing channel positions. The `MA_CHANNEL_FRONT_LEFT` position can be
  thought of as being in the corner of the front and left walls.
  
  Finally, the `ma_channel_mix_mode_custom_weights` mode can be used to use custom user-defined
  weights. Custom weights can be passed in as the last parameter of
  `ma_channel_converter_config_init()`.
  
  Predefined channel maps can be retrieved with `ma_channel_map_init_standard()`. This takes a
  `ma_standard_channel_map` enum as it's first parameter, which can be one of the following:
  
      +-----------------------------------+-----------------------------------------------------------+
      | Name                              | Description                                               |
      +-----------------------------------+-----------------------------------------------------------+
      | ma_standard_channel_map_default   | Default channel map used by miniaudio. See below.         |
      | ma_standard_channel_map_microsoft | Channel map used by Microsoft's bitfield channel maps.    |
      | ma_standard_channel_map_alsa      | Default ALSA channel map.                                 |
      | ma_standard_channel_map_rfc3551   | RFC 3551. Based on AIFF.                                  |
      | ma_standard_channel_map_flac      | FLAC channel map.                                         |
      | ma_standard_channel_map_vorbis    | Vorbis channel map.                                       |
      | ma_standard_channel_map_sound4    | FreeBSD's sound(4).                                       |
      | ma_standard_channel_map_sndio     | sndio channel map. http://www.sndio.org/tips.html.        |
      | ma_standard_channel_map_webaudio  | https://webaudio.github.io/web-audio-api/#ChannelOrdering |
      +-----------------------------------+-----------------------------------------------------------+
  
  Below are the channel maps used by default in miniaudio (`ma_standard_channel_map_default`):
  
      +---------------+---------------------------------+
      | Channel Count | Mapping                         |
      +---------------+---------------------------------+
      | 1 (Mono)      | 0: MA_CHANNEL_MONO              |
      +---------------+---------------------------------+
      | 2 (Stereo)    | 0: MA_CHANNEL_FRONT_LEFT   <br> |
      |               | 1: MA_CHANNEL_FRONT_RIGHT       |
      +---------------+---------------------------------+
      | 3             | 0: MA_CHANNEL_FRONT_LEFT   <br> |
      |               | 1: MA_CHANNEL_FRONT_RIGHT  <br> |
      |               | 2: MA_CHANNEL_FRONT_CENTER      |
      +---------------+---------------------------------+
      | 4 (Surround)  | 0: MA_CHANNEL_FRONT_LEFT   <br> |
      |               | 1: MA_CHANNEL_FRONT_RIGHT  <br> |
      |               | 2: MA_CHANNEL_FRONT_CENTER <br> |
      |               | 3: MA_CHANNEL_BACK_CENTER       |
      +---------------+---------------------------------+
      | 5             | 0: MA_CHANNEL_FRONT_LEFT   <br> |
      |               | 1: MA_CHANNEL_FRONT_RIGHT  <br> |
      |               | 2: MA_CHANNEL_FRONT_CENTER <br> |
      |               | 3: MA_CHANNEL_BACK_LEFT    <br> |
      |               | 4: MA_CHANNEL_BACK_RIGHT        |
      +---------------+---------------------------------+
      | 6 (5.1)       | 0: MA_CHANNEL_FRONT_LEFT   <br> |
      |               | 1: MA_CHANNEL_FRONT_RIGHT  <br> |
      |               | 2: MA_CHANNEL_FRONT_CENTER <br> |
      |               | 3: MA_CHANNEL_LFE          <br> |
      |               | 4: MA_CHANNEL_SIDE_LEFT    <br> |
      |               | 5: MA_CHANNEL_SIDE_RIGHT        |
      +---------------+---------------------------------+
      | 7             | 0: MA_CHANNEL_FRONT_LEFT   <br> |
      |               | 1: MA_CHANNEL_FRONT_RIGHT  <br> |
      |               | 2: MA_CHANNEL_FRONT_CENTER <br> |
      |               | 3: MA_CHANNEL_LFE          <br> |
      |               | 4: MA_CHANNEL_BACK_CENTER  <br> |
      |               | 4: MA_CHANNEL_SIDE_LEFT    <br> |
      |               | 5: MA_CHANNEL_SIDE_RIGHT        |
      +---------------+---------------------------------+
      | 8 (7.1)       | 0: MA_CHANNEL_FRONT_LEFT   <br> |
      |               | 1: MA_CHANNEL_FRONT_RIGHT  <br> |
      |               | 2: MA_CHANNEL_FRONT_CENTER <br> |
      |               | 3: MA_CHANNEL_LFE          <br> |
      |               | 4: MA_CHANNEL_BACK_LEFT    <br> |
      |               | 5: MA_CHANNEL_BACK_RIGHT   <br> |
      |               | 6: MA_CHANNEL_SIDE_LEFT    <br> |
      |               | 7: MA_CHANNEL_SIDE_RIGHT        |
      +---------------+---------------------------------+
      | Other         | All channels set to 0. This     |
      |               | is equivalent to the same       |
      |               | mapping as the device.          |
      +---------------+---------------------------------+
  
  
  
  10.3. Resampling
  ----------------
  Resampling is achieved with the `ma_resampler` object. To create a resampler object, do something
  like the following:
  
      ```c
      ma_resampler_config config = ma_resampler_config_init(
          ma_format_s16,
          channels,
          sampleRateIn,
          sampleRateOut,
          ma_resample_algorithm_linear);
  
      ma_resampler resampler;
      ma_result result = ma_resampler_init(&config, &resampler);
      if (result != MA_SUCCESS) 
          // An error occurred...
      
      ```
  
  Do the following to uninitialize the resampler:
  
      ```c
      ma_resampler_uninit(&resampler);
      ```
  
  The following example shows how data can be processed
  
      ```c
      ma_uint64 frameCountIn  = 1000;
      ma_uint64 frameCountOut = 2000;
      ma_result result = ma_resampler_process_pcm_frames(&resampler, pFramesIn, &frameCountIn, pFramesOut, &frameCountOut);
      if (result != MA_SUCCESS) 
          // An error occurred...
      
  
      // At this point, frameCountIn contains the number of input frames that were consumed and frameCountOut contains the
      // number of output frames written.
      ```
  
  To initialize the resampler you first need to set up a config (`ma_resampler_config`) with
  `ma_resampler_config_init()`. You need to specify the sample format you want to use, the number of
  channels, the input and output sample rate, and the algorithm.
  
  The sample format can be either `ma_format_s16` or `ma_format_f32`. If you need a different format
  you will need to perform pre- and post-conversions yourself where necessary. Note that the format
  is the same for both input and output. The format cannot be changed after initialization.
  
  The resampler supports multiple channels and is always interleaved (both input and output). The
  channel count cannot be changed after initialization.
  
  The sample rates can be anything other than zero, and are always specified in hertz. They should be
  set to something like 44100, etc. The sample rate is the only configuration property that can be
  changed after initialization.
  
  The miniaudio resampler has built-in support for the following algorithms:
  
      +-----------+------------------------------+
      | Algorithm | Enum Token                   |
      +-----------+------------------------------+
      | Linear    | ma_resample_algorithm_linear |
      | Custom    | ma_resample_algorithm_custom |
      +-----------+------------------------------+
  
  The algorithm cannot be changed after initialization.
  
  Processing always happens on a per PCM frame basis and always assumes interleaved input and output.
  De-interleaved processing is not supported. To process frames, use
  `ma_resampler_process_pcm_frames()`. On input, this function takes the number of output frames you
  can fit in the output buffer and the number of input frames contained in the input buffer. On
  output these variables contain the number of output frames that were written to the output buffer
  and the number of input frames that were consumed in the process. You can pass in NULL for the
  input buffer in which case it will be treated as an infinitely large buffer of zeros. The output
  buffer can also be NULL, in which case the processing will be treated as seek.
  
  The sample rate can be changed dynamically on the fly. You can change this with explicit sample
  rates with `ma_resampler_set_rate()` and also with a decimal ratio with
  `ma_resampler_set_rate_ratio()`. The ratio is in/out.
  
  Sometimes it's useful to know exactly how many input frames will be required to output a specific
  number of frames. You can calculate this with `ma_resampler_get_required_input_frame_count()`.
  Likewise, it's sometimes useful to know exactly how many frames would be output given a certain
  number of input frames. You can do this with `ma_resampler_get_expected_output_frame_count()`.
  
  Due to the nature of how resampling works, the resampler introduces some latency. This can be
  retrieved in terms of both the input rate and the output rate with
  `ma_resampler_get_input_latency()` and `ma_resampler_get_output_latency()`.
  
  
  10.3.1. Resampling Algorithms
  -----------------------------
  The choice of resampling algorithm depends on your situation and requirements.
  
  
  10.3.1.1. Linear Resampling
  ---------------------------
  The linear resampler is the fastest, but comes at the expense of poorer quality. There is, however,
  some control over the quality of the linear resampler which may make it a suitable option depending
  on your requirements.
  
  The linear resampler performs low-pass filtering before or after downsampling or upsampling,
  depending on the sample rates you're converting between. When decreasing the sample rate, the
  low-pass filter will be applied before downsampling. When increasing the rate it will be performed
  after upsampling. By default a fourth order low-pass filter will be applied. This can be configured
  via the `lpfOrder` configuration variable. Setting this to 0 will disable filtering.
  
  The low-pass filter has a cutoff frequency which defaults to half the sample rate of the lowest of
  the input and output sample rates (Nyquist Frequency).
  
  The API for the linear resampler is the same as the main resampler API, only it's called
  `ma_linear_resampler`.
  
  
  10.3.2. Custom Resamplers
  -------------------------
  You can implement a custom resampler by using the `ma_resample_algorithm_custom` resampling
  algorithm and setting a vtable in the resampler config:
  
      ```c
      ma_resampler_config config = ma_resampler_config_init(..., ma_resample_algorithm_custom);
      config.pBackendVTable = &g_customResamplerVTable;
      ```
  
  Custom resamplers are useful if the stock algorithms are not appropriate for your use case. You
  need to implement the required functions in `ma_resampling_backend_vtable`. Note that not all
  functions in the vtable need to be implemented, but if it's possible to implement, they should be.
  
  You can use the `ma_linear_resampler` object for an example on how to implement the vtable. The
  `onGetHeapSize` callback is used to calculate the size of any internal heap allocation the custom
  resampler will need to make given the supplied config. When you initialize the resampler via the
  `onInit` callback, you'll be given a pointer to a heap allocation which is where you should store
  the heap allocated data. You should not free this data in `onUninit` because miniaudio will manage
  it for you.
  
  The `onProcess` callback is where the actual resampling takes place. On input, `pFrameCountIn`
  points to a variable containing the number of frames in the `pFramesIn` buffer and
  `pFrameCountOut` points to a variable containing the capacity in frames of the `pFramesOut` buffer.
  On output, `pFrameCountIn` should be set to the number of input frames that were fully consumed,
  whereas `pFrameCountOut` should be set to the number of frames that were written to `pFramesOut`.
  
  The `onSetRate` callback is optional and is used for dynamically changing the sample rate. If
  dynamic rate changes are not supported, you can set this callback to NULL.
  
  The `onGetInputLatency` and `onGetOutputLatency` functions are used for retrieving the latency in
  input and output rates respectively. These can be NULL in which case latency calculations will be
  assumed to be NULL.
  
  The `onGetRequiredInputFrameCount` callback is used to give miniaudio a hint as to how many input
  frames are required to be available to produce the given number of output frames. Likewise, the
  `onGetExpectedOutputFrameCount` callback is used to determine how many output frames will be
  produced given the specified number of input frames. miniaudio will use these as a hint, but they
  are optional and can be set to NULL if you're unable to implement them.
  
  
  
  10.4. General Data Conversion
  -----------------------------
  The `ma_data_converter` API can be used to wrap sample format conversion, channel conversion and
  resampling into one operation. This is what miniaudio uses internally to convert between the format
  requested when the device was initialized and the format of the backend's native device. The API
  for general data conversion is very similar to the resampling API. Create a `ma_data_converter`
  object like this:
  
      ```c
      ma_data_converter_config config = ma_data_converter_config_init(
          inputFormat,
          outputFormat,
          inputChannels,
          outputChannels,
          inputSampleRate,
          outputSampleRate
      );
  
      ma_data_converter converter;
      ma_result result = ma_data_converter_init(&config, NULL, &converter);
      if (result != MA_SUCCESS) 
          // An error occurred...
      
      ```
  
  In the example above we use `ma_data_converter_config_init()` to initialize the config, however
  there's many more properties that can be configured, such as channel maps and resampling quality.
  Something like the following may be more suitable depending on your requirements:
  
      ```c
      ma_data_converter_config config = ma_data_converter_config_init_default();
      config.formatIn = inputFormat;
      config.formatOut = outputFormat;
      config.channelsIn = inputChannels;
      config.channelsOut = outputChannels;
      config.sampleRateIn = inputSampleRate;
      config.sampleRateOut = outputSampleRate;
      ma_channel_map_init_standard(ma_standard_channel_map_flac, config.channelMapIn, sizeof(config.channelMapIn)/sizeof(config.channelMapIn[0]), config.channelCountIn);
      config.resampling.linear.lpfOrder = MA_MAX_FILTER_ORDER;
      ```
  
  Do the following to uninitialize the data converter:
  
      ```c
      ma_data_converter_uninit(&converter, NULL);
      ```
  
  The following example shows how data can be processed
  
      ```c
      ma_uint64 frameCountIn  = 1000;
      ma_uint64 frameCountOut = 2000;
      ma_result result = ma_data_converter_process_pcm_frames(&converter, pFramesIn, &frameCountIn, pFramesOut, &frameCountOut);
      if (result != MA_SUCCESS) 
          // An error occurred...
      
  
      // At this point, frameCountIn contains the number of input frames that were consumed and frameCountOut contains the number
      // of output frames written.
      ```
  
  The data converter supports multiple channels and is always interleaved (both input and output).
  The channel count cannot be changed after initialization.
  
  Sample rates can be anything other than zero, and are always specified in hertz. They should be set
  to something like 44100, etc. The sample rate is the only configuration property that can be
  changed after initialization, but only if the `resampling.allowDynamicSampleRate` member of
  `ma_data_converter_config` is set to `MA_TRUE`. To change the sample rate, use
  `ma_data_converter_set_rate()` or `ma_data_converter_set_rate_ratio()`. The ratio must be in/out.
  The resampling algorithm cannot be changed after initialization.
  
  Processing always happens on a per PCM frame basis and always assumes interleaved input and output.
  De-interleaved processing is not supported. To process frames, use
  `ma_data_converter_process_pcm_frames()`. On input, this function takes the number of output frames
  you can fit in the output buffer and the number of input frames contained in the input buffer. On
  output these variables contain the number of output frames that were written to the output buffer
  and the number of input frames that were consumed in the process. You can pass in NULL for the
  input buffer in which case it will be treated as an infinitely large
  buffer of zeros. The output buffer can also be NULL, in which case the processing will be treated
  as seek.
  
  Sometimes it's useful to know exactly how many input frames will be required to output a specific
  number of frames. You can calculate this with `ma_data_converter_get_required_input_frame_count()`.
  Likewise, it's sometimes useful to know exactly how many frames would be output given a certain
  number of input frames. You can do this with `ma_data_converter_get_expected_output_frame_count()`.
  
  Due to the nature of how resampling works, the data converter introduces some latency if resampling
  is required. This can be retrieved in terms of both the input rate and the output rate with
  `ma_data_converter_get_input_latency()` and `ma_data_converter_get_output_latency()`.
  
  
  
  11. Filtering
  =============
  
  11.1. Biquad Filtering
  ----------------------
  Biquad filtering is achieved with the `ma_biquad` API. Example:
  
      ```c
      ma_biquad_config config = ma_biquad_config_init(ma_format_f32, channels, b0, b1, b2, a0, a1, a2);
      ma_result result = ma_biquad_init(&config, &biquad);
      if (result != MA_SUCCESS) 
          // Error.
      
  
      ...
  
      ma_biquad_process_pcm_frames(&biquad, pFramesOut, pFramesIn, frameCount);
      ```
  
  Biquad filtering is implemented using transposed direct form 2. The numerator coefficients are b0,
  b1 and b2, and the denominator coefficients are a0, a1 and a2. The a0 coefficient is required and
  coefficients must not be pre-normalized.
  
  Supported formats are `ma_format_s16` and `ma_format_f32`. If you need to use a different format
  you need to convert it yourself beforehand. When using `ma_format_s16` the biquad filter will use
  fixed point arithmetic. When using `ma_format_f32`, floating point arithmetic will be used.
  
  Input and output frames are always interleaved.
  
  Filtering can be applied in-place by passing in the same pointer for both the input and output
  buffers, like so:
  
      ```c
      ma_biquad_process_pcm_frames(&biquad, pMyData, pMyData, frameCount);
      ```
  
  If you need to change the values of the coefficients, but maintain the values in the registers you
  can do so with `ma_biquad_reinit()`. This is useful if you need to change the properties of the
  filter while keeping the values of registers valid to avoid glitching. Do not use
  `ma_biquad_init()` for this as it will do a full initialization which involves clearing the
  registers to 0. Note that changing the format or channel count after initialization is invalid and
  will result in an error.
  
  
  11.2. Low-Pass Filtering
  ------------------------
  Low-pass filtering is achieved with the following APIs:
  
      +---------+------------------------------------------+
      | API     | Description                              |
      +---------+------------------------------------------+
      | ma_lpf1 | First order low-pass filter              |
      | ma_lpf2 | Second order low-pass filter             |
      | ma_lpf  | High order low-pass filter (Butterworth) |
      +---------+------------------------------------------+
  
  Low-pass filter example:
  
      ```c
      ma_lpf_config config = ma_lpf_config_init(ma_format_f32, channels, sampleRate, cutoffFrequency, order);
      ma_result result = ma_lpf_init(&config, &lpf);
      if (result != MA_SUCCESS) 
          // Error.
      
  
      ...
  
      ma_lpf_process_pcm_frames(&lpf, pFramesOut, pFramesIn, frameCount);
      ```
  
  Supported formats are `ma_format_s16` and` ma_format_f32`. If you need to use a different format
  you need to convert it yourself beforehand. Input and output frames are always interleaved.
  
  Filtering can be applied in-place by passing in the same pointer for both the input and output
  buffers, like so:
  
      ```c
      ma_lpf_process_pcm_frames(&lpf, pMyData, pMyData, frameCount);
      ```
  
  The maximum filter order is limited to `MA_MAX_FILTER_ORDER` which is set to 8. If you need more,
  you can chain first and second order filters together.
  
      ```c
      for (iFilter = 0; iFilter < filterCount; iFilter += 1) 
          ma_lpf2_process_pcm_frames(&lpf2[iFilter], pMyData, pMyData, frameCount);
      
      ```
  
  If you need to change the configuration of the filter, but need to maintain the state of internal
  registers you can do so with `ma_lpf_reinit()`. This may be useful if you need to change the sample
  rate and/or cutoff frequency dynamically while maintaining smooth transitions. Note that changing the
  format or channel count after initialization is invalid and will result in an error.
  
  The `ma_lpf` object supports a configurable order, but if you only need a first order filter you
  may want to consider using `ma_lpf1`. Likewise, if you only need a second order filter you can use
  `ma_lpf2`. The advantage of this is that they're lighter weight and a bit more efficient.
  
  If an even filter order is specified, a series of second order filters will be processed in a
  chain. If an odd filter order is specified, a first order filter will be applied, followed by a
  series of second order filters in a chain.
  
  
  11.3. High-Pass Filtering
  -------------------------
  High-pass filtering is achieved with the following APIs:
  
      +---------+-------------------------------------------+
      | API     | Description                               |
      +---------+-------------------------------------------+
      | ma_hpf1 | First order high-pass filter              |
      | ma_hpf2 | Second order high-pass filter             |
      | ma_hpf  | High order high-pass filter (Butterworth) |
      +---------+-------------------------------------------+
  
  High-pass filters work exactly the same as low-pass filters, only the APIs are called `ma_hpf1`,
  `ma_hpf2` and `ma_hpf`. See example code for low-pass filters for example usage.
  
  
  11.4. Band-Pass Filtering
  -------------------------
  Band-pass filtering is achieved with the following APIs:
  
      +---------+-------------------------------+
      | API     | Description                   |
      +---------+-------------------------------+
      | ma_bpf2 | Second order band-pass filter |
      | ma_bpf  | High order band-pass filter   |
      +---------+-------------------------------+
  
  Band-pass filters work exactly the same as low-pass filters, only the APIs are called `ma_bpf2` and
  `ma_hpf`. See example code for low-pass filters for example usage. Note that the order for
  band-pass filters must be an even number which means there is no first order band-pass filter,
  unlike low-pass and high-pass filters.
  
  
  11.5. Notch Filtering
  ---------------------
  Notch filtering is achieved with the following APIs:
  
      +-----------+------------------------------------------+
      | API       | Description                              |
      +-----------+------------------------------------------+
      | ma_notch2 | Second order notching filter             |
      +-----------+------------------------------------------+
  
  
  11.6. Peaking EQ Filtering
  -------------------------
  Peaking filtering is achieved with the following APIs:
  
      +----------+------------------------------------------+
      | API      | Description                              |
      +----------+------------------------------------------+
      | ma_peak2 | Second order peaking filter              |
      +----------+------------------------------------------+
  
  
  11.7. Low Shelf Filtering
  -------------------------
  Low shelf filtering is achieved with the following APIs:
  
      +-------------+------------------------------------------+
      | API         | Description                              |
      +-------------+------------------------------------------+
      | ma_loshelf2 | Second order low shelf filter            |
      +-------------+------------------------------------------+
  
  Where a high-pass filter is used to eliminate lower frequencies, a low shelf filter can be used to
  just turn them down rather than eliminate them entirely.
  
  
  11.8. High Shelf Filtering
  --------------------------
  High shelf filtering is achieved with the following APIs:
  
      +-------------+------------------------------------------+
      | API         | Description                              |
      +-------------+------------------------------------------+
      | ma_hishelf2 | Second order high shelf filter           |
      +-------------+------------------------------------------+
  
  The high shelf filter has the same API as the low shelf filter, only you would use `ma_hishelf`
  instead of `ma_loshelf`. Where a low shelf filter is used to adjust the volume of low frequencies,
  the high shelf filter does the same thing for high frequencies.
  
  
  
  
  12. Waveform and Noise Generation
  =================================
  
  12.1. Waveforms
  ---------------
  miniaudio supports generation of sine, square, triangle and sawtooth waveforms. This is achieved
  with the `ma_waveform` API. Example:
  
      ```c
      ma_waveform_config config = ma_waveform_config_init(
          FORMAT,
          CHANNELS,
          SAMPLE_RATE,
          ma_waveform_type_sine,
          amplitude,
          frequency);
  
      ma_waveform waveform;
      ma_result result = ma_waveform_init(&config, &waveform);
      if (result != MA_SUCCESS) 
          // Error.
      
  
      ...
  
      ma_waveform_read_pcm_frames(&waveform, pOutput, frameCount);
      ```
  
  The amplitude, frequency, type, and sample rate can be changed dynamically with
  `ma_waveform_set_amplitude()`, `ma_waveform_set_frequency()`, `ma_waveform_set_type()`, and
  `ma_waveform_set_sample_rate()` respectively.
  
  You can invert the waveform by setting the amplitude to a negative value. You can use this to
  control whether or not a sawtooth has a positive or negative ramp, for example.
  
  Below are the supported waveform types:
  
      +---------------------------+
      | Enum Name                 |
      +---------------------------+
      | ma_waveform_type_sine     |
      | ma_waveform_type_square   |
      | ma_waveform_type_triangle |
      | ma_waveform_type_sawtooth |
      +---------------------------+
  
  
  
  12.2. Noise
  -----------
  miniaudio supports generation of white, pink and Brownian noise via the `ma_noise` API. Example:
  
      ```c
      ma_noise_config config = ma_noise_config_init(
          FORMAT,
          CHANNELS,
          ma_noise_type_white,
          SEED,
          amplitude);
  
      ma_noise noise;
      ma_result result = ma_noise_init(&config, &noise);
      if (result != MA_SUCCESS) 
          // Error.
      
  
      ...
  
      ma_noise_read_pcm_frames(&noise, pOutput, frameCount);
      ```
  
  The noise API uses simple LCG random number generation. It supports a custom seed which is useful
  for things like automated testing requiring reproducibility. Setting the seed to zero will default
  to `MA_DEFAULT_LCG_SEED`.
  
  The amplitude and seed can be changed dynamically with `ma_noise_set_amplitude()` and
  `ma_noise_set_seed()` respectively.
  
  By default, the noise API will use different values for different channels. So, for example, the
  left side in a stereo stream will be different to the right side. To instead have each channel use
  the same random value, set the `duplicateChannels` member of the noise config to true, like so:
  
      ```c
      config.duplicateChannels = MA_TRUE;
      ```
  
  Below are the supported noise types.
  
      +------------------------+
      | Enum Name              |
      +------------------------+
      | ma_noise_type_white    |
      | ma_noise_type_pink     |
      | ma_noise_type_brownian |
      +------------------------+
  
  
  
  13. Audio Buffers
  =================
  miniaudio supports reading from a buffer of raw audio data via the `ma_audio_buffer` API. This can
  read from memory that's managed by the application, but can also handle the memory management for
  you internally. Memory management is flexible and should support most use cases.
  
  Audio buffers are initialised using the standard configuration system used everywhere in miniaudio:
  
      ```c
      ma_audio_buffer_config config = ma_audio_buffer_config_init(
          format,
          channels,
          sizeInFrames,
          pExistingData,
          &allocationCallbacks);
  
      ma_audio_buffer buffer;
      result = ma_audio_buffer_init(&config, &buffer);
      if (result != MA_SUCCESS) 
          // Error.
      
  
      ...
  
      ma_audio_buffer_uninit(&buffer);
      ```
  
  In the example above, the memory pointed to by `pExistingData` will *not* be copied and is how an
  application can do self-managed memory allocation. If you would rather make a copy of the data, use
  `ma_audio_buffer_init_copy()`. To uninitialize the buffer, use `ma_audio_buffer_uninit()`.
  
  Sometimes it can be convenient to allocate the memory for the `ma_audio_buffer` structure and the
  raw audio data in a contiguous block of memory. That is, the raw audio data will be located
  immediately after the `ma_audio_buffer` structure. To do this, use
  `ma_audio_buffer_alloc_and_init()`:
  
      ```c
      ma_audio_buffer_config config = ma_audio_buffer_config_init(
          format,
          channels,
          sizeInFrames,
          pExistingData,
          &allocationCallbacks);
  
      ma_audio_buffer* pBuffer
      result = ma_audio_buffer_alloc_and_init(&config, &pBuffer);
      if (result != MA_SUCCESS) 
          // Error
      
  
      ...
  
      ma_audio_buffer_uninit_and_free(&buffer);
      ```
  
  If you initialize the buffer with `ma_audio_buffer_alloc_and_init()` you should uninitialize it
  with `ma_audio_buffer_uninit_and_free()`. In the example above, the memory pointed to by
  `pExistingData` will be copied into the buffer, which is contrary to the behavior of
  `ma_audio_buffer_init()`.
  
  An audio buffer has a playback cursor just like a decoder. As you read frames from the buffer, the
  cursor moves forward. The last parameter (`loop`) can be used to determine if the buffer should
  loop. The return value is the number of frames actually read. If this is less than the number of
  frames requested it means the end has been reached. This should never happen if the `loop`
  parameter is set to true. If you want to manually loop back to the start, you can do so with with
  `ma_audio_buffer_seek_to_pcm_frame(pAudioBuffer, 0)`. Below is an example for reading data from an
  audio buffer.
  
      ```c
      ma_uint64 framesRead = ma_audio_buffer_read_pcm_frames(pAudioBuffer, pFramesOut, desiredFrameCount, isLooping);
      if (framesRead < desiredFrameCount) 
          // If not looping, this means the end has been reached. This should never happen in looping mode with valid input.
      
      ```
  
  Sometimes you may want to avoid the cost of data movement between the internal buffer and the
  output buffer. Instead you can use memory mapping to retrieve a pointer to a segment of data:
  
      ```c
      void* pMappedFrames;
      ma_uint64 frameCount = frameCountToTryMapping;
      ma_result result = ma_audio_buffer_map(pAudioBuffer, &pMappedFrames, &frameCount);
      if (result == MA_SUCCESS) 
          // Map was successful. The value in frameCount will be how many frames were _actually_ mapped, which may be
          // less due to the end of the buffer being reached.
          ma_copy_pcm_frames(pFramesOut, pMappedFrames, frameCount, pAudioBuffer->format, pAudioBuffer->channels);
  
          // You must unmap the buffer.
          ma_audio_buffer_unmap(pAudioBuffer, frameCount);
      
      ```
  
  When you use memory mapping, the read cursor is increment by the frame count passed in to
  `ma_audio_buffer_unmap()`. If you decide not to process every frame you can pass in a value smaller
  than the value returned by `ma_audio_buffer_map()`. The disadvantage to using memory mapping is
  that it does not handle looping for you. You can determine if the buffer is at the end for the
  purpose of looping with `ma_audio_buffer_at_end()` or by inspecting the return value of
  `ma_audio_buffer_unmap()` and checking if it equals `MA_AT_END`. You should not treat `MA_AT_END`
  as an error when returned by `ma_audio_buffer_unmap()`.
  
  
  
  14. Ring Buffers
  ================
  miniaudio supports lock free (single producer, single consumer) ring buffers which are exposed via
  the `ma_rb` and `ma_pcm_rb` APIs. The `ma_rb` API operates on bytes, whereas the `ma_pcm_rb`
  operates on PCM frames. They are otherwise identical as `ma_pcm_rb` is just a wrapper around
  `ma_rb`.
  
  Unlike most other APIs in miniaudio, ring buffers support both interleaved and deinterleaved
  streams. The caller can also allocate their own backing memory for the ring buffer to use
  internally for added flexibility. Otherwise the ring buffer will manage it's internal memory for
  you.
  
  The examples below use the PCM frame variant of the ring buffer since that's most likely the one
  you will want to use. To initialize a ring buffer, do something like the following:
  
      ```c
      ma_pcm_rb rb;
      ma_result result = ma_pcm_rb_init(FORMAT, CHANNELS, BUFFER_SIZE_IN_FRAMES, NULL, NULL, &rb);
      if (result != MA_SUCCESS) 
          // Error
      
      ```
  
  The `ma_pcm_rb_init()` function takes the sample format and channel count as parameters because
  it's the PCM variant of the ring buffer API. For the regular ring buffer that operates on bytes you
  would call `ma_rb_init()` which leaves these out and just takes the size of the buffer in bytes
  instead of frames. The fourth parameter is an optional pre-allocated buffer and the fifth parameter
  is a pointer to a `ma_allocation_callbacks` structure for custom memory allocation routines.
  Passing in `NULL` for this results in `MA_MALLOC()` and `MA_FREE()` being used.
  
  Use `ma_pcm_rb_init_ex()` if you need a deinterleaved buffer. The data for each sub-buffer is
  offset from each other based on the stride. To manage your sub-buffers you can use
  `ma_pcm_rb_get_subbuffer_stride()`, `ma_pcm_rb_get_subbuffer_offset()` and
  `ma_pcm_rb_get_subbuffer_ptr()`.
  
  Use `ma_pcm_rb_acquire_read()` and `ma_pcm_rb_acquire_write()` to retrieve a pointer to a section
  of the ring buffer. You specify the number of frames you need, and on output it will set to what
  was actually acquired. If the read or write pointer is positioned such that the number of frames
  requested will require a loop, it will be clamped to the end of the buffer. Therefore, the number
  of frames you're given may be less than the number you requested.
  
  After calling `ma_pcm_rb_acquire_read()` or `ma_pcm_rb_acquire_write()`, you do your work on the
  buffer and then "commit" it with `ma_pcm_rb_commit_read()` or `ma_pcm_rb_commit_write()`. This is
  where the read/write pointers are updated. When you commit you need to pass in the buffer that was
  returned by the earlier call to `ma_pcm_rb_acquire_read()` or `ma_pcm_rb_acquire_write()` and is
  only used for validation. The number of frames passed to `ma_pcm_rb_commit_read()` and
  `ma_pcm_rb_commit_write()` is what's used to increment the pointers, and can be less that what was
  originally requested.
  
  If you want to correct for drift between the write pointer and the read pointer you can use a
  combination of `ma_pcm_rb_pointer_distance()`, `ma_pcm_rb_seek_read()` and
  `ma_pcm_rb_seek_write()`. Note that you can only move the pointers forward, and you should only
  move the read pointer forward via the consumer thread, and the write pointer forward by the
  producer thread. If there is too much space between the pointers, move the read pointer forward. If
  there is too little space between the pointers, move the write pointer forward.
  
  You can use a ring buffer at the byte level instead of the PCM frame level by using the `ma_rb`
  API. This is exactly the same, only you will use the `ma_rb` functions instead of `ma_pcm_rb` and
  instead of frame counts you will pass around byte counts.
  
  The maximum size of the buffer in bytes is `0x7FFFFFFF-(MA_SIMD_ALIGNMENT-1)` due to the most
  significant bit being used to encode a loop flag and the internally managed buffers always being
  aligned to `MA_SIMD_ALIGNMENT`.
  
  Note that the ring buffer is only thread safe when used by a single consumer thread and single
  producer thread.
  
  
  
  15. Backends
  ============
  The following backends are supported by miniaudio. These are listed in order of default priority.
  When no backend is specified when initializing a context or device, miniaudio will attempt to use
  each of these backends in the order listed in the table below.
  
  Note that backends that are not usable by the build target will not be included in the build. For
  example, ALSA, which is specific to Linux, will not be included in the Windows build.
  
      +-------------+-----------------------+--------------------------------------------------------+
      | Name        | Enum Name             | Supported Operating Systems                            |
      +-------------+-----------------------+--------------------------------------------------------+
      | WASAPI      | ma_backend_wasapi     | Windows Vista+                                         |
      | DirectSound | ma_backend_dsound     | Windows XP+                                            |
      | WinMM       | ma_backend_winmm      | Windows 95+                                            |
      | Core Audio  | ma_backend_coreaudio  | macOS, iOS                                             |
      | sndio       | ma_backend_sndio      | OpenBSD                                                |
      | audio(4)    | ma_backend_audio4     | NetBSD, OpenBSD                                        |
      | OSS         | ma_backend_oss        | FreeBSD                                                |
      | PulseAudio  | ma_backend_pulseaudio | Cross Platform (disabled on Windows, BSD and Android)  |
      | ALSA        | ma_backend_alsa       | Linux                                                  |
      | JACK        | ma_backend_jack       | Cross Platform (disabled on BSD and Android)           |
      | AAudio      | ma_backend_aaudio     | Android 8+                                             |
      | OpenSL ES   | ma_backend_opensl     | Android (API level 16+)                                |
      | Web Audio   | ma_backend_webaudio   | Web (via Emscripten)                                   |
      | Custom      | ma_backend_custom     | Cross Platform                                         |
      | Null        | ma_backend_null       | Cross Platform (not used on Web)                       |
      +-------------+-----------------------+--------------------------------------------------------+
  
  Some backends have some nuance details you may want to be aware of.
  
  15.1. WASAPI
  ------------
  - Low-latency shared mode will be disabled when using an application-defined sample rate which is
    different to the device's native sample rate. To work around this, set `wasapi.noAutoConvertSRC`
    to true in the device config. This is due to IAudioClient3_InitializeSharedAudioStream() failing
    when the `AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM` flag is specified. Setting wasapi.noAutoConvertSRC
    will result in miniaudio's internal resampler being used instead which will in turn enable the
    use of low-latency shared mode.
  
  15.2. PulseAudio
  ----------------
  - If you experience bad glitching/noise on Arch Linux, consider this fix from the Arch wiki:
    https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Glitches,_skips_or_crackling.
    Alternatively, consider using a different backend such as ALSA.
  
  15.3. Android
  -------------
  - To capture audio on Android, remember to add the RECORD_AUDIO permission to your manifest:
    `<uses-permission android:name="android.permission.RECORD_AUDIO" />`
  - With OpenSL|ES, only a single ma_context can be active at any given time. This is due to a
    limitation with OpenSL|ES.
  - With AAudio, only default devices are enumerated. This is due to AAudio not having an enumeration
    API (devices are enumerated through Java). You can however perform your own device enumeration
    through Java and then set the ID in the ma_device_id structure (ma_device_id.aaudio) and pass it
    to ma_device_init().
  - The backend API will perform resampling where possible. The reason for this as opposed to using
    miniaudio's built-in resampler is to take advantage of any potential device-specific
    optimizations the driver may implement.
  
  BSD
  ---
  - The sndio backend is currently only enabled on OpenBSD builds.
  - The audio(4) backend is supported on OpenBSD, but you may need to disable sndiod before you can
    use it.
  
  15.4. UWP
  ---------
  - UWP only supports default playback and capture devices.
  - UWP requires the Microphone capability to be enabled in the application's manifest (Package.appxmanifest):
  
      ```
      <Package ...>
          ...
          <Capabilities>
              <DeviceCapability Name="microphone" />
          </Capabilities>
      </Package>
      ```
  
  15.5. Web Audio / Emscripten
  ----------------------------
  - You cannot use `-std=c*` compiler flags, nor `-ansi`. This only applies to the Emscripten build.
  - The first time a context is initialized it will create a global object called "miniaudio" whose
    primary purpose is to act as a factory for device objects.
  - Currently the Web Audio backend uses ScriptProcessorNode's, but this may need to change later as
    they've been deprecated.
  - Google has implemented a policy in their browsers that prevent automatic media output without
    first receiving some kind of user input. The following web page has additional details:
    https://developers.google.com/web/updates/2017/09/autoplay-policy-changes. Starting the device
    may fail if you try to start playback without first handling some kind of user input.
  
  
  
  16. Optimization Tips
  =====================
  See below for some tips on improving performance.
  
  16.1. Low Level API
  -------------------
  - In the data callback, if your data is already clipped prior to copying it into the output buffer,
    set the `noClip` config option in the device config to true. This will disable miniaudio's built
    in clipping function.
  - By default, miniaudio will pre-silence the data callback's output buffer. If you know that you
    will always write valid data to the output buffer you can disable pre-silencing by setting the
    `noPreSilence` config option in the device config to true.
  
  16.2. High Level API
  --------------------
  - If a sound does not require doppler or pitch shifting, consider disabling pitching by
    initializing the sound with the `MA_SOUND_FLAG_NO_PITCH` flag.
  - If a sound does not require spatialization, disable it by initializing the sound with the
    `MA_SOUND_FLAG_NO_SPATIALIZATION` flag. It can be re-enabled again post-initialization with
    `ma_sound_set_spatialization_enabled()`.
  - If you know all of your sounds will always be the same sample rate, set the engine's sample
    rate to match that of the sounds. Likewise, if you're using a self-managed resource manager,
    consider setting the decoded sample rate to match your sounds. By configuring everything to
    use a consistent sample rate, sample rate conversion can be avoided.
  
  
  
  17. Miscellaneous Notes
  =======================
  - Automatic stream routing is enabled on a per-backend basis. Support is explicitly enabled for
    WASAPI and Core Audio, however other backends such as PulseAudio may naturally support it, though
    not all have been tested.
  - When compiling with VC6 and earlier, decoding is restricted to files less than 2GB in size. This
    is due to 64-bit file APIs not being available.
   }
{$ifndef miniaudio_h}
{$define miniaudio_h}  
{ C++ extern C conditionnal removed }
{$if defined(_MSC_VER) AND NOT defined(__clang__)}
(** unsupported pragma#pragma warning(push)*)
(** unsupported pragma#pragma warning(disable:4201)   /* nonstandard extension used: nameless struct/union */*)
(** unsupported pragma#pragma warning(disable:4214)   /* nonstandard extension used: bit field types other than int */*)
(** unsupported pragma#pragma warning(disable:4324)   /* structure was padded due to alignment specifier */*)
(*** was #elif ****){$else defined(__clang__) OR (defined(__GNUC__) AND (__GNUC__ > 4 OR (__GNUC__ == 4 AND __GNUC_MINOR__ >= 8)))}
(** unsupported pragma#pragma GCC diagnostic push*)
(** unsupported pragma#pragma GCC diagnostic ignored "-Wpedantic" /* For ISO C99 doesn't support unnamed structs/unions [-Wpedantic] */*)
{$endif}
{include <stddef.h> /* For size_t. */}
  { Sized types.  }
{$if defined(MA_USE_STDINT)}
{$include <stdint.h>}

    ma_int8 = int8_t;

    ma_uint8 = uint8_t;

    ma_int16 = int16_t;

    ma_uint16 = uint16_t;

    ma_int32 = int32_t;

    ma_uint32 = uint32_t;

    ma_int64 = int64_t;

    ma_uint64 = uint64_t;
{$else}

    ma_int8 = char;

    ma_uint8 = byte;

    ma_int16 = smallint;

    ma_uint16 = word;

    ma_int32 = longint;

    ma_uint32 = dword;

    ma_int64 = int64;

    ma_uint64 = qword;
{$endif}
  { MA_USE_STDINT  }
{$if MA_SIZEOF_PTR = 8}
    ma_uintptr = ma_uint64;
{$else}

    ma_uintptr = ma_uint32;
{$endif}

    ma_bool8 = ma_uint8;

    ma_bool32 = ma_uint32;

    ma_float = single;

    ma_double = double;

    ma_handle = pointer;

    ma_ptr = pointer;
{$if defined(__GNUC__)}
    ma_proc = procedure (_para1:pointer);cdecl;
{$else}

    ma_proc = pointer;
{$endif}
{$if defined(_MSC_VER) AND NOT defined(_WCHAR_T_DEFINED)}

    wchar_t = ma_uint16;
{$endif}
{$ifdef UNIX    /* If it's not Win32, assume POSIX. */}
{$define MA_POSIX}  
{$ifndef MA_NO_PTHREAD_IN_HEADER}
{include <pthread.h>    /* Unfortunate #include, but needed for pthread_t, pthread_mutex_t and pthread_cond_t types. */}

    ma_pthread_t = pthread_t;

    ma_pthread_mutex_t = pthread_mutex_t;

    ma_pthread_cond_t = pthread_cond_t;
{$else}

    ma_pthread_t = ma_uintptr;

    ma_pthread_mutex_t = record
        case longint of
          0 : ( __data : array[0..39] of char );
          1 : ( __alignment : ma_uint64 );
        end;

    ma_pthread_cond_t = record
        case longint of
          0 : ( __data : array[0..47] of char );
          1 : ( __alignment : ma_uint64 );
        end;
{$endif}
{$if defined(UNIX)}
{$define MA_UNIX}  
{$endif}
{$if defined(LINUX)}
{$define MA_LINUX}  
{$endif}
{$if defined(DARWIN)}
{$define MA_APPLE}  
{$endif}
{$if defined(DragonFly) OR defined(FREEBSD) OR defined(NETBSD) OR defined(OPENBSD)}
{$define MA_BSD}  
{$endif}
{$if defined(ANDROID)}
{$define MA_ANDROID}  
{$endif}
{$if defined(__EMSCRIPTEN__)}
{$define MA_EMSCRIPTEN}  
{$endif}
{$if defined(__ORBIS__)}
{$define MA_ORBIS}  
{$endif}
{$if defined(__PROSPERO__)}
{$define MA_PROSPERO}  
{$endif}
{$if defined(__NX__)}
{$define MA_NX}  
{$endif}
{$if defined(BEOS) OR defined(HAIKU)}
{$define MA_BEOS}  
{$endif}
{$if defined(HAIKU)}
{$define MA_HAIKU}  
{$endif}
{$endif}
{$if NOT defined(MA_FALLTHROUGH) AND defined(__has_attribute) AND (defined(__clang__) OR defined(__GNUC__))}
{$endif}
  {
      I've had a bug report where GCC is emitting warnings about functions possibly not being inlineable. This warning happens when
      the __attribute__((always_inline)) attribute is defined without an "inline" statement. I think therefore there must be some
      case where "__inline__" is not always defined, thus the compiler emitting these warnings. When using -std=c89 or -ansi on the
      command line, we cannot use the "inline" keyword and instead need to use "__inline__". In an attempt to work around this issue
      I am using "__inline__" only when we're compiling in strict ANSI mode.
       }
  { SIMD alignment in bytes. Currently set to 32 bytes in preparation for future AVX optimizations.  }

  {
  Special wchar_t type to ensure any structures in the public sections that reference it have a
  consistent size across all platforms.
  
  On Windows, wchar_t is 2 bytes, whereas everywhere else it's 4 bytes. Since Windows likes to use
  wchar_t for it's IDs, we need a special explicitly sized wchar type that is always 2 bytes on all
  platforms.
   }
{$if NOT defined(MA_POSIX) AND defined(WIN32)}
    ma_wchar_win32 = wchar_t;
{$else}
    ma_wchar_win32 = ma_uint16;
{$endif}
  {
  Logging Levels
  ==============
  Log levels are only used to give logging callbacks some context as to the severity of a log message
  so they can do filtering. All log levels will be posted to registered logging callbacks. If you
  don't want to output a certain log level you can discriminate against the log level in the callback.
  
  MA_LOG_LEVEL_DEBUG
      Used for debugging. Useful for debug and test builds, but should be disabled in release builds.
  
  MA_LOG_LEVEL_INFO
      Informational logging. Useful for debugging. This will never be called from within the data
      callback.
  
  MA_LOG_LEVEL_WARNING
      Warnings. You should enable this in you development builds and action them when encounted. These
      logs usually indicate a potential problem or misconfiguration, but still allow you to keep
      running. This will never be called from within the data callback.
  
  MA_LOG_LEVEL_ERROR
      Error logging. This will be fired when an operation fails and is subsequently aborted. This can
      be fired from within the data callback, in which case the device will be stopped. You should
      always have this log level enabled.
   }

    ma_log_level = (MA_LOG_LEVEL_DEBUG := 4,MA_LOG_LEVEL_INFO := 3,
      MA_LOG_LEVEL_WARNING := 2,MA_LOG_LEVEL_ERROR := 1
      );
  {
  Variables needing to be accessed atomically should be declared with this macro for two reasons:
  
      1) It allows people who read the code to identify a variable as such; and
      2) It forces alignment on platforms where it's required or optimal.
  
  Note that for x86/64, alignment is not strictly necessary, but does have some performance
  implications. Where supported by the compiler, alignment will be used, but otherwise if the CPU
  architecture does not require it, it will simply leave it unaligned. This is the case with old
  versions of Visual Studio, which I've confirmed with at least VC6.
   }

    ma_channel = ma_uint8;

    _ma_channel_position = (MA_CHANNEL_NONE := 0,MA_CHANNEL_MONO := 1,
      MA_CHANNEL_FRONT_LEFT := 2,MA_CHANNEL_FRONT_RIGHT := 3,
      MA_CHANNEL_FRONT_CENTER := 4,MA_CHANNEL_LFE := 5,
      MA_CHANNEL_BACK_LEFT := 6,MA_CHANNEL_BACK_RIGHT := 7,
      MA_CHANNEL_FRONT_LEFT_CENTER := 8,MA_CHANNEL_FRONT_RIGHT_CENTER := 9,
      MA_CHANNEL_BACK_CENTER := 10,MA_CHANNEL_SIDE_LEFT := 11,
      MA_CHANNEL_SIDE_RIGHT := 12,MA_CHANNEL_TOP_CENTER := 13,
      MA_CHANNEL_TOP_FRONT_LEFT := 14,MA_CHANNEL_TOP_FRONT_CENTER := 15,
      MA_CHANNEL_TOP_FRONT_RIGHT := 16,MA_CHANNEL_TOP_BACK_LEFT := 17,
      MA_CHANNEL_TOP_BACK_CENTER := 18,MA_CHANNEL_TOP_BACK_RIGHT := 19,
      MA_CHANNEL_AUX_0 := 20,MA_CHANNEL_AUX_1 := 21,
      MA_CHANNEL_AUX_2 := 22,MA_CHANNEL_AUX_3 := 23,
      MA_CHANNEL_AUX_4 := 24,MA_CHANNEL_AUX_5 := 25,
      MA_CHANNEL_AUX_6 := 26,MA_CHANNEL_AUX_7 := 27,
      MA_CHANNEL_AUX_8 := 28,MA_CHANNEL_AUX_9 := 29,
      MA_CHANNEL_AUX_10 := 30,MA_CHANNEL_AUX_11 := 31,
      MA_CHANNEL_AUX_12 := 32,MA_CHANNEL_AUX_13 := 33,
      MA_CHANNEL_AUX_14 := 34,MA_CHANNEL_AUX_15 := 35,
      MA_CHANNEL_AUX_16 := 36,MA_CHANNEL_AUX_17 := 37,
      MA_CHANNEL_AUX_18 := 38,MA_CHANNEL_AUX_19 := 39,
      MA_CHANNEL_AUX_20 := 40,MA_CHANNEL_AUX_21 := 41,
      MA_CHANNEL_AUX_22 := 42,MA_CHANNEL_AUX_23 := 43,
      MA_CHANNEL_AUX_24 := 44,MA_CHANNEL_AUX_25 := 45,
      MA_CHANNEL_AUX_26 := 46,MA_CHANNEL_AUX_27 := 47,
      MA_CHANNEL_AUX_28 := 48,MA_CHANNEL_AUX_29 := 49,
      MA_CHANNEL_AUX_30 := 50,MA_CHANNEL_AUX_31 := 51,
      MA_CHANNEL_LEFT := MA_CHANNEL_FRONT_LEFT,MA_CHANNEL_RIGHT := MA_CHANNEL_FRONT_RIGHT,
      MA_CHANNEL_POSITION_COUNT := 52);
  { Do not use `_ma_channel_position` directly. Use `ma_channel` instead.  }
  { A generic error.  }
  { General non-standard errors.  }
  { General miniaudio-specific errors.  }
  { State errors.  }
  { Operation errors.  }

    ma_result = (MA_SUCCESS := 0,MA_ERROR := -(1),MA_INVALID_ARGS := -(2),
      MA_INVALID_OPERATION := -(3),MA_OUT_OF_MEMORY := -(4),
      MA_OUT_OF_RANGE := -(5),MA_ACCESS_DENIED := -(6),
      MA_DOES_NOT_EXIST := -(7),MA_ALREADY_EXISTS := -(8),
      MA_TOO_MANY_OPEN_FILES := -(9),MA_INVALID_FILE := -(10),
      MA_TOO_BIG := -(11),MA_PATH_TOO_LONG := -(12),
      MA_NAME_TOO_LONG := -(13),MA_NOT_DIRECTORY := -(14),
      MA_IS_DIRECTORY := -(15),MA_DIRECTORY_NOT_EMPTY := -(16),
      MA_AT_END := -(17),MA_NO_SPACE := -(18),MA_BUSY := -(19),
      MA_IO_ERROR := -(20),MA_INTERRUPT := -(21),
      MA_UNAVAILABLE := -(22),MA_ALREADY_IN_USE := -(23),
      MA_BAD_ADDRESS := -(24),MA_BAD_SEEK := -(25),
      MA_BAD_PIPE := -(26),MA_DEADLOCK := -(27),MA_TOO_MANY_LINKS := -(28),
      MA_NOT_IMPLEMENTED := -(29),MA_NO_MESSAGE := -(30),
      MA_BAD_MESSAGE := -(31),MA_NO_DATA_AVAILABLE := -(32),
      MA_INVALID_DATA := -(33),MA_TIMEOUT := -(34),
      MA_NO_NETWORK := -(35),MA_NOT_UNIQUE := -(36),
      MA_NOT_SOCKET := -(37),MA_NO_ADDRESS := -(38),
      MA_BAD_PROTOCOL := -(39),MA_PROTOCOL_UNAVAILABLE := -(40),
      MA_PROTOCOL_NOT_SUPPORTED := -(41),MA_PROTOCOL_FAMILY_NOT_SUPPORTED := -(42),
      MA_ADDRESS_FAMILY_NOT_SUPPORTED := -(43),
      MA_SOCKET_NOT_SUPPORTED := -(44),MA_CONNECTION_RESET := -(45),
      MA_ALREADY_CONNECTED := -(46),MA_NOT_CONNECTED := -(47),
      MA_CONNECTION_REFUSED := -(48),MA_NO_HOST := -(49),
      MA_IN_PROGRESS := -(50),MA_CANCELLED := -(51),
      MA_MEMORY_ALREADY_MAPPED := -(52),MA_CRC_MISMATCH := -(100),
      MA_FORMAT_NOT_SUPPORTED := -(200),MA_DEVICE_TYPE_NOT_SUPPORTED := -(201),
      MA_SHARE_MODE_NOT_SUPPORTED := -(202),MA_NO_BACKEND := -(203),
      MA_NO_DEVICE := -(204),MA_API_NOT_FOUND := -(205),
      MA_INVALID_DEVICE_CONFIG := -(206),MA_LOOP := -(207),
      MA_BACKEND_NOT_ENABLED := -(208),MA_DEVICE_NOT_INITIALIZED := -(300),
      MA_DEVICE_ALREADY_INITIALIZED := -(301),
      MA_DEVICE_NOT_STARTED := -(302),MA_DEVICE_NOT_STOPPED := -(303),
      MA_FAILED_TO_INIT_BACKEND := -(400),MA_FAILED_TO_OPEN_BACKEND_DEVICE := -(401),
      MA_FAILED_TO_START_BACKEND_DEVICE := -(402),
      MA_FAILED_TO_STOP_BACKEND_DEVICE := -(403)
      );


    ma_stream_format = (ma_stream_format_pcm := 0);

    ma_stream_layout = (ma_stream_layout_interleaved := 0,ma_stream_layout_deinterleaved
      );

    ma_dither_mode = (ma_dither_mode_none := 0,ma_dither_mode_rectangle,
      ma_dither_mode_triangle);
  {
      I like to keep these explicitly defined because they're used as a key into a lookup table. When items are
      added to this, make sure there are no gaps and that they're added to the lookup table in ma_get_bytes_per_sample().
       }
  { Mainly used for indicating an error, but also used as the default for the output format for decoders.  }
  { Seems to be the most widely supported format.  }
  { Tightly packed. 3 bytes per sample.  }

    ma_format = (ma_format_unknown := 0,ma_format_u8 := 1,
      ma_format_s16 := 2,ma_format_s24 := 3,
      ma_format_s32 := 4,ma_format_f32 := 5,
      ma_format_count);
  { Standard rates need to be in priority order.  }
  { Most common  }
  { Lows  }
  { Highs  }
  { Extreme lows  }
  { Extreme highs  }
  { Need to maintain the count manually. Make sure this is updated if items are added to enum.  }

    ma_standard_sample_rate = (ma_standard_sample_rate_48000 := 48000,
      ma_standard_sample_rate_44100 := 44100,
      ma_standard_sample_rate_32000 := 32000,
      ma_standard_sample_rate_24000 := 24000,
      ma_standard_sample_rate_22050 := 22050,
      ma_standard_sample_rate_88200 := 88200,
      ma_standard_sample_rate_96000 := 96000,
      ma_standard_sample_rate_176400 := 176400,
      ma_standard_sample_rate_192000 := 192000,
      ma_standard_sample_rate_16000 := 16000,
      ma_standard_sample_rate_11025 := 11250,
      ma_standard_sample_rate_8000 := 8000,ma_standard_sample_rate_352800 := 352800,
      ma_standard_sample_rate_384000 := 384000,
      ma_standard_sample_rate_min := ma_standard_sample_rate_8000,ma_standard_sample_rate_max := ma_standard_sample_rate_384000,
      ma_standard_sample_rate_count := 14
      );
  { Simple averaging based on the plane(s) the channel is sitting on.  }
  { Drop excess channels; zeroed out extra channels.  }
  { Use custom weights specified in ma_channel_converter_config.  }

    ma_channel_mix_mode = (ma_channel_mix_mode_rectangular := 0,
      ma_channel_mix_mode_simple,ma_channel_mix_mode_custom_weights,
      ma_channel_mix_mode_default := ma_channel_mix_mode_rectangular);
  { Based off AIFF.  }
  { FreeBSD's sound(4).  }
  { www.sndio.org/tips.html  }
  { https://webaudio.github.io/web-audio-api/#ChannelOrdering. Only 1, 2, 4 and 6 channels are defined, but can fill in the gaps with logical assumptions.  }

    ma_standard_channel_map = (ma_standard_channel_map_microsoft,ma_standard_channel_map_alsa,
      ma_standard_channel_map_rfc3551,ma_standard_channel_map_flac,
      ma_standard_channel_map_vorbis,ma_standard_channel_map_sound4,
      ma_standard_channel_map_sndio,ma_standard_channel_map_webaudio := ma_standard_channel_map_flac,
      ma_standard_channel_map_default := ma_standard_channel_map_microsoft
      );

    ma_performance_profile = (ma_performance_profile_low_latency := 0,
      ma_performance_profile_conservative
      );

    ma_allocation_callbacks = record
        pUserData : pointer;
        onMalloc : function (sz:size_t; pUserData:pointer):pointer;cdecl;
        onRealloc : function (p:pointer; sz:size_t; pUserData:pointer):pointer;cdecl;
        onFree : procedure (p:pointer; pUserData:pointer);cdecl;
      end;

    ma_lcg = record
        state : ma_int32;
      end;
  {
  Atomics.
  
  These are typesafe structures to prevent errors as a result of forgetting to reference variables atomically. It's too
  easy to introduce subtle bugs where you accidentally do a regular assignment instead of an atomic load/store, etc. By
  using a struct we can enforce the use of atomics at compile time.
  
  These types are declared in the header section because we need to reference them in structs below, but functions for
  using them are only exposed in the implementation section. I do not want these to be part of the public API.
  
  There's a few downsides to this system. The first is that you need to declare a new struct for each type. Below are
  some macros to help with the declarations. They will be named like so:
  
      ma_atomic_uint32 - atomic ma_uint32
      ma_atomic_int32  - atomic ma_int32
      ma_atomic_uint64 - atomic ma_uint64
      ma_atomic_float  - atomic float
      ma_atomic_bool32 - atomic ma_bool32
  
  The other downside is that atomic pointers are extremely messy. You need to declare a new struct for each specific
  type of pointer you need to make atomic. For example, an atomic ma_node* will look like this:
  
      MA_ATOMIC_SAFE_TYPE_IMPL_PTR(node)
  
  Which will declare a type struct that's named like so:
  
      ma_atomic_ptr_node
  
  Functions to use the atomic types are declared in the implementation section. All atomic functions are prefixed with
  the name of the struct. For example:
  
      ma_atomic_uint32_set() - Atomic store of ma_uint32
      ma_atomic_uint32_get() - Atomic load of ma_uint32
      etc.
  
  For pointer types it's the same, which makes them a bit messy to use due to the length of each function name, but in
  return you get type safety and enforcement of atomic operations.
   }
  {_Alignas(4) }
    ma_atomic_uint32 = record
        value : ma_uint32;
      end;
  {_Alignas(4) }
    ma_atomic_int32 = record
        value : ma_int32;
      end;
  {_Alignas(8) }
    ma_atomic_uint64 = record
        value : ma_uint64;
      end;
  {_Alignas(4) }
    ma_atomic_float = record
        value : ma_float;
      end;
  {_Alignas(4) }
    ma_atomic_bool32 = record
        value : ma_bool32;
      end;
  { Spinlocks are 32-bit for compatibility reasons.  }

    ma_spinlock = ma_uint32;
{$ifndef MA_NO_THREADING}
  { Thread priorities should be ordered such that the default priority of the worker thread is 0.  }

    ma_thread_priority = (ma_thread_priority_idle := -(5),ma_thread_priority_lowest := -(4),
      ma_thread_priority_low := -(3),ma_thread_priority_normal := -(2),
      ma_thread_priority_high := -(1),ma_thread_priority_highest := 0,
      ma_thread_priority_realtime := 1,ma_thread_priority_default := 0
      );
{$if defined(MA_POSIX)}

    ma_thread = ma_pthread_t;
(*** was #elif ****){$else defined(MA_WIN32)}

    ma_thread = ma_handle;
{$endif}
{$if defined(MA_POSIX)}

    ma_mutex = ma_pthread_mutex_t;
(*** was #elif ****){$else defined(MA_WIN32)}

    ma_mutex = ma_handle;
{$endif}
{$if defined(MA_POSIX)}

    ma_event = record
        value : ma_uint32;
        lock : ma_pthread_mutex_t;
        cond : ma_pthread_cond_t;
      end;
(*** was #elif ****){$else defined(MA_WIN32)}

    ma_event = ma_handle;
{$endif}
{$if defined(MA_POSIX)}

    ma_semaphore = record
        value : longint;
        lock : ma_pthread_mutex_t;
        cond : ma_pthread_cond_t;
      end;
(*** was #elif ****){$else defined(MA_WIN32)}

    ma_semaphore = ma_handle;
{$endif}
{$else}
  { MA_NO_THREADING is set which means threading is disabled. Threading is required by some API families. If any of these are enabled we need to throw an error.  }
{$endif}
  { MA_NO_THREADING  }
  {
  Retrieves the version of miniaudio as separated integers. Each component can be NULL if it's not required.
   }


  {
  Retrieves the version of miniaudio as a string which can be useful for logging purposes.
   }
(* Const before type ignored *)

  {*************************************************************************************************************************************************************
  
  Logging
  
  ************************************************************************************************************************************************************* }
  {#include <stdarg.h> /* For va_list. */ }
  {
  The callback for handling log messages.
  
  
  Parameters
  ----------
  pUserData (in)
      The user data pointer that was passed into ma_log_register_callback().
  
  logLevel (in)
      The log level. This can be one of the following:
  
      +----------------------+
      | Log Level            |
      +----------------------+
      | MA_LOG_LEVEL_DEBUG   |
      | MA_LOG_LEVEL_INFO    |
      | MA_LOG_LEVEL_WARNING |
      | MA_LOG_LEVEL_ERROR   |
      +----------------------+
  
  pMessage (in)
      The log message.
   }
(* Const before type ignored *)

    ma_log_callback_proc = procedure (pUserData:pointer; level:ma_uint32; pMessage:Pchar);cdecl;

    ma_log_callback = record
        onLog : ma_log_callback_proc;
        pUserData : pointer;
      end;


  { Need to store these persistently because ma_log_postv() might need to allocate a buffer on the heap.  }

    ma_log = record
        callbacks : array[0..(MA_MAX_LOG_CALLBACKS)-1] of ma_log_callback;
        callbackCount : ma_uint32;
        allocationCallbacks : ma_allocation_callbacks;
        lock : ma_mutex;
      end;
(* Const before type ignored *)

  {extern ma_result ma_log_postf(ma_log* pLog, ma_uint32 level, const char* pFormat, ...) MA_ATTRIBUTE_FORMAT(3, 4); }
  {*************************************************************************************************************************************************************
  
  Biquad Filtering
  
  ************************************************************************************************************************************************************* }

    ma_biquad_coefficient = record
        case longint of
          0 : ( f32 : single );
          1 : ( s32 : ma_int32 );
        end;

    ma_biquad_config = record
        format : ma_format;
        channels : ma_uint32;
        b0 : double;
        b1 : double;
        b2 : double;
        a0 : double;
        a1 : double;
        a2 : double;
      end;


  { Memory management.  }

    ma_biquad = record
        format : ma_format;
        channels : ma_uint32;
        b0 : ma_biquad_coefficient;
        b1 : ma_biquad_coefficient;
        b2 : ma_biquad_coefficient;
        a1 : ma_biquad_coefficient;
        a2 : ma_biquad_coefficient;
        pR1 : ^ma_biquad_coefficient;
        pR2 : ^ma_biquad_coefficient;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)


  {*************************************************************************************************************************************************************
  
  Low-Pass Filtering
  
  ************************************************************************************************************************************************************* }

    ma_lpf1_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        cutoffFrequency : double;
        q : double;
      end;
    ma_lpf2_config = ma_lpf1_config;

  { Memory management.  }

    ma_lpf1 = record
        format : ma_format;
        channels : ma_uint32;
        a : ma_biquad_coefficient;
        pR1 : ^ma_biquad_coefficient;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)


    ma_lpf2 = record
        bq : ma_biquad;
      end;
(* Const before type ignored *)


    ma_lpf_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        cutoffFrequency : double;
        order : ma_uint32;
      end;

  { Memory management.  }

    ma_lpf = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        lpf1Count : ma_uint32;
        lpf2Count : ma_uint32;
        pLPF1 : ^ma_lpf1;
        pLPF2 : ^ma_lpf2;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)


  {*************************************************************************************************************************************************************
  
  High-Pass Filtering
  
  ************************************************************************************************************************************************************* }

    ma_hpf1_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        cutoffFrequency : double;
        q : double;
      end;
    ma_hpf2_config = ma_hpf1_config;

  { Memory management.  }

    ma_hpf1 = record
        format : ma_format;
        channels : ma_uint32;
        a : ma_biquad_coefficient;
        pR1 : ^ma_biquad_coefficient;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)


    ma_hpf2 = record
        bq : ma_biquad;
      end;
(* Const before type ignored *)


    ma_hpf_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        cutoffFrequency : double;
        order : ma_uint32;
      end;

  { Memory management.  }

    ma_hpf = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        hpf1Count : ma_uint32;
        hpf2Count : ma_uint32;
        pHPF1 : ^ma_hpf1;
        pHPF2 : ^ma_hpf2;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)


  {*************************************************************************************************************************************************************
  
  Band-Pass Filtering
  
  ************************************************************************************************************************************************************* }

    ma_bpf2_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        cutoffFrequency : double;
        q : double;
      end;

  { The second order band-pass filter is implemented as a biquad filter.  }

    ma_bpf2 = record
        bq : ma_biquad;
      end;
(* Const before type ignored *)


    ma_bpf_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        cutoffFrequency : double;
        order : ma_uint32;
      end;

  { Memory management.  }

    ma_bpf = record
        format : ma_format;
        channels : ma_uint32;
        bpf2Count : ma_uint32;
        pBPF2 : ^ma_bpf2;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)

  {*************************************************************************************************************************************************************
  
  Notching Filter
  
  ************************************************************************************************************************************************************* }

    ma_notch2_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        q : double;
        frequency : double;
      end;
    ma_notch_config = ma_notch2_config;


    ma_notch2 = record
        bq : ma_biquad;
      end;
(* Const before type ignored *)


  {*************************************************************************************************************************************************************
  
  Peaking EQ Filter
  
  ************************************************************************************************************************************************************* }

    ma_peak2_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        gainDB : double;
        q : double;
        frequency : double;
      end;
    ma_peak_config = ma_peak2_config;


    ma_peak2 = record
        bq : ma_biquad;
      end;
(* Const before type ignored *)

  {*************************************************************************************************************************************************************
  
  Low Shelf Filter
  
  ************************************************************************************************************************************************************* }

    ma_loshelf2_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        gainDB : double;
        shelfSlope : double;
        frequency : double;
      end;
    ma_loshelf_config = ma_loshelf2_config;


    ma_loshelf2 = record
        bq : ma_biquad;
      end;
(* Const before type ignored *)


  {*************************************************************************************************************************************************************
  
  High Shelf Filter
  
  ************************************************************************************************************************************************************* }

    ma_hishelf2_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        gainDB : double;
        shelfSlope : double;
        frequency : double;
      end;
    ma_hishelf_config = ma_hishelf2_config;


    ma_hishelf2 = record
        bq : ma_biquad;
      end;
(* Const before type ignored *)

    ma_delay_config = record
        channels : ma_uint32;
        sampleRate : ma_uint32;
        delayInFrames : ma_uint32;
        delayStart : ma_bool32;
        wet : single;
        dry : single;
        decay : single;
      end;

  { Feedback is written to this cursor. Always equal or in front of the read cursor.  }

    ma_delay = record
        config : ma_delay_config;
        cursor : ma_uint32;
        bufferSizeInFrames : ma_uint32;
        pBuffer : ^single;
      end;
(* Const before type ignored *)
(* Const before type ignored *)


    ma_gainer_config = record
        channels : ma_uint32;
        smoothTimeInFrames : ma_uint32;
      end;

  { Memory management.  }

    ma_gainer = record
        config : ma_gainer_config;
        t : ma_uint32;
        masterVolume : single;
        pOldGains : ^single;
        pNewGains : ^single;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)

    ma_pan_mode = (ma_pan_mode_balance := 0,ma_pan_mode_pan
      );

    ma_panner_config = record
        format : ma_format;
        channels : ma_uint32;
        mode : ma_pan_mode;
        pan : single;
      end;

  { -1..1 where 0 is no pan, -1 is left side, +1 is right side. Defaults to 0.  }

    ma_panner = record
        format : ma_format;
        channels : ma_uint32;
        mode : ma_pan_mode;
        pan : single;
      end;
(* Const before type ignored *)


  { Fader.  }

    ma_fader_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
      end;


  { If volumeBeg and volumeEnd is equal to 1, no fading happens (ma_fader_process_pcm_frames() will run as a passthrough).  }
  { The total length of the fade.  }
  { The current time in frames. Incremented by ma_fader_process_pcm_frames(). Signed because it'll be offset by startOffsetInFrames in set_fade_ex().  }

    ma_fader = record
        config : ma_fader_config;
        volumeBeg : single;
        volumeEnd : single;
        lengthInFrames : ma_uint64;
        cursorInFrames : ma_int64;
      end;
(* Const before type ignored *)

  { Spatializer.  }

    ma_vec3f = record
        x : single;
        y : single;
        z : single;
      end;

    ma_atomic_vec3f = record
        v : ma_vec3f;
        lock : ma_spinlock;
      end;
  { No distance attenuation and no spatialization.  }
  { Equivalent to OpenAL's AL_INVERSE_DISTANCE_CLAMPED.  }
  { Linear attenuation. Equivalent to OpenAL's AL_LINEAR_DISTANCE_CLAMPED.  }
  { Exponential attenuation. Equivalent to OpenAL's AL_EXPONENT_DISTANCE_CLAMPED.  }

    ma_attenuation_model = (ma_attenuation_model_none,ma_attenuation_model_inverse,
      ma_attenuation_model_linear,ma_attenuation_model_exponential
      );

    ma_positioning = (ma_positioning_absolute,ma_positioning_relative
      );

    ma_handedness = (ma_handedness_right,ma_handedness_left
      );
  { Defaults to right. Forward is -1 on the Z axis. In a left handed system, forward is +1 on the Z axis.  }

    ma_spatializer_listener_config = record
        channelsOut : ma_uint32;
        pChannelMapOut : ^ma_channel;
        handedness : ma_handedness;
        coneInnerAngleInRadians : single;
        coneOuterAngleInRadians : single;
        coneOuterGain : single;
        speedOfSound : single;
        worldUp : ma_vec3f;
      end;


  { The absolute position of the listener.  }
  { The direction the listener is facing. The world up vector is config.worldUp.  }
  { Memory management.  }

    ma_spatializer_listener = record
        config : ma_spatializer_listener_config;
        position : ma_atomic_vec3f;
        direction : ma_atomic_vec3f;
        velocity : ma_atomic_vec3f;
        isEnabled : ma_bool32;
        _ownsHeap : ma_bool32;
        _pHeap : pointer;
      end;
(* Const before type ignored *)


  { Defaults to right. Forward is -1 on the Z axis. In a left handed system, forward is +1 on the Z axis.  }
  { Set to 0 to disable doppler effect.  }
  { Set to 0 to disable directional attenuation.  }
  { The minimal scaling factor to apply to channel gains when accounting for the direction of the sound relative to the listener. Must be in the range of 0..1. Smaller values means more aggressive directional panning, larger values means more subtle directional panning.  }
  { When the gain of a channel changes during spatialization, the transition will be linearly interpolated over this number of frames.  }

    ma_spatializer_config = record
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        pChannelMapIn : ^ma_channel;
        attenuationModel : ma_attenuation_model;
        positioning : ma_positioning;
        handedness : ma_handedness;
        minGain : single;
        maxGain : single;
        minDistance : single;
        maxDistance : single;
        rolloff : single;
        coneInnerAngleInRadians : single;
        coneOuterAngleInRadians : single;
        coneOuterGain : single;
        dopplerFactor : single;
        directionalAttenuationFactor : single;
        minSpatializationChannelGain : single;
        gainSmoothTimeInFrames : ma_uint32;
      end;


  { Defaults to right. Forward is -1 on the Z axis. In a left handed system, forward is +1 on the Z axis.  }
  { Set to 0 to disable doppler effect.  }
  { Set to 0 to disable directional attenuation.  }
  { When the gain of a channel changes during spatialization, the transition will be linearly interpolated over this number of frames.  }
  { For doppler effect.  }
  { Will be updated by ma_spatializer_process_pcm_frames() and can be used by higher level functions to apply a pitch shift for doppler effect.  }
  { For smooth gain transitions.  }
  { An offset of _pHeap. Used by ma_spatializer_process_pcm_frames() to store new channel gains. The number of elements in this array is equal to config.channelsOut.  }
  { Memory management.  }

    ma_spatializer = record
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        pChannelMapIn : ^ma_channel;
        attenuationModel : ma_attenuation_model;
        positioning : ma_positioning;
        handedness : ma_handedness;
        minGain : single;
        maxGain : single;
        minDistance : single;
        maxDistance : single;
        rolloff : single;
        coneInnerAngleInRadians : single;
        coneOuterAngleInRadians : single;
        coneOuterGain : single;
        dopplerFactor : single;
        directionalAttenuationFactor : single;
        gainSmoothTimeInFrames : ma_uint32;
        position : ma_atomic_vec3f;
        direction : ma_atomic_vec3f;
        velocity : ma_atomic_vec3f;
        dopplerPitch : single;
        minSpatializationChannelGain : single;
        gainer : ma_gainer;
        pNewChannelGainsOut : ^single;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)

  {***********************************************************************************************************************************************************
  *************************************************************************************************************************************************************
  
  DATA CONVERSION
  ===============
  
  This section contains the APIs for data conversion. You will find everything here for channel mapping, sample format conversion, resampling, etc.
  
  *************************************************************************************************************************************************************
  *********************************************************************************************************************************************************** }
  {*************************************************************************************************************************************************************
  
  Resampling
  
  ************************************************************************************************************************************************************* }
  { The low-pass filter order. Setting this to 0 will disable low-pass filtering.  }
  { 0..1. Defaults to 1. 1 = Half the sampling frequency (Nyquist Frequency), 0.5 = Quarter the sampling frequency (half Nyquest Frequency), etc.  }

    ma_linear_resampler_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRateIn : ma_uint32;
        sampleRateOut : ma_uint32;
        lpfOrder : ma_uint32;
        lpfNyquistFactor : double;
      end;

  { The previous input frame.  }
  { The next input frame.  }
  { Memory management.  }

    ma_linear_resampler = record
        config : ma_linear_resampler_config;
        inAdvanceInt : ma_uint32;
        inAdvanceFrac : ma_uint32;
        inTimeInt : ma_uint32;
        inTimeFrac : ma_uint32;
        x0 : record
            case longint of
              0 : ( f32 : ^single );
              1 : ( s16 : ^ma_int16 );
            end;
        x1 : record
            case longint of
              0 : ( f32 : ^single );
              1 : ( s16 : ^ma_int16 );
            end;
        lpf : ma_lpf;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)


    ma_resampling_backend = pointer;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
  { Optional. Rate changes will be disabled.  }
(* Const before type ignored *)
  { Optional. Latency will be reported as 0.  }
(* Const before type ignored *)
  { Optional. Latency will be reported as 0.  }
(* Const before type ignored *)
  { Optional. Latency mitigation will be disabled.  }
(* Const before type ignored *)
  { Optional. Latency mitigation will be disabled.  }

    ma_resampling_backend_vtable = record
        onGetHeapSize : function (pUserData:pointer; pConfig:Pma_resampler_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl;
        onInit : function (pUserData:pointer; pConfig:Pma_resampler_config; pHeap:pointer; ppBackend:PPma_resampling_backend):ma_result;cdecl;
        onUninit : procedure (pUserData:pointer; pBackend:Pma_resampling_backend; pAllocationCallbacks:Pma_allocation_callbacks);cdecl;
        onProcess : function (pUserData:pointer; pBackend:Pma_resampling_backend; pFramesIn:pointer; pFrameCountIn:Pma_uint64; pFramesOut:pointer; 
                     pFrameCountOut:Pma_uint64):ma_result;cdecl;
        onSetRate : function (pUserData:pointer; pBackend:Pma_resampling_backend; sampleRateIn:ma_uint32; sampleRateOut:ma_uint32):ma_result;cdecl;
        onGetInputLatency : function (pUserData:pointer; pBackend:Pma_resampling_backend):ma_uint64;cdecl;
        onGetOutputLatency : function (pUserData:pointer; pBackend:Pma_resampling_backend):ma_uint64;cdecl;
        onGetRequiredInputFrameCount : function (pUserData:pointer; pBackend:Pma_resampling_backend; outputFrameCount:ma_uint64; pInputFrameCount:Pma_uint64):ma_result;cdecl;
        onGetExpectedOutputFrameCount : function (pUserData:pointer; pBackend:Pma_resampling_backend; inputFrameCount:ma_uint64; pOutputFrameCount:Pma_uint64):ma_result;cdecl;
        onReset : function (pUserData:pointer; pBackend:Pma_resampling_backend):ma_result;cdecl;
      end;
  { Fastest, lowest quality. Optional low-pass filtering. Default.  }

    ma_resample_algorithm = (ma_resample_algorithm_linear := 0,ma_resample_algorithm_custom
      );
  { Must be either ma_format_f32 or ma_format_s16.  }
  { When set to ma_resample_algorithm_custom, pBackendVTable will be used.  }
    ma_resampler_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRateIn : ma_uint32;
        sampleRateOut : ma_uint32;
        algorithm : ma_resample_algorithm;
        pBackendVTable : ^ma_resampling_backend_vtable;
        pBackendUserData : pointer;
        linear : record
            lpfOrder : ma_uint32;
          end;
      end;


  { State for stock resamplers so we can avoid a malloc. For stock resamplers, pBackend will point here.  }
  { Memory management.  }

    ma_resampler = record
        pBackend : ^ma_resampling_backend;
        pBackendVTable : ^ma_resampling_backend_vtable;
        pBackendUserData : pointer;
        format : ma_format;
        channels : ma_uint32;
        sampleRateIn : ma_uint32;
        sampleRateOut : ma_uint32;
        state : record
            case longint of
              0 : ( linear : ma_linear_resampler );
            end;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)

  {
  Initializes a new resampler object from a config.
   }
(* Const before type ignored *)
(* Const before type ignored *)
  {
  Converts the given input data.
  
  Both the input and output frames must be in the format specified in the config when the resampler was initilized.
  
  On input, [pFrameCountOut] contains the number of output frames to process. On output it contains the number of output frames that
  were actually processed, which may be less than the requested amount which will happen if there's not enough input data. You can use
  ma_resampler_get_expected_output_frame_count() to know how many output frames will be processed for a given number of input frames.
  
  On input, [pFrameCountIn] contains the number of input frames contained in [pFramesIn]. On output it contains the number of whole
  input frames that were actually processed. You can use ma_resampler_get_required_input_frame_count() to know how many input frames
  you should provide for a given number of output frames. [pFramesIn] can be NULL, in which case zeroes will be used instead.
  
  If [pFramesOut] is NULL, a seek is performed. In this case, if [pFrameCountOut] is not NULL it will seek by the specified number of
  output frames. Otherwise, if [pFramesCountOut] is NULL and [pFrameCountIn] is not NULL, it will seek by the specified number of input
  frames. When seeking, [pFramesIn] is allowed to NULL, in which case the internal timing state will be updated, but no input will be
  processed. In this case, any internal filter state will be updated as if zeroes were passed in.
  
  It is an error for [pFramesOut] to be non-NULL and [pFrameCountOut] to be NULL.
  
  It is an error for both [pFrameCountOut] and [pFrameCountIn] to be NULL.
   }
(* Const before type ignored *)
  {*************************************************************************************************************************************************************
  
  Channel Conversion
  
  ************************************************************************************************************************************************************* }
  { Converting to mono.  }
  { Converting from mono.  }
  { Simple shuffle. Will use this when all channels are present in both input and output channel maps, but just in a different order.  }
  { Blended based on weights.  }

    ma_channel_conversion_path = (ma_channel_conversion_path_unknown,ma_channel_conversion_path_passthrough,
      ma_channel_conversion_path_mono_out,
      ma_channel_conversion_path_mono_in,ma_channel_conversion_path_shuffle,
      ma_channel_conversion_path_weights);
  { The default.  }
  { Average the mono channel across all channels.  }
  { Duplicate to the left and right channels only and ignore the others.  }

    ma_mono_expansion_mode = (ma_mono_expansion_mode_duplicate := 0,
      ma_mono_expansion_mode_average,ma_mono_expansion_mode_stereo_only,
      ma_mono_expansion_mode_default := ma_mono_expansion_mode_duplicate
      );
(* Const before type ignored *)
(* Const before type ignored *)
  { When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present.  }
  { [in][out]. Only used when mixingMode is set to ma_channel_mix_mode_custom_weights.  }

    ma_channel_converter_config = record
        format : ma_format;
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        pChannelMapIn : ^ma_channel;
        pChannelMapOut : ^ma_channel;
        mixingMode : ma_channel_mix_mode;
        calculateLFEFromSpatialChannels : ma_bool32;
        ppWeights : PPsingle;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  { Indexed by output channel index.  }
  { [in][out]  }
  { Memory management.  }

    ma_channel_converter = record
        format : ma_format;
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        mixingMode : ma_channel_mix_mode;
        conversionPath : ma_channel_conversion_path;
        pChannelMapIn : ^ma_channel;
        pChannelMapOut : ^ma_channel;
        pShuffleTable : ^ma_uint8;
        weights : record
            case longint of
              0 : ( f32 : PPsingle );
              1 : ( s16 : PPma_int32 );
            end;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)

  {*************************************************************************************************************************************************************
  
  Data Conversion
  
  ************************************************************************************************************************************************************* }
  { When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present.  }
  { [in][out]. Only used when mixingMode is set to ma_channel_mix_mode_custom_weights.  }

    ma_data_converter_config = record
        formatIn : ma_format;
        formatOut : ma_format;
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        sampleRateIn : ma_uint32;
        sampleRateOut : ma_uint32;
        pChannelMapIn : ^ma_channel;
        pChannelMapOut : ^ma_channel;
        ditherMode : ma_dither_mode;
        channelMixMode : ma_channel_mix_mode;
        calculateLFEFromSpatialChannels : ma_bool32;
        ppChannelWeights : PPsingle;
        allowDynamicSampleRate : ma_bool32;
        resampling : ma_resampler_config;
      end;

  { No conversion.  }
  { Only format conversion.  }
  { Only channel conversion.  }
  { Only resampling.  }
  { All conversions, but resample as the first step.  }
  { All conversions, but channels as the first step.  }

    ma_data_converter_execution_path = (ma_data_converter_execution_path_passthrough,
      ma_data_converter_execution_path_format_only,
      ma_data_converter_execution_path_channels_only,
      ma_data_converter_execution_path_resample_only,
      ma_data_converter_execution_path_resample_first,
      ma_data_converter_execution_path_channels_first
      );
  { The execution path the data converter will follow when processing.  }
  { Memory management.  }

    ma_data_converter = record
        formatIn : ma_format;
        formatOut : ma_format;
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        sampleRateIn : ma_uint32;
        sampleRateOut : ma_uint32;
        ditherMode : ma_dither_mode;
        executionPath : ma_data_converter_execution_path;
        channelConverter : ma_channel_converter;
        resampler : ma_resampler;
        hasPreFormatConversion : ma_bool8;
        hasPostFormatConversion : ma_bool8;
        hasChannelConverter : ma_bool8;
        hasResampler : ma_bool8;
        isPassthrough : ma_bool8;
        _ownsHeap : ma_bool8;
        _pHeap : pointer;
      end;
(* Const before type ignored *)


  {***********************************************************************************************************************************************************
  
  Channel Maps
  
  *********************************************************************************************************************************************************** }
  {
  This is used in the shuffle table to indicate that the channel index is undefined and should be ignored.
   }
    ma_data_source = pointer;

    ma_data_source_vtable = record
        onRead : function (pDataSource:Pma_data_source; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl;
        onSeek : function (pDataSource:Pma_data_source; frameIndex:ma_uint64):ma_result;cdecl;
        onGetDataFormat : function (pDataSource:Pma_data_source; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel; 
                     channelMapCap:size_t):ma_result;cdecl;
        onGetCursor : function (pDataSource:Pma_data_source; pCursor:Pma_uint64):ma_result;cdecl;
        onGetLength : function (pDataSource:Pma_data_source; pLength:Pma_uint64):ma_result;cdecl;
        onSetLooping : function (pDataSource:Pma_data_source; isLooping:ma_bool32):ma_result;cdecl;
        flags : ma_uint32;
      end;

    ma_data_source_get_next_proc = function (pDataSource:Pma_data_source):Pma_data_source;cdecl;
(* Const before type ignored *)

    ma_data_source_config = record
        vtable : ^ma_data_source_vtable;
      end;


(* Const before type ignored *)
  { Set to -1 for unranged (default).  }
  { Relative to rangeBegInFrames.  }
  { Relative to rangeBegInFrames. Set to -1 for the end of the range.  }
  { When non-NULL, the data source being initialized will act as a proxy and will route all operations to pCurrent. Used in conjunction with pNext/onGetNext for seamless chaining.  }
  { When set to NULL, onGetNext will be used.  }
  { Will be used when pNext is NULL. If both are NULL, no next will be used.  }
  {_Alignas(4) }
    ma_data_source_base = record
        vtable : ^ma_data_source_vtable;
        rangeBegInFrames : ma_uint64;
        rangeEndInFrames : ma_uint64;
        loopBegInFrames : ma_uint64;
        loopEndInFrames : ma_uint64;
        pCurrent : ^ma_data_source;
        pNext : ^ma_data_source;
        onGetNext : ma_data_source_get_next_proc;
        isLooping : ma_bool32;
      end;
(* Const before type ignored *)


    ma_audio_buffer_ref = record
        ds : ma_data_source_base;
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        cursor : ma_uint64;
        sizeInFrames : ma_uint64;
        pData : pointer;
      end;
(* Const before type ignored *)

(* Const before type ignored *)
  { If set to NULL, will allocate a block of memory for you.  }

    ma_audio_buffer_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        sizeInFrames : ma_uint64;
        pData : pointer;
        allocationCallbacks : ma_allocation_callbacks;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  { Used to control whether or not miniaudio owns the data buffer. If set to true, pData will be freed in ma_audio_buffer_uninit().  }
  { For allocating a buffer with the memory located directly after the other memory of the structure.  }

    ma_audio_buffer = record
        ref : ma_audio_buffer_ref;
        allocationCallbacks : ma_allocation_callbacks;
        ownsData : ma_bool32;
        _pExtraData : array[0..0] of ma_uint8;
      end;
(* Const before type ignored *)


  {
  Paged Audio Buffer
  ==================
  A paged audio buffer is made up of a linked list of pages. It's expandable, but not shrinkable. It
  can be used for cases where audio data is streamed in asynchronously while allowing data to be read
  at the same time.
  
  This is lock-free, but not 100% thread safe. You can append a page and read from the buffer across
  simultaneously across different threads, however only one thread at a time can append, and only one
  thread at a time can read and seek.
   }

  {_Alignas(MA_SIZEOF_PTR) }    ma_paged_audio_buffer_page = record
        pNext : ^ma_paged_audio_buffer_page;
        sizeInFrames : ma_uint64;
        pAudioData : array[0..0] of ma_uint8;
      end;

  { Dummy head for the lock-free algorithm. Always has a size of 0.  }
  {_Alignas(MA_SIZEOF_PTR) }  { Never null. Initially set to &head.  }

    ma_paged_audio_buffer_data = record
        format : ma_format;
        channels : ma_uint32;
        head : ma_paged_audio_buffer_page;
        pTail : ^ma_paged_audio_buffer_page;
      end;

(* Const before type ignored *)
(* Const before type ignored *)
  { Must not be null.  }

    ma_paged_audio_buffer_config = record
        pData : ^ma_paged_audio_buffer_data;
      end;


  { Audio data is read from here. Cannot be null.  }
  { Relative to the current page.  }

    ma_paged_audio_buffer = record
        ds : ma_data_source_base;
        pData : ^ma_paged_audio_buffer_data;
        pCurrent : ^ma_paged_audio_buffer_page;
        relativeCursor : ma_uint64;
        absoluteCursor : ma_uint64;
      end;
(* Const before type ignored *)

  {***********************************************************************************************************************************************************
  
  Ring Buffer
  
  *********************************************************************************************************************************************************** }
  {_Alignas(4) }  { Most significant bit is the loop flag. Lower 31 bits contains the actual offset in bytes. Must be used atomically.  }
  {_Alignas(4) }  { Most significant bit is the loop flag. Lower 31 bits contains the actual offset in bytes. Must be used atomically.  }
  { Used to know whether or not miniaudio is responsible for free()-ing the buffer.  }
  { When set, clears the acquired write buffer before returning from ma_rb_acquire_write().  }

    ma_rb = record
        pBuffer : pointer;
        subbufferSizeInBytes : ma_uint32;
        subbufferCount : ma_uint32;
        subbufferStrideInBytes : ma_uint32;
        encodedReadOffset : ma_uint32;
        encodedWriteOffset : ma_uint32;
        ownsBuffer : ma_bool8;
        clearOnWriteAcquire : ma_bool8;
        allocationCallbacks : ma_allocation_callbacks;
      end;
(* Const before type ignored *)

  { Not required for the ring buffer itself, but useful for associating the data with some sample rate, particularly for data sources.  }

    ma_pcm_rb = record
        ds : ma_data_source_base;
        rb : ma_rb;
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
      end;
(* Const before type ignored *)


  {
  The idea of the duplex ring buffer is to act as the intermediary buffer when running two asynchronous devices in a duplex set up. The
  capture device writes to it, and then a playback device reads from it.
  
  At the moment this is just a simple naive implementation, but in the future I want to implement some dynamic resampling to seamlessly
  handle desyncs. Note that the API is work in progress and may change at any time in any version.
  
  The size of the buffer is based on the capture side since that's what'll be written to the buffer. It is based on the capture period size
  in frames. The internal sample rate of the capture device is also needed in order to calculate the size.
   }

    ma_duplex_rb = record
        rb : ma_pcm_rb;
      end;
(* Const before type ignored *)

    ma_fence = record
        e : ma_event;
        counter : ma_uint32;
      end;


    ma_async_notification = pointer;

    ma_async_notification_callbacks = record
        onSignal : procedure (pNotification:Pma_async_notification);cdecl;
      end;


  {
  Simple polling notification.
  
  This just sets a variable when the notification has been signalled which is then polled with ma_async_notification_poll_is_signalled()
   }

    ma_async_notification_poll = record
        cb : ma_async_notification_callbacks;
        signalled : ma_bool32;
      end;


  {
  Event Notification
  
  This uses an ma_event. If threading is disabled (MA_NO_THREADING), initialization will fail.
   }

    ma_async_notification_event = record
        cb : ma_async_notification_callbacks;
        e : ma_event;
      end;

  {***********************************************************************************************************************************************************
  
  Job Queue
  
  *********************************************************************************************************************************************************** }
  {
  Slot Allocator
  --------------
  The idea of the slot allocator is for it to be used in conjunction with a fixed sized buffer. You use the slot allocator to allocator an index that can be used
  as the insertion point for an object.
  
  Slots are reference counted to help mitigate the ABA problem in the lock-free queue we use for tracking jobs.
  
  The slot index is stored in the low 32 bits. The reference counter is stored in the high 32 bits:
  
      +-----------------+-----------------+
      | 32 Bits         | 32 Bits         |
      +-----------------+-----------------+
      | Reference Count | Slot Index      |
      +-----------------+-----------------+
   }
  { The number of slots to make available.  }

    ma_slot_allocator_config = record
        capacity : ma_uint32;
      end;


  {_Alignas(4) }  { Must be used atomically because the allocation and freeing routines need to make copies of this which must never be optimized away by the compiler.  }

    ma_slot_allocator_group = record
        bitfield : ma_uint32;
      end;
  { Slots are grouped in chunks of 32.  }
  { 32 bits for reference counting for ABA mitigation.  }
  { Allocation count.  }
  { Memory management.  }

    ma_slot_allocator = record
        pGroups : ^ma_slot_allocator_group;
        pSlots : ^ma_uint32;
        count : ma_uint32;
        capacity : ma_uint32;
        _ownsHeap : ma_bool32;
        _pHeap : pointer;
      end;
(* Const before type ignored *)


  {
  Callback for processing a job. Each job type will have their own processing callback which will be
  called by ma_job_process().
   }

    ma_job_proc = function (pJob:Pma_job):ma_result;cdecl;
  { When a job type is added here an callback needs to be added go "g_jobVTable" in the implementation section.  }
  { Miscellaneous.  }
  { Resource Manager.  }
  { Device.  }
  { Count. Must always be last.  }

    ma_job_type = (MA_JOB_TYPE_QUIT := 0,MA_JOB_TYPE_CUSTOM,
      MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_BUFFER_NODE,
      MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_BUFFER_NODE,
      MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE,
      MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_BUFFER,
      MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_BUFFER,
      MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_STREAM,
      MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_STREAM,
      MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_STREAM,
      MA_JOB_TYPE_RESOURCE_MANAGER_SEEK_DATA_STREAM,
      MA_JOB_TYPE_DEVICE_AAUDIO_REROUTE,MA_JOB_TYPE_COUNT
      );
  { Job type.  }
  { Index into a ma_slot_allocator.  }
  { 8 bytes. We encode the job code into the slot allocation data to save space.  }
  {_Alignas(8) }  { refcount + slot for the next item. Does not include the job code.  }
  { Execution order. Used to create a data dependency and ensure a job is executed in order. Usage is contextual depending on the job type.  }
  { Miscellaneous.  }
  { Resource Manager  }
  {ma_resource_manager* }  {ma_resource_manager_data_buffer_node* }  { Resource manager data source flags that were used when initializing the data buffer.  }
  { Signalled when the data buffer has been initialized and the format/channels/rate can be retrieved.  }
  { Signalled when the data buffer has been fully decoded. Will be passed through to MA_JOB_TYPE_RESOURCE_MANAGER_PAGE_DATA_BUFFER_NODE when decoding.  }
  { Released when initialization of the decoder is complete.  }
  { Released if initialization of the decoder fails. Passed through to PAGE_DATA_BUFFER_NODE untouched if init is successful.  }
  {ma_resource_manager* }  {ma_resource_manager_data_buffer_node* }  {ma_resource_manager* }  {ma_resource_manager_data_buffer_node* }  {ma_decoder* }  { Signalled when the data buffer has been fully decoded.  }
  { Passed through from LOAD_DATA_BUFFER_NODE and released when the data buffer completes decoding or an error occurs.  }
  {ma_resource_manager_data_buffer* }  { Signalled when the data buffer has been initialized and the format/channels/rate can be retrieved.  }
  { Signalled when the data buffer has been fully decoded.  }
  { Released when the data buffer has been initialized and the format/channels/rate can be retrieved.  }
  { Released when the data buffer has been fully decoded.  }
  {ma_resource_manager_data_buffer* }  {ma_resource_manager_data_stream* }  { Allocated when the job is posted, freed by the job thread after loading.  }
  { ^ As above ^. Only used if pFilePath is NULL.  }
  { Signalled after the first two pages have been decoded and frames can be read from the stream.  }
  {ma_resource_manager_data_stream* }  {ma_resource_manager_data_stream* }  { The index of the page to decode into.  }
  {ma_resource_manager_data_stream* }  { Device.  }
  {ma_device* }  {ma_device_type }    ma_job = record
        toc : record
            case longint of
              0 : ( breakup : record
                  code : ma_uint16;
                  slot : ma_uint16;
                  refcount : ma_uint32;
                end );
              1 : ( allocation : ma_uint64 );
            end;
        next : ma_uint64;
        order : ma_uint32;
        data : record
            case longint of
              0 : ( custom : record
                  proc : ma_job_proc;
                  data0 : ma_uintptr;
                  data1 : ma_uintptr;
                end );
              1 : ( resourceManager : record
                  case longint of
                    0 : ( loadDataBufferNode : record
                        pResourceManager : pointer;
                        pDataBufferNode : pointer;
                        pFilePath : ^char;
                        pFilePathW : ^wchar_t;
                        flags : ma_uint32;
                        pInitNotification : ^ma_async_notification;
                        pDoneNotification : ^ma_async_notification;
                        pInitFence : ^ma_fence;
                        pDoneFence : ^ma_fence;
                      end );
                    1 : ( freeDataBufferNode : record
                        pResourceManager : pointer;
                        pDataBufferNode : pointer;
                        pDoneNotification : ^ma_async_notification;
                        pDoneFence : ^ma_fence;
                      end );
                    2 : ( pageDataBufferNode : record
                        pResourceManager : pointer;
                        pDataBufferNode : pointer;
                        pDecoder : pointer;
                        pDoneNotification : ^ma_async_notification;
                        pDoneFence : ^ma_fence;
                      end );
                    3 : ( loadDataBuffer : record
                        pDataBuffer : pointer;
                        pInitNotification : ^ma_async_notification;
                        pDoneNotification : ^ma_async_notification;
                        pInitFence : ^ma_fence;
                        pDoneFence : ^ma_fence;
                        rangeBegInPCMFrames : ma_uint64;
                        rangeEndInPCMFrames : ma_uint64;
                        loopPointBegInPCMFrames : ma_uint64;
                        loopPointEndInPCMFrames : ma_uint64;
                        isLooping : ma_uint32;
                      end );
                    4 : ( freeDataBuffer : record
                        pDataBuffer : pointer;
                        pDoneNotification : ^ma_async_notification;
                        pDoneFence : ^ma_fence;
                      end );
                    5 : ( loadDataStream : record
                        pDataStream : pointer;
                        pFilePath : ^char;
                        pFilePathW : ^wchar_t;
                        initialSeekPoint : ma_uint64;
                        pInitNotification : ^ma_async_notification;
                        pInitFence : ^ma_fence;
                      end );
                    6 : ( freeDataStream : record
                        pDataStream : pointer;
                        pDoneNotification : ^ma_async_notification;
                        pDoneFence : ^ma_fence;
                      end );
                    7 : ( pageDataStream : record
                        pDataStream : pointer;
                        pageIndex : ma_uint32;
                      end );
                    8 : ( seekDataStream : record
                        pDataStream : pointer;
                        frameIndex : ma_uint64;
                      end );
                  end );
              2 : ( device : record
                  case longint of
                    0 : ( aaudio : record
                        case longint of
                          0 : ( reroute : record
                              pDevice : pointer;
                              deviceType : ma_uint32;
                            end );
                        end );
                  end );
            end;
      end;



  {
  When set, ma_job_queue_next() will not wait and no semaphore will be signaled in
  ma_job_queue_post(). ma_job_queue_next() will return MA_NO_DATA_AVAILABLE if nothing is available.
  
  This flag should always be used for platforms that do not support multithreading.
   }

    ma_job_queue_flags = (MA_JOB_QUEUE_FLAG_NON_BLOCKING := $00000001
      );
  { The maximum number of jobs that can fit in the queue at a time.  }

    ma_job_queue_config = record
        flags : ma_uint32;
        capacity : ma_uint32;
      end;


  { Flags passed in at initialization time.  }
  { The maximum number of jobs that can fit in the queue at a time. Set by the config.  }
  {_Alignas(8) }  { The first item in the list. Required for removing from the top of the list.  }
  {_Alignas(8) }  { The last item in the list. Required for appending to the end of the list.  }
  { Memory management.  }

    ma_job_queue = record
        flags : ma_uint32;
        capacity : ma_uint32;
        head : ma_uint64;
        tail : ma_uint64;
        sem : ma_semaphore;
        allocator : ma_slot_allocator;
        pJobs : ^ma_job;
        lock : ma_spinlock;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)

  { Returns MA_CANCELLED if the next job is a quit job.  }
  {***********************************************************************************************************************************************************
  *************************************************************************************************************************************************************
  
  DEVICE I/O
  ==========
  
  This section contains the APIs for device playback and capture. Here is where you'll find ma_device_init(), etc.
  
  *************************************************************************************************************************************************************
  *********************************************************************************************************************************************************** }
{$ifndef MA_NO_DEVICE_IO}
  { Some backends are only supported on certain platforms.  }
{$if defined(MA_WIN32)}
{$define MA_SUPPORT_WASAPI}  
  {todo}
{$if defined(MA_WIN32_DESKTOP)   /* DirectSound and WinMM backends are only supported on desktops. */}
{$define MA_SUPPORT_DSOUND}  
{$define MA_SUPPORT_WINMM}  
  { Don't enable JACK here if compiling with Cosmopolitan. It'll be enabled in the Linux section below.  }
{$ifndef WINDOWS}
  { JACK is technically supported on Windows, but I don't know how many people use it in practice...  }
{$define MA_SUPPORT_JACK}  
{$endif}
{$endif}
{$endif}
{$if defined(MA_UNIX) AND NOT defined(MA_ORBIS) AND NOT defined(MA_PROSPERO)}
{$if defined(MA_LINUX)}
{if NOT defined(MA_ANDROID) AND NOT defined(__COSMOPOLITAN__)   /* ALSA is not supported on Android. */}
{$ifndef ANDROID AND WINDOWS}
{$define MA_SUPPORT_ALSA}  
{$endif}
{$endif}
{$if NOT defined(MA_BSD) AND NOT defined(MA_ANDROID) AND NOT defined(MA_EMSCRIPTEN)}
{$define MA_SUPPORT_PULSEAUDIO}  
{$define MA_SUPPORT_JACK}  
{$endif}
{$if defined(OPENBSD)}
  { sndio is only supported on OpenBSD for now. May be expanded later if there's demand.  }
{$define MA_SUPPORT_SNDIO}  
{$endif}
{$if defined(NETBSD) OR defined(OPENBSD)}
  { Only support audio(4) on platforms with known support.  }
{$define MA_SUPPORT_AUDIO4}  
{$endif}
{$if defined(FREEBSD) OR defined(DragonFly)}
  { Only support OSS on specific platforms with known support.  }
{$define MA_SUPPORT_OSS}  
{$endif}
{$endif}
{$if defined(MA_ANDROID)}
{$define MA_SUPPORT_AAUDIO}  
{$define MA_SUPPORT_OPENSL}  
{$endif}
{$if defined(MA_APPLE)}
{$define MA_SUPPORT_COREAUDIO}  
{$endif}
{$if defined(MA_EMSCRIPTEN)}
{$define MA_SUPPORT_WEBAUDIO}  
{$endif}
  { All platforms should support custom backends.  }
{$define MA_SUPPORT_CUSTOM}  
  { Explicitly disable the Null backend for Emscripten because it uses a background thread which is not properly supported right now.  }
{$if NOT defined(MA_EMSCRIPTEN)}
{$define MA_SUPPORT_NULL}  
{$endif}
{$if defined(MA_SUPPORT_WASAPI) AND NOT defined(MA_NO_WASAPI) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_WASAPI))}
{$define MA_HAS_WASAPI}  
{$endif}
{$if defined(MA_SUPPORT_DSOUND) AND NOT defined(MA_NO_DSOUND) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_DSOUND))}
{$define MA_HAS_DSOUND}  
{$endif}
{$if defined(MA_SUPPORT_WINMM) AND NOT defined(MA_NO_WINMM) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_WINMM))}
{$define MA_HAS_WINMM}  
{$endif}
{$if defined(MA_SUPPORT_ALSA) AND NOT defined(MA_NO_ALSA) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_ALSA))}
{$define MA_HAS_ALSA}  
{$endif}
{$if defined(MA_SUPPORT_PULSEAUDIO) AND NOT defined(MA_NO_PULSEAUDIO) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_PULSEAUDIO))}
{$define MA_HAS_PULSEAUDIO}  
{$endif}
{$if defined(MA_SUPPORT_JACK) AND NOT defined(MA_NO_JACK) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_JACK))}
{$define MA_HAS_JACK}  
{$endif}
{$if defined(MA_SUPPORT_COREAUDIO) AND NOT defined(MA_NO_COREAUDIO) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_COREAUDIO))}
{$define MA_HAS_COREAUDIO}  
{$endif}
{$if defined(MA_SUPPORT_SNDIO) AND NOT defined(MA_NO_SNDIO) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_SNDIO))}
{$define MA_HAS_SNDIO}  
{$endif}
{$if defined(MA_SUPPORT_AUDIO4) AND NOT defined(MA_NO_AUDIO4) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_AUDIO4))}
{$define MA_HAS_AUDIO4}  
{$endif}
{$if defined(MA_SUPPORT_OSS) AND NOT defined(MA_NO_OSS) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_OSS))}
{$define MA_HAS_OSS}  
{$endif}
{$if defined(MA_SUPPORT_AAUDIO) AND NOT defined(MA_NO_AAUDIO) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_AAUDIO))}
{$define MA_HAS_AAUDIO}  
{$endif}
{$if defined(MA_SUPPORT_OPENSL) AND NOT defined(MA_NO_OPENSL) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_OPENSL))}
{$define MA_HAS_OPENSL}  
{$endif}
{$if defined(MA_SUPPORT_WEBAUDIO) AND NOT defined(MA_NO_WEBAUDIO) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_WEBAUDIO))}
{$define MA_HAS_WEBAUDIO}  
{$endif}
{$if defined(MA_SUPPORT_CUSTOM) AND NOT defined(MA_NO_CUSTOM) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_CUSTOM))}
{$define MA_HAS_CUSTOM}  
{$endif}
{$if defined(MA_SUPPORT_NULL) AND NOT defined(MA_NO_NULL) AND (NOT defined(MA_ENABLE_ONLY_SPECIFIC_BACKENDS) OR defined(MA_ENABLE_NULL))}
{$define MA_HAS_NULL}  
{$endif}
  { The device's default state after initialization.  }
  { The device is started and is requesting and/or delivering audio data.  }
  { Transitioning from a stopped state to started.  }
  { Transitioning from a started state to stopped.  }

    ma_device_state = (ma_device_state_uninitialized := 0,
      ma_device_state_stopped := 1,ma_device_state_started := 2,
      ma_device_state_starting := 3,ma_device_state_stopping := 4
      );
  {_Alignas(4) }
    ma_atomic_device_state = record
        value : ma_device_state;
      end;
{$ifdef MA_SUPPORT_WASAPI}
  { We need a IMMNotificationClient object for WASAPI.  }

    ma_IMMNotificationClient = record
        lpVtbl : pointer;
        counter : ma_uint32;
        pDevice : ^ma_device;
      end;
{$endif}
  { Backend enums must be in priority order.  }
  { <-- Custom backend, with callbacks defined by the context config.  }
  { <-- Must always be the last item. Lowest priority, and used as the terminator for backend enumeration.  }

    ma_backend = (ma_backend_wasapi,ma_backend_dsound,ma_backend_winmm,
      ma_backend_coreaudio,ma_backend_sndio,
      ma_backend_audio4,ma_backend_oss,ma_backend_pulseaudio,
      ma_backend_alsa,ma_backend_jack,ma_backend_aaudio,
      ma_backend_opensl,ma_backend_webaudio,
      ma_backend_custom,ma_backend_null);

  {
  Device job thread. This is used by backends that require asynchronous processing of certain
  operations. It is not used by all backends.
  
  The device job thread is made up of a thread and a job queue. You can post a job to the thread with
  ma_device_job_thread_post(). The thread will do the processing of the job.
   }
  { Set this to true if you want to process jobs yourself.  }

    ma_device_job_thread_config = record
        noThread : ma_bool32;
        jobQueueCapacity : ma_uint32;
        jobQueueFlags : ma_uint32;
      end;



    ma_device_job_thread = record
        thread : ma_thread;
        jobQueue : ma_job_queue;
        _hasThread : ma_bool32;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  { Device notification types.  }

    ma_device_notification_type = (ma_device_notification_type_started,
      ma_device_notification_type_stopped,
      ma_device_notification_type_rerouted,
      ma_device_notification_type_interruption_began,
      ma_device_notification_type_interruption_ended
      );

    ma_device_notification = record
        pDevice : ^ma_device;
        _type : ma_device_notification_type;
        data : record
            case longint of
              0 : ( started : record
                  _unused : longint;
                end );
              1 : ( stopped : record
                  _unused : longint;
                end );
              2 : ( rerouted : record
                  _unused : longint;
                end );
              3 : ( interruption : record
                  _unused : longint;
                end );
            end;
      end;
  {
  The notification callback for when the application should be notified of a change to the device.
  
  This callback is used for notifying the application of changes such as when the device has started,
  stopped, rerouted or an interruption has occurred. Note that not all backends will post all
  notification types. For example, some backends will perform automatic stream routing without any
  kind of notification to the host program which means miniaudio will never know about it and will
  never be able to fire the rerouted notification. You should keep this in mind when designing your
  program.
  
  The stopped notification will *not* get fired when a device is rerouted.
  
  
  Parameters
  ----------
  pNotification (in)
      A pointer to a structure containing information about the event. Use the `pDevice` member of
      this object to retrieve the relevant device. The `type` member can be used to discriminate
      against each of the notification types.
  
  
  Remarks
  -------
  Do not restart or uninitialize the device from the callback.
  
  Not all notifications will be triggered by all backends, however the started and stopped events
  should be reliable for all backends. Some backends do not have a good way to detect device
  stoppages due to unplugging the device which may result in the stopped callback not getting
  fired. This has been observed with at least one BSD variant.
  
  The rerouted notification is fired *after* the reroute has occurred. The stopped notification will
  *not* get fired when a device is rerouted. The following backends are known to do automatic stream
  rerouting, but do not have a way to be notified of the change:
  
    * DirectSound
  
  The interruption notifications are used on mobile platforms for detecting when audio is interrupted
  due to things like an incoming phone call. Currently this is only implemented on iOS. None of the
  Android backends will report this notification.
   }
(* Const before type ignored *)

    ma_device_notification_proc = procedure (pNotification:Pma_device_notification);cdecl;
  {
  The callback for processing audio data from the device.
  
  The data callback is fired by miniaudio whenever the device needs to have more data delivered to a playback device, or when a capture device has some data
  available. This is called as soon as the backend asks for more data which means it may be called with inconsistent frame counts. You cannot assume the
  callback will be fired with a consistent frame count.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the relevant device.
  
  pOutput (out)
      A pointer to the output buffer that will receive audio data that will later be played back through the speakers. This will be non-null for a playback or
      full-duplex device and null for a capture and loopback device.
  
  pInput (in)
      A pointer to the buffer containing input data from a recording device. This will be non-null for a capture, full-duplex or loopback device and null for a
      playback device.
  
  frameCount (in)
      The number of PCM frames to process. Note that this will not necessarily be equal to what you requested when you initialized the device. The
      `periodSizeInFrames` and `periodSizeInMilliseconds` members of the device config are just hints, and are not necessarily exactly what you'll get. You must
      not assume this will always be the same value each time the callback is fired.
  
  
  Remarks
  -------
  You cannot stop and start the device from inside the callback or else you'll get a deadlock. You must also not uninitialize the device from inside the
  callback. The following APIs cannot be called from inside the callback:
  
      ma_device_init()
      ma_device_init_ex()
      ma_device_uninit()
      ma_device_start()
      ma_device_stop()
  
  The proper way to stop the device is to call `ma_device_stop()` from a different thread, normally the main application thread.
   }
(* Const before type ignored *)

    ma_device_data_proc = procedure (pDevice:Pma_device; pOutput:pointer; pInput:pointer; frameCount:ma_uint32);cdecl;
  {
  DEPRECATED. Use ma_device_notification_proc instead.
  
  The callback for when the device has been stopped.
  
  This will be called when the device is stopped explicitly with `ma_device_stop()` and also called implicitly when the device is stopped through external forces
  such as being unplugged or an internal error occurring.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device that has just stopped.
  
  
  Remarks
  -------
  Do not restart or uninitialize the device from the callback.
   }

    ma_stop_proc = procedure (pDevice:Pma_device);cdecl;
  { DEPRECATED. Use ma_device_notification_proc instead.  }
  { 3  }

    ma_device_type = (ma_device_type_playback := 1,ma_device_type_capture := 2,
      ma_device_type_duplex := 1 or 2,ma_device_type_loopback := 4
      );

    ma_share_mode = (ma_share_mode_shared := 0,ma_share_mode_exclusive
      );
  { iOS/tvOS/watchOS session categories.  }
  { AVAudioSessionCategoryPlayAndRecord.  }
  { Leave the session category unchanged.  }
  { AVAudioSessionCategoryAmbient  }
  { AVAudioSessionCategorySoloAmbient  }
  { AVAudioSessionCategoryPlayback  }
  { AVAudioSessionCategoryRecord  }
  { AVAudioSessionCategoryPlayAndRecord  }
  { AVAudioSessionCategoryMultiRoute  }

    ma_ios_session_category = (ma_ios_session_category_default := 0,
      ma_ios_session_category_none,ma_ios_session_category_ambient,
      ma_ios_session_category_solo_ambient,
      ma_ios_session_category_playback,ma_ios_session_category_record,
      ma_ios_session_category_play_and_record,
      ma_ios_session_category_multi_route
      );
  { iOS/tvOS/watchOS session category options  }
  { AVAudioSessionCategoryOptionMixWithOthers  }
  { AVAudioSessionCategoryOptionDuckOthers  }
  { AVAudioSessionCategoryOptionAllowBluetooth  }
  { AVAudioSessionCategoryOptionDefaultToSpeaker  }
  { AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers  }
  { AVAudioSessionCategoryOptionAllowBluetoothA2DP  }
  { AVAudioSessionCategoryOptionAllowAirPlay  }

    ma_ios_session_category_option = (ma_ios_session_category_option_mix_with_others := $01,
      ma_ios_session_category_option_duck_others := $02,
      ma_ios_session_category_option_allow_bluetooth := $04,
      ma_ios_session_category_option_default_to_speaker := $08,
      ma_ios_session_category_option_interrupt_spoken_audio_and_mix_with_others := $11,
      ma_ios_session_category_option_allow_bluetooth_a2dp := $20,
      ma_ios_session_category_option_allow_air_play := $40
      );
  { OpenSL stream types.  }
  { Leaves the stream type unset.  }
  { SL_ANDROID_STREAM_VOICE  }
  { SL_ANDROID_STREAM_SYSTEM  }
  { SL_ANDROID_STREAM_RING  }
  { SL_ANDROID_STREAM_MEDIA  }
  { SL_ANDROID_STREAM_ALARM  }
  { SL_ANDROID_STREAM_NOTIFICATION  }

    ma_opensl_stream_type = (ma_opensl_stream_type_default := 0,
      ma_opensl_stream_type_voice,ma_opensl_stream_type_system,
      ma_opensl_stream_type_ring,ma_opensl_stream_type_media,
      ma_opensl_stream_type_alarm,ma_opensl_stream_type_notification
      );
  { OpenSL recording presets.  }
  { Leaves the input preset unset.  }
  { SL_ANDROID_RECORDING_PRESET_GENERIC  }
  { SL_ANDROID_RECORDING_PRESET_CAMCORDER  }
  { SL_ANDROID_RECORDING_PRESET_VOICE_RECOGNITION  }
  { SL_ANDROID_RECORDING_PRESET_VOICE_COMMUNICATION  }
  { SL_ANDROID_RECORDING_PRESET_UNPROCESSED  }

    ma_opensl_recording_preset = (ma_opensl_recording_preset_default := 0,
      ma_opensl_recording_preset_generic,ma_opensl_recording_preset_camcorder,
      ma_opensl_recording_preset_voice_recognition,
      ma_opensl_recording_preset_voice_communication,
      ma_opensl_recording_preset_voice_unprocessed
      );
  { WASAPI audio thread priority characteristics.  }

    ma_wasapi_usage = (ma_wasapi_usage_default := 0,ma_wasapi_usage_games,
      ma_wasapi_usage_pro_audio);
  { AAudio usage types.  }
  { Leaves the usage type unset.  }
  { AAUDIO_USAGE_MEDIA  }
  { AAUDIO_USAGE_VOICE_COMMUNICATION  }
  { AAUDIO_USAGE_VOICE_COMMUNICATION_SIGNALLING  }
  { AAUDIO_USAGE_ALARM  }
  { AAUDIO_USAGE_NOTIFICATION  }
  { AAUDIO_USAGE_NOTIFICATION_RINGTONE  }
  { AAUDIO_USAGE_NOTIFICATION_EVENT  }
  { AAUDIO_USAGE_ASSISTANCE_ACCESSIBILITY  }
  { AAUDIO_USAGE_ASSISTANCE_NAVIGATION_GUIDANCE  }
  { AAUDIO_USAGE_ASSISTANCE_SONIFICATION  }
  { AAUDIO_USAGE_GAME  }
  { AAUDIO_USAGE_ASSISTANT  }
  { AAUDIO_SYSTEM_USAGE_EMERGENCY  }
  { AAUDIO_SYSTEM_USAGE_SAFETY  }
  { AAUDIO_SYSTEM_USAGE_VEHICLE_STATUS  }
  { AAUDIO_SYSTEM_USAGE_ANNOUNCEMENT  }

    ma_aaudio_usage = (ma_aaudio_usage_default := 0,ma_aaudio_usage_media,
      ma_aaudio_usage_voice_communication,
      ma_aaudio_usage_voice_communication_signalling,
      ma_aaudio_usage_alarm,ma_aaudio_usage_notification,
      ma_aaudio_usage_notification_ringtone,
      ma_aaudio_usage_notification_event,ma_aaudio_usage_assistance_accessibility,
      ma_aaudio_usage_assistance_navigation_guidance,
      ma_aaudio_usage_assistance_sonification,
      ma_aaudio_usage_game,ma_aaudio_usage_assitant,
      ma_aaudio_usage_emergency,ma_aaudio_usage_safety,
      ma_aaudio_usage_vehicle_status,ma_aaudio_usage_announcement
      );
  { AAudio content types.  }
  { Leaves the content type unset.  }
  { AAUDIO_CONTENT_TYPE_SPEECH  }
  { AAUDIO_CONTENT_TYPE_MUSIC  }
  { AAUDIO_CONTENT_TYPE_MOVIE  }
  { AAUDIO_CONTENT_TYPE_SONIFICATION  }

    ma_aaudio_content_type = (ma_aaudio_content_type_default := 0,
      ma_aaudio_content_type_speech,ma_aaudio_content_type_music,
      ma_aaudio_content_type_movie,ma_aaudio_content_type_sonification
      );
  { AAudio input presets.  }
  { Leaves the input preset unset.  }
  { AAUDIO_INPUT_PRESET_GENERIC  }
  { AAUDIO_INPUT_PRESET_CAMCORDER  }
  { AAUDIO_INPUT_PRESET_VOICE_RECOGNITION  }
  { AAUDIO_INPUT_PRESET_VOICE_COMMUNICATION  }
  { AAUDIO_INPUT_PRESET_UNPROCESSED  }
  { AAUDIO_INPUT_PRESET_VOICE_PERFORMANCE  }

    ma_aaudio_input_preset = (ma_aaudio_input_preset_default := 0,
      ma_aaudio_input_preset_generic,ma_aaudio_input_preset_camcorder,
      ma_aaudio_input_preset_voice_recognition,
      ma_aaudio_input_preset_voice_communication,
      ma_aaudio_input_preset_unprocessed,ma_aaudio_input_preset_voice_performance
      );
  { Leaves the allowed capture policy unset.  }
  { AAUDIO_ALLOW_CAPTURE_BY_ALL  }
  { AAUDIO_ALLOW_CAPTURE_BY_SYSTEM  }
  { AAUDIO_ALLOW_CAPTURE_BY_NONE  }

    ma_aaudio_allowed_capture_policy = (ma_aaudio_allow_capture_default := 0,
      ma_aaudio_allow_capture_by_all,ma_aaudio_allow_capture_by_system,
      ma_aaudio_allow_capture_by_none);

    ma_timer = record
        case longint of
          0 : ( counter : ma_int64 );
          1 : ( counterD : double );
        end;
  { WASAPI uses a wchar_t string for identification.  }
  { DirectSound uses a GUID for identification.  }
  {UINT_PTR }  { When creating a device, WinMM expects a Win32 UINT_PTR for device identification. In practice it's actually just a UINT.  }
  { ALSA uses a name string for identification.  }
  { PulseAudio uses a name string for identification.  }
  { JACK always uses default devices.  }
  { Core Audio uses a string for identification.  }
  { "snd/0", etc.  }
  { "/dev/audio", etc.  }
  { "dev/dsp0", etc. "dev/dsp" for the default device.  }
  { AAudio uses a 32-bit integer for identification.  }
  { OpenSL|ES uses a 32-bit unsigned integer for identification.  }
  { Web Audio always uses default devices for now, but if this changes it'll be a GUID.  }
  { The custom backend could be anything. Give them a few options.  }
  { The null backend uses an integer for device IDs.  }

    ma_device_id = record
        case longint of
          0 : ( wasapi : array[0..63] of ma_wchar_win32 );
          1 : ( dsound : array[0..15] of ma_uint8 );
          2 : ( winmm : ma_uint32 );
          3 : ( alsa : array[0..255] of char );
          4 : ( pulse : array[0..255] of char );
          5 : ( jack : longint );
          6 : ( coreaudio : array[0..255] of char );
          7 : ( sndio : array[0..255] of char );
          8 : ( audio4 : array[0..255] of char );
          9 : ( oss : array[0..63] of char );
          10 : ( aaudio : ma_int32 );
          11 : ( opensl : ma_uint32 );
          12 : ( webaudio : array[0..31] of char );
          13 : ( custom : record
              case longint of
                0 : ( i : longint );
                1 : ( s : array[0..255] of char );
                2 : ( p : pointer );
              end );
          14 : ( nullbackend : longint );
        end;
  { If set, this is supported in exclusive mode. Otherwise not natively supported by exclusive mode.  }

  { Basic info. This is the only information guaranteed to be filled in during device enumeration.  }
  { +1 for null terminator.  }
  { Sample format. If set to ma_format_unknown, all sample formats are supported.  }
  { If set to 0, all channels are supported.  }
  { If set to 0, all sample rates are supported.  }
  { A combination of MA_DATA_FORMAT_FLAG_* flags.  }
  {ma_format_count * ma_standard_sample_rate_count * MA_MAX_CHANNELS }  { Not sure how big to make this. There can be *many* permutations for virtual devices which can support anything.  }

    ma_device_info = record
        id : ma_device_id;
        name : array[0..(MA_MAX_DEVICE_NAME_LENGTH+1)-1] of char;
        isDefault : ma_bool32;
        nativeDataFormatCount : ma_uint32;
        nativeDataFormats : array[0..63] of record
            format : ma_format;
            channels : ma_uint32;
            sampleRate : ma_uint32;
            flags : ma_uint32;
          end;
      end;
  { When set to true, the contents of the output buffer passed into the data callback will be left undefined rather than initialized to silence.  }
  { When set to true, the contents of the output buffer passed into the data callback will be clipped after returning. Only applies when the playback sample format is f32.  }
  { Do not disable denormals when firing the data callback.  }
  { Disables strict fixed-sized data callbacks. Setting this to true will result in the period size being treated only as a hint to the backend. This is an optimization for those who don't need fixed sized callbacks.  }
(* Const before type ignored *)
  { When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present.  }
(* Const before type ignored *)
  { When an output LFE channel is present, but no input LFE, set to true to set the output LFE to the average of all spatial channels (LR, FR, etc.). Ignored when an input LFE is present.  }
  { When configured, uses Avrt APIs to set the thread characteristics.  }
  { When set to true, disables the use of AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM.  }
  { When set to true, disables the use of AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY.  }
  { Disables automatic stream routing.  }
  { Disables WASAPI's hardware offloading feature.  }
  { The process ID to include or exclude for loopback mode. Set to 0 to capture audio from all processes. Ignored when an explicit device ID is specified.  }
  { When set to true, excludes the process specified by loopbackProcessID. By default, the process will be included.  }
  { Disables MMap mode.  }
  { Opens the ALSA device with SND_PCM_NO_AUTO_FORMAT.  }
  { Opens the ALSA device with SND_PCM_NO_AUTO_CHANNELS.  }
  { Opens the ALSA device with SND_PCM_NO_AUTO_RESAMPLE.  }
(* Const before type ignored *)
(* Const before type ignored *)
  { Desktop only. When enabled, allows changing of the sample rate at the operating system level.  }
    ma_device_config = record
        deviceType : ma_device_type;
        sampleRate : ma_uint32;
        periodSizeInFrames : ma_uint32;
        periodSizeInMilliseconds : ma_uint32;
        periods : ma_uint32;
        performanceProfile : ma_performance_profile;
        noPreSilencedOutputBuffer : ma_bool8;
        noClip : ma_bool8;
        noDisableDenormals : ma_bool8;
        noFixedSizedCallback : ma_bool8;
        dataCallback : ma_device_data_proc;
        notificationCallback : ma_device_notification_proc;
        stopCallback : ma_stop_proc;
        pUserData : pointer;
        resampling : ma_resampler_config;
        playback : record
            pDeviceID : ^ma_device_id;
            format : ma_format;
            channels : ma_uint32;
            pChannelMap : ^ma_channel;
            channelMixMode : ma_channel_mix_mode;
            calculateLFEFromSpatialChannels : ma_bool32;
            shareMode : ma_share_mode;
          end;
        capture : record
            pDeviceID : ^ma_device_id;
            format : ma_format;
            channels : ma_uint32;
            pChannelMap : ^ma_channel;
            channelMixMode : ma_channel_mix_mode;
            calculateLFEFromSpatialChannels : ma_bool32;
            shareMode : ma_share_mode;
          end;
        wasapi : record
            usage : ma_wasapi_usage;
            noAutoConvertSRC : ma_bool8;
            noDefaultQualitySRC : ma_bool8;
            noAutoStreamRouting : ma_bool8;
            noHardwareOffloading : ma_bool8;
            loopbackProcessID : ma_uint32;
            loopbackProcessExclude : ma_bool8;
          end;
        alsa : record
            noMMap : ma_bool32;
            noAutoFormat : ma_bool32;
            noAutoChannels : ma_bool32;
            noAutoResample : ma_bool32;
          end;
        pulse : record
            pStreamNamePlayback : ^char;
            pStreamNameCapture : ^char;
          end;
        coreaudio : record
            allowNominalSampleRateChange : ma_bool32;
          end;
        opensl : record
            streamType : ma_opensl_stream_type;
            recordingPreset : ma_opensl_recording_preset;
            enableCompatibilityWorkarounds : ma_bool32;
          end;
        aaudio : record
            usage : ma_aaudio_usage;
            contentType : ma_aaudio_content_type;
            inputPreset : ma_aaudio_input_preset;
            allowedCapturePolicy : ma_aaudio_allowed_capture_policy;
            noAutoStartAfterReroute : ma_bool32;
            enableCompatibilityWorkarounds : ma_bool32;
          end;
      end;

  {
  The callback for handling device enumeration. This is fired from `ma_context_enumerate_devices()`.
  
  
  Parameters
  ----------
  pContext (in)
      A pointer to the context performing the enumeration.
  
  deviceType (in)
      The type of the device being enumerated. This will always be either `ma_device_type_playback` or `ma_device_type_capture`.
  
  pInfo (in)
      A pointer to a `ma_device_info` containing the ID and name of the enumerated device. Note that this will not include detailed information about the device,
      only basic information (ID and name). The reason for this is that it would otherwise require opening the backend device to probe for the information which
      is too inefficient.
  
  pUserData (in)
      The user data pointer passed into `ma_context_enumerate_devices()`.
   }
(* Const before type ignored *)

    ma_enum_devices_callback_proc = function (pContext:Pma_context; deviceType:ma_device_type; pInfo:Pma_device_info; pUserData:pointer):ma_bool32;cdecl;
  {
  Describes some basic details about a playback or capture device.
   }
(* Const before type ignored *)

    ma_device_descriptor = record
        pDeviceID : ^ma_device_id;
        shareMode : ma_share_mode;
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        channelMap : array[0..(MA_MAX_CHANNELS)-1] of ma_channel;
        periodSizeInFrames : ma_uint32;
        periodSizeInMilliseconds : ma_uint32;
        periodCount : ma_uint32;
      end;
  {
  These are the callbacks required to be implemented for a backend. These callbacks are grouped into two parts: context and device. There is one context
  to many devices. A device is created from a context.
  
  The general flow goes like this:
  
    1) A context is created with `onContextInit()`
       1a) Available devices can be enumerated with `onContextEnumerateDevices()` if required.
       1b) Detailed information about a device can be queried with `onContextGetDeviceInfo()` if required.
    2) A device is created from the context that was created in the first step using `onDeviceInit()`, and optionally a device ID that was
       selected from device enumeration via `onContextEnumerateDevices()`.
    3) A device is started or stopped with `onDeviceStart()` / `onDeviceStop()`
    4) Data is delivered to and from the device by the backend. This is always done based on the native format returned by the prior call
       to `onDeviceInit()`. Conversion between the device's native format and the format requested by the application will be handled by
       miniaudio internally.
  
  Initialization of the context is quite simple. You need to do any necessary initialization of internal objects and then output the
  callbacks defined in this structure.
  
  Once the context has been initialized you can initialize a device. Before doing so, however, the application may want to know which
  physical devices are available. This is where `onContextEnumerateDevices()` comes in. This is fairly simple. For each device, fire the
  given callback with, at a minimum, the basic information filled out in `ma_device_info`. When the callback returns `MA_FALSE`, enumeration
  needs to stop and the `onContextEnumerateDevices()` function returns with a success code.
  
  Detailed device information can be retrieved from a device ID using `onContextGetDeviceInfo()`. This takes as input the device type and ID,
  and on output returns detailed information about the device in `ma_device_info`. The `onContextGetDeviceInfo()` callback must handle the
  case when the device ID is NULL, in which case information about the default device needs to be retrieved.
  
  Once the context has been created and the device ID retrieved (if using anything other than the default device), the device can be created.
  This is a little bit more complicated than initialization of the context due to it's more complicated configuration. When initializing a
  device, a duplex device may be requested. This means a separate data format needs to be specified for both playback and capture. On input,
  the data format is set to what the application wants. On output it's set to the native format which should match as closely as possible to
  the requested format. The conversion between the format requested by the application and the device's native format will be handled
  internally by miniaudio.
  
  On input, if the sample format is set to `ma_format_unknown`, the backend is free to use whatever sample format it desires, so long as it's
  supported by miniaudio. When the channel count is set to 0, the backend should use the device's native channel count. The same applies for
  sample rate. For the channel map, the default should be used when `ma_channel_map_is_blank()` returns true (all channels set to
  `MA_CHANNEL_NONE`). On input, the `periodSizeInFrames` or `periodSizeInMilliseconds` option should always be set. The backend should
  inspect both of these variables. If `periodSizeInFrames` is set, it should take priority, otherwise it needs to be derived from the period
  size in milliseconds (`periodSizeInMilliseconds`) and the sample rate, keeping in mind that the sample rate may be 0, in which case the
  sample rate will need to be determined before calculating the period size in frames. On output, all members of the `ma_device_descriptor`
  object should be set to a valid value, except for `periodSizeInMilliseconds` which is optional (`periodSizeInFrames` *must* be set).
  
  Starting and stopping of the device is done with `onDeviceStart()` and `onDeviceStop()` and should be self-explanatory. If the backend uses
  asynchronous reading and writing, `onDeviceStart()` and `onDeviceStop()` should always be implemented.
  
  The handling of data delivery between the application and the device is the most complicated part of the process. To make this a bit
  easier, some helper callbacks are available. If the backend uses a blocking read/write style of API, the `onDeviceRead()` and
  `onDeviceWrite()` callbacks can optionally be implemented. These are blocking and work just like reading and writing from a file. If the
  backend uses a callback for data delivery, that callback must call `ma_device_handle_backend_data_callback()` from within it's callback.
  This allows miniaudio to then process any necessary data conversion and then pass it to the miniaudio data callback.
  
  If the backend requires absolute flexibility with it's data delivery, it can optionally implement the `onDeviceDataLoop()` callback
  which will allow it to implement the logic that will run on the audio thread. This is much more advanced and is completely optional.
  
  The audio thread should run data delivery logic in a loop while `ma_device_get_state() == ma_device_state_started` and no errors have been
  encountered. Do not start or stop the device here. That will be handled from outside the `onDeviceDataLoop()` callback.
  
  The invocation of the `onDeviceDataLoop()` callback will be handled by miniaudio. When you start the device, miniaudio will fire this
  callback. When the device is stopped, the `ma_device_get_state() == ma_device_state_started` condition will fail and the loop will be terminated
  which will then fall through to the part that stops the device. For an example on how to implement the `onDeviceDataLoop()` callback,
  look at `ma_device_audio_thread__default_read_write()`. Implement the `onDeviceDataLoopWakeup()` callback if you need a mechanism to
  wake up the audio thread.
  
  If the backend supports an optimized retrieval of device information from an initialized `ma_device` object, it should implement the
  `onDeviceGetInfo()` callback. This is optional, in which case it will fall back to `onContextGetDeviceInfo()` which is less efficient.
   }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
    ma_backend_callbacks = record
        onContextInit : function (pContext:Pma_context; pConfig:Pma_context_config; pCallbacks:Pma_backend_callbacks):ma_result;cdecl;
        onContextUninit : function (pContext:Pma_context):ma_result;cdecl;
        onContextEnumerateDevices : function (pContext:Pma_context; callback:ma_enum_devices_callback_proc; pUserData:pointer):ma_result;cdecl;
        onContextGetDeviceInfo : function (pContext:Pma_context; deviceType:ma_device_type; pDeviceID:Pma_device_id; pDeviceInfo:Pma_device_info):ma_result;cdecl;
        onDeviceInit : function (pDevice:Pma_device; pConfig:Pma_device_config; pDescriptorPlayback:Pma_device_descriptor; pDescriptorCapture:Pma_device_descriptor):ma_result;cdecl;
        onDeviceUninit : function (pDevice:Pma_device):ma_result;cdecl;
        onDeviceStart : function (pDevice:Pma_device):ma_result;cdecl;
        onDeviceStop : function (pDevice:Pma_device):ma_result;cdecl;
        onDeviceRead : function (pDevice:Pma_device; pFrames:pointer; frameCount:ma_uint32; pFramesRead:Pma_uint32):ma_result;cdecl;
        onDeviceWrite : function (pDevice:Pma_device; pFrames:pointer; frameCount:ma_uint32; pFramesWritten:Pma_uint32):ma_result;cdecl;
        onDeviceDataLoop : function (pDevice:Pma_device):ma_result;cdecl;
        onDeviceDataLoopWakeup : function (pDevice:Pma_device):ma_result;cdecl;
        onDeviceGetInfo : function (pDevice:Pma_device; _type:ma_device_type; pDeviceInfo:Pma_device_info):ma_result;cdecl;
      end;

(* Const before type ignored *)
(* Const before type ignored *)
  { Enables autospawning of the PulseAudio daemon if necessary.  }
  { iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:true] on initialization.  }
  { iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:false] on uninitialization.  }
(* Const before type ignored *)
    ma_context_config = record
        pLog : ^ma_log;
        threadPriority : ma_thread_priority;
        threadStackSize : size_t;
        pUserData : pointer;
        allocationCallbacks : ma_allocation_callbacks;
        alsa : record
            useVerboseDeviceEnumeration : ma_bool32;
          end;
        pulse : record
            pApplicationName : ^char;
            pServerName : ^char;
            tryAutoSpawn : ma_bool32;
          end;
        coreaudio : record
            sessionCategory : ma_ios_session_category;
            sessionCategoryOptions : ma_uint32;
            noAudioSessionActivate : ma_bool32;
            noAudioSessionDeactivate : ma_bool32;
          end;
        jack : record
            pClientName : ^char;
            tryStartServer : ma_bool32;
          end;
        custom : ma_backend_callbacks;
      end;

  { WASAPI specific structure for some commands which must run on a common thread due to bugs in WASAPI.  }
  { This will be signalled when the event is complete.  }
  { The result from creating the audio client service.  }

    ma_context_command__wasapi = record
        code : longint;
        pEvent : ^ma_event;
        data : record
            case longint of
              0 : ( quit : record
                  _unused : longint;
                end );
              1 : ( createAudioClient : record
                  deviceType : ma_device_type;
                  pAudioClient : pointer;
                  ppAudioClientService : ^pointer;
                  pResult : ^ma_result;
                end );
              2 : ( releaseAudioClient : record
                  pDevice : ^ma_device;
                  deviceType : ma_device_type;
                end );
            end;
      end;
  { DirectSound, ALSA, etc.  }
  { Only used if the log is owned by the context. The pLog member will be set to &log in this case.  }
  { Used to make ma_context_get_devices() thread safe.  }
  { Used to make ma_context_get_device_info() thread safe.  }
  { Total capacity of pDeviceInfos.  }
  { Playback devices first, then capture.  }
{$ifdef MA_SUPPORT_WASAPI}
{$endif}
{$ifdef MA_SUPPORT_DSOUND}
{$endif}
{$ifdef MA_SUPPORT_WINMM}
{$endif}
{$ifdef MA_SUPPORT_ALSA}
{$endif}
{$ifdef MA_SUPPORT_PULSEAUDIO}
  {pa_mainloop* }  {pa_context* }  { Set when the context is initialized. Used by devices for their local pa_context objects.  }
  { Set when the context is initialized. Used by devices for their local pa_context objects.  }
{$endif}
{$ifdef MA_SUPPORT_JACK}
{$endif}
{$ifdef MA_SUPPORT_COREAUDIO}
  { Could possibly be set to AudioToolbox on later versions of macOS.  }
  {AudioComponent }  { For tracking whether or not the iOS audio session should be explicitly deactivated. Set from the config in ma_context_init__coreaudio().  }
{$endif}
{$ifdef MA_SUPPORT_SNDIO}
{$endif}
{$ifdef MA_SUPPORT_AUDIO4}
{$endif}
{$ifdef MA_SUPPORT_OSS}
{$endif}
{$ifdef MA_SUPPORT_AAUDIO}
  { libaaudio.so  }
  { For processing operations outside of the error callback, specifically device disconnections and rerouting.  }
{$endif}
{$ifdef MA_SUPPORT_OPENSL}
{$endif}
{$ifdef MA_SUPPORT_WEBAUDIO}
{$endif}
{$ifdef MA_SUPPORT_NULL}
{$endif}
{$if defined(MA_WIN32)}
  {HMODULE }  {HMODULE }  {HMODULE }  {HRESULT }{$endif}
{$ifdef MA_POSIX}
{$endif}

    ma_context = record
        callbacks : ma_backend_callbacks;
        backend : ma_backend;
        pLog : ^ma_log;
        log : ma_log;
        threadPriority : ma_thread_priority;
        threadStackSize : size_t;
        pUserData : pointer;
        allocationCallbacks : ma_allocation_callbacks;
        deviceEnumLock : ma_mutex;
        deviceInfoLock : ma_mutex;
        deviceInfoCapacity : ma_uint32;
        playbackDeviceInfoCount : ma_uint32;
        captureDeviceInfoCount : ma_uint32;
        pDeviceInfos : ^ma_device_info;
        todo1 : record
          {$ifdef MA_SUPPORT_WASAPI}
              wasapi : record
                  commandThread : ma_thread;
                  commandLock : ma_mutex;
                  commandSem : ma_semaphore;
                  commandIndex : ma_uint32;
                  commandCount : ma_uint32;
                  commands : array[0..3] of ma_context_command__wasapi;
                  hAvrt : ma_handle;
                  AvSetMmThreadCharacteristicsA : ma_proc;
                  AvRevertMmThreadcharacteristics : ma_proc;
                  hMMDevapi : ma_handle;
                  ActivateAudioInterfaceAsync : ma_proc;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_DSOUND}
              dsound : record
                  hDSoundDLL : ma_handle;
                  DirectSoundCreate : ma_proc;
                  DirectSoundEnumerateA : ma_proc;
                  DirectSoundCaptureCreate : ma_proc;
                  DirectSoundCaptureEnumerateA : ma_proc;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_WINMM}
              winmm : record
                  hWinMM : ma_handle;
                  waveOutGetNumDevs : ma_proc;
                  waveOutGetDevCapsA : ma_proc;
                  waveOutOpen : ma_proc;
                  waveOutClose : ma_proc;
                  waveOutPrepareHeader : ma_proc;
                  waveOutUnprepareHeader : ma_proc;
                  waveOutWrite : ma_proc;
                  waveOutReset : ma_proc;
                  waveInGetNumDevs : ma_proc;
                  waveInGetDevCapsA : ma_proc;
                  waveInOpen : ma_proc;
                  waveInClose : ma_proc;
                  waveInPrepareHeader : ma_proc;
                  waveInUnprepareHeader : ma_proc;
                  waveInAddBuffer : ma_proc;
                  waveInStart : ma_proc;
                  waveInReset : ma_proc;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_ALSA}
              alsa : record
                  asoundSO : ma_handle;
                  snd_pcm_open : ma_proc;
                  snd_pcm_close : ma_proc;
                  snd_pcm_hw_params_sizeof : ma_proc;
                  snd_pcm_hw_params_any : ma_proc;
                  snd_pcm_hw_params_set_format : ma_proc;
                  snd_pcm_hw_params_set_format_first : ma_proc;
                  snd_pcm_hw_params_get_format_mask : ma_proc;
                  snd_pcm_hw_params_set_channels : ma_proc;
                  snd_pcm_hw_params_set_channels_near : ma_proc;
                  snd_pcm_hw_params_set_channels_minmax : ma_proc;
                  snd_pcm_hw_params_set_rate_resample : ma_proc;
                  snd_pcm_hw_params_set_rate : ma_proc;
                  snd_pcm_hw_params_set_rate_near : ma_proc;
                  snd_pcm_hw_params_set_buffer_size_near : ma_proc;
                  snd_pcm_hw_params_set_periods_near : ma_proc;
                  snd_pcm_hw_params_set_access : ma_proc;
                  snd_pcm_hw_params_get_format : ma_proc;
                  snd_pcm_hw_params_get_channels : ma_proc;
                  snd_pcm_hw_params_get_channels_min : ma_proc;
                  snd_pcm_hw_params_get_channels_max : ma_proc;
                  snd_pcm_hw_params_get_rate : ma_proc;
                  snd_pcm_hw_params_get_rate_min : ma_proc;
                  snd_pcm_hw_params_get_rate_max : ma_proc;
                  snd_pcm_hw_params_get_buffer_size : ma_proc;
                  snd_pcm_hw_params_get_periods : ma_proc;
                  snd_pcm_hw_params_get_access : ma_proc;
                  snd_pcm_hw_params_test_format : ma_proc;
                  snd_pcm_hw_params_test_channels : ma_proc;
                  snd_pcm_hw_params_test_rate : ma_proc;
                  snd_pcm_hw_params : ma_proc;
                  snd_pcm_sw_params_sizeof : ma_proc;
                  snd_pcm_sw_params_current : ma_proc;
                  snd_pcm_sw_params_get_boundary : ma_proc;
                  snd_pcm_sw_params_set_avail_min : ma_proc;
                  snd_pcm_sw_params_set_start_threshold : ma_proc;
                  snd_pcm_sw_params_set_stop_threshold : ma_proc;
                  snd_pcm_sw_params : ma_proc;
                  snd_pcm_format_mask_sizeof : ma_proc;
                  snd_pcm_format_mask_test : ma_proc;
                  snd_pcm_get_chmap : ma_proc;
                  snd_pcm_state : ma_proc;
                  snd_pcm_prepare : ma_proc;
                  snd_pcm_start : ma_proc;
                  snd_pcm_drop : ma_proc;
                  snd_pcm_drain : ma_proc;
                  snd_pcm_reset : ma_proc;
                  snd_device_name_hint : ma_proc;
                  snd_device_name_get_hint : ma_proc;
                  snd_card_get_index : ma_proc;
                  snd_device_name_free_hint : ma_proc;
                  snd_pcm_mmap_begin : ma_proc;
                  snd_pcm_mmap_commit : ma_proc;
                  snd_pcm_recover : ma_proc;
                  snd_pcm_readi : ma_proc;
                  snd_pcm_writei : ma_proc;
                  snd_pcm_avail : ma_proc;
                  snd_pcm_avail_update : ma_proc;
                  snd_pcm_wait : ma_proc;
                  snd_pcm_nonblock : ma_proc;
                  snd_pcm_info : ma_proc;
                  snd_pcm_info_sizeof : ma_proc;
                  snd_pcm_info_get_name : ma_proc;
                  snd_pcm_poll_descriptors : ma_proc;
                  snd_pcm_poll_descriptors_count : ma_proc;
                  snd_pcm_poll_descriptors_revents : ma_proc;
                  snd_config_update_free_global : ma_proc;
                  internalDeviceEnumLock : ma_mutex;
                  useVerboseDeviceEnumeration : ma_bool32;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_PULSEAUDIO}
              pulse : record
                  pulseSO : ma_handle;
                  pa_mainloop_new : ma_proc;
                  pa_mainloop_free : ma_proc;
                  pa_mainloop_quit : ma_proc;
                  pa_mainloop_get_api : ma_proc;
                  pa_mainloop_iterate : ma_proc;
                  pa_mainloop_wakeup : ma_proc;
                  pa_threaded_mainloop_new : ma_proc;
                  pa_threaded_mainloop_free : ma_proc;
                  pa_threaded_mainloop_start : ma_proc;
                  pa_threaded_mainloop_stop : ma_proc;
                  pa_threaded_mainloop_lock : ma_proc;
                  pa_threaded_mainloop_unlock : ma_proc;
                  pa_threaded_mainloop_wait : ma_proc;
                  pa_threaded_mainloop_signal : ma_proc;
                  pa_threaded_mainloop_accept : ma_proc;
                  pa_threaded_mainloop_get_retval : ma_proc;
                  pa_threaded_mainloop_get_api : ma_proc;
                  pa_threaded_mainloop_in_thread : ma_proc;
                  pa_threaded_mainloop_set_name : ma_proc;
                  pa_context_new : ma_proc;
                  pa_context_unref : ma_proc;
                  pa_context_connect : ma_proc;
                  pa_context_disconnect : ma_proc;
                  pa_context_set_state_callback : ma_proc;
                  pa_context_get_state : ma_proc;
                  pa_context_get_sink_info_list : ma_proc;
                  pa_context_get_source_info_list : ma_proc;
                  pa_context_get_sink_info_by_name : ma_proc;
                  pa_context_get_source_info_by_name : ma_proc;
                  pa_operation_unref : ma_proc;
                  pa_operation_get_state : ma_proc;
                  pa_channel_map_init_extend : ma_proc;
                  pa_channel_map_valid : ma_proc;
                  pa_channel_map_compatible : ma_proc;
                  pa_stream_new : ma_proc;
                  pa_stream_unref : ma_proc;
                  pa_stream_connect_playback : ma_proc;
                  pa_stream_connect_record : ma_proc;
                  pa_stream_disconnect : ma_proc;
                  pa_stream_get_state : ma_proc;
                  pa_stream_get_sample_spec : ma_proc;
                  pa_stream_get_channel_map : ma_proc;
                  pa_stream_get_buffer_attr : ma_proc;
                  pa_stream_set_buffer_attr : ma_proc;
                  pa_stream_get_device_name : ma_proc;
                  pa_stream_set_write_callback : ma_proc;
                  pa_stream_set_read_callback : ma_proc;
                  pa_stream_set_suspended_callback : ma_proc;
                  pa_stream_set_moved_callback : ma_proc;
                  pa_stream_is_suspended : ma_proc;
                  pa_stream_flush : ma_proc;
                  pa_stream_drain : ma_proc;
                  pa_stream_is_corked : ma_proc;
                  pa_stream_cork : ma_proc;
                  pa_stream_trigger : ma_proc;
                  pa_stream_begin_write : ma_proc;
                  pa_stream_write : ma_proc;
                  pa_stream_peek : ma_proc;
                  pa_stream_drop : ma_proc;
                  pa_stream_writable_size : ma_proc;
                  pa_stream_readable_size : ma_proc;
                  pMainLoop : ma_ptr;
                  pPulseContext : ma_ptr;
                  pApplicationName : ^char;
                  pServerName : ^char;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_JACK}
              jack : record
                  jackSO : ma_handle;
                  jack_client_open : ma_proc;
                  jack_client_close : ma_proc;
                  jack_client_name_size : ma_proc;
                  jack_set_process_callback : ma_proc;
                  jack_set_buffer_size_callback : ma_proc;
                  jack_on_shutdown : ma_proc;
                  jack_get_sample_rate : ma_proc;
                  jack_get_buffer_size : ma_proc;
                  jack_get_ports : ma_proc;
                  jack_activate : ma_proc;
                  jack_deactivate : ma_proc;
                  jack_connect : ma_proc;
                  jack_port_register : ma_proc;
                  jack_port_name : ma_proc;
                  jack_port_get_buffer : ma_proc;
                  jack_free : ma_proc;
                  pClientName : ^char;
                  tryStartServer : ma_bool32;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_COREAUDIO}
              coreaudio : record
                  hCoreFoundation : ma_handle;
                  CFStringGetCString : ma_proc;
                  CFRelease : ma_proc;
                  hCoreAudio : ma_handle;
                  AudioObjectGetPropertyData : ma_proc;
                  AudioObjectGetPropertyDataSize : ma_proc;
                  AudioObjectSetPropertyData : ma_proc;
                  AudioObjectAddPropertyListener : ma_proc;
                  AudioObjectRemovePropertyListener : ma_proc;
                  hAudioUnit : ma_handle;
                  AudioComponentFindNext : ma_proc;
                  AudioComponentInstanceDispose : ma_proc;
                  AudioComponentInstanceNew : ma_proc;
                  AudioOutputUnitStart : ma_proc;
                  AudioOutputUnitStop : ma_proc;
                  AudioUnitAddPropertyListener : ma_proc;
                  AudioUnitGetPropertyInfo : ma_proc;
                  AudioUnitGetProperty : ma_proc;
                  AudioUnitSetProperty : ma_proc;
                  AudioUnitInitialize : ma_proc;
                  AudioUnitRender : ma_proc;
                  component : ma_ptr;
                  noAudioSessionDeactivate : ma_bool32;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_SNDIO}
              sndio : record
                  sndioSO : ma_handle;
                  sio_open : ma_proc;
                  sio_close : ma_proc;
                  sio_setpar : ma_proc;
                  sio_getpar : ma_proc;
                  sio_getcap : ma_proc;
                  sio_start : ma_proc;
                  sio_stop : ma_proc;
                  sio_read : ma_proc;
                  sio_write : ma_proc;
                  sio_onmove : ma_proc;
                  sio_nfds : ma_proc;
                  sio_pollfd : ma_proc;
                  sio_revents : ma_proc;
                  sio_eof : ma_proc;
                  sio_setvol : ma_proc;
                  sio_onvol : ma_proc;
                  sio_initpar : ma_proc;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_AUDIO4}
              audio4 : record
                  _unused : longint;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_OSS}
              oss : record
                  versionMajor : longint;
                  versionMinor : longint;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_AAUDIO}
               aaudio : record
                  hAAudio : ma_handle;
                  AAudio_createStreamBuilder : ma_proc;
                  AAudioStreamBuilder_delete : ma_proc;
                  AAudioStreamBuilder_setDeviceId : ma_proc;
                  AAudioStreamBuilder_setDirection : ma_proc;
                  AAudioStreamBuilder_setSharingMode : ma_proc;
                  AAudioStreamBuilder_setFormat : ma_proc;
                  AAudioStreamBuilder_setChannelCount : ma_proc;
                  AAudioStreamBuilder_setSampleRate : ma_proc;
                  AAudioStreamBuilder_setBufferCapacityInFrames : ma_proc;
                  AAudioStreamBuilder_setFramesPerDataCallback : ma_proc;
                  AAudioStreamBuilder_setDataCallback : ma_proc;
                  AAudioStreamBuilder_setErrorCallback : ma_proc;
                  AAudioStreamBuilder_setPerformanceMode : ma_proc;
                  AAudioStreamBuilder_setUsage : ma_proc;
                  AAudioStreamBuilder_setContentType : ma_proc;
                  AAudioStreamBuilder_setInputPreset : ma_proc;
                  AAudioStreamBuilder_setAllowedCapturePolicy : ma_proc;
                  AAudioStreamBuilder_openStream : ma_proc;
                  AAudioStream_close : ma_proc;
                  AAudioStream_getState : ma_proc;
                  AAudioStream_waitForStateChange : ma_proc;
                  AAudioStream_getFormat : ma_proc;
                  AAudioStream_getChannelCount : ma_proc;
                  AAudioStream_getSampleRate : ma_proc;
                  AAudioStream_getBufferCapacityInFrames : ma_proc;
                  AAudioStream_getFramesPerDataCallback : ma_proc;
                  AAudioStream_getFramesPerBurst : ma_proc;
                  AAudioStream_requestStart : ma_proc;
                  AAudioStream_requestStop : ma_proc;
                  jobThread : ma_device_job_thread;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_OPENSL}
              opensl : record
                  libOpenSLES : ma_handle;
                  SL_IID_ENGINE : ma_handle;
                  SL_IID_AUDIOIODEVICECAPABILITIES : ma_handle;
                  SL_IID_ANDROIDSIMPLEBUFFERQUEUE : ma_handle;
                  SL_IID_RECORD : ma_handle;
                  SL_IID_PLAY : ma_handle;
                  SL_IID_OUTPUTMIX : ma_handle;
                  SL_IID_ANDROIDCONFIGURATION : ma_handle;
                  slCreateEngine : ma_proc;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_WEBAUDIO}
              webaudio : record
                  _unused : longint;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_NULL}
              null_backend : record
                  _unused : longint;
                end;
          {$endif}
            end;
        _ex2 : record
          {$ifdef MA_WIN32}
               win32 : record
                  hOle32DLL : ma_handle;
                  CoInitialize : ma_proc;
                  CoInitializeEx : ma_proc;
                  CoUninitialize : ma_proc;
                  CoCreateInstance : ma_proc;
                  CoTaskMemFree : ma_proc;
                  PropVariantClear : ma_proc;
                  StringFromGUID2 : ma_proc;
                  hUser32DLL : ma_handle;
                  GetForegroundWindow : ma_proc;
                  GetDesktopWindow : ma_proc;
                  hAdvapi32DLL : ma_handle;
                  RegOpenKeyExA : ma_proc;
                  RegCloseKey : ma_proc;
                  RegQueryValueExA : ma_proc;
                  CoInitializeResult : longint;
                end;
          {$endif}
          {$ifdef MA_POSIX}
              posix : record
                  _unused : longint;
                end;
          {$endif}
               _unused : longint;
            end;
      end;

  { The state of the device is variable and can change at any time on any thread. Must be used atomically.  }
  { Set once at initialization time and should not be changed after.  }
  { Set once at initialization time and should not be changed after.  }
  { DEPRECATED. Use the notification callback instead. Set once at initialization time and should not be changed after.  }
  { Application defined data.  }
  { This is set by the worker thread after it's finished doing a job.  }
  { When set to true, uninitializing the device will also uninitialize the context. Set to true when NULL is passed into ma_device_init().  }
  { Linear 0..1. Can be read and written simultaneously by different threads. Must be used atomically.  }
  { Intermediary buffer for duplex device on asynchronous backends.  }
  { Set to NULL if using default ID, otherwise set to the address of "id".  }
  { If using an explicit device, will be set to a copy of the ID used for initialization. Otherwise cleared to 0.  }
  { Maybe temporary. Likely to be replaced with a query API.  }
  { Set to whatever was passed in when the device was initialized.  }
  { For implementing fixed sized buffer callbacks. Will be null if using variable sized callbacks.  }
  { How many valid frames are sitting in the intermediary buffer.  }
  { In external format. Can be null.  }
  { Set to NULL if using default ID, otherwise set to the address of "id".  }
  { If using an explicit device, will be set to a copy of the ID used for initialization. Otherwise cleared to 0.  }
  { Maybe temporary. Likely to be replaced with a query API.  }
  { Set to whatever was passed in when the device was initialized.  }
  { For implementing fixed sized buffer callbacks. Will be null if using variable sized callbacks.  }
  { How many valid frames are sitting in the intermediary buffer.  }
{$ifdef MA_SUPPORT_WASAPI}
  {IAudioClient* }  {IAudioClient* }  {IAudioRenderClient* }  {IAudioCaptureClient* }  {IMMDeviceEnumerator* }  { Used for IMMNotificationClient notifications. Required for detecting default device changes.  }
  {HANDLE }  { Auto reset. Initialized to signaled.  }
  {HANDLE }  { Auto reset. Initialized to unsignaled.  }
  { Value from GetBufferSize(). internalPeriodSizeInFrames is not set to the _actual_ buffer size when low-latency shared mode is being used due to the way the IAudioClient3 API works.  }
  { Can be read and written simultaneously across different threads. Must be used atomically, and must be 32-bit.  }
  { Can be read and written simultaneously across different threads. Must be used atomically, and must be 32-bit.  }
  { When set to true, disables the use of AUDCLNT_STREAMFLAGS_AUTOCONVERTPCM.  }
  { When set to true, disables the use of AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY.  }
{$endif}
{$ifdef MA_SUPPORT_DSOUND}
  {LPDIRECTSOUND }  {LPDIRECTSOUNDBUFFER }  {LPDIRECTSOUNDBUFFER }  {LPDIRECTSOUNDCAPTURE }  {LPDIRECTSOUNDCAPTUREBUFFER }{$endif}
{$ifdef MA_SUPPORT_WINMM}
  {HWAVEOUT }  {HWAVEIN }  {HANDLE }  {HANDLE }  { [0,periods). Used as an index into pWAVEHDRPlayback.  }
  { [0,periods). Used as an index into pWAVEHDRCapture.  }
  { The number of PCM frames consumed in the buffer in pWAVEHEADER[iNextHeader].  }
  { ^^^  }
  {WAVEHDR* }  { One instantiation for each period.  }
  {WAVEHDR* }  { One instantiation for each period.  }
  { Used internally and is used for the heap allocated data for the intermediary buffer and the WAVEHDR structures.  }
{$endif}
{$ifdef MA_SUPPORT_ALSA}
  {snd_pcm_t* }  {snd_pcm_t* }  {struct pollfd* }  {struct pollfd* }  { eventfd for waking up from poll() when the playback device is stopped.  }
  { eventfd for waking up from poll() when the capture device is stopped.  }
{$endif}
{$ifdef MA_SUPPORT_PULSEAUDIO}
  {pa_mainloop* }  {pa_context* }  {pa_stream* }  {pa_stream* }{$endif}
{$ifdef MA_SUPPORT_JACK}
  {jack_client_t* }  {jack_port_t* }  {jack_port_t* }  { Typed as a float because JACK is always floating point.  }
{$endif}
{$ifdef MA_SUPPORT_COREAUDIO}
  {AudioUnit }  {AudioUnit }  {AudioBufferList* }  { Only used for input devices.  }
  { Only used for input devices. The capacity in frames of each buffer in pAudioBufferList.  }
  { <-- Set to true when the default device has changed and miniaudio is in the process of switching.  }
  { <-- Set to true when the default device has changed and miniaudio is in the process of switching.  }
  { Only used on mobile platforms. Obj-C object for handling route changes.  }
{$endif}
{$ifdef MA_SUPPORT_SNDIO}
{$endif}
{$ifdef MA_SUPPORT_AUDIO4}
{$endif}
{$ifdef MA_SUPPORT_OSS}
{$endif}
{$ifdef MA_SUPPORT_AAUDIO}
  {AAudioStream* }  {AAudioStream* }{$endif}
{$ifdef MA_SUPPORT_OPENSL}
  {SLObjectItf }  {SLOutputMixItf }  {SLObjectItf }  {SLPlayItf }  {SLObjectItf }  {SLRecordItf }  {SLAndroidSimpleBufferQueueItf }  {SLAndroidSimpleBufferQueueItf }  { This is malloc()'d and is used for storing audio data. Typed as ma_uint8 for easy offsetting.  }
{$endif}
{$ifdef MA_SUPPORT_WEBAUDIO}
  { AudioWorklets path.  }
  { EMSCRIPTEN_WEBAUDIO_T  }  { EMSCRIPTEN_WEBAUDIO_T  }  { Set to MA_BUSY while initialization is in progress.  }
  { We store the device in a list on the JavaScript side. This is used to map our C object to the JS object.  }
{$endif}
{$ifdef MA_SUPPORT_NULL}
  { Read and written by multiple threads. Must be used atomically, and must be 32-bit for compiler compatibility.  }
{$endif}

    ma_device = record
        pContext : ^ma_context;
        _type : ma_device_type;
        sampleRate : ma_uint32;
        state : ma_atomic_device_state;
        onData : ma_device_data_proc;
        onNotification : ma_device_notification_proc;
        onStop : ma_stop_proc;
        pUserData : pointer;
        startStopLock : ma_mutex;
        wakeupEvent : ma_event;
        startEvent : ma_event;
        stopEvent : ma_event;
        thread : ma_thread;
        workResult : ma_result;
        isOwnerOfContext : ma_bool8;
        noPreSilencedOutputBuffer : ma_bool8;
        noClip : ma_bool8;
        noDisableDenormals : ma_bool8;
        noFixedSizedCallback : ma_bool8;
        masterVolumeFactor : ma_atomic_float;
        duplexRB : ma_duplex_rb;
        resampling : record
            algorithm : ma_resample_algorithm;
            pBackendVTable : ^ma_resampling_backend_vtable;
            pBackendUserData : pointer;
            linear : record
                lpfOrder : ma_uint32;
              end;
          end;
        playback : record
            pID : ^ma_device_id;
            id : ma_device_id;
            name : array[0..(MA_MAX_DEVICE_NAME_LENGTH+1)-1] of char;
            shareMode : ma_share_mode;
            format : ma_format;
            channels : ma_uint32;
            channelMap : array[0..(MA_MAX_CHANNELS)-1] of ma_channel;
            internalFormat : ma_format;
            internalChannels : ma_uint32;
            internalSampleRate : ma_uint32;
            internalChannelMap : array[0..(MA_MAX_CHANNELS)-1] of ma_channel;
            internalPeriodSizeInFrames : ma_uint32;
            internalPeriods : ma_uint32;
            channelMixMode : ma_channel_mix_mode;
            calculateLFEFromSpatialChannels : ma_bool32;
            converter : ma_data_converter;
            pIntermediaryBuffer : pointer;
            intermediaryBufferCap : ma_uint32;
            intermediaryBufferLen : ma_uint32;
            pInputCache : pointer;
            inputCacheCap : ma_uint64;
            inputCacheConsumed : ma_uint64;
            inputCacheRemaining : ma_uint64;
          end;
        capture : record
            pID : ^ma_device_id;
            id : ma_device_id;
            name : array[0..(MA_MAX_DEVICE_NAME_LENGTH+1)-1] of char;
            shareMode : ma_share_mode;
            format : ma_format;
            channels : ma_uint32;
            channelMap : array[0..(MA_MAX_CHANNELS)-1] of ma_channel;
            internalFormat : ma_format;
            internalChannels : ma_uint32;
            internalSampleRate : ma_uint32;
            internalChannelMap : array[0..(MA_MAX_CHANNELS)-1] of ma_channel;
            internalPeriodSizeInFrames : ma_uint32;
            internalPeriods : ma_uint32;
            channelMixMode : ma_channel_mix_mode;
            calculateLFEFromSpatialChannels : ma_bool32;
            converter : ma_data_converter;
            pIntermediaryBuffer : pointer;
            intermediaryBufferCap : ma_uint32;
            intermediaryBufferLen : ma_uint32;
          end;
        _ex : record
          {$ifdef MA_SUPPORT_WASAPI}
               wasapi : record
                  pAudioClientPlayback : ma_ptr;
                  pAudioClientCapture : ma_ptr;
                  pRenderClient : ma_ptr;
                  pCaptureClient : ma_ptr;
                  pDeviceEnumerator : ma_ptr;
                  notificationClient : ma_IMMNotificationClient;
                  hEventPlayback : ma_handle;
                  hEventCapture : ma_handle;
                  actualBufferSizeInFramesPlayback : ma_uint32;
                  actualBufferSizeInFramesCapture : ma_uint32;
                  originalPeriodSizeInFrames : ma_uint32;
                  originalPeriodSizeInMilliseconds : ma_uint32;
                  originalPeriods : ma_uint32;
                  originalPerformanceProfile : ma_performance_profile;
                  periodSizeInFramesPlayback : ma_uint32;
                  periodSizeInFramesCapture : ma_uint32;
                  pMappedBufferCapture : pointer;
                  mappedBufferCaptureCap : ma_uint32;
                  mappedBufferCaptureLen : ma_uint32;
                  pMappedBufferPlayback : pointer;
                  mappedBufferPlaybackCap : ma_uint32;
                  mappedBufferPlaybackLen : ma_uint32;
                  isStartedCapture : ma_atomic_bool32;
                  isStartedPlayback : ma_atomic_bool32;
                  loopbackProcessID : ma_uint32;
                  loopbackProcessExclude : ma_bool8;
                  noAutoConvertSRC : ma_bool8;
                  noDefaultQualitySRC : ma_bool8;
                  noHardwareOffloading : ma_bool8;
                  allowCaptureAutoStreamRouting : ma_bool8;
                  allowPlaybackAutoStreamRouting : ma_bool8;
                  isDetachedPlayback : ma_bool8;
                  isDetachedCapture : ma_bool8;
                  usage : ma_wasapi_usage;
                  hAvrtHandle : pointer;
                  rerouteLock : ma_mutex;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_DSOUND}
               dsound : record
                  pPlayback : ma_ptr;
                  pPlaybackPrimaryBuffer : ma_ptr;
                  pPlaybackBuffer : ma_ptr;
                  pCapture : ma_ptr;
                  pCaptureBuffer : ma_ptr;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_WINMM}
               winmm : record
                  hDevicePlayback : ma_handle;
                  hDeviceCapture : ma_handle;
                  hEventPlayback : ma_handle;
                  hEventCapture : ma_handle;
                  fragmentSizeInFrames : ma_uint32;
                  iNextHeaderPlayback : ma_uint32;
                  iNextHeaderCapture : ma_uint32;
                  headerFramesConsumedPlayback : ma_uint32;
                  headerFramesConsumedCapture : ma_uint32;
                  pWAVEHDRPlayback : ^ma_uint8;
                  pWAVEHDRCapture : ^ma_uint8;
                  pIntermediaryBufferPlayback : ^ma_uint8;
                  pIntermediaryBufferCapture : ^ma_uint8;
                  _pHeapData : ^ma_uint8;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_ALSA}
              alsa : record
                  pPCMPlayback : ma_ptr;
                  pPCMCapture : ma_ptr;
                  pPollDescriptorsPlayback : pointer;
                  pPollDescriptorsCapture : pointer;
                  pollDescriptorCountPlayback : longint;
                  pollDescriptorCountCapture : longint;
                  wakeupfdPlayback : longint;
                  wakeupfdCapture : longint;
                  isUsingMMapPlayback : ma_bool8;
                  isUsingMMapCapture : ma_bool8;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_PULSEAUDIO}
               pulse : record
                  pMainLoop : ma_ptr;
                  pPulseContext : ma_ptr;
                  pStreamPlayback : ma_ptr;
                  pStreamCapture : ma_ptr;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_JACK}
              jack : record
                  pClient : ma_ptr;
                  ppPortsPlayback : ^ma_ptr;
                  ppPortsCapture : ^ma_ptr;
                  pIntermediaryBufferPlayback : ^single;
                  pIntermediaryBufferCapture : ^single;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_COREAUDIO}
               coreaudio : record
                  deviceObjectIDPlayback : ma_uint32;
                  deviceObjectIDCapture : ma_uint32;
                  audioUnitPlayback : ma_ptr;
                  audioUnitCapture : ma_ptr;
                  pAudioBufferList : ma_ptr;
                  audioBufferCapInFrames : ma_uint32;
                  stopEvent : ma_event;
                  originalPeriodSizeInFrames : ma_uint32;
                  originalPeriodSizeInMilliseconds : ma_uint32;
                  originalPeriods : ma_uint32;
                  originalPerformanceProfile : ma_performance_profile;
                  isDefaultPlaybackDevice : ma_bool32;
                  isDefaultCaptureDevice : ma_bool32;
                  isSwitchingPlaybackDevice : ma_bool32;
                  isSwitchingCaptureDevice : ma_bool32;
                  pNotificationHandler : pointer;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_SNDIO}
               sndio : record
                  handlePlayback : ma_ptr;
                  handleCapture : ma_ptr;
                  isStartedPlayback : ma_bool32;
                  isStartedCapture : ma_bool32;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_AUDIO4}
               audio4 : record
                  fdPlayback : longint;
                  fdCapture : longint;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_OSS}
               oss : record
                  fdPlayback : longint;
                  fdCapture : longint;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_AAUDIO}
               aaudio : record
                  pStreamPlayback : ma_ptr;
                  pStreamCapture : ma_ptr;
                  usage : ma_aaudio_usage;
                  contentType : ma_aaudio_content_type;
                  inputPreset : ma_aaudio_input_preset;
                  allowedCapturePolicy : ma_aaudio_allowed_capture_policy;
                  noAutoStartAfterReroute : ma_bool32;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_OPENSL}
               opensl : record
                  pOutputMixObj : ma_ptr;
                  pOutputMix : ma_ptr;
                  pAudioPlayerObj : ma_ptr;
                  pAudioPlayer : ma_ptr;
                  pAudioRecorderObj : ma_ptr;
                  pAudioRecorder : ma_ptr;
                  pBufferQueuePlayback : ma_ptr;
                  pBufferQueueCapture : ma_ptr;
                  isDrainingCapture : ma_bool32;
                  isDrainingPlayback : ma_bool32;
                  currentBufferIndexPlayback : ma_uint32;
                  currentBufferIndexCapture : ma_uint32;
                  pBufferPlayback : ^ma_uint8;
                  pBufferCapture : ^ma_uint8;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_WEBAUDIO}
               webaudio : record
                  audioContext : longint;
                  audioWorklet : longint;
                  pIntermediaryBuffer : ^single;
                  pStackBuffer : pointer;
                  initResult : ma_result;
                  deviceIndex : longint;
                end;
          {$endif}
          {$ifdef MA_SUPPORT_NULL}
               null_device : record
                  deviceThread : ma_thread;
                  operationEvent : ma_event;
                  operationCompletionEvent : ma_event;
                  operationSemaphore : ma_semaphore;
                  operation : ma_uint32;
                  operationResult : ma_result;
                  timer : ma_timer;
                  priorRunTime : double;
                  currentPeriodFramesRemainingPlayback : ma_uint32;
                  currentPeriodFramesRemainingCapture : ma_uint32;
                  lastProcessedFramePlayback : ma_uint64;
                  lastProcessedFrameCapture : ma_uint64;
                  isStarted : ma_atomic_bool32;
                end;
          {$endif}
            end;
      end;

  {
  Initializes a `ma_context_config` object.
  
  
  Return Value
  ------------
  A `ma_context_config` initialized to defaults.
  
  
  Remarks
  -------
  You must always use this to initialize the default state of the `ma_context_config` object. Not using this will result in your program breaking when miniaudio
  is updated and new members are added to `ma_context_config`. It also sets logical defaults.
  
  You can override members of the returned object by changing it's members directly.
  
  
  See Also
  --------
  ma_context_init()
   }


  {
  Initializes a context.
  
  The context is used for selecting and initializing an appropriate backend and to represent the backend at a more global level than that of an individual
  device. There is one context to many devices, and a device is created from a context. A context is required to enumerate devices.
  
  
  Parameters
  ----------
  backends (in, optional)
      A list of backends to try initializing, in priority order. Can be NULL, in which case it uses default priority order.
  
  backendCount (in, optional)
      The number of items in `backend`. Ignored if `backend` is NULL.
  
  pConfig (in, optional)
      The context configuration.
  
  pContext (in)
      A pointer to the context object being initialized.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. Do not call this function across multiple threads as some backends read and write to global state.
  
  
  Remarks
  -------
  When `backends` is NULL, the default priority order will be used. Below is a list of backends in priority order:
  
      |-------------|-----------------------|--------------------------------------------------------|
      | Name        | Enum Name             | Supported Operating Systems                            |
      |-------------|-----------------------|--------------------------------------------------------|
      | WASAPI      | ma_backend_wasapi     | Windows Vista+                                         |
      | DirectSound | ma_backend_dsound     | Windows XP+                                            |
      | WinMM       | ma_backend_winmm      | Windows XP+ (may work on older versions, but untested) |
      | Core Audio  | ma_backend_coreaudio  | macOS, iOS                                             |
      | ALSA        | ma_backend_alsa       | Linux                                                  |
      | PulseAudio  | ma_backend_pulseaudio | Cross Platform (disabled on Windows, BSD and Android)  |
      | JACK        | ma_backend_jack       | Cross Platform (disabled on BSD and Android)           |
      | sndio       | ma_backend_sndio      | OpenBSD                                                |
      | audio(4)    | ma_backend_audio4     | NetBSD, OpenBSD                                        |
      | OSS         | ma_backend_oss        | FreeBSD                                                |
      | AAudio      | ma_backend_aaudio     | Android 8+                                             |
      | OpenSL|ES   | ma_backend_opensl     | Android (API level 16+)                                |
      | Web Audio   | ma_backend_webaudio   | Web (via Emscripten)                                   |
      | Null        | ma_backend_null       | Cross Platform (not used on Web)                       |
      |-------------|-----------------------|--------------------------------------------------------|
  
  The context can be configured via the `pConfig` argument. The config object is initialized with `ma_context_config_init()`. Individual configuration settings
  can then be set directly on the structure. Below are the members of the `ma_context_config` object.
  
      pLog
          A pointer to the `ma_log` to post log messages to. Can be NULL if the application does not
          require logging. See the `ma_log` API for details on how to use the logging system.
  
      threadPriority
          The desired priority to use for the audio thread. Allowable values include the following:
  
          |--------------------------------------|
          | Thread Priority                      |
          |--------------------------------------|
          | ma_thread_priority_idle              |
          | ma_thread_priority_lowest            |
          | ma_thread_priority_low               |
          | ma_thread_priority_normal            |
          | ma_thread_priority_high              |
          | ma_thread_priority_highest (default) |
          | ma_thread_priority_realtime          |
          | ma_thread_priority_default           |
          |--------------------------------------|
  
      threadStackSize
          The desired size of the stack for the audio thread. Defaults to the operating system's default.
  
      pUserData
          A pointer to application-defined data. This can be accessed from the context object directly such as `context.pUserData`.
  
      allocationCallbacks
          Structure containing custom allocation callbacks. Leaving this at defaults will cause it to use MA_MALLOC, MA_REALLOC and MA_FREE. These allocation
          callbacks will be used for anything tied to the context, including devices.
  
      alsa.useVerboseDeviceEnumeration
          ALSA will typically enumerate many different devices which can be intrusive and not user-friendly. To combat this, miniaudio will enumerate only unique
          card/device pairs by default. The problem with this is that you lose a bit of flexibility and control. Setting alsa.useVerboseDeviceEnumeration makes
          it so the ALSA backend includes all devices. Defaults to false.
  
      pulse.pApplicationName
          PulseAudio only. The application name to use when initializing the PulseAudio context with `pa_context_new()`.
  
      pulse.pServerName
          PulseAudio only. The name of the server to connect to with `pa_context_connect()`.
  
      pulse.tryAutoSpawn
          PulseAudio only. Whether or not to try automatically starting the PulseAudio daemon. Defaults to false. If you set this to true, keep in mind that
          miniaudio uses a trial and error method to find the most appropriate backend, and this will result in the PulseAudio daemon starting which may be
          intrusive for the end user.
  
      coreaudio.sessionCategory
          iOS only. The session category to use for the shared AudioSession instance. Below is a list of allowable values and their Core Audio equivalents.
  
          |-----------------------------------------|-------------------------------------|
          | miniaudio Token                         | Core Audio Token                    |
          |-----------------------------------------|-------------------------------------|
          | ma_ios_session_category_ambient         | AVAudioSessionCategoryAmbient       |
          | ma_ios_session_category_solo_ambient    | AVAudioSessionCategorySoloAmbient   |
          | ma_ios_session_category_playback        | AVAudioSessionCategoryPlayback      |
          | ma_ios_session_category_record          | AVAudioSessionCategoryRecord        |
          | ma_ios_session_category_play_and_record | AVAudioSessionCategoryPlayAndRecord |
          | ma_ios_session_category_multi_route     | AVAudioSessionCategoryMultiRoute    |
          | ma_ios_session_category_none            | AVAudioSessionCategoryAmbient       |
          | ma_ios_session_category_default         | AVAudioSessionCategoryAmbient       |
          |-----------------------------------------|-------------------------------------|
  
      coreaudio.sessionCategoryOptions
          iOS only. Session category options to use with the shared AudioSession instance. Below is a list of allowable values and their Core Audio equivalents.
  
          |---------------------------------------------------------------------------|------------------------------------------------------------------|
          | miniaudio Token                                                           | Core Audio Token                                                 |
          |---------------------------------------------------------------------------|------------------------------------------------------------------|
          | ma_ios_session_category_option_mix_with_others                            | AVAudioSessionCategoryOptionMixWithOthers                        |
          | ma_ios_session_category_option_duck_others                                | AVAudioSessionCategoryOptionDuckOthers                           |
          | ma_ios_session_category_option_allow_bluetooth                            | AVAudioSessionCategoryOptionAllowBluetooth                       |
          | ma_ios_session_category_option_default_to_speaker                         | AVAudioSessionCategoryOptionDefaultToSpeaker                     |
          | ma_ios_session_category_option_interrupt_spoken_audio_and_mix_with_others | AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers |
          | ma_ios_session_category_option_allow_bluetooth_a2dp                       | AVAudioSessionCategoryOptionAllowBluetoothA2DP                   |
          | ma_ios_session_category_option_allow_air_play                             | AVAudioSessionCategoryOptionAllowAirPlay                         |
          |---------------------------------------------------------------------------|------------------------------------------------------------------|
  
      coreaudio.noAudioSessionActivate
          iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:true] on initialization.
  
      coreaudio.noAudioSessionDeactivate
          iOS only. When set to true, does not perform an explicit [[AVAudioSession sharedInstace] setActive:false] on uninitialization.
  
      jack.pClientName
          The name of the client to pass to `jack_client_open()`.
  
      jack.tryStartServer
          Whether or not to try auto-starting the JACK server. Defaults to false.
  
  
  It is recommended that only a single context is active at any given time because it's a bulky data structure which performs run-time linking for the
  relevant backends every time it's initialized.
  
  The location of the context cannot change throughout it's lifetime. Consider allocating the `ma_context` object with `malloc()` if this is an issue. The
  reason for this is that a pointer to the context is stored in the `ma_device` structure.
  
  
  Example 1 - Default Initialization
  ----------------------------------
  The example below shows how to initialize the context using the default configuration.
  
  ```c
  ma_context context;
  ma_result result = ma_context_init(NULL, 0, NULL, &context);
  if (result != MA_SUCCESS) 
      // Error.
  
  ```
  
  
  Example 2 - Custom Configuration
  --------------------------------
  The example below shows how to initialize the context using custom backend priorities and a custom configuration. In this hypothetical example, the program
  wants to prioritize ALSA over PulseAudio on Linux. They also want to avoid using the WinMM backend on Windows because it's latency is too high. They also
  want an error to be returned if no valid backend is available which they achieve by excluding the Null backend.
  
  For the configuration, the program wants to capture any log messages so they can, for example, route it to a log file and user interface.
  
  ```c
  ma_backend backends[] = 
      ma_backend_alsa,
      ma_backend_pulseaudio,
      ma_backend_wasapi,
      ma_backend_dsound
  ;
  
  ma_log log;
  ma_log_init(&log);
  ma_log_register_callback(&log, ma_log_callback_init(my_log_callbac, pMyLogUserData));
  
  ma_context_config config = ma_context_config_init();
  config.pLog = &log; // Specify a custom log object in the config so any logs that are posted from ma_context_init() are captured.
  
  ma_context context;
  ma_result result = ma_context_init(backends, sizeof(backends)/sizeof(backends[0]), &config, &context);
  if (result != MA_SUCCESS) 
      // Error.
      if (result == MA_NO_BACKEND) 
          // Couldn't find an appropriate backend.
      
  
  
  // You could also attach a log callback post-initialization:
  ma_log_register_callback(ma_context_get_log(&context), ma_log_callback_init(my_log_callback, pMyLogUserData));
  ```
  
  
  See Also
  --------
  ma_context_config_init()
  ma_context_uninit()
   }
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Uninitializes a context.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. Do not call this function across multiple threads as some backends read and write to global state.
  
  
  Remarks
  -------
  Results are undefined if you call this while any device created by this context is still active.
  
  
  See Also
  --------
  ma_context_init()
   }

  {
  Retrieves the size of the ma_context object.
  
  This is mainly for the purpose of bindings to know how much memory to allocate.
   }

  {
  Retrieves a pointer to the log object associated with this context.
  
  
  Remarks
  -------
  Pass the returned pointer to `ma_log_post()`, `ma_log_postv()` or `ma_log_postf()` to post a log
  message.
  
  You can attach your own logging callback to the log with `ma_log_register_callback()`
  
  
  Return Value
  ------------
  A pointer to the `ma_log` object that the context uses to post log messages. If some error occurs,
  NULL will be returned.
   }

  {
  Enumerates over every device (both playback and capture).
  
  This is a lower-level enumeration function to the easier to use `ma_context_get_devices()`. Use `ma_context_enumerate_devices()` if you would rather not incur
  an internal heap allocation, or it simply suits your code better.
  
  Note that this only retrieves the ID and name/description of the device. The reason for only retrieving basic information is that it would otherwise require
  opening the backend device in order to probe it for more detailed information which can be inefficient. Consider using `ma_context_get_device_info()` for this,
  but don't call it from within the enumeration callback.
  
  Returning false from the callback will stop enumeration. Returning true will continue enumeration.
  
  
  Parameters
  ----------
  pContext (in)
      A pointer to the context performing the enumeration.
  
  callback (in)
      The callback to fire for each enumerated device.
  
  pUserData (in)
      A pointer to application-defined data passed to the callback.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Safe. This is guarded using a simple mutex lock.
  
  
  Remarks
  -------
  Do _not_ assume the first enumerated device of a given type is the default device.
  
  Some backends and platforms may only support default playback and capture devices.
  
  In general, you should not do anything complicated from within the callback. In particular, do not try initializing a device from within the callback. Also,
  do not try to call `ma_context_get_device_info()` from within the callback.
  
  Consider using `ma_context_get_devices()` for a simpler and safer API, albeit at the expense of an internal heap allocation.
  
  
  Example 1 - Simple Enumeration
  ------------------------------
  ma_bool32 ma_device_enum_callback(ma_context* pContext, ma_device_type deviceType, const ma_device_info* pInfo, void* pUserData)
  
      printf("Device Name: %s\n", pInfo->name);
      return MA_TRUE;
  
  
  ma_result result = ma_context_enumerate_devices(&context, my_device_enum_callback, pMyUserData);
  if (result != MA_SUCCESS) 
      // Error.
  
  
  
  See Also
  --------
  ma_context_get_devices()
   }

  {
  Retrieves basic information about every active playback and/or capture device.
  
  This function will allocate memory internally for the device lists and return a pointer to them through the `ppPlaybackDeviceInfos` and `ppCaptureDeviceInfos`
  parameters. If you do not want to incur the overhead of these allocations consider using `ma_context_enumerate_devices()` which will instead use a callback.
  
  
  Parameters
  ----------
  pContext (in)
      A pointer to the context performing the enumeration.
  
  ppPlaybackDeviceInfos (out)
      A pointer to a pointer that will receive the address of a buffer containing the list of `ma_device_info` structures for playback devices.
  
  pPlaybackDeviceCount (out)
      A pointer to an unsigned integer that will receive the number of playback devices.
  
  ppCaptureDeviceInfos (out)
      A pointer to a pointer that will receive the address of a buffer containing the list of `ma_device_info` structures for capture devices.
  
  pCaptureDeviceCount (out)
      A pointer to an unsigned integer that will receive the number of capture devices.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. Since each call to this function invalidates the pointers from the previous call, you should not be calling this simultaneously across multiple
  threads. Instead, you need to make a copy of the returned data with your own higher level synchronization.
  
  
  Remarks
  -------
  It is _not_ safe to assume the first device in the list is the default device.
  
  You can pass in NULL for the playback or capture lists in which case they'll be ignored.
  
  The returned pointers will become invalid upon the next call this this function, or when the context is uninitialized. Do not free the returned pointers.
  
  
  See Also
  --------
  ma_context_get_devices()
   }

  {
  Retrieves information about a device of the given type, with the specified ID and share mode.
  
  
  Parameters
  ----------
  pContext (in)
      A pointer to the context performing the query.
  
  deviceType (in)
      The type of the device being queried. Must be either `ma_device_type_playback` or `ma_device_type_capture`.
  
  pDeviceID (in)
      The ID of the device being queried.
  
  pDeviceInfo (out)
      A pointer to the `ma_device_info` structure that will receive the device information.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Safe. This is guarded using a simple mutex lock.
  
  
  Remarks
  -------
  Do _not_ call this from within the `ma_context_enumerate_devices()` callback.
  
  It's possible for a device to have different information and capabilities depending on whether or not it's opened in shared or exclusive mode. For example, in
  shared mode, WASAPI always uses floating point samples for mixing, but in exclusive mode it can be anything. Therefore, this function allows you to specify
  which share mode you want information for. Note that not all backends and devices support shared or exclusive mode, in which case this function will fail if
  the requested share mode is unsupported.
  
  This leaves pDeviceInfo unmodified in the result of an error.
   }
(* Const before type ignored *)

  {
  Determines if the given context supports loopback mode.
  
  
  Parameters
  ----------
  pContext (in)
      A pointer to the context getting queried.
  
  
  Return Value
  ------------
  MA_TRUE if the context supports loopback mode; MA_FALSE otherwise.
   }

  {
  Initializes a device config with default settings.
  
  
  Parameters
  ----------
  deviceType (in)
      The type of the device this config is being initialized for. This must set to one of the following:
  
      |-------------------------|
      | Device Type             |
      |-------------------------|
      | ma_device_type_playback |
      | ma_device_type_capture  |
      | ma_device_type_duplex   |
      | ma_device_type_loopback |
      |-------------------------|
  
  
  Return Value
  ------------
  A new device config object with default settings. You will typically want to adjust the config after this function returns. See remarks.
  
  
  Thread Safety
  -------------
  Safe.
  
  
  Callback Safety
  ---------------
  Safe, but don't try initializing a device in a callback.
  
  
  Remarks
  -------
  The returned config will be initialized to defaults. You will normally want to customize a few variables before initializing the device. See Example 1 for a
  typical configuration which sets the sample format, channel count, sample rate, data callback and user data. These are usually things you will want to change
  before initializing the device.
  
  See `ma_device_init()` for details on specific configuration options.
  
  
  Example 1 - Simple Configuration
  --------------------------------
  The example below is what a program will typically want to configure for each device at a minimum. Notice how `ma_device_config_init()` is called first, and
  then the returned object is modified directly. This is important because it ensures that your program continues to work as new configuration options are added
  to the `ma_device_config` structure.
  
  ```c
  ma_device_config config = ma_device_config_init(ma_device_type_playback);
  config.playback.format   = ma_format_f32;
  config.playback.channels = 2;
  config.sampleRate        = 48000;
  config.dataCallback      = ma_data_callback;
  config.pUserData         = pMyUserData;
  ```
  
  
  See Also
  --------
  ma_device_init()
  ma_device_init_ex()
   }

  {
  Initializes a device.
  
  A device represents a physical audio device. The idea is you send or receive audio data from the device to either play it back through a speaker, or capture it
  from a microphone. Whether or not you should send or receive data from the device (or both) depends on the type of device you are initializing which can be
  playback, capture, full-duplex or loopback. (Note that loopback mode is only supported on select backends.) Sending and receiving audio data to and from the
  device is done via a callback which is fired by miniaudio at periodic time intervals.
  
  The frequency at which data is delivered to and from a device depends on the size of it's period. The size of the period can be defined in terms of PCM frames
  or milliseconds, whichever is more convenient. Generally speaking, the smaller the period, the lower the latency at the expense of higher CPU usage and
  increased risk of glitching due to the more frequent and granular data deliver intervals. The size of a period will depend on your requirements, but
  miniaudio's defaults should work fine for most scenarios. If you're building a game you should leave this fairly small, whereas if you're building a simple
  media player you can make it larger. Note that the period size you request is actually just a hint - miniaudio will tell the backend what you want, but the
  backend is ultimately responsible for what it gives you. You cannot assume you will get exactly what you ask for.
  
  When delivering data to and from a device you need to make sure it's in the correct format which you can set through the device configuration. You just set the
  format that you want to use and miniaudio will perform all of the necessary conversion for you internally. When delivering data to and from the callback you
  can assume the format is the same as what you requested when you initialized the device. See Remarks for more details on miniaudio's data conversion pipeline.
  
  
  Parameters
  ----------
  pContext (in, optional)
      A pointer to the context that owns the device. This can be null, in which case it creates a default context internally.
  
  pConfig (in)
      A pointer to the device configuration. Cannot be null. See remarks for details.
  
  pDevice (out)
      A pointer to the device object being initialized.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. It is not safe to call this function simultaneously for different devices because some backends depend on and mutate global state. The same applies to
  calling this at the same time as `ma_device_uninit()`.
  
  
  Callback Safety
  ---------------
  Unsafe. It is not safe to call this inside any callback.
  
  
  Remarks
  -------
  Setting `pContext` to NULL will result in miniaudio creating a default context internally and is equivalent to passing in a context initialized like so:
  
      ```c
      ma_context_init(NULL, 0, NULL, &context);
      ```
  
  Do not set `pContext` to NULL if you are needing to open multiple devices. You can, however, use NULL when initializing the first device, and then use
  device.pContext for the initialization of other devices.
  
  The device can be configured via the `pConfig` argument. The config object is initialized with `ma_device_config_init()`. Individual configuration settings can
  then be set directly on the structure. Below are the members of the `ma_device_config` object.
  
      deviceType
          Must be `ma_device_type_playback`, `ma_device_type_capture`, `ma_device_type_duplex` of `ma_device_type_loopback`.
  
      sampleRate
          The sample rate, in hertz. The most common sample rates are 48000 and 44100. Setting this to 0 will use the device's native sample rate.
  
      periodSizeInFrames
          The desired size of a period in PCM frames. If this is 0, `periodSizeInMilliseconds` will be used instead. If both are 0 the default buffer size will
          be used depending on the selected performance profile. This value affects latency. See below for details.
  
      periodSizeInMilliseconds
          The desired size of a period in milliseconds. If this is 0, `periodSizeInFrames` will be used instead. If both are 0 the default buffer size will be
          used depending on the selected performance profile. The value affects latency. See below for details.
  
      periods
          The number of periods making up the device's entire buffer. The total buffer size is `periodSizeInFrames` or `periodSizeInMilliseconds` multiplied by
          this value. This is just a hint as backends will be the ones who ultimately decide how your periods will be configured.
  
      performanceProfile
          A hint to miniaudio as to the performance requirements of your program. Can be either `ma_performance_profile_low_latency` (default) or
          `ma_performance_profile_conservative`. This mainly affects the size of default buffers and can usually be left at it's default value.
  
      noPreSilencedOutputBuffer
          When set to true, the contents of the output buffer passed into the data callback will be left undefined. When set to false (default), the contents of
          the output buffer will be cleared the zero. You can use this to avoid the overhead of zeroing out the buffer if you can guarantee that your data
          callback will write to every sample in the output buffer, or if you are doing your own clearing.
  
      noClip
          When set to true, the contents of the output buffer passed into the data callback will be clipped after returning. When set to false (default), the
          contents of the output buffer are left alone after returning and it will be left up to the backend itself to decide whether or not the clip. This only
          applies when the playback sample format is f32.
  
      noDisableDenormals
          By default, miniaudio will disable denormals when the data callback is called. Setting this to true will prevent the disabling of denormals.
  
      noFixedSizedCallback
          Allows miniaudio to fire the data callback with any frame count. When this is set to false (the default), the data callback will be fired with a
          consistent frame count as specified by `periodSizeInFrames` or `periodSizeInMilliseconds`. When set to true, miniaudio will fire the callback with
          whatever the backend requests, which could be anything.
  
      dataCallback
          The callback to fire whenever data is ready to be delivered to or from the device.
  
      notificationCallback
          The callback to fire when something has changed with the device, such as whether or not it has been started or stopped.
  
      pUserData
          The user data pointer to use with the device. You can access this directly from the device object like `device.pUserData`.
  
      resampling.algorithm
          The resampling algorithm to use when miniaudio needs to perform resampling between the rate specified by `sampleRate` and the device's native rate. The
          default value is `ma_resample_algorithm_linear`, and the quality can be configured with `resampling.linear.lpfOrder`.
  
      resampling.pBackendVTable
          A pointer to an optional vtable that can be used for plugging in a custom resampler.
  
      resampling.pBackendUserData
          A pointer that will passed to callbacks in pBackendVTable.
  
      resampling.linear.lpfOrder
          The linear resampler applies a low-pass filter as part of it's processing for anti-aliasing. This setting controls the order of the filter. The higher
          the value, the better the quality, in general. Setting this to 0 will disable low-pass filtering altogether. The maximum value is
          `MA_MAX_FILTER_ORDER`. The default value is `min(4, MA_MAX_FILTER_ORDER)`.
  
      playback.pDeviceID
          A pointer to a `ma_device_id` structure containing the ID of the playback device to initialize. Setting this NULL (default) will use the system's
          default playback device. Retrieve the device ID from the `ma_device_info` structure, which can be retrieved using device enumeration.
  
      playback.format
          The sample format to use for playback. When set to `ma_format_unknown` the device's native format will be used. This can be retrieved after
          initialization from the device object directly with `device.playback.format`.
  
      playback.channels
          The number of channels to use for playback. When set to 0 the device's native channel count will be used. This can be retrieved after initialization
          from the device object directly with `device.playback.channels`.
  
      playback.pChannelMap
          The channel map to use for playback. When left empty, the device's native channel map will be used. This can be retrieved after initialization from the
          device object direct with `device.playback.pChannelMap`. When set, the buffer should contain `channels` items.
  
      playback.shareMode
          The preferred share mode to use for playback. Can be either `ma_share_mode_shared` (default) or `ma_share_mode_exclusive`. Note that if you specify
          exclusive mode, but it's not supported by the backend, initialization will fail. You can then fall back to shared mode if desired by changing this to
          ma_share_mode_shared and reinitializing.
  
      capture.pDeviceID
          A pointer to a `ma_device_id` structure containing the ID of the capture device to initialize. Setting this NULL (default) will use the system's
          default capture device. Retrieve the device ID from the `ma_device_info` structure, which can be retrieved using device enumeration.
  
      capture.format
          The sample format to use for capture. When set to `ma_format_unknown` the device's native format will be used. This can be retrieved after
          initialization from the device object directly with `device.capture.format`.
  
      capture.channels
          The number of channels to use for capture. When set to 0 the device's native channel count will be used. This can be retrieved after initialization
          from the device object directly with `device.capture.channels`.
  
      capture.pChannelMap
          The channel map to use for capture. When left empty, the device's native channel map will be used. This can be retrieved after initialization from the
          device object direct with `device.capture.pChannelMap`. When set, the buffer should contain `channels` items.
  
      capture.shareMode
          The preferred share mode to use for capture. Can be either `ma_share_mode_shared` (default) or `ma_share_mode_exclusive`. Note that if you specify
          exclusive mode, but it's not supported by the backend, initialization will fail. You can then fall back to shared mode if desired by changing this to
          ma_share_mode_shared and reinitializing.
  
      wasapi.noAutoConvertSRC
          WASAPI only. When set to true, disables WASAPI's automatic resampling and forces the use of miniaudio's resampler. Defaults to false.
  
      wasapi.noDefaultQualitySRC
          WASAPI only. Only used when `wasapi.noAutoConvertSRC` is set to false. When set to true, disables the use of `AUDCLNT_STREAMFLAGS_SRC_DEFAULT_QUALITY`.
          You should usually leave this set to false, which is the default.
  
      wasapi.noAutoStreamRouting
          WASAPI only. When set to true, disables automatic stream routing on the WASAPI backend. Defaults to false.
  
      wasapi.noHardwareOffloading
          WASAPI only. When set to true, disables the use of WASAPI's hardware offloading feature. Defaults to false.
  
      alsa.noMMap
          ALSA only. When set to true, disables MMap mode. Defaults to false.
  
      alsa.noAutoFormat
          ALSA only. When set to true, disables ALSA's automatic format conversion by including the SND_PCM_NO_AUTO_FORMAT flag. Defaults to false.
  
      alsa.noAutoChannels
          ALSA only. When set to true, disables ALSA's automatic channel conversion by including the SND_PCM_NO_AUTO_CHANNELS flag. Defaults to false.
  
      alsa.noAutoResample
          ALSA only. When set to true, disables ALSA's automatic resampling by including the SND_PCM_NO_AUTO_RESAMPLE flag. Defaults to false.
  
      pulse.pStreamNamePlayback
          PulseAudio only. Sets the stream name for playback.
  
      pulse.pStreamNameCapture
          PulseAudio only. Sets the stream name for capture.
  
      coreaudio.allowNominalSampleRateChange
          Core Audio only. Desktop only. When enabled, allows the sample rate of the device to be changed at the operating system level. This
          is disabled by default in order to prevent intrusive changes to the user's system. This is useful if you want to use a sample rate
          that is known to be natively supported by the hardware thereby avoiding the cost of resampling. When set to true, miniaudio will
          find the closest match between the sample rate requested in the device config and the sample rates natively supported by the
          hardware. When set to false, the sample rate currently set by the operating system will always be used.
  
      opensl.streamType
          OpenSL only. Explicitly sets the stream type. If left unset (`ma_opensl_stream_type_default`), the
          stream type will be left unset. Think of this as the type of audio you're playing.
  
      opensl.recordingPreset
          OpenSL only. Explicitly sets the type of recording your program will be doing. When left
          unset, the recording preset will be left unchanged.
  
      aaudio.usage
          AAudio only. Explicitly sets the nature of the audio the program will be consuming. When
          left unset, the usage will be left unchanged.
  
      aaudio.contentType
          AAudio only. Sets the content type. When left unset, the content type will be left unchanged.
  
      aaudio.inputPreset
          AAudio only. Explicitly sets the type of recording your program will be doing. When left
          unset, the input preset will be left unchanged.
  
      aaudio.noAutoStartAfterReroute
          AAudio only. Controls whether or not the device should be automatically restarted after a
          stream reroute. When set to false (default) the device will be restarted automatically;
          otherwise the device will be stopped.
  
  
  Once initialized, the device's config is immutable. If you need to change the config you will need to initialize a new device.
  
  After initializing the device it will be in a stopped state. To start it, use `ma_device_start()`.
  
  If both `periodSizeInFrames` and `periodSizeInMilliseconds` are set to zero, it will default to `MA_DEFAULT_PERIOD_SIZE_IN_MILLISECONDS_LOW_LATENCY` or
  `MA_DEFAULT_PERIOD_SIZE_IN_MILLISECONDS_CONSERVATIVE`, depending on whether or not `performanceProfile` is set to `ma_performance_profile_low_latency` or
  `ma_performance_profile_conservative`.
  
  If you request exclusive mode and the backend does not support it an error will be returned. For robustness, you may want to first try initializing the device
  in exclusive mode, and then fall back to shared mode if required. Alternatively you can just request shared mode (the default if you leave it unset in the
  config) which is the most reliable option. Some backends do not have a practical way of choosing whether or not the device should be exclusive or not (ALSA,
  for example) in which case it just acts as a hint. Unless you have special requirements you should try avoiding exclusive mode as it's intrusive to the user.
  Starting with Windows 10, miniaudio will use low-latency shared mode where possible which may make exclusive mode unnecessary.
  
  When sending or receiving data to/from a device, miniaudio will internally perform a format conversion to convert between the format specified by the config
  and the format used internally by the backend. If you pass in 0 for the sample format, channel count, sample rate _and_ channel map, data transmission will run
  on an optimized pass-through fast path. You can retrieve the format, channel count and sample rate by inspecting the `playback/capture.format`,
  `playback/capture.channels` and `sampleRate` members of the device object.
  
  When compiling for UWP you must ensure you call this function on the main UI thread because the operating system may need to present the user with a message
  asking for permissions. Please refer to the official documentation for ActivateAudioInterfaceAsync() for more information.
  
  ALSA Specific: When initializing the default device, requesting shared mode will try using the "dmix" device for playback and the "dsnoop" device for capture.
  If these fail it will try falling back to the "hw" device.
  
  
  Example 1 - Simple Initialization
  ---------------------------------
  This example shows how to initialize a simple playback device using a standard configuration. If you are just needing to do simple playback from the default
  playback device this is usually all you need.
  
  ```c
  ma_device_config config = ma_device_config_init(ma_device_type_playback);
  config.playback.format   = ma_format_f32;
  config.playback.channels = 2;
  config.sampleRate        = 48000;
  config.dataCallback      = ma_data_callback;
  config.pMyUserData       = pMyUserData;
  
  ma_device device;
  ma_result result = ma_device_init(NULL, &config, &device);
  if (result != MA_SUCCESS) 
      // Error
  
  ```
  
  
  Example 2 - Advanced Initialization
  -----------------------------------
  This example shows how you might do some more advanced initialization. In this hypothetical example we want to control the latency by setting the buffer size
  and period count. We also want to allow the user to be able to choose which device to output from which means we need a context so we can perform device
  enumeration.
  
  ```c
  ma_context context;
  ma_result result = ma_context_init(NULL, 0, NULL, &context);
  if (result != MA_SUCCESS) 
      // Error
  
  
  ma_device_info* pPlaybackDeviceInfos;
  ma_uint32 playbackDeviceCount;
  result = ma_context_get_devices(&context, &pPlaybackDeviceInfos, &playbackDeviceCount, NULL, NULL);
  if (result != MA_SUCCESS) 
      // Error
  
  
  // ... choose a device from pPlaybackDeviceInfos ...
  
  ma_device_config config = ma_device_config_init(ma_device_type_playback);
  config.playback.pDeviceID       = pMyChosenDeviceID;    // <-- Get this from the `id` member of one of the `ma_device_info` objects returned by ma_context_get_devices().
  config.playback.format          = ma_format_f32;
  config.playback.channels        = 2;
  config.sampleRate               = 48000;
  config.dataCallback             = ma_data_callback;
  config.pUserData                = pMyUserData;
  config.periodSizeInMilliseconds = 10;
  config.periods                  = 3;
  
  ma_device device;
  result = ma_device_init(&context, &config, &device);
  if (result != MA_SUCCESS) 
      // Error
  
  ```
  
  
  See Also
  --------
  ma_device_config_init()
  ma_device_uninit()
  ma_device_start()
  ma_context_init()
  ma_context_get_devices()
  ma_context_enumerate_devices()
   }
(* Const before type ignored *)

  {
  Initializes a device without a context, with extra parameters for controlling the configuration of the internal self-managed context.
  
  This is the same as `ma_device_init()`, only instead of a context being passed in, the parameters from `ma_context_init()` are passed in instead. This function
  allows you to configure the internally created context.
  
  
  Parameters
  ----------
  backends (in, optional)
      A list of backends to try initializing, in priority order. Can be NULL, in which case it uses default priority order.
  
  backendCount (in, optional)
      The number of items in `backend`. Ignored if `backend` is NULL.
  
  pContextConfig (in, optional)
      The context configuration.
  
  pConfig (in)
      A pointer to the device configuration. Cannot be null. See remarks for details.
  
  pDevice (out)
      A pointer to the device object being initialized.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. It is not safe to call this function simultaneously for different devices because some backends depend on and mutate global state. The same applies to
  calling this at the same time as `ma_device_uninit()`.
  
  
  Callback Safety
  ---------------
  Unsafe. It is not safe to call this inside any callback.
  
  
  Remarks
  -------
  You only need to use this function if you want to configure the context differently to it's defaults. You should never use this function if you want to manage
  your own context.
  
  See the documentation for `ma_context_init()` for information on the different context configuration options.
  
  
  See Also
  --------
  ma_device_init()
  ma_device_uninit()
  ma_device_config_init()
  ma_context_init()
   }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Uninitializes a device.
  
  This will explicitly stop the device. You do not need to call `ma_device_stop()` beforehand, but it's harmless if you do.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device to stop.
  
  
  Return Value
  ------------
  Nothing
  
  
  Thread Safety
  -------------
  Unsafe. As soon as this API is called the device should be considered undefined.
  
  
  Callback Safety
  ---------------
  Unsafe. It is not safe to call this inside any callback. Doing this will result in a deadlock.
  
  
  See Also
  --------
  ma_device_init()
  ma_device_stop()
   }

  {
  Retrieves a pointer to the context that owns the given device.
   }

  {
  Helper function for retrieving the log object associated with the context that owns this device.
   }

  {
  Retrieves information about the device.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose information is being retrieved.
  
  type (in)
      The device type. This parameter is required for duplex devices. When retrieving device
      information, you are doing so for an individual playback or capture device.
  
  pDeviceInfo (out)
      A pointer to the `ma_device_info` that will receive the device information.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. This should be considered unsafe because it may be calling into the backend which may or
  may not be safe.
  
  
  Callback Safety
  ---------------
  Unsafe. You should avoid calling this in the data callback because it may call into the backend
  which may or may not be safe.
   }

  {
  Retrieves the name of the device.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose information is being retrieved.
  
  type (in)
      The device type. This parameter is required for duplex devices. When retrieving device
      information, you are doing so for an individual playback or capture device.
  
  pName (out)
      A pointer to the buffer that will receive the name.
  
  nameCap (in)
      The capacity of the output buffer, including space for the null terminator.
  
  pLengthNotIncludingNullTerminator (out, optional)
      A pointer to the variable that will receive the length of the name, not including the null
      terminator.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. This should be considered unsafe because it may be calling into the backend which may or
  may not be safe.
  
  
  Callback Safety
  ---------------
  Unsafe. You should avoid calling this in the data callback because it may call into the backend
  which may or may not be safe.
  
  
  Remarks
  -------
  If the name does not fully fit into the output buffer, it'll be truncated. You can pass in NULL to
  `pName` if you want to first get the length of the name for the purpose of memory allocation of the
  output buffer. Allocating a buffer of size `MA_MAX_DEVICE_NAME_LENGTH + 1` should be enough for
  most cases and will avoid the need for the inefficiency of calling this function twice.
  
  This is implemented in terms of `ma_device_get_info()`.
   }

  {
  Starts the device. For playback devices this begins playback. For capture devices it begins recording.
  
  Use `ma_device_stop()` to stop the device.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device to start.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Safe. It's safe to call this from any thread with the exception of the callback thread.
  
  
  Callback Safety
  ---------------
  Unsafe. It is not safe to call this inside any callback.
  
  
  Remarks
  -------
  For a playback device, this will retrieve an initial chunk of audio data from the client before returning. The reason for this is to ensure there is valid
  audio data in the buffer, which needs to be done before the device begins playback.
  
  This API waits until the backend device has been started for real by the worker thread. It also waits on a mutex for thread-safety.
  
  Do not call this in any callback.
  
  
  See Also
  --------
  ma_device_stop()
   }

  {
  Stops the device. For playback devices this stops playback. For capture devices it stops recording.
  
  Use `ma_device_start()` to start the device again.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device to stop.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error code otherwise.
  
  
  Thread Safety
  -------------
  Safe. It's safe to call this from any thread with the exception of the callback thread.
  
  
  Callback Safety
  ---------------
  Unsafe. It is not safe to call this inside any callback. Doing this will result in a deadlock.
  
  
  Remarks
  -------
  This API needs to wait on the worker thread to stop the backend device properly before returning. It also waits on a mutex for thread-safety. In addition, some
  backends need to wait for the device to finish playback/recording of the current fragment which can take some time (usually proportionate to the buffer size
  that was specified at initialization time).
  
  Backends are required to either pause the stream in-place or drain the buffer if pausing is not possible. The reason for this is that stopping the device and
  the resuming it with ma_device_start() (which you might do when your program loses focus) may result in a situation where those samples are never output to the
  speakers or received from the microphone which can in turn result in de-syncs.
  
  Do not call this in any callback.
  
  This will be called implicitly by `ma_device_uninit()`.
  
  
  See Also
  --------
  ma_device_start()
   }

  {
  Determines whether or not the device is started.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose start state is being retrieved.
  
  
  Return Value
  ------------
  True if the device is started, false otherwise.
  
  
  Thread Safety
  -------------
  Safe. If another thread calls `ma_device_start()` or `ma_device_stop()` at this same time as this function is called, there's a very small chance the return
  value will be out of sync.
  
  
  Callback Safety
  ---------------
  Safe. This is implemented as a simple accessor.
  
  
  See Also
  --------
  ma_device_start()
  ma_device_stop()
   }
(* Const before type ignored *)

  {
  Retrieves the state of the device.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose state is being retrieved.
  
  
  Return Value
  ------------
  The current state of the device. The return value will be one of the following:
  
      +-------------------------------+------------------------------------------------------------------------------+
      | ma_device_state_uninitialized | Will only be returned if the device is in the middle of initialization.      |
      +-------------------------------+------------------------------------------------------------------------------+
      | ma_device_state_stopped       | The device is stopped. The initial state of the device after initialization. |
      +-------------------------------+------------------------------------------------------------------------------+
      | ma_device_state_started       | The device started and requesting and/or delivering audio data.              |
      +-------------------------------+------------------------------------------------------------------------------+
      | ma_device_state_starting      | The device is in the process of starting.                                    |
      +-------------------------------+------------------------------------------------------------------------------+
      | ma_device_state_stopping      | The device is in the process of stopping.                                    |
      +-------------------------------+------------------------------------------------------------------------------+
  
  
  Thread Safety
  -------------
  Safe. This is implemented as a simple accessor. Note that if the device is started or stopped at the same time as this function is called,
  there's a possibility the return value could be out of sync. See remarks.
  
  
  Callback Safety
  ---------------
  Safe. This is implemented as a simple accessor.
  
  
  Remarks
  -------
  The general flow of a devices state goes like this:
  
      ```
      ma_device_init()  -> ma_device_state_uninitialized -> ma_device_state_stopped
      ma_device_start() -> ma_device_state_starting      -> ma_device_state_started
      ma_device_stop()  -> ma_device_state_stopping      -> ma_device_state_stopped
      ```
  
  When the state of the device is changed with `ma_device_start()` or `ma_device_stop()` at this same time as this function is called, the
  value returned by this function could potentially be out of sync. If this is significant to your program you need to implement your own
  synchronization.
   }
(* Const before type ignored *)

  {
  Performs post backend initialization routines for setting up internal data conversion.
  
  This should be called whenever the backend is initialized. The only time this should be called from
  outside of miniaudio is if you're implementing a custom backend, and you would only do it if you
  are reinitializing the backend due to rerouting or reinitializing for some reason.
  
  
  Parameters
  ----------
  pDevice [in]
      A pointer to the device.
  
  deviceType [in]
      The type of the device that was just reinitialized.
  
  pPlaybackDescriptor [in]
      The descriptor of the playback device containing the internal data format and buffer sizes.
  
  pPlaybackDescriptor [in]
      The descriptor of the capture device containing the internal data format and buffer sizes.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other error otherwise.
  
  
  Thread Safety
  -------------
  Unsafe. This will be reinitializing internal data converters which may be in use by another thread.
  
  
  Callback Safety
  ---------------
  Unsafe. This will be reinitializing internal data converters which may be in use by the callback.
  
  
  Remarks
  -------
  For a duplex device, you can call this for only one side of the system. This is why the deviceType
  is specified as a parameter rather than deriving it from the device.
  
  You do not need to call this manually unless you are doing a custom backend, in which case you need
  only do it if you're manually performing rerouting or reinitialization.
   }
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Sets the master volume factor for the device.
  
  The volume factor must be between 0 (silence) and 1 (full volume). Use `ma_device_set_master_volume_db()` to use decibel notation, where 0 is full volume and
  values less than 0 decreases the volume.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose volume is being set.
  
  volume (in)
      The new volume factor. Must be >= 0.
  
  
  Return Value
  ------------
  MA_SUCCESS if the volume was set successfully.
  MA_INVALID_ARGS if pDevice is NULL.
  MA_INVALID_ARGS if volume is negative.
  
  
  Thread Safety
  -------------
  Safe. This just sets a local member of the device object.
  
  
  Callback Safety
  ---------------
  Safe. If you set the volume in the data callback, that data written to the output buffer will have the new volume applied.
  
  
  Remarks
  -------
  This applies the volume factor across all channels.
  
  This does not change the operating system's volume. It only affects the volume for the given `ma_device` object's audio stream.
  
  
  See Also
  --------
  ma_device_get_master_volume()
  ma_device_set_master_volume_db()
  ma_device_get_master_volume_db()
   }

  {
  Retrieves the master volume factor for the device.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose volume factor is being retrieved.
  
  pVolume (in)
      A pointer to the variable that will receive the volume factor. The returned value will be in the range of [0, 1].
  
  
  Return Value
  ------------
  MA_SUCCESS if successful.
  MA_INVALID_ARGS if pDevice is NULL.
  MA_INVALID_ARGS if pVolume is NULL.
  
  
  Thread Safety
  -------------
  Safe. This just a simple member retrieval.
  
  
  Callback Safety
  ---------------
  Safe.
  
  
  Remarks
  -------
  If an error occurs, `*pVolume` will be set to 0.
  
  
  See Also
  --------
  ma_device_set_master_volume()
  ma_device_set_master_volume_gain_db()
  ma_device_get_master_volume_gain_db()
   }

  {
  Sets the master volume for the device as gain in decibels.
  
  A gain of 0 is full volume, whereas a gain of < 0 will decrease the volume.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose gain is being set.
  
  gainDB (in)
      The new volume as gain in decibels. Must be less than or equal to 0, where 0 is full volume and anything less than 0 decreases the volume.
  
  
  Return Value
  ------------
  MA_SUCCESS if the volume was set successfully.
  MA_INVALID_ARGS if pDevice is NULL.
  MA_INVALID_ARGS if the gain is > 0.
  
  
  Thread Safety
  -------------
  Safe. This just sets a local member of the device object.
  
  
  Callback Safety
  ---------------
  Safe. If you set the volume in the data callback, that data written to the output buffer will have the new volume applied.
  
  
  Remarks
  -------
  This applies the gain across all channels.
  
  This does not change the operating system's volume. It only affects the volume for the given `ma_device` object's audio stream.
  
  
  See Also
  --------
  ma_device_get_master_volume_gain_db()
  ma_device_set_master_volume()
  ma_device_get_master_volume()
   }

  {
  Retrieves the master gain in decibels.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to the device whose gain is being retrieved.
  
  pGainDB (in)
      A pointer to the variable that will receive the gain in decibels. The returned value will be <= 0.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful.
  MA_INVALID_ARGS if pDevice is NULL.
  MA_INVALID_ARGS if pGainDB is NULL.
  
  
  Thread Safety
  -------------
  Safe. This just a simple member retrieval.
  
  
  Callback Safety
  ---------------
  Safe.
  
  
  Remarks
  -------
  If an error occurs, `*pGainDB` will be set to 0.
  
  
  See Also
  --------
  ma_device_set_master_volume_db()
  ma_device_set_master_volume()
  ma_device_get_master_volume()
   }

  {
  Called from the data callback of asynchronous backends to allow miniaudio to process the data and fire the miniaudio data callback.
  
  
  Parameters
  ----------
  pDevice (in)
      A pointer to device whose processing the data callback.
  
  pOutput (out)
      A pointer to the buffer that will receive the output PCM frame data. On a playback device this must not be NULL. On a duplex device
      this can be NULL, in which case pInput must not be NULL.
  
  pInput (in)
      A pointer to the buffer containing input PCM frame data. On a capture device this must not be NULL. On a duplex device this can be
      NULL, in which case `pOutput` must not be NULL.
  
  frameCount (in)
      The number of frames being processed.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful; any other result code otherwise.
  
  
  Thread Safety
  -------------
  This function should only ever be called from the internal data callback of the backend. It is safe to call this simultaneously between a
  playback and capture device in duplex setups.
  
  
  Callback Safety
  ---------------
  Do not call this from the miniaudio data callback. It should only ever be called from the internal data callback of the backend.
  
  
  Remarks
  -------
  If both `pOutput` and `pInput` are NULL, and error will be returned. In duplex scenarios, both `pOutput` and `pInput` can be non-NULL, in
  which case `pInput` will be processed first, followed by `pOutput`.
  
  If you are implementing a custom backend, and that backend uses a callback for data delivery, you'll need to call this from inside that
  callback.
   }
(* Const before type ignored *)

  {
  Calculates an appropriate buffer size from a descriptor, native sample rate and performance profile.
  
  This function is used by backends for helping determine an appropriately sized buffer to use with
  the device depending on the values of `periodSizeInFrames` and `periodSizeInMilliseconds` in the
  `pDescriptor` object. Since buffer size calculations based on time depends on the sample rate, a
  best guess at the device's native sample rate is also required which is where `nativeSampleRate`
  comes in. In addition, the performance profile is also needed for cases where both the period size
  in frames and milliseconds are both zero.
  
  
  Parameters
  ----------
  pDescriptor (in)
      A pointer to device descriptor whose `periodSizeInFrames` and `periodSizeInMilliseconds` members
      will be used for the calculation of the buffer size.
  
  nativeSampleRate (in)
      The device's native sample rate. This is only ever used when the `periodSizeInFrames` member of
      `pDescriptor` is zero. In this case, `periodSizeInMilliseconds` will be used instead, in which
      case a sample rate is required to convert to a size in frames.
  
  performanceProfile (in)
      When both the `periodSizeInFrames` and `periodSizeInMilliseconds` members of `pDescriptor` are
      zero, miniaudio will fall back to a buffer size based on the performance profile. The profile
      to use for this calculation is determine by this parameter.
  
  
  Return Value
  ------------
  The calculated buffer size in frames.
  
  
  Thread Safety
  -------------
  This is safe so long as nothing modifies `pDescriptor` at the same time. However, this function
  should only ever be called from within the backend's device initialization routine and therefore
  shouldn't have any multithreading concerns.
  
  
  Callback Safety
  ---------------
  This is safe to call within the data callback, but there is no reason to ever do this.
  
  
  Remarks
  -------
  If `nativeSampleRate` is zero, this function will fall back to `pDescriptor->sampleRate`. If that
  is also zero, `MA_DEFAULT_SAMPLE_RATE` will be used instead.
   }
(* Const before type ignored *)

  {
  Retrieves a friendly name for a backend.
   }
(* Const before type ignored *)

  {
  Retrieves the backend enum from the given name.
   }
(* Const before type ignored *)

  {
  Determines whether or not the given backend is available by the compilation environment.
   }

  {
  Retrieves compile-time enabled backends.
  
  
  Parameters
  ----------
  pBackends (out, optional)
      A pointer to the buffer that will receive the enabled backends. Set to NULL to retrieve the backend count. Setting
      the capacity of the buffer to `MA_BUFFER_COUNT` will guarantee it's large enough for all backends.
  
  backendCap (in)
      The capacity of the `pBackends` buffer.
  
  pBackendCount (out)
      A pointer to the variable that will receive the enabled backend count.
  
  
  Return Value
  ------------
  MA_SUCCESS if successful.
  MA_INVALID_ARGS if `pBackendCount` is NULL.
  MA_NO_SPACE if the capacity of `pBackends` is not large enough.
  
  If `MA_NO_SPACE` is returned, the `pBackends` buffer will be filled with `*pBackendCount` values.
  
  
  Thread Safety
  -------------
  Safe.
  
  
  Callback Safety
  ---------------
  Safe.
  
  
  Remarks
  -------
  If you want to retrieve the number of backends so you can determine the capacity of `pBackends` buffer, you can call
  this function with `pBackends` set to NULL.
  
  This will also enumerate the null backend. If you don't want to include this you need to check for `ma_backend_null`
  when you enumerate over the returned backends and handle it appropriately. Alternatively, you can disable it at
  compile time with `MA_NO_NULL`.
  
  The returned backends are determined based on compile time settings, not the platform it's currently running on. For
  example, PulseAudio will be returned if it was enabled at compile time, even when the user doesn't actually have
  PulseAudio installed.
  
  
  Example 1
  ---------
  The example below retrieves the enabled backend count using a fixed sized buffer allocated on the stack. The buffer is
  given a capacity of `MA_BACKEND_COUNT` which will guarantee it'll be large enough to store all available backends.
  Since `MA_BACKEND_COUNT` is always a relatively small value, this should be suitable for most scenarios.
  
  ```
  ma_backend enabledBackends[MA_BACKEND_COUNT];
  size_t enabledBackendCount;
  
  result = ma_get_enabled_backends(enabledBackends, MA_BACKEND_COUNT, &enabledBackendCount);
  if (result != MA_SUCCESS) 
      // Failed to retrieve enabled backends. Should never happen in this example since all inputs are valid.
  
  ```
  
  
  See Also
  --------
  ma_is_backend_enabled()
   }

  {
  Determines whether or not loopback mode is support by a backend.
   }

{$endif}
  { MA_NO_DEVICE_IO  }
  {***********************************************************************************************************************************************************
  
  Utilities
  
  *********************************************************************************************************************************************************** }
  {
  Calculates a buffer size in milliseconds from the specified number of frames and sample rate.
   }


  {
  Calculates a buffer size in frames from the specified number of milliseconds and sample rate.
   }

  {
  Copies PCM frames from one buffer to another.
   }
(* Const before type ignored *)

  {
  Copies silent frames into the given buffer.
  
  Remarks
  -------
  For all formats except `ma_format_u8`, the output buffer will be filled with 0. For `ma_format_u8` it will be filled with 128. The reason for this is that it
  makes more sense for the purpose of mixing to initialize it to the center point.
   }

  {
  Offsets a pointer by the specified number of PCM frames.
   }

(* Const before type ignored *)
(* Const before type ignored *)

  {static MA_INLINE float* ma_offset_pcm_frames_ptr_f32(float* p, ma_uint64 offsetInFrames, ma_uint32 channels)  return (float*)ma_offset_pcm_frames_ptr((void*)p, offsetInFrames, ma_format_f32, channels);  }
  {static MA_INLINE const float* ma_offset_pcm_frames_const_ptr_f32(const float* p, ma_uint64 offsetInFrames, ma_uint32 channels)  return (const float*)ma_offset_pcm_frames_const_ptr((const void*)p, offsetInFrames, ma_format_f32, channels);  }
  {
  Clips samples.
   }
(* Const before type ignored *)

(* Const before type ignored *)

  {***********************************************************************************************************************************************************
  
  VFS
  ===
  
  The VFS object (virtual file system) is what's used to customize file access. This is useful in cases where stdio FILE* based APIs may not be entirely
  appropriate for a given situation.
  
  *********************************************************************************************************************************************************** }

    ma_vfs = pointer;

    ma_vfs_file = ma_handle;

    ma_open_mode_flags = (MA_OPEN_MODE_READ := $00000001,MA_OPEN_MODE_WRITE := $00000002
      );
  { Not used by decoders.  }

    ma_seek_origin = (ma_seek_origin_start,ma_seek_origin_current,
      ma_seek_origin_end);

    ma_file_info = record
        sizeInBytes : ma_uint64;
      end;
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)

    ma_vfs_callbacks = record
        onOpen : function (pVFS:Pma_vfs; pFilePath:Pchar; openMode:ma_uint32; pFile:Pma_vfs_file):ma_result;cdecl;
        onOpenW : function (pVFS:Pma_vfs; pFilePath:Pwchar_t; openMode:ma_uint32; pFile:Pma_vfs_file):ma_result;cdecl;
        onClose : function (pVFS:Pma_vfs; vfile:ma_vfs_file):ma_result;cdecl;
        onRead : function (pVFS:Pma_vfs; vfile:ma_vfs_file; pDst:pointer; sizeInBytes:size_t; pBytesRead:Psize_t):ma_result;cdecl;
        onWrite : function (pVFS:Pma_vfs; vfile:ma_vfs_file; pSrc:pointer; sizeInBytes:size_t; pBytesWritten:Psize_t):ma_result;cdecl;
        onSeek : function (pVFS:Pma_vfs; vfile:ma_vfs_file; offset:ma_int64; origin:ma_seek_origin):ma_result;cdecl;
        onTell : function (pVFS:Pma_vfs; vfile:ma_vfs_file; pCursor:Pma_int64):ma_result;cdecl;
        onInfo : function (pVFS:Pma_vfs; vfile:ma_vfs_file; pInfo:Pma_file_info):ma_result;cdecl;
      end;
(* Const before type ignored *)

  { Only used for the wchar_t version of open() on non-Windows platforms.  }

    ma_default_vfs = record
        cb : ma_vfs_callbacks;
        allocationCallbacks : ma_allocation_callbacks;
      end;
(* Const before type ignored *)


    ma_read_proc = function (pUserData:pointer; pBufferOut:pointer; bytesToRead:size_t; pBytesRead:Psize_t):ma_result;cdecl;

    ma_seek_proc = function (pUserData:pointer; offset:ma_int64; origin:ma_seek_origin):ma_result;cdecl;

    ma_tell_proc = function (pUserData:pointer; pCursor:Pma_int64):ma_result;cdecl;
{$if NOT defined(MA_NO_DECODING) OR NOT defined(MA_NO_ENCODING)}

    ma_encoding_format = (ma_encoding_format_unknown := 0,ma_encoding_format_wav,
      ma_encoding_format_flac,ma_encoding_format_mp3,
      ma_encoding_format_vorbis);
{$endif}
  {***********************************************************************************************************************************************************
  
  Decoding
  ========
  
  Decoders are independent of the main device API. Decoding APIs can be called freely inside the device's data callback, but they are not thread safe unless
  you do your own synchronization.
  
  *********************************************************************************************************************************************************** }
{$ifndef MA_NO_DECODING}

  { Set to > 0 to generate a seektable if the decoding backend supports it.  }

    ma_decoding_backend_config = record
        preferredFormat : ma_format;
        seekPointCount : ma_uint32;
      end;


(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
  { Optional.  }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
  { Optional.  }
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)
  { Optional.  }
(* Const before type ignored *)

    Pma_decoding_backend_vtable = ^ma_decoding_backend_vtable;
    PPma_decoding_backend_vtable = ^Pma_decoding_backend_vtable;
    ma_decoding_backend_vtable = record
        onInit : function (pUserData:pointer; onRead:ma_read_proc; onSeek:ma_seek_proc; onTell:ma_tell_proc; pReadSeekTellUserData:pointer; 
                     pConfig:Pma_decoding_backend_config; pAllocationCallbacks:Pma_allocation_callbacks; ppBackend:PPma_data_source):ma_result;cdecl;
        onInitFile : function (pUserData:pointer; pFilePath:Pchar; pConfig:Pma_decoding_backend_config; pAllocationCallbacks:Pma_allocation_callbacks; ppBackend:PPma_data_source):ma_result;cdecl;
        onInitFileW : function (pUserData:pointer; pFilePath:Pwchar_t; pConfig:Pma_decoding_backend_config; pAllocationCallbacks:Pma_allocation_callbacks; ppBackend:PPma_data_source):ma_result;cdecl;
        onInitMemory : function (pUserData:pointer; pData:pointer; dataSize:size_t; pConfig:Pma_decoding_backend_config; pAllocationCallbacks:Pma_allocation_callbacks; 
                     ppBackend:PPma_data_source):ma_result;cdecl;
        onUninit : procedure (pUserData:pointer; pBackend:Pma_data_source; pAllocationCallbacks:Pma_allocation_callbacks);cdecl;
      end;

    ma_decoder_read_proc = function (pDecoder:Pma_decoder; pBufferOut:pointer; bytesToRead:size_t; pBytesRead:Psize_t):ma_result;cdecl;
  { Returns the number of bytes read.  }

    ma_decoder_seek_proc = function (pDecoder:Pma_decoder; byteOffset:ma_int64; origin:ma_seek_origin):ma_result;cdecl;

    ma_decoder_tell_proc = function (pDecoder:Pma_decoder; pCursor:Pma_int64):ma_result;cdecl;
  { Set to 0 or ma_format_unknown to use the stream's internal format.  }
  { Set to 0 to use the stream's internal channels.  }
  { Set to 0 to use the stream's internal sample rate.  }
  { When set to > 0, specifies the number of seek points to use for the generation of a seek table. Not all decoding backends support this.  }

    ma_decoder_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        pChannelMap : ^ma_channel;
        channelMixMode : ma_channel_mix_mode;
        ditherMode : ma_dither_mode;
        resampling : ma_resampler_config;
        allocationCallbacks : ma_allocation_callbacks;
        encodingFormat : ma_encoding_format;
        seekPointCount : ma_uint32;
        ppCustomBackendVTables : PPma_decoding_backend_vtable;
        customBackendCount : ma_uint32;
        pCustomBackendUserData : pointer;
      end;
  { The decoding backend we'll be pulling data from.  }
(* Const before type ignored *)
  { The vtable for the decoding backend. This needs to be stored so we can access the onUninit() callback.  }
  { In output sample rate. Used for keeping track of how many frames are available for decoding.  }
  { Data conversion is achieved by running frames through this.  }
  { In input format. Can be null if it's not needed.  }
  { The capacity of the input cache.  }
  { The number of frames that have been consumed in the cache. Used for determining the next valid frame.  }
  { The number of valid frames remaining in the cahce.  }
(* Const before type ignored *)
  { Only used for decoders that were opened against a block of memory.  }
    ma_decoder = record
        ds : ma_data_source_base;
        pBackend : ^ma_data_source;
        pBackendVTable : ^ma_decoding_backend_vtable;
        pBackendUserData : pointer;
        onRead : ma_decoder_read_proc;
        onSeek : ma_decoder_seek_proc;
        onTell : ma_decoder_tell_proc;
        pUserData : pointer;
        readPointerInPCMFrames : ma_uint64;
        outputFormat : ma_format;
        outputChannels : ma_uint32;
        outputSampleRate : ma_uint32;
        converter : ma_data_converter;
        pInputCache : pointer;
        inputCacheCap : ma_uint64;
        inputCacheConsumed : ma_uint64;
        inputCacheRemaining : ma_uint64;
        allocationCallbacks : ma_allocation_callbacks;
        data : record
            case longint of
              0 : ( vfs : record
                  pVFS : ^ma_vfs;
                  vfile : ma_vfs_file;
                end );
              1 : ( memory : record
                  pData : ^ma_uint8;
                  dataSize : size_t;
                  currentReadPos : size_t;
                end );
            end;
      end;


{$endif}
  { MA_NO_DECODING  }
  {***********************************************************************************************************************************************************
  
  Encoding
  ========
  
  Encoders do not perform any format conversion for you. If your target format does not support the format, and error will be returned.
  
  *********************************************************************************************************************************************************** }
{$ifndef MA_NO_ENCODING}

(* Const before type ignored *)

    ma_encoder_write_proc = function (pEncoder:Pma_encoder; pBufferIn:pointer; bytesToWrite:size_t; pBytesWritten:Psize_t):ma_result;cdecl;

    ma_encoder_seek_proc = function (pEncoder:Pma_encoder; offset:ma_int64; origin:ma_seek_origin):ma_result;cdecl;

    ma_encoder_init_proc = function (pEncoder:Pma_encoder):ma_result;cdecl;

    ma_encoder_uninit_proc = procedure (pEncoder:Pma_encoder);cdecl;
(* Const before type ignored *)

    ma_encoder_write_pcm_frames_proc = function (pEncoder:Pma_encoder; pFramesIn:pointer; frameCount:ma_uint64; pFramesWritten:Pma_uint64):ma_result;cdecl;

    ma_encoder_config = record
        encodingFormat : ma_encoding_format;
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        allocationCallbacks : ma_allocation_callbacks;
      end;



    ma_encoder = record
        config : ma_encoder_config;
        onWrite : ma_encoder_write_proc;
        onSeek : ma_encoder_seek_proc;
        onInit : ma_encoder_init_proc;
        onUninit : ma_encoder_uninit_proc;
        onWritePCMFrames : ma_encoder_write_pcm_frames_proc;
        pUserData : pointer;
        pInternalEncoder : pointer;
        data : record
            case longint of
              0 : ( vfs : record
                  pVFS : ^ma_vfs;
                  vfile : ma_vfs_file;
                end );
            end;
      end;

(* Const before type ignored *)


{$endif}
  { MA_NO_ENCODING  }
  {***********************************************************************************************************************************************************
  
  Generation
  
  *********************************************************************************************************************************************************** }
{$ifndef MA_NO_GENERATION}

    ma_waveform_type = (ma_waveform_type_sine,ma_waveform_type_square,
      ma_waveform_type_triangle,ma_waveform_type_sawtooth
      );

    ma_waveform_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        _type : ma_waveform_type;
        amplitude : double;
        frequency : double;
      end;



    ma_waveform = record
        ds : ma_data_source_base;
        config : ma_waveform_config;
        advance : double;
        time : double;
      end;
(* Const before type ignored *)


    ma_pulsewave_config = record
        format : ma_format;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        dutyCycle : double;
        amplitude : double;
        frequency : double;
      end;


    ma_pulsewave = record
        waveform : ma_waveform;
        config : ma_pulsewave_config;
      end;
(* Const before type ignored *)

    ma_noise_type = (ma_noise_type_white,ma_noise_type_pink,
      ma_noise_type_brownian);

    ma_noise_config = record
        format : ma_format;
        channels : ma_uint32;
        _type : ma_noise_type;
        seed : ma_int32;
        amplitude : double;
        duplicateChannels : ma_bool32;
      end;


  { Memory management.  }

    ma_noise = record
        ds : ma_data_source_vtable;
        config : ma_noise_config;
        lcg : ma_lcg;
        state : record
            case longint of
              0 : ( pink : record
                  bin : PPdouble;
                  accumulation : Pdouble;
                  counter : ^ma_uint32;
                end );
              1 : ( brownian : record
                  accumulation : Pdouble;
                end );
            end;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;
(* Const before type ignored *)


{$endif}
  { MA_NO_GENERATION  }
  {***********************************************************************************************************************************************************
  
  Resource Manager
  
  *********************************************************************************************************************************************************** }
  { The resource manager cannot be enabled if there is no decoder.  }

{$ifndef MA_NO_RESOURCE_MANAGER}

  { When set, does not load the entire data source in memory. Disk I/O will happen on job threads.  }
  { Decode data before storing in memory. When set, decoding is done at the resource manager level rather than the mixing thread. Results in faster mixing, but higher memory usage.  }
  { When set, the resource manager will load the data source asynchronously.  }
  { When set, waits for initialization of the underlying data source before returning from ma_resource_manager_data_source_init().  }
  { Gives the resource manager a hint that the length of the data source is unknown and calling `ma_data_source_get_length_in_pcm_frames()` should be avoided.  }

    ma_resource_manager_data_source_flags = (MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM := $00000001,
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE := $00000002,
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_ASYNC := $00000004,
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_WAIT_INIT := $00000008,
      MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_UNKNOWN_LENGTH := $00000010
      );
  {
  Pipeline notifications used by the resource manager. Made up of both an async notification and a fence, both of which are optional.
   }

    ma_resource_manager_pipeline_stage_notification = record
        pNotification : ^ma_async_notification;
        pFence : ^ma_fence;
      end;
  { Initialization of the decoder.  }
  { Decoding fully completed.  }

    ma_resource_manager_pipeline_notifications = record
        init : ma_resource_manager_pipeline_stage_notification;
        done : ma_resource_manager_pipeline_stage_notification;
      end;

  { BEGIN BACKWARDS COMPATIBILITY  }
  { TODO: Remove this block in version 0.12.  }
  { Indicates ma_resource_manager_next_job() should not block. Only valid when the job thread count is 0.  }
  { Disables any kind of multithreading. Implicitly enables MA_RESOURCE_MANAGER_FLAG_NON_BLOCKING.  }

    ma_resource_manager_flags = (MA_RESOURCE_MANAGER_FLAG_NON_BLOCKING := $00000001,
      MA_RESOURCE_MANAGER_FLAG_NO_THREADING := $00000002
      );
(* Const before type ignored *)
(* Const before type ignored *)
(* Const before type ignored *)

    ma_resource_manager_data_source_config = record
        pFilePath : ^char;
        pFilePathW : ^wchar_t;
        pNotifications : ^ma_resource_manager_pipeline_notifications;
        initialSeekPointInPCMFrames : ma_uint64;
        rangeBegInPCMFrames : ma_uint64;
        rangeEndInPCMFrames : ma_uint64;
        loopPointBegInPCMFrames : ma_uint64;
        loopPointEndInPCMFrames : ma_uint64;
        isLooping : ma_bool32;
        flags : ma_uint32;
      end;


  { Used for determining whether or the data supply has been initialized.  }
  { Data supply is an encoded buffer. Connector is ma_decoder.  }
  { Data supply is a decoded buffer. Connector is ma_audio_buffer.  }
  { Data supply is a linked list of decoded buffers. Connector is ma_paged_audio_buffer.  }

    ma_resource_manager_data_supply_type = (ma_resource_manager_data_supply_type_unknown := 0,
      ma_resource_manager_data_supply_type_encoded,
      ma_resource_manager_data_supply_type_decoded,
      ma_resource_manager_data_supply_type_decoded_paged
      );
  {_Alignas(4) }  { Read and written from different threads so needs to be accessed atomically.  }
(* Const before type ignored *)
(* Const before type ignored *)

    ma_resource_manager_data_supply = record
        _type : ma_resource_manager_data_supply_type;
        backend : record
            case longint of
              0 : ( encoded : record
                  pData : pointer;
                  sizeInBytes : size_t;
                end );
              1 : ( decoded : record
                  pData : pointer;
                  totalFrameCount : ma_uint64;
                  decodedFrameCount : ma_uint64;
                  format : ma_format;
                  channels : ma_uint32;
                  sampleRate : ma_uint32;
                end );
              2 : ( decodedPaged : record
                  data : ma_paged_audio_buffer_data;
                  decodedFrameCount : ma_uint64;
                  sampleRate : ma_uint32;
                end );
            end;
      end;
  { The hashed name. This is the key.  }
  {_Alignas(4) }  { Result from asynchronous loading. When loading set to MA_BUSY. When fully loaded set to MA_SUCCESS. When deleting set to MA_UNAVAILABLE.  }
  {_Alignas(4) }  { For allocating execution orders for jobs.  }
  {_Alignas(4) }  { For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing.  }
  { Set to true when the underlying data buffer was allocated the resource manager. Set to false if it is owned by the application (via ma_resource_manager_register_*()).  }
    ma_resource_manager_data_buffer_node = record
        hashedName32 : ma_uint32;
        refCount : ma_uint32;
        result : ma_result;
        executionCounter : ma_uint32;
        executionPointer : ma_uint32;
        isDataOwnedByResourceManager : ma_bool32;
        data : ma_resource_manager_data_supply;
        pParent : ^ma_resource_manager_data_buffer_node;
        pChildLo : ^ma_resource_manager_data_buffer_node;
        pChildHi : ^ma_resource_manager_data_buffer_node;
      end;

  { Base data source. A data buffer is a data source.  }
  { A pointer to the resource manager that owns this buffer.  }
  { The data node. This is reference counted and is what supplies the data.  }
  { The flags that were passed used to initialize the buffer.  }
  {_Alignas(4) }  { For allocating execution orders for jobs.  }
  {_Alignas(4) }  { For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing.  }
  { Only updated by the public API. Never written nor read from the job thread.  }
  { On the next read we need to seek to the frame cursor.  }
  {_Alignas(4) }  { Keeps track of a result of decoding. Set to MA_BUSY while the buffer is still loading. Set to MA_SUCCESS when loading is finished successfully. Otherwise set to some other code.  }
  {_Alignas(4) }  { Can be read and written by different threads at the same time. Must be used atomically.  }
  { Used for asynchronous loading to ensure we don't try to initialize the connector multiple times while waiting for the node to fully load.  }
  { Supply type is ma_resource_manager_data_supply_type_encoded  }
  { Supply type is ma_resource_manager_data_supply_type_decoded  }
  { Supply type is ma_resource_manager_data_supply_type_decoded_paged  }
  { Connects this object to the node's data supply.  }
    ma_resource_manager_data_buffer = record
        ds : ma_data_source_base;
        pResourceManager : ^ma_resource_manager;
        pNode : ^ma_resource_manager_data_buffer_node;
        flags : ma_uint32;
        executionCounter : ma_uint32;
        executionPointer : ma_uint32;
        seekTargetInPCMFrames : ma_uint64;
        seekToCursorOnNextRead : ma_bool32;
        result : ma_result;
        isLooping : ma_bool32;
        isConnectorInitialized : ma_atomic_bool32;
        connector : record
            case longint of
              0 : ( decoder : ma_decoder );
              1 : ( buffer : ma_audio_buffer );
              2 : ( pagedBuffer : ma_paged_audio_buffer );
            end;
      end;

  { Base data source. A data stream is a data source.  }
  { A pointer to the resource manager that owns this data stream.  }
  { The flags that were passed used to initialize the stream.  }
  { Used for filling pages with data. This is only ever accessed by the job thread. The public API should never touch this.  }
  { Required for determining whether or not the decoder should be uninitialized in MA_JOB_TYPE_RESOURCE_MANAGER_FREE_DATA_STREAM.  }
  { This is calculated when first loaded by the MA_JOB_TYPE_RESOURCE_MANAGER_LOAD_DATA_STREAM.  }
  { The playback cursor, relative to the current page. Only ever accessed by the public API. Never accessed by the job thread.  }
  {_Alignas(8) }  { The playback cursor, in absolute position starting from the start of the file.  }
  { Toggles between 0 and 1. Index 0 is the first half of pPageData. Index 1 is the second half. Only ever accessed by the public API. Never accessed by the job thread.  }
  {_Alignas(4) }  { For allocating execution orders for jobs.  }
  {_Alignas(4) }  { For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing.  }
  { Written by the public API, read by the job thread.  }
  {_Alignas(4) }  { Whether or not the stream is looping. It's important to set the looping flag at the data stream level for smooth loop transitions.  }
  { Written by the job thread, read by the public API.  }
  { Buffer containing the decoded data of each page. Allocated once at initialization time.  }
  {_Alignas(4) }  { The number of valid PCM frames in each page. Used to determine the last valid frame.  }
  { Written and read by both the public API and the job thread. These must be atomic.  }
  {_Alignas(4) }  { Result from asynchronous loading. When loading set to MA_BUSY. When initialized set to MA_SUCCESS. When deleting set to MA_UNAVAILABLE. If an error occurs when loading, set to an error code.  }
  {_Alignas(4) }  { Whether or not the decoder has reached the end.  }
  {_Alignas(4) }  { Booleans to indicate whether or not a page is valid. Set to false by the public API, set to true by the job thread. Set to false as the pages are consumed, true when they are filled.  }
  {_Alignas(4) }  { When 0, no seeking is being performed. When > 0, a seek is being performed and reading should be delayed with MA_BUSY.  }
    ma_resource_manager_data_stream = record
        ds : ma_data_source_base;
        pResourceManager : ^ma_resource_manager;
        flags : ma_uint32;
        decoder : ma_decoder;
        isDecoderInitialized : ma_bool32;
        totalLengthInPCMFrames : ma_uint64;
        relativeCursor : ma_uint32;
        absoluteCursor : ma_uint64;
        currentPageIndex : ma_uint32;
        executionCounter : ma_uint32;
        executionPointer : ma_uint32;
        isLooping : ma_bool32;
        pPageData : pointer;
        pageFrameCount : array[0..1] of ma_uint32;
        result : ma_result;
        isDecoderAtEnd : ma_bool32;
        isPageValid : array[0..1] of ma_bool32;
        seekCounter : ma_bool32;
      end;

  { Must be the first item because we need the first item to be the data source callbacks for the buffer or stream.  }
  { The flags that were passed in to ma_resource_manager_data_source_init().  }
  {_Alignas(4) }  { For allocating execution orders for jobs.  }
  {_Alignas(4) }  { For managing the order of execution for asynchronous jobs relating to this object. Incremented as jobs complete processing.  }
    ma_resource_manager_data_source = record
        backend : record
            case longint of
              0 : ( buffer : ma_resource_manager_data_buffer );
              1 : ( stream : ma_resource_manager_data_stream );
            end;
        flags : ma_uint32;
        executionCounter : ma_uint32;
        executionPointer : ma_uint32;
      end;

  { The decoded format to use. Set to ma_format_unknown (default) to use the file's native format.  }
  { The decoded channel count to use. Set to 0 (default) to use the file's native channel count.  }
  { the decoded sample rate to use. Set to 0 (default) to use the file's native sample rate.  }
  { Set to 0 if you want to self-manage your job threads. Defaults to 1.  }
  { The maximum number of jobs that can fit in the queue at a time. Defaults to MA_JOB_TYPE_RESOURCE_MANAGER_QUEUE_CAPACITY. Cannot be zero.  }
  { Can be NULL in which case defaults will be used.  }

    ma_resource_manager_config = record
        allocationCallbacks : ma_allocation_callbacks;
        pLog : ^ma_log;
        decodedFormat : ma_format;
        decodedChannels : ma_uint32;
        decodedSampleRate : ma_uint32;
        jobThreadCount : ma_uint32;
        jobThreadStackSize : size_t;
        jobQueueCapacity : ma_uint32;
        flags : ma_uint32;
        pVFS : ^ma_vfs;
        ppCustomDecodingBackendVTables : PPma_decoding_backend_vtable;
        customDecodingBackendCount : ma_uint32;
        pCustomDecodingBackendUserData : pointer;
      end;


  { The root buffer in the binary tree.  }
{$ifndef MA_NO_THREADING}
  { For synchronizing access to the data buffer binary tree.  }
  { The threads for executing jobs.  }
{$endif}
  { Multi-consumer, multi-producer job queue for managing jobs for asynchronous decoding and streaming.  }
  { Only used if a custom VFS is not specified.  }
  { Only used if no log was specified in the config.  }

    ma_resource_manager = record
        config : ma_resource_manager_config;
        pRootDataBufferNode : ^ma_resource_manager_data_buffer_node;
        dataBufferBSTLock : ma_mutex;
        jobThreads : array[0..(MA_RESOURCE_MANAGER_MAX_JOB_THREAD_COUNT)-1] of ma_thread;
        jobQueue : ma_job_queue;
        defaultVFS : ma_default_vfs;
        log : ma_log;
      end;

  { Init.  }
(* Const before type ignored *)


  { Returns MA_CANCELLED if a MA_JOB_TYPE_QUIT job is found. In non-blocking mode, returns MA_NO_DATA_AVAILABLE if no jobs are available.  }
{$endif}
  { MA_NO_RESOURCE_MANAGER  }
  {***********************************************************************************************************************************************************
  
  Node Graph
  
  *********************************************************************************************************************************************************** }

    ma_node = pointer;
  { Node flags.  }

    ma_node_flags = (MA_NODE_FLAG_PASSTHROUGH := $00000001,MA_NODE_FLAG_CONTINUOUS_PROCESSING := $00000002,
      MA_NODE_FLAG_ALLOW_NULL_INPUT := $00000004,
      MA_NODE_FLAG_DIFFERENT_PROCESSING_RATES := $00000008,
      MA_NODE_FLAG_SILENT_OUTPUT := $00000010);
  { The playback state of a node. Either started or stopped.  }

    ma_node_state = (ma_node_state_started := 0,ma_node_state_stopped := 1
      );
  {
      Extended processing callback. This callback is used for effects that process input and output
      at different rates (i.e. they perform resampling). This is similar to the simple version, only
      they take two seperate frame counts: one for input, and one for output.
  
      On input, `pFrameCountOut` is equal to the capacity of the output buffer for each bus, whereas
      `pFrameCountIn` will be equal to the number of PCM frames in each of the buffers in `ppFramesIn`.
  
      On output, set `pFrameCountOut` to the number of PCM frames that were actually output and set
      `pFrameCountIn` to the number of input frames that were consumed.
       }
(* Const before type ignored *)
  {
      A callback for retrieving the number of a input frames that are required to output the
      specified number of output frames. You would only want to implement this when the node performs
      resampling. This is optional, even for nodes that perform resampling, but it does offer a
      small reduction in latency as it allows miniaudio to calculate the exact number of input frames
      to read at a time instead of having to estimate.
       }
  {
      The number of input buses. This is how many sub-buffers will be contained in the `ppFramesIn`
      parameters of the callbacks above.
       }
  {
      The number of output buses. This is how many sub-buffers will be contained in the `ppFramesOut`
      parameters of the callbacks above.
       }
  {
      Flags describing characteristics of the node. This is currently just a placeholder for some
      ideas for later on.
       }

    ma_node_vtable = record
        onProcess : procedure (pNode:Pma_node; ppFramesIn:PPsingle; pFrameCountIn:Pma_uint32; ppFramesOut:PPsingle; pFrameCountOut:Pma_uint32);cdecl;
        onGetRequiredInputFrameCount : function (pNode:Pma_node; outputFrameCount:ma_uint32; pInputFrameCount:Pma_uint32):ma_result;cdecl;
        inputBusCount : ma_uint8;
        outputBusCount : ma_uint8;
        flags : ma_uint32;
      end;
(* Const before type ignored *)
  { Should never be null. Initialization of the node will fail if so.  }
  { Defaults to ma_node_state_started.  }
  { Only used if the vtable specifies an input bus count of `MA_NODE_BUS_COUNT_UNKNOWN`, otherwise must be set to `MA_NODE_BUS_COUNT_UNKNOWN` (default).  }
  { Only used if the vtable specifies an output bus count of `MA_NODE_BUS_COUNT_UNKNOWN`, otherwise  be set to `MA_NODE_BUS_COUNT_UNKNOWN` (default).  }
(* Const before type ignored *)
  { The number of elements are determined by the input bus count as determined by the vtable, or `inputBusCount` if the vtable specifies `MA_NODE_BUS_COUNT_UNKNOWN`.  }
(* Const before type ignored *)
  { The number of elements are determined by the output bus count as determined by the vtable, or `outputBusCount` if the vtable specifies `MA_NODE_BUS_COUNT_UNKNOWN`.  }

    ma_node_config = record
        vtable : ^ma_node_vtable;
        initialState : ma_node_state;
        inputBusCount : ma_uint32;
        outputBusCount : ma_uint32;
        pInputChannels : ^ma_uint32;
        pOutputChannels : ^ma_uint32;
      end;

  {
  A node has multiple output buses. An output bus is attached to an input bus as an item in a linked
  list. Think of the input bus as a linked list, with the output bus being an item in that list.
   }

  { Immutable.  }
  { The node that owns this output bus. The input node. Will be null for dummy head and tail nodes.  }
  { The index of the output bus on pNode that this output bus represents.  }
  { The number of channels in the audio stream for this bus.  }
  { Mutable via multiple threads. Must be used atomically. The weird ordering here is for packing reasons.  }
  { The index of the input bus on the input. Required for detaching. Will only be used within the spinlock so does not need to be atomic.  }
  {_Alignas(4) }  { Some state flags for tracking the read state of the output buffer. A combination of MA_NODE_OUTPUT_BUS_FLAG_*.  }
  {_Alignas(4) }  { Reference count for some thread-safety when detaching.  }
  {_Alignas(4) }  { This is used to prevent iteration of nodes that are in the middle of being detached. Used for thread safety.  }
  {_Alignas(4) }  { Unfortunate lock, but significantly simplifies the implementation. Required for thread-safe attaching and detaching.  }
  {_Alignas(4) }  { Linear.  }
  {_Alignas(MA_SIZEOF_PTR) }  { If null, it's the tail node or detached.  }
  {_Alignas(MA_SIZEOF_PTR) }  { If null, it's the head node or detached.  }
  {_Alignas(MA_SIZEOF_PTR) }  { The node that this output bus is attached to. Required for detaching.  }
    ma_node_output_bus = record
        pNode : ^ma_node;
        outputBusIndex : ma_uint8;
        channels : ma_uint8;
        inputNodeInputBusIndex : ma_uint8;
        flags : ma_uint32;
        refCount : ma_uint32;
        isAttached : ma_bool32;
        lock : ma_spinlock;
        volume : single;
        pNext : ^ma_node_output_bus;
        pPrev : ^ma_node_output_bus;
        pInputNode : ^ma_node;
      end;

  {
  A node has multiple input buses. The output buses of a node are connecting to the input busses of
  another. An input bus is essentially just a linked list of output buses.
   }
  { Mutable via multiple threads.  }
  { Dummy head node for simplifying some lock-free thread-safety stuff.  }
  {_Alignas(4) }  { This is used to determine whether or not the input bus is finding the next node in the list. Used for thread safety when detaching output buses.  }
  {_Alignas(4) }  { Unfortunate lock, but significantly simplifies the implementation. Required for thread-safe attaching and detaching.  }
  { Set once at startup.  }
  { The number of channels in the audio stream for this bus.  }
    ma_node_input_bus = record
        head : ma_node_output_bus;
        nextCounter : ma_uint32;
        lock : ma_spinlock;
        channels : ma_uint8;
      end;

  { These variables are set once at startup.  }
  { The graph this node belongs to.  }
(* Const before type ignored *)
  { Allocated on the heap. Fixed size. Needs to be stored on the heap because reading from output buses is done in separate function calls.  }
  { The capacity of the input data cache in frames, per bus.  }
  { These variables are read and written only from the audio thread.  }
  { These variables are read and written between different threads.  }
  {_Alignas(4) }  { When set to stopped, nothing will be read, regardless of the times in stateTimes.  }
  {_Alignas(8) }  { Indexed by ma_node_state. Specifies the time based on the global clock that a node should be considered to be in the relevant state.  }
  {_Alignas(8) }  { The node's local clock. This is just a running sum of the number of output frames that have been processed. Can be modified by any thread with `ma_node_set_time()`.  }
  { Memory management.  }
  { A heap allocation for internal use only. pInputBuses and/or pOutputBuses will point to this if the bus count exceeds MA_MAX_NODE_LOCAL_BUS_COUNT.  }
  { If set to true, the node owns the heap allocation and _pHeap will be freed in ma_node_uninit().  }
    ma_node_base = record
        pNodeGraph : ^ma_node_graph;
        vtable : ^ma_node_vtable;
        pCachedData : ^single;
        cachedDataCapInFramesPerBus : ma_uint16;
        cachedFrameCountOut : ma_uint16;
        cachedFrameCountIn : ma_uint16;
        consumedFrameCountIn : ma_uint16;
        state : ma_node_state;
        stateTimes : array[0..1] of ma_uint64;
        localTime : ma_uint64;
        inputBusCount : ma_uint32;
        outputBusCount : ma_uint32;
        pInputBuses : ^ma_node_input_bus;
        pOutputBuses : ^ma_node_output_bus;
        _inputBuses : array[0..(MA_MAX_NODE_LOCAL_BUS_COUNT)-1] of ma_node_input_bus;
        _outputBuses : array[0..(MA_MAX_NODE_LOCAL_BUS_COUNT)-1] of ma_node_output_bus;
        _pHeap : pointer;
        _ownsHeap : ma_bool32;
      end;

(* Const before type ignored *)


    ma_node_graph_config = record
        channels : ma_uint32;
        nodeCacheCapInFrames : ma_uint16;
      end;


  { Immutable.  }
  { The node graph itself is a node so it can be connected as an input to different node graph. This has zero inputs and calls ma_node_graph_read_pcm_frames() to generate it's output.  }
  { Special node that all nodes eventually connect to. Data is read from this node in ma_node_graph_read_pcm_frames().  }
  { Read and written by multiple threads.  }
  {_Alignas(4) }
    ma_node_graph = record
        base : ma_node_base;
        endpoint : ma_node_base;
        nodeCacheCapInFrames : ma_uint16;
        isReading : ma_bool32;
      end;

(* Const before type ignored *)
(* Const before type ignored *)


  { Data source node. 0 input buses, 1 output bus. Used for reading from a data source.  }

    ma_data_source_node_config = record
        nodeConfig : ma_node_config;
        pDataSource : ^ma_data_source;
      end;



    ma_data_source_node = record
        base : ma_node_base;
        pDataSource : ^ma_data_source;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  { Splitter Node. 1 input, many outputs. Used for splitting/copying a stream so it can be as input into two separate output nodes.  }

    ma_splitter_node_config = record
        nodeConfig : ma_node_config;
        channels : ma_uint32;
        outputBusCount : ma_uint32;
      end;



    ma_splitter_node = record
        base : ma_node_base;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Biquad Node
   }

    ma_biquad_node_config = record
        nodeConfig : ma_node_config;
        biquad : ma_biquad_config;
      end;



    ma_biquad_node = record
        baseNode : ma_node_base;
        biquad : ma_biquad;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Low Pass Filter Node
   }

    ma_lpf_node_config = record
        nodeConfig : ma_node_config;
        lpf : ma_lpf_config;
      end;



    ma_lpf_node = record
        baseNode : ma_node_base;
        lpf : ma_lpf;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  {
  High Pass Filter Node
   }

    ma_hpf_node_config = record
        nodeConfig : ma_node_config;
        hpf : ma_hpf_config;
      end;



    ma_hpf_node = record
        baseNode : ma_node_base;
        hpf : ma_hpf;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Band Pass Filter Node
   }

    ma_bpf_node_config = record
        nodeConfig : ma_node_config;
        bpf : ma_bpf_config;
      end;


    ma_bpf_node = record
        baseNode : ma_node_base;
        bpf : ma_bpf;
      end;
(* Const before type ignored *)
(* Const before type ignored *)


  {
  Notching Filter Node
   }

    ma_notch_node_config = record
        nodeConfig : ma_node_config;
        notch : ma_notch_config;
      end;



    ma_notch_node = record
        baseNode : ma_node_base;
        notch : ma_notch2;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Peaking Filter Node
   }

    ma_peak_node_config = record
        nodeConfig : ma_node_config;
        peak : ma_peak_config;
      end;



    ma_peak_node = record
        baseNode : ma_node_base;
        peak : ma_peak2;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  {
  Low Shelf Filter Node
   }

    ma_loshelf_node_config = record
        nodeConfig : ma_node_config;
        loshelf : ma_loshelf_config;
      end;


    ma_loshelf_node = record
        baseNode : ma_node_base;
        loshelf : ma_loshelf2;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  {
  High Shelf Filter Node
   }

    ma_hishelf_node_config = record
        nodeConfig : ma_node_config;
        hishelf : ma_hishelf_config;
      end;


    ma_hishelf_node = record
        baseNode : ma_node_base;
        hishelf : ma_hishelf2;
      end;
(* Const before type ignored *)
(* Const before type ignored *)


    ma_delay_node_config = record
        nodeConfig : ma_node_config;
        delay : ma_delay_config;
      end;



    ma_delay_node = record
        baseNode : ma_node_base;
        delay : ma_delay;
      end;
(* Const before type ignored *)
(* Const before type ignored *)

  { MA_NO_NODE_GRAPH  }
  { SECTION: miniaudio_engine.h  }
  {***********************************************************************************************************************************************************
  
  Engine
  
  *********************************************************************************************************************************************************** }
{$if NOT defined(MA_NO_ENGINE) AND NOT defined(MA_NO_NODE_GRAPH)}

  { Sound flags.  }
  { Resource manager flags.  }
  { MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_STREAM  }
  { MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_DECODE  }
  { MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_ASYNC  }
  { MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_WAIT_INIT  }
  { MA_RESOURCE_MANAGER_DATA_SOURCE_FLAG_UNKNOWN_LENGTH  }
  { ma_sound specific flags.  }
  { Do not attach to the endpoint by default. Useful for when setting up nodes in a complex graph system.  }
  { Disable pitch shifting with ma_sound_set_pitch() and ma_sound_group_set_pitch(). This is an optimization.  }
  { Disable spatialization.  }

    ma_sound_flags = (MA_SOUND_FLAG_STREAM := $00000001,MA_SOUND_FLAG_DECODE := $00000002,
      MA_SOUND_FLAG_ASYNC := $00000004,MA_SOUND_FLAG_WAIT_INIT := $00000008,
      MA_SOUND_FLAG_UNKNOWN_LENGTH := $00000010,MA_SOUND_FLAG_NO_DEFAULT_ATTACHMENT := $00001000,
      MA_SOUND_FLAG_NO_PITCH := $00002000,MA_SOUND_FLAG_NO_SPATIALIZATION := $00004000
      );


    ma_engine_node_type = (ma_engine_node_type_sound,ma_engine_node_type_group
      );
  { Only used when the type is set to ma_engine_node_type_sound.  }
  { The number of frames to smooth over volume changes. Defaults to 0 in which case no smoothing is used.  }
  { Pitching can be explicitly disabled with MA_SOUND_FLAG_NO_PITCH to optimize processing.  }
  { Spatialization can be explicitly disabled with MA_SOUND_FLAG_NO_SPATIALIZATION.  }
  { The index of the listener this node should always use for spatialization. If set to MA_LISTENER_INDEX_CLOSEST the engine will use the closest listener.  }

    ma_engine_node_config = record
        pEngine : ^ma_engine;
        _type : ma_engine_node_type;
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        sampleRate : ma_uint32;
        volumeSmoothTimeInPCMFrames : ma_uint32;
        monoExpansionMode : ma_mono_expansion_mode;
        isPitchDisabled : ma_bool8;
        isSpatializationDisabled : ma_bool8;
        pinnedListenerIndex : ma_uint8;
      end;


  { Base node object for both ma_sound and ma_sound_group.  }
  { Must be the first member for compatiblity with the ma_node API.  }
  { A pointer to the engine. Set based on the value from the config.  }
  { The sample rate of the input data. For sounds backed by a data source, this will be the data source's sample rate. Otherwise it'll be the engine's sample rate.  }
  { For pitch shift.  }
  { This will only be used if volumeSmoothTimeInPCMFrames is > 0.  }
  { Defaults to 1.  }
  {_Alignas(4) }  { For determining whether or not the resampler needs to be updated to reflect the new pitch. The resampler will be updated on the mixing thread.  }
  { For determining whether or not the resampler needs to be updated to take a new doppler pitch into account.  }
  {_Alignas(4) }  { When set to true, pitching will be disabled which will allow the resampler to be bypassed to save some computation.  }
  {_Alignas(4) }  { Set to false by default. When set to false, will not have spatialisation applied.  }
  {_Alignas(4) }  { The index of the listener this node should always use for spatialization. If set to MA_LISTENER_INDEX_CLOSEST the engine will use the closest listener.  }
  { When setting a fade, it's not done immediately in ma_sound_set_fade(). It's deferred to the audio thread which means we need to store the settings here.  }
  { <-- Defaults to (~(ma_uint64)0) which is used to indicate that no fade should be applied.  }
  { <-- The time to start the fade.  }
  { Memory management.  }

    ma_engine_node = record
        baseNode : ma_node_base;
        pEngine : ^ma_engine;
        sampleRate : ma_uint32;
        volumeSmoothTimeInPCMFrames : ma_uint32;
        monoExpansionMode : ma_mono_expansion_mode;
        fader : ma_fader;
        resampler : ma_linear_resampler;
        spatializer : ma_spatializer;
        panner : ma_panner;
        volumeGainer : ma_gainer;
        volume : ma_atomic_float;
        pitch : single;
        oldPitch : single;
        oldDopplerPitch : single;
        isPitchDisabled : ma_bool32;
        isSpatializationDisabled : ma_bool32;
        pinnedListenerIndex : ma_uint32;
        fadeSettings : record
            volumeBeg : ma_atomic_float;
            volumeEnd : ma_atomic_float;
            fadeLengthInFrames : ma_atomic_uint64;
            absoluteGlobalTimeInFrames : ma_atomic_uint64;
          end;
        _ownsHeap : ma_bool8;
        _pHeap : pointer;
      end;
(* Const before type ignored *)


  { Callback for when a sound reaches the end.  }


    ma_sound_end_proc = procedure (pUserData:pointer; pSound:Pma_sound);cdecl;
(* Const before type ignored *)
  { Set this to load from the resource manager.  }
(* Const before type ignored *)
  { Set this to load from the resource manager.  }
  { Set this to load from an existing data source.  }
  { If set, the sound will be attached to an input of this node. This can be set to a ma_sound. If set to NULL, the sound will be attached directly to the endpoint unless MA_SOUND_FLAG_NO_DEFAULT_ATTACHMENT is set in `flags`.  }
  { The index of the input bus of pInitialAttachment to attach the sound to.  }
  { Ignored if using a data source as input (the data source's channel count will be used always). Otherwise, setting to 0 will cause the engine's channel count to be used.  }
  { Set this to 0 (default) to use the engine's channel count. Set to MA_SOUND_SOURCE_CHANNEL_COUNT to use the data source's channel count (only used if using a data source as input).  }
  { Controls how the mono channel should be expanded to other channels when spatialization is disabled on a sound.  }
  { A combination of MA_SOUND_FLAG_* flags.  }
  { The number of frames to smooth over volume changes. Defaults to 0 in which case no smoothing is used.  }
  { Initializes the sound such that it's seeked to this location by default.  }
  { Fired when the sound reaches the end. Will be fired from the audio thread. Do not restart, uninitialize or otherwise change the state of the sound from here. Instead fire an event or set a variable to indicate to a different thread to change the start of the sound. Will not be fired in response to a scheduled stop with ma_sound_set_stop_time_*().  }
  { Deprecated. Use initNotifications instead. Released when the resource manager has finished decoding the entire sound. Not used with streams.  }

    ma_sound_config = record
        pFilePath : ^char;
        pFilePathW : ^wchar_t;
        pDataSource : ^ma_data_source;
        pInitialAttachment : ^ma_node;
        initialAttachmentInputBusIndex : ma_uint32;
        channelsIn : ma_uint32;
        channelsOut : ma_uint32;
        monoExpansionMode : ma_mono_expansion_mode;
        flags : ma_uint32;
        volumeSmoothTimeInPCMFrames : ma_uint32;
        initialSeekPointInPCMFrames : ma_uint64;
        rangeBegInPCMFrames : ma_uint64;
        rangeEndInPCMFrames : ma_uint64;
        loopPointBegInPCMFrames : ma_uint64;
        loopPointEndInPCMFrames : ma_uint64;
        isLooping : ma_bool32;
        endCallback : ma_sound_end_proc;
        pEndCallbackUserData : pointer;
        initNotifications : ma_resource_manager_pipeline_notifications;
        pDoneFence : ^ma_fence;
      end;


  { Will be renamed to ma_sound_config_init() in version 0.12.  }
  { Must be the first member for compatibility with the ma_node API.  }
  {_Alignas(8) }  { The PCM frame index to seek to in the mixing thread. Set to (~(ma_uint64)0) to not perform any seeking.  }
  {_Alignas(4) }  {
      We're declaring a resource manager data source object here to save us a malloc when loading a
      sound via the resource manager, which I *think* will be the most common scenario.
       }
{$ifndef MA_NO_RESOURCE_MANAGER}
{$endif}

    ma_sound = record
        engineNode : ma_engine_node;
        pDataSource : ^ma_data_source;
        seekTarget : ma_uint64;
        atEnd : ma_bool32;
        endCallback : ma_sound_end_proc;
        pEndCallbackUserData : pointer;
        ownsDataSource : ma_bool8;
        pResourceManagerDataSource : ^ma_resource_manager_data_source;
      end;

  { Structure specifically for sounds played with ma_engine_play_sound(). Making this a separate structure to reduce overhead.  }
    ma_sound_inlined = record
        sound : ma_sound;
        pNext : ^ma_sound_inlined;
        pPrev : ^ma_sound_inlined;
      end;

  { A sound group is just a sound.  }

    ma_sound_group_config = ma_sound_config;

    ma_sound_group = ma_sound;



    ma_engine_process_proc = procedure (pUserData:pointer; pFramesOut:Psingle; frameCount:ma_uint64);cdecl;
{$if NOT defined(MA_NO_RESOURCE_MANAGER)}
  { Can be null in which case a resource manager will be created for you.  }
{$endif}
{$if NOT defined(MA_NO_DEVICE_IO)}
  { If set, the caller is responsible for calling ma_engine_data_callback() in the device's data callback.  }
  { The ID of the playback device to use with the default listener.  }
  { Can be null. Can be used to provide a custom device data callback.  }
{$endif}
  { When set to NULL, will use the context's log.  }
  { Must be between 1 and MA_ENGINE_MAX_LISTENERS.  }
  { The number of channels to use when mixing and spatializing. When set to 0, will use the native channel count of the device.  }
  { The sample rate. When set to 0 will use the native channel count of the device.  }
  { If set to something other than 0, updates will always be exactly this size. The underlying device may be a different size, but from the perspective of the mixer that won't matter. }
  { Used if periodSizeInFrames is unset.  }
  { The number of frames to interpolate the gain of spatialized sounds across. If set to 0, will use gainSmoothTimeInMilliseconds.  }
  { When set to 0, gainSmoothTimeInFrames will be used. If both are set to 0, a default value will be used.  }
  { Defaults to 0. Controls the default amount of smoothing to apply to volume changes to sounds. High values means more smoothing at the expense of high latency (will take longer to reach the new volume).  }
  { When set to true, requires an explicit call to ma_engine_start(). This is false by default, meaning the engine will be started automatically in ma_engine_init().  }
  { When set to true, don't create a default device. ma_engine_read_pcm_frames() can be called manually to read data.  }
  { Controls how the mono channel should be expanded to other channels when spatialization is disabled on a sound.  }
  { A pointer to a pre-allocated VFS object to use with the resource manager. This is ignored if pResourceManager is not NULL.  }
  { Fired at the end of each call to ma_engine_read_pcm_frames(). For engine's that manage their own internal device (the default configuration), this will be fired from the audio thread, and you do not need to call ma_engine_read_pcm_frames() manually in order to trigger this.  }
  { User data that's passed into onProcess.  }

    ma_engine_config = record
        pResourceManager : ^ma_resource_manager;
        pContext : ^ma_context;
        pDevice : ^ma_device;
        pPlaybackDeviceID : ^ma_device_id;
        dataCallback : ma_device_data_proc;
        notificationCallback : ma_device_notification_proc;
        pLog : ^ma_log;
        listenerCount : ma_uint32;
        channels : ma_uint32;
        sampleRate : ma_uint32;
        periodSizeInFrames : ma_uint32;
        periodSizeInMilliseconds : ma_uint32;
        gainSmoothTimeInFrames : ma_uint32;
        gainSmoothTimeInMilliseconds : ma_uint32;
        defaultVolumeSmoothTimeInPCMFrames : ma_uint32;
        allocationCallbacks : ma_allocation_callbacks;
        noAutoStart : ma_bool32;
        noDevice : ma_bool32;
        monoExpansionMode : ma_mono_expansion_mode;
        pResourceManagerVFS : ^ma_vfs;
        onProcess : ma_engine_process_proc;
        pProcessUserData : pointer;
      end;


  { An engine is a node graph. It should be able to be plugged into any ma_node_graph API (with a cast) which means this must be the first member of this struct.  }
  { For synchronizing access so the inlined sound list.  }
  { The first inlined sound. Inlined sounds are tracked in a linked list.  }
  {_Alignas(4) }  { The total number of allocated inlined sound objects. Used for debugging.  }
  { The number of frames to interpolate the gain of spatialized sounds across.  }

    ma_engine = record
        nodeGraph : ma_node_graph;
        pResourceManager : ^ma_resource_manager;
        pDevice : ^ma_device;
        pLog : ^ma_log;
        sampleRate : ma_uint32;
        listenerCount : ma_uint32;
        listeners : array[0..(MA_ENGINE_MAX_LISTENERS)-1] of ma_spatializer_listener;
        allocationCallbacks : ma_allocation_callbacks;
        ownsResourceManager : ma_bool8;
        ownsDevice : ma_bool8;
        inlinedSoundLock : ma_spinlock;
        pInlinedSoundHead : ^ma_sound_inlined;
        inlinedSoundCount : ma_uint32;
        gainSmoothTimeInFrames : ma_uint32;
        defaultVolumeSmoothTimeInPCMFrames : ma_uint32;
        monoExpansionMode : ma_mono_expansion_mode;
        onProcess : ma_engine_process_proc;
        pProcessUserData : pointer;
      end;

(* Const before type ignored *)

  function ma_engine_init(pConfig:Pma_engine_config; pEngine:Pma_engine):ma_result;cdecl; external;

  procedure ma_engine_uninit(pEngine:Pma_engine);cdecl; external;

  function ma_engine_read_pcm_frames(pEngine:Pma_engine; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  function ma_engine_get_node_graph(pEngine:Pma_engine):Pma_node_graph;cdecl; external;

{$if NOT defined(MA_NO_RESOURCE_MANAGER)}

  function ma_engine_get_resource_manager(pEngine:Pma_engine):Pma_resource_manager;cdecl; external;

{$endif}

  function ma_engine_get_device(pEngine:Pma_engine):Pma_device;cdecl; external;

  function ma_engine_get_log(pEngine:Pma_engine):Pma_log;cdecl; external;

  function ma_engine_get_endpoint(pEngine:Pma_engine):Pma_node;cdecl; external;

(* Const before type ignored *)
  function ma_engine_get_time_in_pcm_frames(pEngine:Pma_engine):ma_uint64;cdecl; external;

(* Const before type ignored *)
  function ma_engine_get_time_in_milliseconds(pEngine:Pma_engine):ma_uint64;cdecl; external;

  function ma_engine_set_time_in_pcm_frames(pEngine:Pma_engine; globalTime:ma_uint64):ma_result;cdecl; external;

  function ma_engine_set_time_in_milliseconds(pEngine:Pma_engine; globalTime:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_engine_get_time(pEngine:Pma_engine):ma_uint64;cdecl; external;

  { Deprecated. Use ma_engine_get_time_in_pcm_frames(). Will be removed in version 0.12.  }
  function ma_engine_set_time(pEngine:Pma_engine; globalTime:ma_uint64):ma_result;cdecl; external;

  { Deprecated. Use ma_engine_set_time_in_pcm_frames(). Will be removed in version 0.12.  }
(* Const before type ignored *)
  function ma_engine_get_channels(pEngine:Pma_engine):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_engine_get_sample_rate(pEngine:Pma_engine):ma_uint32;cdecl; external;

  function ma_engine_start(pEngine:Pma_engine):ma_result;cdecl; external;

  function ma_engine_stop(pEngine:Pma_engine):ma_result;cdecl; external;

  function ma_engine_set_volume(pEngine:Pma_engine; volume:single):ma_result;cdecl; external;

  function ma_engine_get_volume(pEngine:Pma_engine):single;cdecl; external;

  function ma_engine_set_gain_db(pEngine:Pma_engine; gainDB:single):ma_result;cdecl; external;

  function ma_engine_get_gain_db(pEngine:Pma_engine):single;cdecl; external;

(* Const before type ignored *)
  function ma_engine_get_listener_count(pEngine:Pma_engine):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_engine_find_closest_listener(pEngine:Pma_engine; absolutePosX:single; absolutePosY:single; absolutePosZ:single):ma_uint32;cdecl; external;

  procedure ma_engine_listener_set_position(pEngine:Pma_engine; listenerIndex:ma_uint32; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_engine_listener_get_position(pEngine:Pma_engine; listenerIndex:ma_uint32):ma_vec3f;cdecl; external;

  procedure ma_engine_listener_set_direction(pEngine:Pma_engine; listenerIndex:ma_uint32; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_engine_listener_get_direction(pEngine:Pma_engine; listenerIndex:ma_uint32):ma_vec3f;cdecl; external;

  procedure ma_engine_listener_set_velocity(pEngine:Pma_engine; listenerIndex:ma_uint32; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_engine_listener_get_velocity(pEngine:Pma_engine; listenerIndex:ma_uint32):ma_vec3f;cdecl; external;

  procedure ma_engine_listener_set_cone(pEngine:Pma_engine; listenerIndex:ma_uint32; innerAngleInRadians:single; outerAngleInRadians:single; outerGain:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_engine_listener_get_cone(pEngine:Pma_engine; listenerIndex:ma_uint32; pInnerAngleInRadians:Psingle; pOuterAngleInRadians:Psingle; pOuterGain:Psingle);cdecl; external;

  procedure ma_engine_listener_set_world_up(pEngine:Pma_engine; listenerIndex:ma_uint32; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_engine_listener_get_world_up(pEngine:Pma_engine; listenerIndex:ma_uint32):ma_vec3f;cdecl; external;

  procedure ma_engine_listener_set_enabled(pEngine:Pma_engine; listenerIndex:ma_uint32; isEnabled:ma_bool32);cdecl; external;

(* Const before type ignored *)
  function ma_engine_listener_is_enabled(pEngine:Pma_engine; listenerIndex:ma_uint32):ma_bool32;cdecl; external;

{$ifndef MA_NO_RESOURCE_MANAGER}
(* Const before type ignored *)

  function ma_engine_play_sound_ex(pEngine:Pma_engine; pFilePath:Pchar; pNode:Pma_node; nodeInputBusIndex:ma_uint32):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_engine_play_sound(pEngine:Pma_engine; pFilePath:Pchar; pGroup:Pma_sound_group):ma_result;cdecl; external;

  { Fire and forget.  }
{$endif}
{$ifndef MA_NO_RESOURCE_MANAGER}
(* Const before type ignored *)

  function ma_sound_init_from_file(pEngine:Pma_engine; pFilePath:Pchar; flags:ma_uint32; pGroup:Pma_sound_group; pDoneFence:Pma_fence; 
             pSound:Pma_sound):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_sound_init_from_file_w(pEngine:Pma_engine; pFilePath:Pwchar_t; flags:ma_uint32; pGroup:Pma_sound_group; pDoneFence:Pma_fence; 
             pSound:Pma_sound):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_sound_init_copy(pEngine:Pma_engine; pExistingSound:Pma_sound; flags:ma_uint32; pGroup:Pma_sound_group; pSound:Pma_sound):ma_result;cdecl; external;

{$endif}

  function ma_sound_init_from_data_source(pEngine:Pma_engine; pDataSource:Pma_data_source; flags:ma_uint32; pGroup:Pma_sound_group; pSound:Pma_sound):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_sound_init_ex(pEngine:Pma_engine; pConfig:Pma_sound_config; pSound:Pma_sound):ma_result;cdecl; external;

  procedure ma_sound_uninit(pSound:Pma_sound);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_engine(pSound:Pma_sound):Pma_engine;cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_data_source(pSound:Pma_sound):Pma_data_source;cdecl; external;

  function ma_sound_start(pSound:Pma_sound):ma_result;cdecl; external;

  function ma_sound_stop(pSound:Pma_sound):ma_result;cdecl; external;

  function ma_sound_stop_with_fade_in_pcm_frames(pSound:Pma_sound; fadeLengthInFrames:ma_uint64):ma_result;cdecl; external;

  { Will overwrite any scheduled stop and fade.  }
  function ma_sound_stop_with_fade_in_milliseconds(pSound:Pma_sound; fadeLengthInFrames:ma_uint64):ma_result;cdecl; external;

  { Will overwrite any scheduled stop and fade.  }
  procedure ma_sound_set_volume(pSound:Pma_sound; volume:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_volume(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_pan(pSound:Pma_sound; pan:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_pan(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_pan_mode(pSound:Pma_sound; panMode:ma_pan_mode);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_pan_mode(pSound:Pma_sound):ma_pan_mode;cdecl; external;

  procedure ma_sound_set_pitch(pSound:Pma_sound; pitch:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_pitch(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_spatialization_enabled(pSound:Pma_sound; enabled:ma_bool32);cdecl; external;

(* Const before type ignored *)
  function ma_sound_is_spatialization_enabled(pSound:Pma_sound):ma_bool32;cdecl; external;

  procedure ma_sound_set_pinned_listener_index(pSound:Pma_sound; listenerIndex:ma_uint32);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_pinned_listener_index(pSound:Pma_sound):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_listener_index(pSound:Pma_sound):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_direction_to_listener(pSound:Pma_sound):ma_vec3f;cdecl; external;

  procedure ma_sound_set_position(pSound:Pma_sound; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_position(pSound:Pma_sound):ma_vec3f;cdecl; external;

  procedure ma_sound_set_direction(pSound:Pma_sound; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_direction(pSound:Pma_sound):ma_vec3f;cdecl; external;

  procedure ma_sound_set_velocity(pSound:Pma_sound; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_velocity(pSound:Pma_sound):ma_vec3f;cdecl; external;

  procedure ma_sound_set_attenuation_model(pSound:Pma_sound; attenuationModel:ma_attenuation_model);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_attenuation_model(pSound:Pma_sound):ma_attenuation_model;cdecl; external;

  procedure ma_sound_set_positioning(pSound:Pma_sound; positioning:ma_positioning);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_positioning(pSound:Pma_sound):ma_positioning;cdecl; external;

  procedure ma_sound_set_rolloff(pSound:Pma_sound; rolloff:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_rolloff(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_min_gain(pSound:Pma_sound; minGain:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_min_gain(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_max_gain(pSound:Pma_sound; maxGain:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_max_gain(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_min_distance(pSound:Pma_sound; minDistance:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_min_distance(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_max_distance(pSound:Pma_sound; maxDistance:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_max_distance(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_cone(pSound:Pma_sound; innerAngleInRadians:single; outerAngleInRadians:single; outerGain:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_sound_get_cone(pSound:Pma_sound; pInnerAngleInRadians:Psingle; pOuterAngleInRadians:Psingle; pOuterGain:Psingle);cdecl; external;

  procedure ma_sound_set_doppler_factor(pSound:Pma_sound; dopplerFactor:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_doppler_factor(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_directional_attenuation_factor(pSound:Pma_sound; directionalAttenuationFactor:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_directional_attenuation_factor(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_fade_in_pcm_frames(pSound:Pma_sound; volumeBeg:single; volumeEnd:single; fadeLengthInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_set_fade_in_milliseconds(pSound:Pma_sound; volumeBeg:single; volumeEnd:single; fadeLengthInMilliseconds:ma_uint64);cdecl; external;

  procedure ma_sound_set_fade_start_in_pcm_frames(pSound:Pma_sound; volumeBeg:single; volumeEnd:single; fadeLengthInFrames:ma_uint64; absoluteGlobalTimeInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_set_fade_start_in_milliseconds(pSound:Pma_sound; volumeBeg:single; volumeEnd:single; fadeLengthInMilliseconds:ma_uint64; absoluteGlobalTimeInMilliseconds:ma_uint64);cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_current_fade_volume(pSound:Pma_sound):single;cdecl; external;

  procedure ma_sound_set_start_time_in_pcm_frames(pSound:Pma_sound; absoluteGlobalTimeInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_set_start_time_in_milliseconds(pSound:Pma_sound; absoluteGlobalTimeInMilliseconds:ma_uint64);cdecl; external;

  procedure ma_sound_set_stop_time_in_pcm_frames(pSound:Pma_sound; absoluteGlobalTimeInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_set_stop_time_in_milliseconds(pSound:Pma_sound; absoluteGlobalTimeInMilliseconds:ma_uint64);cdecl; external;

  procedure ma_sound_set_stop_time_with_fade_in_pcm_frames(pSound:Pma_sound; stopAbsoluteGlobalTimeInFrames:ma_uint64; fadeLengthInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_set_stop_time_with_fade_in_milliseconds(pSound:Pma_sound; stopAbsoluteGlobalTimeInMilliseconds:ma_uint64; fadeLengthInMilliseconds:ma_uint64);cdecl; external;

(* Const before type ignored *)
  function ma_sound_is_playing(pSound:Pma_sound):ma_bool32;cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_time_in_pcm_frames(pSound:Pma_sound):ma_uint64;cdecl; external;

(* Const before type ignored *)
  function ma_sound_get_time_in_milliseconds(pSound:Pma_sound):ma_uint64;cdecl; external;

  procedure ma_sound_set_looping(pSound:Pma_sound; isLooping:ma_bool32);cdecl; external;

(* Const before type ignored *)
  function ma_sound_is_looping(pSound:Pma_sound):ma_bool32;cdecl; external;

(* Const before type ignored *)
  function ma_sound_at_end(pSound:Pma_sound):ma_bool32;cdecl; external;

  function ma_sound_seek_to_pcm_frame(pSound:Pma_sound; frameIndex:ma_uint64):ma_result;cdecl; external;

  { Just a wrapper around ma_data_source_seek_to_pcm_frame().  }
  function ma_sound_get_data_format(pSound:Pma_sound; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel; 
             channelMapCap:size_t):ma_result;cdecl; external;

  function ma_sound_get_cursor_in_pcm_frames(pSound:Pma_sound; pCursor:Pma_uint64):ma_result;cdecl; external;

  function ma_sound_get_length_in_pcm_frames(pSound:Pma_sound; pLength:Pma_uint64):ma_result;cdecl; external;

  function ma_sound_get_cursor_in_seconds(pSound:Pma_sound; pCursor:Psingle):ma_result;cdecl; external;

  function ma_sound_get_length_in_seconds(pSound:Pma_sound; pLength:Psingle):ma_result;cdecl; external;

  function ma_sound_set_end_callback(pSound:Pma_sound; callback:ma_sound_end_proc; pUserData:pointer):ma_result;cdecl; external;

  function ma_sound_group_init(pEngine:Pma_engine; flags:ma_uint32; pParentGroup:Pma_sound_group; pGroup:Pma_sound_group):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_init_ex(pEngine:Pma_engine; pConfig:Pma_sound_group_config; pGroup:Pma_sound_group):ma_result;cdecl; external;

  procedure ma_sound_group_uninit(pGroup:Pma_sound_group);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_engine(pGroup:Pma_sound_group):Pma_engine;cdecl; external;

  function ma_sound_group_start(pGroup:Pma_sound_group):ma_result;cdecl; external;

  function ma_sound_group_stop(pGroup:Pma_sound_group):ma_result;cdecl; external;

  procedure ma_sound_group_set_volume(pGroup:Pma_sound_group; volume:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_volume(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_pan(pGroup:Pma_sound_group; pan:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_pan(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_pan_mode(pGroup:Pma_sound_group; panMode:ma_pan_mode);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_pan_mode(pGroup:Pma_sound_group):ma_pan_mode;cdecl; external;

  procedure ma_sound_group_set_pitch(pGroup:Pma_sound_group; pitch:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_pitch(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_spatialization_enabled(pGroup:Pma_sound_group; enabled:ma_bool32);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_is_spatialization_enabled(pGroup:Pma_sound_group):ma_bool32;cdecl; external;

  procedure ma_sound_group_set_pinned_listener_index(pGroup:Pma_sound_group; listenerIndex:ma_uint32);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_pinned_listener_index(pGroup:Pma_sound_group):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_listener_index(pGroup:Pma_sound_group):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_direction_to_listener(pGroup:Pma_sound_group):ma_vec3f;cdecl; external;

  procedure ma_sound_group_set_position(pGroup:Pma_sound_group; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_position(pGroup:Pma_sound_group):ma_vec3f;cdecl; external;

  procedure ma_sound_group_set_direction(pGroup:Pma_sound_group; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_direction(pGroup:Pma_sound_group):ma_vec3f;cdecl; external;

  procedure ma_sound_group_set_velocity(pGroup:Pma_sound_group; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_velocity(pGroup:Pma_sound_group):ma_vec3f;cdecl; external;

  procedure ma_sound_group_set_attenuation_model(pGroup:Pma_sound_group; attenuationModel:ma_attenuation_model);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_attenuation_model(pGroup:Pma_sound_group):ma_attenuation_model;cdecl; external;

  procedure ma_sound_group_set_positioning(pGroup:Pma_sound_group; positioning:ma_positioning);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_positioning(pGroup:Pma_sound_group):ma_positioning;cdecl; external;

  procedure ma_sound_group_set_rolloff(pGroup:Pma_sound_group; rolloff:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_rolloff(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_min_gain(pGroup:Pma_sound_group; minGain:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_min_gain(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_max_gain(pGroup:Pma_sound_group; maxGain:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_max_gain(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_min_distance(pGroup:Pma_sound_group; minDistance:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_min_distance(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_max_distance(pGroup:Pma_sound_group; maxDistance:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_max_distance(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_cone(pGroup:Pma_sound_group; innerAngleInRadians:single; outerAngleInRadians:single; outerGain:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_sound_group_get_cone(pGroup:Pma_sound_group; pInnerAngleInRadians:Psingle; pOuterAngleInRadians:Psingle; pOuterGain:Psingle);cdecl; external;

  procedure ma_sound_group_set_doppler_factor(pGroup:Pma_sound_group; dopplerFactor:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_doppler_factor(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_directional_attenuation_factor(pGroup:Pma_sound_group; directionalAttenuationFactor:single);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_directional_attenuation_factor(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_fade_in_pcm_frames(pGroup:Pma_sound_group; volumeBeg:single; volumeEnd:single; fadeLengthInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_group_set_fade_in_milliseconds(pGroup:Pma_sound_group; volumeBeg:single; volumeEnd:single; fadeLengthInMilliseconds:ma_uint64);cdecl; external;

  function ma_sound_group_get_current_fade_volume(pGroup:Pma_sound_group):single;cdecl; external;

  procedure ma_sound_group_set_start_time_in_pcm_frames(pGroup:Pma_sound_group; absoluteGlobalTimeInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_group_set_start_time_in_milliseconds(pGroup:Pma_sound_group; absoluteGlobalTimeInMilliseconds:ma_uint64);cdecl; external;

  procedure ma_sound_group_set_stop_time_in_pcm_frames(pGroup:Pma_sound_group; absoluteGlobalTimeInFrames:ma_uint64);cdecl; external;

  procedure ma_sound_group_set_stop_time_in_milliseconds(pGroup:Pma_sound_group; absoluteGlobalTimeInMilliseconds:ma_uint64);cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_is_playing(pGroup:Pma_sound_group):ma_bool32;cdecl; external;

(* Const before type ignored *)
  function ma_sound_group_get_time_in_pcm_frames(pGroup:Pma_sound_group):ma_uint64;cdecl; external;

  (* from above *)

  function ma_log_callback_init(onLog:ma_log_callback_proc; pUserData:pointer):ma_log_callback;cdecl; external;
  function ma_log_init(pAllocationCallbacks:Pma_allocation_callbacks; pLog:Pma_log):ma_result;cdecl; external;

  procedure ma_log_uninit(pLog:Pma_log);cdecl; external;

  function ma_log_register_callback(pLog:Pma_log; callback:ma_log_callback):ma_result;cdecl; external;

  function ma_log_unregister_callback(pLog:Pma_log; callback:ma_log_callback):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_log_post(pLog:Pma_log; level:ma_uint32; pMessage:Pchar):ma_result;cdecl; external;

(* Const before type ignored *)
  //function ma_log_postv(pLog:Pma_log; level:ma_uint32; pFormat:Pchar; args:va_list):ma_result;cdecl; external;

  function ma_biquad_config_init(format:ma_format; channels:ma_uint32; b0:double; b1:double; b2:double; 
             a0:double; a1:double; a2:double):ma_biquad_config;cdecl; external;
  function ma_biquad_get_heap_size(pConfig:Pma_biquad_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_biquad_init_preallocated(pConfig:Pma_biquad_config; pHeap:pointer; pBQ:Pma_biquad):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_biquad_init(pConfig:Pma_biquad_config; pAllocationCallbacks:Pma_allocation_callbacks; pBQ:Pma_biquad):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_biquad_uninit(pBQ:Pma_biquad; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_biquad_reinit(pConfig:Pma_biquad_config; pBQ:Pma_biquad):ma_result;cdecl; external;

  function ma_biquad_clear_cache(pBQ:Pma_biquad):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_biquad_process_pcm_frames(pBQ:Pma_biquad; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_biquad_get_latency(pBQ:Pma_biquad):ma_uint32;cdecl; external;

  function ma_lpf1_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double):ma_lpf1_config;cdecl; external;

  function ma_lpf2_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; q:double):ma_lpf2_config;cdecl; external;


  function ma_lpf1_get_heap_size(pConfig:Pma_lpf1_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf1_init_preallocated(pConfig:Pma_lpf1_config; pHeap:pointer; pLPF:Pma_lpf1):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_lpf1_init(pConfig:Pma_lpf1_config; pAllocationCallbacks:Pma_allocation_callbacks; pLPF:Pma_lpf1):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_lpf1_uninit(pLPF:Pma_lpf1; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_lpf1_reinit(pConfig:Pma_lpf1_config; pLPF:Pma_lpf1):ma_result;cdecl; external;

  function ma_lpf1_clear_cache(pLPF:Pma_lpf1):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf1_process_pcm_frames(pLPF:Pma_lpf1; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf1_get_latency(pLPF:Pma_lpf1):ma_uint32;cdecl; external;
  function ma_lpf2_get_heap_size(pConfig:Pma_lpf2_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf2_init_preallocated(pConfig:Pma_lpf2_config; pHeap:pointer; pHPF:Pma_lpf2):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_lpf2_init(pConfig:Pma_lpf2_config; pAllocationCallbacks:Pma_allocation_callbacks; pLPF:Pma_lpf2):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_lpf2_uninit(pLPF:Pma_lpf2; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_lpf2_reinit(pConfig:Pma_lpf2_config; pLPF:Pma_lpf2):ma_result;cdecl; external;

  function ma_lpf2_clear_cache(pLPF:Pma_lpf2):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf2_process_pcm_frames(pLPF:Pma_lpf2; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf2_get_latency(pLPF:Pma_lpf2):ma_uint32;cdecl; external;

  function ma_lpf_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; order:ma_uint32):ma_lpf_config;cdecl; external;

  function ma_hpf1_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double):ma_hpf1_config;cdecl; external;

  function ma_hpf2_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; q:double):ma_hpf2_config;cdecl; external;

  function ma_lpf_get_heap_size(pConfig:Pma_lpf_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;
  function ma_hpf1_get_heap_size(pConfig:Pma_hpf1_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf1_init_preallocated(pConfig:Pma_hpf1_config; pHeap:pointer; pLPF:Pma_hpf1):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_hpf1_init(pConfig:Pma_hpf1_config; pAllocationCallbacks:Pma_allocation_callbacks; pHPF:Pma_hpf1):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_hpf1_uninit(pHPF:Pma_hpf1; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_hpf1_reinit(pConfig:Pma_hpf1_config; pHPF:Pma_hpf1):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf1_process_pcm_frames(pHPF:Pma_hpf1; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf1_get_latency(pHPF:Pma_hpf1):ma_uint32;cdecl; external;

  { The second order high-pass filter is implemented as a biquad filter.  }

(* Const before type ignored *)
  function ma_lpf_init_preallocated(pConfig:Pma_lpf_config; pHeap:pointer; pLPF:Pma_lpf):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_lpf_init(pConfig:Pma_lpf_config; pAllocationCallbacks:Pma_allocation_callbacks; pLPF:Pma_lpf):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_lpf_uninit(pLPF:Pma_lpf; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_lpf_reinit(pConfig:Pma_lpf_config; pLPF:Pma_lpf):ma_result;cdecl; external;

  function ma_lpf_clear_cache(pLPF:Pma_lpf):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf_process_pcm_frames(pLPF:Pma_lpf; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf_get_latency(pLPF:Pma_lpf):ma_uint32;cdecl; external;

  function ma_hpf2_get_heap_size(pConfig:Pma_hpf2_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf2_init_preallocated(pConfig:Pma_hpf2_config; pHeap:pointer; pHPF:Pma_hpf2):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_hpf2_init(pConfig:Pma_hpf2_config; pAllocationCallbacks:Pma_allocation_callbacks; pHPF:Pma_hpf2):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_hpf2_uninit(pHPF:Pma_hpf2; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_hpf2_reinit(pConfig:Pma_hpf2_config; pHPF:Pma_hpf2):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf2_process_pcm_frames(pHPF:Pma_hpf2; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf2_get_latency(pHPF:Pma_hpf2):ma_uint32;cdecl; external;

  function ma_hpf_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; order:ma_uint32):ma_hpf_config;cdecl; external;

  function ma_hpf_get_heap_size(pConfig:Pma_hpf_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

  function ma_bpf2_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; q:double):ma_bpf2_config;cdecl; external;

(* Const before type ignored *)
  function ma_hpf_init_preallocated(pConfig:Pma_hpf_config; pHeap:pointer; pLPF:Pma_hpf):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_hpf_init(pConfig:Pma_hpf_config; pAllocationCallbacks:Pma_allocation_callbacks; pHPF:Pma_hpf):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_hpf_uninit(pHPF:Pma_hpf; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_hpf_reinit(pConfig:Pma_hpf_config; pHPF:Pma_hpf):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf_process_pcm_frames(pHPF:Pma_hpf; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

  function ma_bpf2_get_heap_size(pConfig:Pma_bpf2_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_bpf2_init_preallocated(pConfig:Pma_bpf2_config; pHeap:pointer; pBPF:Pma_bpf2):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_bpf2_init(pConfig:Pma_bpf2_config; pAllocationCallbacks:Pma_allocation_callbacks; pBPF:Pma_bpf2):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_bpf2_uninit(pBPF:Pma_bpf2; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_bpf2_reinit(pConfig:Pma_bpf2_config; pBPF:Pma_bpf2):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_bpf2_process_pcm_frames(pBPF:Pma_bpf2; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_bpf2_get_latency(pBPF:Pma_bpf2):ma_uint32;cdecl; external;

  { If set to 0, will be treated as a passthrough (no filtering will be applied).  }
(* Const before type ignored *)
  function ma_hpf_get_latency(pHPF:Pma_hpf):ma_uint32;cdecl; external;
  { If set to 0, will be treated as a passthrough (no filtering will be applied).  }
  { If set to 0, will be treated as a passthrough (no filtering will be applied).  }

  function ma_bpf_get_heap_size(pConfig:Pma_bpf_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

  function ma_notch2_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; q:double; frequency:double):ma_notch2_config;cdecl; external;

  function ma_notch2_get_heap_size(pConfig:Pma_notch2_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;
  function ma_peak2_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; gainDB:double; q:double; 
             frequency:double):ma_peak2_config;cdecl; external;

(* Const before type ignored *)
  function ma_notch2_init_preallocated(pConfig:Pma_notch2_config; pHeap:pointer; pFilter:Pma_notch2):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_notch2_init(pConfig:Pma_notch2_config; pAllocationCallbacks:Pma_allocation_callbacks; pFilter:Pma_notch2):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_notch2_uninit(pFilter:Pma_notch2; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_notch2_reinit(pConfig:Pma_notch2_config; pFilter:Pma_notch2):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_notch2_process_pcm_frames(pFilter:Pma_notch2; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_notch2_get_latency(pFilter:Pma_notch2):ma_uint32;cdecl; external;
(* Const before type ignored *)
  function ma_bpf_init_preallocated(pConfig:Pma_bpf_config; pHeap:pointer; pBPF:Pma_bpf):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_bpf_init(pConfig:Pma_bpf_config; pAllocationCallbacks:Pma_allocation_callbacks; pBPF:Pma_bpf):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_bpf_uninit(pBPF:Pma_bpf; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_bpf_reinit(pConfig:Pma_bpf_config; pBPF:Pma_bpf):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_bpf_process_pcm_frames(pBPF:Pma_bpf; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_bpf_get_latency(pBPF:Pma_bpf):ma_uint32;cdecl; external;

  function ma_bpf_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; order:ma_uint32):ma_bpf_config;cdecl; external;
  function ma_peak2_get_heap_size(pConfig:Pma_peak2_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_peak2_init_preallocated(pConfig:Pma_peak2_config; pHeap:pointer; pFilter:Pma_peak2):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_peak2_init(pConfig:Pma_peak2_config; pAllocationCallbacks:Pma_allocation_callbacks; pFilter:Pma_peak2):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_peak2_uninit(pFilter:Pma_peak2; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_peak2_reinit(pConfig:Pma_peak2_config; pFilter:Pma_peak2):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_peak2_process_pcm_frames(pFilter:Pma_peak2; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_peak2_get_latency(pFilter:Pma_peak2):ma_uint32;cdecl; external;


  function ma_loshelf2_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; gainDB:double; shelfSlope:double; 
             frequency:double):ma_loshelf2_config;cdecl; external;
  function ma_loshelf2_get_heap_size(pConfig:Pma_loshelf2_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_loshelf2_init_preallocated(pConfig:Pma_loshelf2_config; pHeap:pointer; pFilter:Pma_loshelf2):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_loshelf2_init(pConfig:Pma_loshelf2_config; pAllocationCallbacks:Pma_allocation_callbacks; pFilter:Pma_loshelf2):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_loshelf2_uninit(pFilter:Pma_loshelf2; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_loshelf2_reinit(pConfig:Pma_loshelf2_config; pFilter:Pma_loshelf2):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_loshelf2_process_pcm_frames(pFilter:Pma_loshelf2; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_loshelf2_get_latency(pFilter:Pma_loshelf2):ma_uint32;cdecl; external;
  function ma_hishelf2_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; gainDB:double; shelfSlope:double; 
             frequency:double):ma_hishelf2_config;cdecl; external;
  function ma_delay_config_init(channels:ma_uint32; sampleRate:ma_uint32; delayInFrames:ma_uint32; decay:single):ma_delay_config;cdecl; external;

  function ma_hishelf2_get_heap_size(pConfig:Pma_hishelf2_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hishelf2_init_preallocated(pConfig:Pma_hishelf2_config; pHeap:pointer; pFilter:Pma_hishelf2):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_hishelf2_init(pConfig:Pma_hishelf2_config; pAllocationCallbacks:Pma_allocation_callbacks; pFilter:Pma_hishelf2):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_hishelf2_uninit(pFilter:Pma_hishelf2; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_hishelf2_reinit(pConfig:Pma_hishelf2_config; pFilter:Pma_hishelf2):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hishelf2_process_pcm_frames(pFilter:Pma_hishelf2; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hishelf2_get_latency(pFilter:Pma_hishelf2):ma_uint32;cdecl; external;
  function ma_delay_init(pConfig:Pma_delay_config; pAllocationCallbacks:Pma_allocation_callbacks; pDelay:Pma_delay):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_delay_uninit(pDelay:Pma_delay; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_delay_process_pcm_frames(pDelay:Pma_delay; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint32):ma_result;cdecl; external;

  procedure ma_delay_set_wet(pDelay:Pma_delay; value:single);cdecl; external;

(* Const before type ignored *)
  function ma_delay_get_wet(pDelay:Pma_delay):single;cdecl; external;

  procedure ma_delay_set_dry(pDelay:Pma_delay; value:single);cdecl; external;

(* Const before type ignored *)
  function ma_delay_get_dry(pDelay:Pma_delay):single;cdecl; external;

  procedure ma_delay_set_decay(pDelay:Pma_delay; value:single);cdecl; external;

(* Const before type ignored *)
  function ma_delay_get_decay(pDelay:Pma_delay):single;cdecl; external;

  function ma_gainer_config_init(channels:ma_uint32; smoothTimeInFrames:ma_uint32):ma_gainer_config;cdecl; external;

  function ma_gainer_get_heap_size(pConfig:Pma_gainer_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_gainer_init_preallocated(pConfig:Pma_gainer_config; pHeap:pointer; pGainer:Pma_gainer):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_gainer_init(pConfig:Pma_gainer_config; pAllocationCallbacks:Pma_allocation_callbacks; pGainer:Pma_gainer):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_gainer_uninit(pGainer:Pma_gainer; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_gainer_process_pcm_frames(pGainer:Pma_gainer; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

  function ma_gainer_set_gain(pGainer:Pma_gainer; newGain:single):ma_result;cdecl; external;

  function ma_gainer_set_gains(pGainer:Pma_gainer; pNewGains:Psingle):ma_result;cdecl; external;

  function ma_gainer_set_master_volume(pGainer:Pma_gainer; volume:single):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_gainer_get_master_volume(pGainer:Pma_gainer; pVolume:Psingle):ma_result;cdecl; external;
  function ma_panner_config_init(format:ma_format; channels:ma_uint32):ma_panner_config;cdecl; external;
  function ma_panner_init(pConfig:Pma_panner_config; pPanner:Pma_panner):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_panner_process_pcm_frames(pPanner:Pma_panner; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

  procedure ma_panner_set_mode(pPanner:Pma_panner; mode:ma_pan_mode);cdecl; external;

(* Const before type ignored *)
  function ma_panner_get_mode(pPanner:Pma_panner):ma_pan_mode;cdecl; external;

  procedure ma_panner_set_pan(pPanner:Pma_panner; pan:single);cdecl; external;

(* Const before type ignored *)
  function ma_panner_get_pan(pPanner:Pma_panner):single;cdecl; external;

  function ma_fader_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32):ma_fader_config;cdecl; external;

  function ma_fader_init(pConfig:Pma_fader_config; pFader:Pma_fader):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_fader_process_pcm_frames(pFader:Pma_fader; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_fader_get_data_format(pFader:Pma_fader; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32);cdecl; external;

  procedure ma_fader_set_fade(pFader:Pma_fader; volumeBeg:single; volumeEnd:single; lengthInFrames:ma_uint64);cdecl; external;

  procedure ma_fader_set_fade_ex(pFader:Pma_fader; volumeBeg:single; volumeEnd:single; lengthInFrames:ma_uint64; startOffsetInFrames:ma_int64);cdecl; external;

(* Const before type ignored *)
  function ma_fader_get_current_volume(pFader:Pma_fader):single;cdecl; external;

  function ma_spatializer_listener_config_init(channelsOut:ma_uint32):ma_spatializer_listener_config;cdecl; external;
  function ma_spatializer_listener_get_heap_size(pConfig:Pma_spatializer_listener_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_listener_init_preallocated(pConfig:Pma_spatializer_listener_config; pHeap:pointer; pListener:Pma_spatializer_listener):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_spatializer_listener_init(pConfig:Pma_spatializer_listener_config; pAllocationCallbacks:Pma_allocation_callbacks; pListener:Pma_spatializer_listener):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_spatializer_listener_uninit(pListener:Pma_spatializer_listener; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_spatializer_listener_get_channel_map(pListener:Pma_spatializer_listener):Pma_channel;cdecl; external;

  procedure ma_spatializer_listener_set_cone(pListener:Pma_spatializer_listener; innerAngleInRadians:single; outerAngleInRadians:single; outerGain:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_spatializer_listener_get_cone(pListener:Pma_spatializer_listener; pInnerAngleInRadians:Psingle; pOuterAngleInRadians:Psingle; pOuterGain:Psingle);cdecl; external;

  procedure ma_spatializer_listener_set_position(pListener:Pma_spatializer_listener; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_listener_get_position(pListener:Pma_spatializer_listener):ma_vec3f;cdecl; external;

  procedure ma_spatializer_listener_set_direction(pListener:Pma_spatializer_listener; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_listener_get_direction(pListener:Pma_spatializer_listener):ma_vec3f;cdecl; external;

  procedure ma_spatializer_listener_set_velocity(pListener:Pma_spatializer_listener; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_listener_get_velocity(pListener:Pma_spatializer_listener):ma_vec3f;cdecl; external;

  procedure ma_spatializer_listener_set_speed_of_sound(pListener:Pma_spatializer_listener; speedOfSound:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_listener_get_speed_of_sound(pListener:Pma_spatializer_listener):single;cdecl; external;

  procedure ma_spatializer_listener_set_world_up(pListener:Pma_spatializer_listener; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_listener_get_world_up(pListener:Pma_spatializer_listener):ma_vec3f;cdecl; external;

  procedure ma_spatializer_listener_set_enabled(pListener:Pma_spatializer_listener; isEnabled:ma_bool32);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_listener_is_enabled(pListener:Pma_spatializer_listener):ma_bool32;cdecl; external;
  { Stereo panner.  }
  { Does not blend one side with the other. Technically just a balance. Compatible with other popular audio engines and therefore the default.  }
  { A true pan. The sound from one side will "move" to the other side and blend with it.  }

  function ma_spatializer_config_init(channelsIn:ma_uint32; channelsOut:ma_uint32):ma_spatializer_config;cdecl; external;
  { Gainer for smooth volume changes.  }

  {
  Delay
   }
  { Set to true to delay the start of the output; false otherwise.  }
  { 0..1. Default = 1.  }
  { 0..1. Default = 1.  }
  { 0..1. Default = 0 (no feedback). Feedback decay. Use this for echo.  }

  { The second order low-pass filter is implemented as a biquad filter.  }
  function ma_spatializer_get_heap_size(pConfig:Pma_spatializer_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_init_preallocated(pConfig:Pma_spatializer_config; pHeap:pointer; pSpatializer:Pma_spatializer):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_spatializer_init(pConfig:Pma_spatializer_config; pAllocationCallbacks:Pma_allocation_callbacks; pSpatializer:Pma_spatializer):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_spatializer_uninit(pSpatializer:Pma_spatializer; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_process_pcm_frames(pSpatializer:Pma_spatializer; pListener:Pma_spatializer_listener; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

  function ma_spatializer_set_master_volume(pSpatializer:Pma_spatializer; volume:single):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_master_volume(pSpatializer:Pma_spatializer; pVolume:Psingle):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_input_channels(pSpatializer:Pma_spatializer):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_output_channels(pSpatializer:Pma_spatializer):ma_uint32;cdecl; external;

  procedure ma_spatializer_set_attenuation_model(pSpatializer:Pma_spatializer; attenuationModel:ma_attenuation_model);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_attenuation_model(pSpatializer:Pma_spatializer):ma_attenuation_model;cdecl; external;

  procedure ma_spatializer_set_positioning(pSpatializer:Pma_spatializer; positioning:ma_positioning);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_positioning(pSpatializer:Pma_spatializer):ma_positioning;cdecl; external;

  procedure ma_spatializer_set_rolloff(pSpatializer:Pma_spatializer; rolloff:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_rolloff(pSpatializer:Pma_spatializer):single;cdecl; external;

  procedure ma_spatializer_set_min_gain(pSpatializer:Pma_spatializer; minGain:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_min_gain(pSpatializer:Pma_spatializer):single;cdecl; external;

  procedure ma_spatializer_set_max_gain(pSpatializer:Pma_spatializer; maxGain:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_max_gain(pSpatializer:Pma_spatializer):single;cdecl; external;

  procedure ma_spatializer_set_min_distance(pSpatializer:Pma_spatializer; minDistance:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_min_distance(pSpatializer:Pma_spatializer):single;cdecl; external;

  procedure ma_spatializer_set_max_distance(pSpatializer:Pma_spatializer; maxDistance:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_max_distance(pSpatializer:Pma_spatializer):single;cdecl; external;

  procedure ma_spatializer_set_cone(pSpatializer:Pma_spatializer; innerAngleInRadians:single; outerAngleInRadians:single; outerGain:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_spatializer_get_cone(pSpatializer:Pma_spatializer; pInnerAngleInRadians:Psingle; pOuterAngleInRadians:Psingle; pOuterGain:Psingle);cdecl; external;

  procedure ma_spatializer_set_doppler_factor(pSpatializer:Pma_spatializer; dopplerFactor:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_doppler_factor(pSpatializer:Pma_spatializer):single;cdecl; external;

  procedure ma_spatializer_set_directional_attenuation_factor(pSpatializer:Pma_spatializer; directionalAttenuationFactor:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_directional_attenuation_factor(pSpatializer:Pma_spatializer):single;cdecl; external;

  procedure ma_spatializer_set_position(pSpatializer:Pma_spatializer; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_position(pSpatializer:Pma_spatializer):ma_vec3f;cdecl; external;

  procedure ma_spatializer_set_direction(pSpatializer:Pma_spatializer; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_direction(pSpatializer:Pma_spatializer):ma_vec3f;cdecl; external;

  procedure ma_spatializer_set_velocity(pSpatializer:Pma_spatializer; x:single; y:single; z:single);cdecl; external;

(* Const before type ignored *)
  function ma_spatializer_get_velocity(pSpatializer:Pma_spatializer):ma_vec3f;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  procedure ma_spatializer_get_relative_position_and_direction(pSpatializer:Pma_spatializer; pListener:Pma_spatializer_listener; pRelativePos:Pma_vec3f; pRelativeDir:Pma_vec3f);cdecl; external;
  function ma_linear_resampler_config_init(format:ma_format; channels:ma_uint32; sampleRateIn:ma_uint32; sampleRateOut:ma_uint32):ma_linear_resampler_config;cdecl; external;
  function ma_linear_resampler_get_heap_size(pConfig:Pma_linear_resampler_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_linear_resampler_init_preallocated(pConfig:Pma_linear_resampler_config; pHeap:pointer; pResampler:Pma_linear_resampler):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_linear_resampler_init(pConfig:Pma_linear_resampler_config; pAllocationCallbacks:Pma_allocation_callbacks; pResampler:Pma_linear_resampler):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_linear_resampler_uninit(pResampler:Pma_linear_resampler; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_linear_resampler_process_pcm_frames(pResampler:Pma_linear_resampler; pFramesIn:pointer; pFrameCountIn:Pma_uint64; pFramesOut:pointer; pFrameCountOut:Pma_uint64):ma_result;cdecl; external;

  function ma_linear_resampler_set_rate(pResampler:Pma_linear_resampler; sampleRateIn:ma_uint32; sampleRateOut:ma_uint32):ma_result;cdecl; external;

  function ma_linear_resampler_set_rate_ratio(pResampler:Pma_linear_resampler; ratioInOut:single):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_linear_resampler_get_input_latency(pResampler:Pma_linear_resampler):ma_uint64;cdecl; external;

(* Const before type ignored *)
  function ma_linear_resampler_get_output_latency(pResampler:Pma_linear_resampler):ma_uint64;cdecl; external;

(* Const before type ignored *)
  function ma_linear_resampler_get_required_input_frame_count(pResampler:Pma_linear_resampler; outputFrameCount:ma_uint64; pInputFrameCount:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_linear_resampler_get_expected_output_frame_count(pResampler:Pma_linear_resampler; inputFrameCount:ma_uint64; pOutputFrameCount:Pma_uint64):ma_result;cdecl; external;

  function ma_linear_resampler_reset(pResampler:Pma_linear_resampler):ma_result;cdecl; external;


  function ma_resampler_config_init(format:ma_format; channels:ma_uint32; sampleRateIn:ma_uint32; sampleRateOut:ma_uint32; algorithm:ma_resample_algorithm):ma_resampler_config;cdecl; external;


  function ma_resampler_get_heap_size(pConfig:Pma_resampler_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resampler_init_preallocated(pConfig:Pma_resampler_config; pHeap:pointer; pResampler:Pma_resampler):ma_result;cdecl; external;
  function ma_resampler_init(pConfig:Pma_resampler_config; pAllocationCallbacks:Pma_allocation_callbacks; pResampler:Pma_resampler):ma_result;cdecl; external;
  function ma_resampler_process_pcm_frames(pResampler:Pma_resampler; pFramesIn:pointer; pFrameCountIn:Pma_uint64; pFramesOut:pointer; pFrameCountOut:Pma_uint64):ma_result;cdecl; external;

  {
  Sets the input and output sample rate.
   }
  function ma_resampler_set_rate(pResampler:Pma_resampler; sampleRateIn:ma_uint32; sampleRateOut:ma_uint32):ma_result;cdecl; external;

  {
  Sets the input and output sample rate as a ratio.
  
  The ration is in/out.
   }
  function ma_resampler_set_rate_ratio(pResampler:Pma_resampler; ratio:single):ma_result;cdecl; external;

  {
  Retrieves the latency introduced by the resampler in input frames.
   }
(* Const before type ignored *)
  function ma_resampler_get_input_latency(pResampler:Pma_resampler):ma_uint64;cdecl; external;

  {
  Retrieves the latency introduced by the resampler in output frames.
   }
(* Const before type ignored *)
  function ma_resampler_get_output_latency(pResampler:Pma_resampler):ma_uint64;cdecl; external;

  {
  Calculates the number of whole input frames that would need to be read from the client in order to output the specified
  number of output frames.
  
  The returned value does not include cached input frames. It only returns the number of extra frames that would need to be
  read from the input buffer in order to output the specified number of output frames.
   }
(* Const before type ignored *)
  function ma_resampler_get_required_input_frame_count(pResampler:Pma_resampler; outputFrameCount:ma_uint64; pInputFrameCount:Pma_uint64):ma_result;cdecl; external;

  {
  Calculates the number of whole output frames that would be output after fully reading and consuming the specified number of
  input frames.
   }
(* Const before type ignored *)
  function ma_resampler_get_expected_output_frame_count(pResampler:Pma_resampler; inputFrameCount:ma_uint64; pOutputFrameCount:Pma_uint64):ma_result;cdecl; external;

  {
  Resets the resampler's timer and clears it's internal cache.
   }
  function ma_resampler_reset(pResampler:Pma_resampler):ma_result;cdecl; external;


  {
  Uninitializes a resampler.
   }
(* Const before type ignored *)
  procedure ma_resampler_uninit(pResampler:Pma_resampler; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;


  function ma_channel_converter_config_init(format:ma_format; channelsIn:ma_uint32; pChannelMapIn:Pma_channel; channelsOut:ma_uint32; pChannelMapOut:Pma_channel; 
             mixingMode:ma_channel_mix_mode):ma_channel_converter_config;cdecl; external;
  function ma_channel_converter_get_heap_size(pConfig:Pma_channel_converter_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_channel_converter_init_preallocated(pConfig:Pma_channel_converter_config; pHeap:pointer; pConverter:Pma_channel_converter):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_channel_converter_init(pConfig:Pma_channel_converter_config; pAllocationCallbacks:Pma_allocation_callbacks; pConverter:Pma_channel_converter):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_channel_converter_uninit(pConverter:Pma_channel_converter; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_channel_converter_process_pcm_frames(pConverter:Pma_channel_converter; pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_channel_converter_get_input_channel_map(pConverter:Pma_channel_converter; pChannelMap:Pma_channel; channelMapCap:size_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_channel_converter_get_output_channel_map(pConverter:Pma_channel_converter; pChannelMap:Pma_channel; channelMapCap:size_t):ma_result;cdecl; external;


  function ma_data_converter_config_init_default:ma_data_converter_config;cdecl; external;

  function ma_data_converter_config_init(formatIn:ma_format; formatOut:ma_format; channelsIn:ma_uint32; channelsOut:ma_uint32; sampleRateIn:ma_uint32; 
             sampleRateOut:ma_uint32):ma_data_converter_config;cdecl; external;

  function ma_data_converter_get_heap_size(pConfig:Pma_data_converter_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_init_preallocated(pConfig:Pma_data_converter_config; pHeap:pointer; pConverter:Pma_data_converter):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_data_converter_init(pConfig:Pma_data_converter_config; pAllocationCallbacks:Pma_allocation_callbacks; pConverter:Pma_data_converter):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_data_converter_uninit(pConverter:Pma_data_converter; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_process_pcm_frames(pConverter:Pma_data_converter; pFramesIn:pointer; pFrameCountIn:Pma_uint64; pFramesOut:pointer; pFrameCountOut:Pma_uint64):ma_result;cdecl; external;

  function ma_data_converter_set_rate(pConverter:Pma_data_converter; sampleRateIn:ma_uint32; sampleRateOut:ma_uint32):ma_result;cdecl; external;

  function ma_data_converter_set_rate_ratio(pConverter:Pma_data_converter; ratioInOut:single):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_get_input_latency(pConverter:Pma_data_converter):ma_uint64;cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_get_output_latency(pConverter:Pma_data_converter):ma_uint64;cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_get_required_input_frame_count(pConverter:Pma_data_converter; outputFrameCount:ma_uint64; pInputFrameCount:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_get_expected_output_frame_count(pConverter:Pma_data_converter; inputFrameCount:ma_uint64; pOutputFrameCount:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_get_input_channel_map(pConverter:Pma_data_converter; pChannelMap:Pma_channel; channelMapCap:size_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_converter_get_output_channel_map(pConverter:Pma_data_converter; pChannelMap:Pma_channel; channelMapCap:size_t):ma_result;cdecl; external;

  function ma_data_converter_reset(pConverter:Pma_data_converter):ma_result;cdecl; external;

  {***********************************************************************************************************************************************************
  
  Format Conversion
  
  *********************************************************************************************************************************************************** }
(* Const before type ignored *)
  procedure ma_pcm_u8_to_s16(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_u8_to_s24(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_u8_to_s32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_u8_to_f32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s16_to_u8(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s16_to_s24(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s16_to_s32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s16_to_f32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s24_to_u8(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s24_to_s16(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s24_to_s32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s24_to_f32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s32_to_u8(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s32_to_s16(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s32_to_s24(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_s32_to_f32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_f32_to_u8(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_f32_to_s16(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_f32_to_s24(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_f32_to_s32(pOut:pointer; pIn:pointer; count:ma_uint64; ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_pcm_convert(pOut:pointer; formatOut:ma_format; pIn:pointer; formatIn:ma_format; sampleCount:ma_uint64; 
              ditherMode:ma_dither_mode);cdecl; external;

(* Const before type ignored *)
  procedure ma_convert_pcm_frames_format(pOut:pointer; formatOut:ma_format; pIn:pointer; formatIn:ma_format; frameCount:ma_uint64; 
              channels:ma_uint32; ditherMode:ma_dither_mode);cdecl; external;

  {
  Deinterleaves an interleaved buffer.
   }
(* Const before type ignored *)
  procedure ma_deinterleave_pcm_frames(format:ma_format; channels:ma_uint32; frameCount:ma_uint64; pInterleavedPCMFrames:pointer; ppDeinterleavedPCMFrames:Ppointer);cdecl; external;

  {
  Interleaves a group of deinterleaved buffers.
   }
(* Const before type ignored *)
  procedure ma_interleave_pcm_frames(format:ma_format; channels:ma_uint32; frameCount:ma_uint64; ppDeinterleavedPCMFrames:Ppointer; pInterleavedPCMFrames:pointer);cdecl; external;



  const
    MA_CHANNEL_INDEX_NULL = 255;    
  const
    MA_DATA_SOURCE_SELF_MANAGED_RANGE_AND_LOOP_POINT = $00000001;    
  {
  Retrieves the channel position of the specified channel in the given channel map.
  
  The pChannelMap parameter can be null, in which case miniaudio's default channel map will be assumed.
   }
(* Const before type ignored *)

  function ma_channel_map_get_channel(pChannelMap:Pma_channel; channelCount:ma_uint32; channelIndex:ma_uint32):ma_channel;cdecl; external;

  {
  Initializes a blank channel map.
  
  When a blank channel map is specified anywhere it indicates that the native channel map should be used.
   }
  procedure ma_channel_map_init_blank(pChannelMap:Pma_channel; channels:ma_uint32);cdecl; external;

  {
  Helper for retrieving a standard channel map.
  
  The output channel map buffer must have a capacity of at least `channelMapCap`.
   }
  procedure ma_channel_map_init_standard(standardChannelMap:ma_standard_channel_map; pChannelMap:Pma_channel; channelMapCap:size_t; channels:ma_uint32);cdecl; external;

  {
  Copies a channel map.
  
  Both input and output channel map buffers must have a capacity of at at least `channels`.
   }
(* Const before type ignored *)
  procedure ma_channel_map_copy(pOut:Pma_channel; pIn:Pma_channel; channels:ma_uint32);cdecl; external;

  {
  Copies a channel map if one is specified, otherwise copies the default channel map.
  
  The output buffer must have a capacity of at least `channels`. If not NULL, the input channel map must also have a capacity of at least `channels`.
   }
(* Const before type ignored *)
  procedure ma_channel_map_copy_or_default(pOut:Pma_channel; channelMapCapOut:size_t; pIn:Pma_channel; channels:ma_uint32);cdecl; external;

  {
  Determines whether or not a channel map is valid.
  
  A blank channel map is valid (all channels set to MA_CHANNEL_NONE). The way a blank channel map is handled is context specific, but
  is usually treated as a passthrough.
  
  Invalid channel maps:
    - A channel map with no channels
    - A channel map with more than one channel and a mono channel
  
  The channel map buffer must have a capacity of at least `channels`.
   }
(* Const before type ignored *)
  function ma_channel_map_is_valid(pChannelMap:Pma_channel; channels:ma_uint32):ma_bool32;cdecl; external;

  {
  Helper for comparing two channel maps for equality.
  
  This assumes the channel count is the same between the two.
  
  Both channels map buffers must have a capacity of at least `channels`.
   }
(* Const before type ignored *)
(* Const before type ignored *)
  function ma_channel_map_is_equal(pChannelMapA:Pma_channel; pChannelMapB:Pma_channel; channels:ma_uint32):ma_bool32;cdecl; external;

  {
  Helper for determining if a channel map is blank (all channels set to MA_CHANNEL_NONE).
  
  The channel map buffer must have a capacity of at least `channels`.
   }
(* Const before type ignored *)
  function ma_channel_map_is_blank(pChannelMap:Pma_channel; channels:ma_uint32):ma_bool32;cdecl; external;

  {
  Helper for determining whether or not a channel is present in the given channel map.
  
  The channel map buffer must have a capacity of at least `channels`.
   }
(* Const before type ignored *)
  function ma_channel_map_contains_channel_position(channels:ma_uint32; pChannelMap:Pma_channel; channelPosition:ma_channel):ma_bool32;cdecl; external;

  {
  Find a channel position in the given channel map. Returns MA_TRUE if the channel is found; MA_FALSE otherwise. The
  index of the channel is output to `pChannelIndex`.
  
  The channel map buffer must have a capacity of at least `channels`.
   }
(* Const before type ignored *)
  function ma_channel_map_find_channel_position(channels:ma_uint32; pChannelMap:Pma_channel; channelPosition:ma_channel; pChannelIndex:Pma_uint32):ma_bool32;cdecl; external;

  {
  Generates a string representing the given channel map.
  
  This is for printing and debugging purposes, not serialization/deserialization.
  
  Returns the length of the string, not including the null terminator.
   }
(* Const before type ignored *)
  function ma_channel_map_to_string(pChannelMap:Pma_channel; channels:ma_uint32; pBufferOut:Pchar; bufferCap:size_t):size_t;cdecl; external;

  {
  Retrieves a human readable version of a channel position.
   }
(* Const before type ignored *)
  function ma_channel_position_to_string(channel:ma_channel):Pchar;cdecl; external;

  {***********************************************************************************************************************************************************
  
  Conversion Helpers
  
  *********************************************************************************************************************************************************** }
  {
  High-level helper for doing a full format conversion in one go. Returns the number of output frames. Call this with pOut set to NULL to
  determine the required size of the output buffer. frameCountOut should be set to the capacity of pOut. If pOut is NULL, frameCountOut is
  ignored.
  
  A return value of 0 indicates an error.
  
  This function is useful for one-off bulk conversions, but if you're streaming data you should use the ma_data_converter APIs instead.
   }
(* Const before type ignored *)
  function ma_convert_frames(pOut:pointer; frameCountOut:ma_uint64; formatOut:ma_format; channelsOut:ma_uint32; sampleRateOut:ma_uint32; 
             pIn:pointer; frameCountIn:ma_uint64; formatIn:ma_format; channelsIn:ma_uint32; sampleRateIn:ma_uint32):ma_uint64;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_convert_frames_ex(pOut:pointer; frameCountOut:ma_uint64; pIn:pointer; frameCountIn:ma_uint64; pConfig:Pma_data_converter_config):ma_uint64;cdecl; external;

  {***********************************************************************************************************************************************************
  
  Data Source
  
  *********************************************************************************************************************************************************** }


  function ma_data_source_config_init:ma_data_source_config;cdecl; external;
  function ma_data_source_init(pConfig:Pma_data_source_config; pDataSource:Pma_data_source):ma_result;cdecl; external;

  procedure ma_data_source_uninit(pDataSource:Pma_data_source);cdecl; external;

  function ma_data_source_read_pcm_frames(pDataSource:Pma_data_source; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  { Must support pFramesOut = NULL in which case a forward seek should be performed.  }
  function ma_data_source_seek_pcm_frames(pDataSource:Pma_data_source; frameCount:ma_uint64; pFramesSeeked:Pma_uint64):ma_result;cdecl; external;

  { Can only seek forward. Equivalent to ma_data_source_read_pcm_frames(pDataSource, NULL, frameCount, &framesRead);  }
  function ma_data_source_seek_to_pcm_frame(pDataSource:Pma_data_source; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_data_source_get_data_format(pDataSource:Pma_data_source; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel; 
             channelMapCap:size_t):ma_result;cdecl; external;

  function ma_data_source_get_cursor_in_pcm_frames(pDataSource:Pma_data_source; pCursor:Pma_uint64):ma_result;cdecl; external;

  function ma_data_source_get_length_in_pcm_frames(pDataSource:Pma_data_source; pLength:Pma_uint64):ma_result;cdecl; external;

  { Returns MA_NOT_IMPLEMENTED if the length is unknown or cannot be determined. Decoders can return this.  }
  function ma_data_source_get_cursor_in_seconds(pDataSource:Pma_data_source; pCursor:Psingle):ma_result;cdecl; external;

  function ma_data_source_get_length_in_seconds(pDataSource:Pma_data_source; pLength:Psingle):ma_result;cdecl; external;

  function ma_data_source_set_looping(pDataSource:Pma_data_source; isLooping:ma_bool32):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_source_is_looping(pDataSource:Pma_data_source):ma_bool32;cdecl; external;

  function ma_data_source_set_range_in_pcm_frames(pDataSource:Pma_data_source; rangeBegInFrames:ma_uint64; rangeEndInFrames:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_data_source_get_range_in_pcm_frames(pDataSource:Pma_data_source; pRangeBegInFrames:Pma_uint64; pRangeEndInFrames:Pma_uint64);cdecl; external;

  function ma_data_source_set_loop_point_in_pcm_frames(pDataSource:Pma_data_source; loopBegInFrames:ma_uint64; loopEndInFrames:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_data_source_get_loop_point_in_pcm_frames(pDataSource:Pma_data_source; pLoopBegInFrames:Pma_uint64; pLoopEndInFrames:Pma_uint64);cdecl; external;

  function ma_data_source_set_current(pDataSource:Pma_data_source; pCurrentDataSource:Pma_data_source):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_source_get_current(pDataSource:Pma_data_source):Pma_data_source;cdecl; external;

  function ma_data_source_set_next(pDataSource:Pma_data_source; pNextDataSource:Pma_data_source):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_source_get_next(pDataSource:Pma_data_source):Pma_data_source;cdecl; external;

  function ma_data_source_set_next_callback(pDataSource:Pma_data_source; onGetNext:ma_data_source_get_next_proc):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_data_source_get_next_callback(pDataSource:Pma_data_source):ma_data_source_get_next_proc;cdecl; external;

(* Const before type ignored *)



  function ma_audio_buffer_ref_init(format:ma_format; channels:ma_uint32; pData:pointer; sizeInFrames:ma_uint64; pAudioBufferRef:Pma_audio_buffer_ref):ma_result;cdecl; external;

  procedure ma_audio_buffer_ref_uninit(pAudioBufferRef:Pma_audio_buffer_ref);cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_ref_set_data(pAudioBufferRef:Pma_audio_buffer_ref; pData:pointer; sizeInFrames:ma_uint64):ma_result;cdecl; external;

  function ma_audio_buffer_ref_read_pcm_frames(pAudioBufferRef:Pma_audio_buffer_ref; pFramesOut:pointer; frameCount:ma_uint64; loop:ma_bool32):ma_uint64;cdecl; external;

  function ma_audio_buffer_ref_seek_to_pcm_frame(pAudioBufferRef:Pma_audio_buffer_ref; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_audio_buffer_ref_map(pAudioBufferRef:Pma_audio_buffer_ref; ppFramesOut:Ppointer; pFrameCount:Pma_uint64):ma_result;cdecl; external;

  function ma_audio_buffer_ref_unmap(pAudioBufferRef:Pma_audio_buffer_ref; frameCount:ma_uint64):ma_result;cdecl; external;

  { Returns MA_AT_END if the end has been reached. This should be considered successful.  }
(* Const before type ignored *)
  function ma_audio_buffer_ref_at_end(pAudioBufferRef:Pma_audio_buffer_ref):ma_bool32;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_ref_get_cursor_in_pcm_frames(pAudioBufferRef:Pma_audio_buffer_ref; pCursor:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_ref_get_length_in_pcm_frames(pAudioBufferRef:Pma_audio_buffer_ref; pLength:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_ref_get_available_frames(pAudioBufferRef:Pma_audio_buffer_ref; pAvailableFrames:Pma_uint64):ma_result;cdecl; external;


  function ma_audio_buffer_config_init(format:ma_format; channels:ma_uint32; sizeInFrames:ma_uint64; pData:pointer; pAllocationCallbacks:Pma_allocation_callbacks):ma_audio_buffer_config;cdecl; external;

  function ma_audio_buffer_init(pConfig:Pma_audio_buffer_config; pAudioBuffer:Pma_audio_buffer):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_init_copy(pConfig:Pma_audio_buffer_config; pAudioBuffer:Pma_audio_buffer):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_alloc_and_init(pConfig:Pma_audio_buffer_config; ppAudioBuffer:PPma_audio_buffer):ma_result;cdecl; external;

  { Always copies the data. Doesn't make sense to use this otherwise. Use ma_audio_buffer_uninit_and_free() to uninit.  }
  procedure ma_audio_buffer_uninit(pAudioBuffer:Pma_audio_buffer);cdecl; external;

  procedure ma_audio_buffer_uninit_and_free(pAudioBuffer:Pma_audio_buffer);cdecl; external;

  function ma_audio_buffer_read_pcm_frames(pAudioBuffer:Pma_audio_buffer; pFramesOut:pointer; frameCount:ma_uint64; loop:ma_bool32):ma_uint64;cdecl; external;

  function ma_audio_buffer_seek_to_pcm_frame(pAudioBuffer:Pma_audio_buffer; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_audio_buffer_map(pAudioBuffer:Pma_audio_buffer; ppFramesOut:Ppointer; pFrameCount:Pma_uint64):ma_result;cdecl; external;

  function ma_audio_buffer_unmap(pAudioBuffer:Pma_audio_buffer; frameCount:ma_uint64):ma_result;cdecl; external;

  { Returns MA_AT_END if the end has been reached. This should be considered successful.  }
(* Const before type ignored *)
  function ma_audio_buffer_at_end(pAudioBuffer:Pma_audio_buffer):ma_bool32;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_get_cursor_in_pcm_frames(pAudioBuffer:Pma_audio_buffer; pCursor:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_get_length_in_pcm_frames(pAudioBuffer:Pma_audio_buffer; pLength:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_audio_buffer_get_available_frames(pAudioBuffer:Pma_audio_buffer; pAvailableFrames:Pma_uint64):ma_result;cdecl; external;

  function ma_paged_audio_buffer_data_init(format:ma_format; channels:ma_uint32; pData:Pma_paged_audio_buffer_data):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_paged_audio_buffer_data_uninit(pData:Pma_paged_audio_buffer_data; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_paged_audio_buffer_data_get_head(pData:Pma_paged_audio_buffer_data):Pma_paged_audio_buffer_page;cdecl; external;

  function ma_paged_audio_buffer_data_get_tail(pData:Pma_paged_audio_buffer_data):Pma_paged_audio_buffer_page;cdecl; external;

  function ma_paged_audio_buffer_data_get_length_in_pcm_frames(pData:Pma_paged_audio_buffer_data; pLength:Pma_uint64):ma_result;cdecl; external;
  function ma_paged_audio_buffer_data_allocate_page(pData:Pma_paged_audio_buffer_data; pageSizeInFrames:ma_uint64; pInitialData:pointer; pAllocationCallbacks:Pma_allocation_callbacks; ppPage:PPma_paged_audio_buffer_page):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_paged_audio_buffer_data_free_page(pData:Pma_paged_audio_buffer_data; pPage:Pma_paged_audio_buffer_page; pAllocationCallbacks:Pma_allocation_callbacks):ma_result;cdecl; external;

  function ma_paged_audio_buffer_data_append_page(pData:Pma_paged_audio_buffer_data; pPage:Pma_paged_audio_buffer_page):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_paged_audio_buffer_data_allocate_and_append_page(pData:Pma_paged_audio_buffer_data; pageSizeInFrames:ma_uint32; pInitialData:pointer; pAllocationCallbacks:Pma_allocation_callbacks):ma_result;cdecl; external;


  function ma_paged_audio_buffer_init(pConfig:Pma_paged_audio_buffer_config; pPagedAudioBuffer:Pma_paged_audio_buffer):ma_result;cdecl; external;

  procedure ma_paged_audio_buffer_uninit(pPagedAudioBuffer:Pma_paged_audio_buffer);cdecl; external;

  function ma_paged_audio_buffer_read_pcm_frames(pPagedAudioBuffer:Pma_paged_audio_buffer; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  { Returns MA_AT_END if no more pages available.  }
  function ma_paged_audio_buffer_seek_to_pcm_frame(pPagedAudioBuffer:Pma_paged_audio_buffer; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_paged_audio_buffer_get_cursor_in_pcm_frames(pPagedAudioBuffer:Pma_paged_audio_buffer; pCursor:Pma_uint64):ma_result;cdecl; external;

  function ma_paged_audio_buffer_get_length_in_pcm_frames(pPagedAudioBuffer:Pma_paged_audio_buffer; pLength:Pma_uint64):ma_result;cdecl; external;


  function ma_rb_init_ex(subbufferSizeInBytes:size_t; subbufferCount:size_t; subbufferStrideInBytes:size_t; pOptionalPreallocatedBuffer:pointer; pAllocationCallbacks:Pma_allocation_callbacks; 
             pRB:Pma_rb):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_rb_init(bufferSizeInBytes:size_t; pOptionalPreallocatedBuffer:pointer; pAllocationCallbacks:Pma_allocation_callbacks; pRB:Pma_rb):ma_result;cdecl; external;

  procedure ma_rb_uninit(pRB:Pma_rb);cdecl; external;

  procedure ma_rb_reset(pRB:Pma_rb);cdecl; external;

  function ma_rb_acquire_read(pRB:Pma_rb; pSizeInBytes:Psize_t; ppBufferOut:Ppointer):ma_result;cdecl; external;

  function ma_rb_commit_read(pRB:Pma_rb; sizeInBytes:size_t):ma_result;cdecl; external;

  function ma_rb_acquire_write(pRB:Pma_rb; pSizeInBytes:Psize_t; ppBufferOut:Ppointer):ma_result;cdecl; external;

  function ma_rb_commit_write(pRB:Pma_rb; sizeInBytes:size_t):ma_result;cdecl; external;

  function ma_rb_seek_read(pRB:Pma_rb; offsetInBytes:size_t):ma_result;cdecl; external;

  function ma_rb_seek_write(pRB:Pma_rb; offsetInBytes:size_t):ma_result;cdecl; external;

  function ma_rb_pointer_distance(pRB:Pma_rb):ma_int32;cdecl; external;

  { Returns the distance between the write pointer and the read pointer. Should never be negative for a correct program. Will return the number of bytes that can be read before the read pointer hits the write pointer.  }
  function ma_rb_available_read(pRB:Pma_rb):ma_uint32;cdecl; external;

  function ma_rb_available_write(pRB:Pma_rb):ma_uint32;cdecl; external;

  function ma_rb_get_subbuffer_size(pRB:Pma_rb):size_t;cdecl; external;

  function ma_rb_get_subbuffer_stride(pRB:Pma_rb):size_t;cdecl; external;

  function ma_rb_get_subbuffer_offset(pRB:Pma_rb; subbufferIndex:size_t):size_t;cdecl; external;

  function ma_rb_get_subbuffer_ptr(pRB:Pma_rb; subbufferIndex:size_t; pBuffer:pointer):pointer;cdecl; external;
  function ma_pcm_rb_init_ex(format:ma_format; channels:ma_uint32; subbufferSizeInFrames:ma_uint32; subbufferCount:ma_uint32; subbufferStrideInFrames:ma_uint32; 
             pOptionalPreallocatedBuffer:pointer; pAllocationCallbacks:Pma_allocation_callbacks; pRB:Pma_pcm_rb):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_pcm_rb_init(format:ma_format; channels:ma_uint32; bufferSizeInFrames:ma_uint32; pOptionalPreallocatedBuffer:pointer; pAllocationCallbacks:Pma_allocation_callbacks; 
             pRB:Pma_pcm_rb):ma_result;cdecl; external;

  procedure ma_pcm_rb_uninit(pRB:Pma_pcm_rb);cdecl; external;

  procedure ma_pcm_rb_reset(pRB:Pma_pcm_rb);cdecl; external;

  function ma_pcm_rb_acquire_read(pRB:Pma_pcm_rb; pSizeInFrames:Pma_uint32; ppBufferOut:Ppointer):ma_result;cdecl; external;

  function ma_pcm_rb_commit_read(pRB:Pma_pcm_rb; sizeInFrames:ma_uint32):ma_result;cdecl; external;

  function ma_pcm_rb_acquire_write(pRB:Pma_pcm_rb; pSizeInFrames:Pma_uint32; ppBufferOut:Ppointer):ma_result;cdecl; external;

  function ma_pcm_rb_commit_write(pRB:Pma_pcm_rb; sizeInFrames:ma_uint32):ma_result;cdecl; external;

  function ma_pcm_rb_seek_read(pRB:Pma_pcm_rb; offsetInFrames:ma_uint32):ma_result;cdecl; external;

  function ma_pcm_rb_seek_write(pRB:Pma_pcm_rb; offsetInFrames:ma_uint32):ma_result;cdecl; external;

  function ma_pcm_rb_pointer_distance(pRB:Pma_pcm_rb):ma_int32;cdecl; external;

  { Return value is in frames.  }
  function ma_pcm_rb_available_read(pRB:Pma_pcm_rb):ma_uint32;cdecl; external;

  function ma_pcm_rb_available_write(pRB:Pma_pcm_rb):ma_uint32;cdecl; external;

  function ma_pcm_rb_get_subbuffer_size(pRB:Pma_pcm_rb):ma_uint32;cdecl; external;

  function ma_pcm_rb_get_subbuffer_stride(pRB:Pma_pcm_rb):ma_uint32;cdecl; external;

  function ma_pcm_rb_get_subbuffer_offset(pRB:Pma_pcm_rb; subbufferIndex:ma_uint32):ma_uint32;cdecl; external;

  function ma_pcm_rb_get_subbuffer_ptr(pRB:Pma_pcm_rb; subbufferIndex:ma_uint32; pBuffer:pointer):pointer;cdecl; external;

(* Const before type ignored *)
  function ma_pcm_rb_get_format(pRB:Pma_pcm_rb):ma_format;cdecl; external;

(* Const before type ignored *)
  function ma_pcm_rb_get_channels(pRB:Pma_pcm_rb):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_pcm_rb_get_sample_rate(pRB:Pma_pcm_rb):ma_uint32;cdecl; external;

  procedure ma_pcm_rb_set_sample_rate(pRB:Pma_pcm_rb; sampleRate:ma_uint32);cdecl; external;
  function ma_duplex_rb_init(captureFormat:ma_format; captureChannels:ma_uint32; sampleRate:ma_uint32; captureInternalSampleRate:ma_uint32; captureInternalPeriodSizeInFrames:ma_uint32; 
             pAllocationCallbacks:Pma_allocation_callbacks; pRB:Pma_duplex_rb):ma_result;cdecl; external;

  function ma_duplex_rb_uninit(pRB:Pma_duplex_rb):ma_result;cdecl; external;

  {***********************************************************************************************************************************************************
  
  Miscellaneous Helpers
  
  *********************************************************************************************************************************************************** }
  {
  Retrieves a human readable description of the given result code.
   }
(* Const before type ignored *)
  function ma_result_description(result:ma_result):Pchar;cdecl; external;

  {
  malloc()
   }
(* Const before type ignored *)
  function ma_malloc(sz:size_t; pAllocationCallbacks:Pma_allocation_callbacks):pointer;cdecl; external;

  {
  calloc()
   }
(* Const before type ignored *)
  function ma_calloc(sz:size_t; pAllocationCallbacks:Pma_allocation_callbacks):pointer;cdecl; external;

  {
  realloc()
   }
(* Const before type ignored *)
  function ma_realloc(p:pointer; sz:size_t; pAllocationCallbacks:Pma_allocation_callbacks):pointer;cdecl; external;

  {
  free()
   }
(* Const before type ignored *)
  procedure ma_free(p:pointer; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  {
  Performs an aligned malloc, with the assumption that the alignment is a power of 2.
   }
(* Const before type ignored *)
  function ma_aligned_malloc(sz:size_t; alignment:size_t; pAllocationCallbacks:Pma_allocation_callbacks):pointer;cdecl; external;

  {
  Free's an aligned malloc'd buffer.
   }
(* Const before type ignored *)
  procedure ma_aligned_free(p:pointer; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  {
  Retrieves a friendly name for a format.
   }
(* Const before type ignored *)
  function ma_get_format_name(format:ma_format):Pchar;cdecl; external;

  {
  Blends two frames in floating point format.
   }
  procedure ma_blend_f32(pOut:Psingle; pInA:Psingle; pInB:Psingle; factor:single; channels:ma_uint32);cdecl; external;

  {
  Retrieves the size of a sample in bytes for the given format.
  
  This API is efficient and is implemented using a lookup table.
  
  Thread Safety: SAFE
    This API is pure.
   }
  function ma_get_bytes_per_sample(format:ma_format):ma_uint32;cdecl; external;

  {static MA_INLINE ma_uint32 ma_get_bytes_per_frame(ma_format format, ma_uint32 channels)  return ma_get_bytes_per_sample(format) * channels;  }
  {
  Converts a log level to a string.
   }
(* Const before type ignored *)
  function ma_log_level_to_string(logLevel:ma_uint32):Pchar;cdecl; external;

  {***********************************************************************************************************************************************************
  
  Synchronization
  
  *********************************************************************************************************************************************************** }
  {
  Locks a spinlock.
   }
  {volatile }  function ma_spinlock_lock(pSpinlock:Pma_spinlock):ma_result;cdecl; external;

  {
  Locks a spinlock, but does not yield() when looping.
   }
  {volatile }  function ma_spinlock_lock_noyield(pSpinlock:Pma_spinlock):ma_result;cdecl; external;

  {
  Unlocks a spinlock.
   }
  {volatile }  function ma_spinlock_unlock(pSpinlock:Pma_spinlock):ma_result;cdecl; external;

{$ifndef MA_NO_THREADING}
  {
  Creates a mutex.
  
  A mutex must be created from a valid context. A mutex is initially unlocked.
   }

  function ma_mutex_init(pMutex:Pma_mutex):ma_result;cdecl; external;

  {
  Deletes a mutex.
   }
  procedure ma_mutex_uninit(pMutex:Pma_mutex);cdecl; external;

  {
  Locks a mutex with an infinite timeout.
   }
  procedure ma_mutex_lock(pMutex:Pma_mutex);cdecl; external;

  {
  Unlocks a mutex.
   }
  procedure ma_mutex_unlock(pMutex:Pma_mutex);cdecl; external;

  {
  Initializes an auto-reset event.
   }
  function ma_event_init(pEvent:Pma_event):ma_result;cdecl; external;

  {
  Uninitializes an auto-reset event.
   }
  procedure ma_event_uninit(pEvent:Pma_event);cdecl; external;

  {
  Waits for the specified auto-reset event to become signalled.
   }
  function ma_event_wait(pEvent:Pma_event):ma_result;cdecl; external;

  {
  Signals the specified auto-reset event.
   }
  function ma_event_signal(pEvent:Pma_event):ma_result;cdecl; external;

{$endif}
  { MA_NO_THREADING  }
  {
  Fence
  =====
  This locks while the counter is larger than 0. Counter can be incremented and decremented by any
  thread, but care needs to be taken when waiting. It is possible for one thread to acquire the
  fence just as another thread returns from ma_fence_wait().
  
  The idea behind a fence is to allow you to wait for a group of operations to complete. When an
  operation starts, the counter is incremented which locks the fence. When the operation completes,
  the fence will be released which decrements the counter. ma_fence_wait() will block until the
  counter hits zero.
  
  If threading is disabled, ma_fence_wait() will spin on the counter.
   }


  function ma_fence_init(pFence:Pma_fence):ma_result;cdecl; external;

  procedure ma_fence_uninit(pFence:Pma_fence);cdecl; external;

  function ma_fence_acquire(pFence:Pma_fence):ma_result;cdecl; external;

  { Increment counter.  }
  function ma_fence_release(pFence:Pma_fence):ma_result;cdecl; external;

  { Decrement counter.  }
  function ma_fence_wait(pFence:Pma_fence):ma_result;cdecl; external;

  { Wait for counter to reach 0.  }
  {
  Notification callback for asynchronous operations.
   }

  function ma_async_notification_signal(pNotification:Pma_async_notification):ma_result;cdecl; external;
  function ma_async_notification_poll_init(pNotificationPoll:Pma_async_notification_poll):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_async_notification_poll_is_signalled(pNotificationPoll:Pma_async_notification_poll):ma_bool32;cdecl; external;
  function ma_async_notification_event_init(pNotificationEvent:Pma_async_notification_event):ma_result;cdecl; external;

  function ma_async_notification_event_uninit(pNotificationEvent:Pma_async_notification_event):ma_result;cdecl; external;

  function ma_async_notification_event_wait(pNotificationEvent:Pma_async_notification_event):ma_result;cdecl; external;

  function ma_async_notification_event_signal(pNotificationEvent:Pma_async_notification_event):ma_result;cdecl; external;

  function ma_slot_allocator_config_init(capacity:ma_uint32):ma_slot_allocator_config;cdecl; external;
  function ma_slot_allocator_get_heap_size(pConfig:Pma_slot_allocator_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_slot_allocator_init_preallocated(pConfig:Pma_slot_allocator_config; pHeap:pointer; pAllocator:Pma_slot_allocator):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_slot_allocator_init(pConfig:Pma_slot_allocator_config; pAllocationCallbacks:Pma_allocation_callbacks; pAllocator:Pma_slot_allocator):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_slot_allocator_uninit(pAllocator:Pma_slot_allocator; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_slot_allocator_alloc(pAllocator:Pma_slot_allocator; pSlot:Pma_uint64):ma_result;cdecl; external;

  function ma_slot_allocator_free(pAllocator:Pma_slot_allocator; slot:ma_uint64):ma_result;cdecl; external;

  function ma_job_init(code:ma_uint16):ma_job;cdecl; external;

  function ma_job_process(pJob:Pma_job):ma_result;cdecl; external;
  function ma_job_queue_config_init(flags:ma_uint32; capacity:ma_uint32):ma_job_queue_config;cdecl; external;
  function ma_job_queue_get_heap_size(pConfig:Pma_job_queue_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_job_queue_init_preallocated(pConfig:Pma_job_queue_config; pHeap:pointer; pQueue:Pma_job_queue):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_job_queue_init(pConfig:Pma_job_queue_config; pAllocationCallbacks:Pma_allocation_callbacks; pQueue:Pma_job_queue):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_job_queue_uninit(pQueue:Pma_job_queue; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_job_queue_post(pQueue:Pma_job_queue; pJob:Pma_job):ma_result;cdecl; external;

  function ma_job_queue_next(pQueue:Pma_job_queue; pJob:Pma_job):ma_result;cdecl; external;
  function ma_device_job_thread_config_init:ma_device_job_thread_config;cdecl; external;
  function ma_device_job_thread_init(pConfig:Pma_device_job_thread_config; pAllocationCallbacks:Pma_allocation_callbacks; pJobThread:Pma_device_job_thread):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_device_job_thread_uninit(pJobThread:Pma_device_job_thread; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_device_job_thread_post(pJobThread:Pma_device_job_thread; pJob:Pma_job):ma_result;cdecl; external;

  function ma_device_job_thread_next(pJobThread:Pma_device_job_thread; pJob:Pma_job):ma_result;cdecl; external;


  function ma_context_init(backends:Pma_backend; backendCount:ma_uint32; pConfig:Pma_context_config; pContext:Pma_context):ma_result;cdecl; external;

  function ma_context_uninit(pContext:Pma_context):ma_result;cdecl; external;
  function ma_context_sizeof:size_t;cdecl; external;
  function ma_context_enumerate_devices(pContext:Pma_context; callback:ma_enum_devices_callback_proc; pUserData:pointer):ma_result;cdecl; external;
  function ma_context_get_devices(pContext:Pma_context; ppPlaybackDeviceInfos:PPma_device_info; pPlaybackDeviceCount:Pma_uint32; ppCaptureDeviceInfos:PPma_device_info; pCaptureDeviceCount:Pma_uint32):ma_result;cdecl; external;
  function ma_context_get_device_info(pContext:Pma_context; deviceType:ma_device_type; pDeviceID:Pma_device_id; pDeviceInfo:Pma_device_info):ma_result;cdecl; external;
  function ma_device_config_init(deviceType:ma_device_type):ma_device_config;cdecl; external;
  function ma_device_init(pContext:Pma_context; pConfig:Pma_device_config; pDevice:Pma_device):ma_result;cdecl; external;
  function ma_device_init_ex(backends:Pma_backend; backendCount:ma_uint32; pContextConfig:Pma_context_config; pConfig:Pma_device_config; pDevice:Pma_device):ma_result;cdecl; external;
  procedure ma_device_uninit(pDevice:Pma_device);cdecl; external;
  function ma_device_get_context(pDevice:Pma_device):Pma_context;cdecl; external;
  function ma_device_get_log(pDevice:Pma_device):Pma_log;cdecl; external;
  function ma_device_get_info(pDevice:Pma_device; _type:ma_device_type; pDeviceInfo:Pma_device_info):ma_result;cdecl; external;
  function ma_device_get_name(pDevice:Pma_device; _type:ma_device_type; pName:Pchar; nameCap:size_t; pLengthNotIncludingNullTerminator:Psize_t):ma_result;cdecl; external;
  function ma_device_start(pDevice:Pma_device):ma_result;cdecl; external;
  function ma_device_stop(pDevice:Pma_device):ma_result;cdecl; external;
  function ma_device_is_started(pDevice:Pma_device):ma_bool32;cdecl; external;
  function ma_device_get_state(pDevice:Pma_device):ma_device_state;cdecl; external;
  function ma_device_post_init(pDevice:Pma_device; deviceType:ma_device_type; pPlaybackDescriptor:Pma_device_descriptor; pCaptureDescriptor:Pma_device_descriptor):ma_result;cdecl; external;
  function ma_device_set_master_volume(pDevice:Pma_device; volume:single):ma_result;cdecl; external;
  function ma_device_get_master_volume(pDevice:Pma_device; pVolume:Psingle):ma_result;cdecl; external;
  function ma_device_set_master_volume_db(pDevice:Pma_device; gainDB:single):ma_result;cdecl; external;
  function ma_device_get_master_volume_db(pDevice:Pma_device; pGainDB:Psingle):ma_result;cdecl; external;
  function ma_device_handle_backend_data_callback(pDevice:Pma_device; pOutput:pointer; pInput:pointer; frameCount:ma_uint32):ma_result;cdecl; external;
  function ma_calculate_buffer_size_in_frames_from_descriptor(pDescriptor:Pma_device_descriptor; nativeSampleRate:ma_uint32; performanceProfile:ma_performance_profile):ma_uint32;cdecl; external;
  function ma_get_backend_name(backend:ma_backend):Pchar;cdecl; external;
  function ma_get_backend_from_name(pBackendName:Pchar; pBackend:Pma_backend):ma_result;cdecl; external;
  function ma_get_enabled_backends(pBackends:Pma_backend; backendCap:size_t; pBackendCount:Psize_t):ma_result;cdecl; external;
  function ma_is_loopback_supported(backend:ma_backend):ma_bool32;cdecl; external;
  function ma_calculate_buffer_size_in_milliseconds_from_frames(bufferSizeInFrames:ma_uint32; sampleRate:ma_uint32):ma_uint32;cdecl; external;
  function ma_is_backend_enabled(backend:ma_backend):ma_bool32;cdecl; external;
  function ma_calculate_buffer_size_in_frames_from_milliseconds(bufferSizeInMilliseconds:ma_uint32; sampleRate:ma_uint32):ma_uint32;cdecl; external;
  procedure ma_copy_pcm_frames(dst:pointer; src:pointer; frameCount:ma_uint64; format:ma_format; channels:ma_uint32);cdecl; external;
  procedure ma_silence_pcm_frames(p:pointer; frameCount:ma_uint64; format:ma_format; channels:ma_uint32);cdecl; external;
  function ma_offset_pcm_frames_ptr(p:pointer; offsetInFrames:ma_uint64; format:ma_format; channels:ma_uint32):pointer;cdecl; external;
  function ma_offset_pcm_frames_const_ptr(p:pointer; offsetInFrames:ma_uint64; format:ma_format; channels:ma_uint32):pointer;cdecl; external;
  procedure ma_clip_samples_u8(pDst:Pma_uint8; pSrc:Pma_int16; count:ma_uint64);cdecl; external;
  procedure ma_clip_samples_s16(pDst:Pma_int16; pSrc:Pma_int32; count:ma_uint64);cdecl; external;

(* Const before type ignored *)
  procedure ma_clip_samples_s24(pDst:Pma_uint8; pSrc:Pma_int64; count:ma_uint64);cdecl; external;

(* Const before type ignored *)
  procedure ma_clip_samples_s32(pDst:Pma_int32; pSrc:Pma_int64; count:ma_uint64);cdecl; external;

(* Const before type ignored *)
  procedure ma_clip_samples_f32(pDst:Psingle; pSrc:Psingle; count:ma_uint64);cdecl; external;

(* Const before type ignored *)
  procedure ma_clip_pcm_frames(pDst:pointer; pSrc:pointer; frameCount:ma_uint64; format:ma_format; channels:ma_uint32);cdecl; external;

  {
  Helper for applying a volume factor to samples.
  
  Note that the source and destination buffers can be the same, in which case it'll perform the operation in-place.
   }
(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_u8(pSamplesOut:Pma_uint8; pSamplesIn:Pma_uint8; sampleCount:ma_uint64; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_s16(pSamplesOut:Pma_int16; pSamplesIn:Pma_int16; sampleCount:ma_uint64; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_s24(pSamplesOut:pointer; pSamplesIn:pointer; sampleCount:ma_uint64; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_s32(pSamplesOut:Pma_int32; pSamplesIn:Pma_int32; sampleCount:ma_uint64; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_f32(pSamplesOut:Psingle; pSamplesIn:Psingle; sampleCount:ma_uint64; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_u8(pSamples:Pma_uint8; sampleCount:ma_uint64; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_s16(pSamples:Pma_int16; sampleCount:ma_uint64; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_s24(pSamples:pointer; sampleCount:ma_uint64; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_s32(pSamples:Pma_int32; sampleCount:ma_uint64; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_f32(pSamples:Psingle; sampleCount:ma_uint64; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_pcm_frames_u8(pFramesOut:Pma_uint8; pFramesIn:Pma_uint8; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_pcm_frames_s16(pFramesOut:Pma_int16; pFramesIn:Pma_int16; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_pcm_frames_s24(pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_pcm_frames_s32(pFramesOut:Pma_int32; pFramesIn:Pma_int32; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_pcm_frames_f32(pFramesOut:Psingle; pFramesIn:Psingle; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_pcm_frames(pFramesOut:pointer; pFramesIn:pointer; frameCount:ma_uint64; format:ma_format; channels:ma_uint32; 
              factor:single);cdecl; external;

  procedure ma_apply_volume_factor_pcm_frames_u8(pFrames:Pma_uint8; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_pcm_frames_s16(pFrames:Pma_int16; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_pcm_frames_s24(pFrames:pointer; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_pcm_frames_s32(pFrames:Pma_int32; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_pcm_frames_f32(pFrames:Psingle; frameCount:ma_uint64; channels:ma_uint32; factor:single);cdecl; external;

  procedure ma_apply_volume_factor_pcm_frames(pFrames:pointer; frameCount:ma_uint64; format:ma_format; channels:ma_uint32; factor:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_factor_per_channel_f32(pFramesOut:Psingle; pFramesIn:Psingle; frameCount:ma_uint64; channels:ma_uint32; pChannelGains:Psingle);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_and_clip_samples_u8(pDst:Pma_uint8; pSrc:Pma_int16; count:ma_uint64; volume:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_and_clip_samples_s16(pDst:Pma_int16; pSrc:Pma_int32; count:ma_uint64; volume:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_and_clip_samples_s24(pDst:Pma_uint8; pSrc:Pma_int64; count:ma_uint64; volume:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_and_clip_samples_s32(pDst:Pma_int32; pSrc:Pma_int64; count:ma_uint64; volume:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_and_clip_samples_f32(pDst:Psingle; pSrc:Psingle; count:ma_uint64; volume:single);cdecl; external;

(* Const before type ignored *)
  procedure ma_copy_and_apply_volume_and_clip_pcm_frames(pDst:pointer; pSrc:pointer; frameCount:ma_uint64; format:ma_format; channels:ma_uint32; 
              volume:single);cdecl; external;

  {
  Helper for converting a linear factor to gain in decibels.
   }
  function ma_volume_linear_to_db(factor:single):single;cdecl; external;

  {
  Helper for converting gain in decibels to a linear factor.
   }
  function ma_volume_db_to_linear(gain:single):single;cdecl; external;

  {
  Mixes the specified number of frames in floating point format with a volume factor.
  
  This will run on an optimized path when the volume is equal to 1.
   }
(* Const before type ignored *)
  function ma_mix_pcm_frames_f32(pDst:Psingle; pSrc:Psingle; frameCount:ma_uint64; channels:ma_uint32; volume:single):ma_result;cdecl; external;
  function ma_vfs_open(pVFS:Pma_vfs; pFilePath:Pchar; openMode:ma_uint32; pFile:Pma_vfs_file):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_vfs_open_w(pVFS:Pma_vfs; pFilePath:Pwchar_t; openMode:ma_uint32; pFile:Pma_vfs_file):ma_result;cdecl; external;

  function ma_vfs_close(pVFS:Pma_vfs; vfile:ma_vfs_file):ma_result;cdecl; external;

  function ma_vfs_read(pVFS:Pma_vfs; vfile:ma_vfs_file; pDst:pointer; sizeInBytes:size_t; pBytesRead:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_vfs_write(pVFS:Pma_vfs; vfile:ma_vfs_file; pSrc:pointer; sizeInBytes:size_t; pBytesWritten:Psize_t):ma_result;cdecl; external;

  function ma_vfs_seek(pVFS:Pma_vfs; vfile:ma_vfs_file; offset:ma_int64; origin:ma_seek_origin):ma_result;cdecl; external;

  function ma_vfs_tell(pVFS:Pma_vfs; vfile:ma_vfs_file; pCursor:Pma_int64):ma_result;cdecl; external;

  function ma_vfs_info(pVFS:Pma_vfs; vfile:ma_vfs_file; pInfo:Pma_file_info):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_vfs_open_and_read_file(pVFS:Pma_vfs; pFilePath:Pchar; ppData:Ppointer; pSize:Psize_t; pAllocationCallbacks:Pma_allocation_callbacks):ma_result;cdecl; external;
  function ma_decoding_backend_config_init(preferredFormat:ma_format; seekPointCount:ma_uint32):ma_decoding_backend_config;cdecl; external;
  function ma_decoder_config_init(outputFormat:ma_format; outputChannels:ma_uint32; outputSampleRate:ma_uint32):ma_decoder_config;cdecl; external;

  function ma_decoder_config_init_default:ma_decoder_config;cdecl; external;

(* Const before type ignored *)
  function ma_decoder_init(onRead:ma_decoder_read_proc; onSeek:ma_decoder_seek_proc; pUserData:pointer; pConfig:Pma_decoder_config; pDecoder:Pma_decoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_decoder_init_memory(pData:pointer; dataSize:size_t; pConfig:Pma_decoder_config; pDecoder:Pma_decoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_decoder_init_vfs(pVFS:Pma_vfs; pFilePath:Pchar; pConfig:Pma_decoder_config; pDecoder:Pma_decoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_decoder_init_vfs_w(pVFS:Pma_vfs; pFilePath:Pwchar_t; pConfig:Pma_decoder_config; pDecoder:Pma_decoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_decoder_init_file(pFilePath:Pchar; pConfig:Pma_decoder_config; pDecoder:Pma_decoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_decoder_init_file_w(pFilePath:Pwchar_t; pConfig:Pma_decoder_config; pDecoder:Pma_decoder):ma_result;cdecl; external;

  {
  Uninitializes a decoder.
   }
  function ma_decoder_uninit(pDecoder:Pma_decoder):ma_result;cdecl; external;

  {
  Reads PCM frames from the given decoder.
  
  This is not thread safe without your own synchronization.
   }
  function ma_decoder_read_pcm_frames(pDecoder:Pma_decoder; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  {
  Seeks to a PCM frame based on it's absolute index.
  
  This is not thread safe without your own synchronization.
   }
  function ma_decoder_seek_to_pcm_frame(pDecoder:Pma_decoder; frameIndex:ma_uint64):ma_result;cdecl; external;

  {
  Retrieves the decoder's output data format.
   }
  function ma_decoder_get_data_format(pDecoder:Pma_decoder; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel; 
             channelMapCap:size_t):ma_result;cdecl; external;

  {
  Retrieves the current position of the read cursor in PCM frames.
   }
  function ma_decoder_get_cursor_in_pcm_frames(pDecoder:Pma_decoder; pCursor:Pma_uint64):ma_result;cdecl; external;

  {
  Retrieves the length of the decoder in PCM frames.
  
  Do not call this on streams of an undefined length, such as internet radio.
  
  If the length is unknown or an error occurs, 0 will be returned.
  
  This will always return 0 for Vorbis decoders. This is due to a limitation with stb_vorbis in push mode which is what miniaudio
  uses internally.
  
  For MP3's, this will decode the entire file. Do not call this in time critical scenarios.
  
  This function is not thread safe without your own synchronization.
   }
  function ma_decoder_get_length_in_pcm_frames(pDecoder:Pma_decoder; pLength:Pma_uint64):ma_result;cdecl; external;

  {
  Retrieves the number of frames that can be read before reaching the end.
  
  This calls `ma_decoder_get_length_in_pcm_frames()` so you need to be aware of the rules for that function, in
  particular ensuring you do not call it on streams of an undefined length, such as internet radio.
  
  If the total length of the decoder cannot be retrieved, such as with Vorbis decoders, `MA_NOT_IMPLEMENTED` will be
  returned.
   }
  function ma_decoder_get_available_frames(pDecoder:Pma_decoder; pAvailableFrames:Pma_uint64):ma_result;cdecl; external;

  {
  Helper for opening and decoding a file into a heap allocated block of memory. Free the returned pointer with ma_free(). On input,
  pConfig should be set to what you want. On output it will be set to what you got.
   }
(* Const before type ignored *)
  function ma_decode_from_vfs(pVFS:Pma_vfs; pFilePath:Pchar; pConfig:Pma_decoder_config; pFrameCountOut:Pma_uint64; ppPCMFramesOut:Ppointer):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_decode_file(pFilePath:Pchar; pConfig:Pma_decoder_config; pFrameCountOut:Pma_uint64; ppPCMFramesOut:Ppointer):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_decode_memory(pData:pointer; dataSize:size_t; pConfig:Pma_decoder_config; pFrameCountOut:Pma_uint64; ppPCMFramesOut:Ppointer):ma_result;cdecl; external;

  function ma_encoder_config_init(encodingFormat:ma_encoding_format; format:ma_format; channels:ma_uint32; sampleRate:ma_uint32):ma_encoder_config;cdecl; external;
  function ma_encoder_init(onWrite:ma_encoder_write_proc; onSeek:ma_encoder_seek_proc; pUserData:pointer; pConfig:Pma_encoder_config; pEncoder:Pma_encoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_encoder_init_vfs(pVFS:Pma_vfs; pFilePath:Pchar; pConfig:Pma_encoder_config; pEncoder:Pma_encoder):ma_result;cdecl; external;
  function ma_waveform_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; _type:ma_waveform_type; amplitude:double; 
             frequency:double):ma_waveform_config;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_encoder_init_vfs_w(pVFS:Pma_vfs; pFilePath:Pwchar_t; pConfig:Pma_encoder_config; pEncoder:Pma_encoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_encoder_init_file(pFilePath:Pchar; pConfig:Pma_encoder_config; pEncoder:Pma_encoder):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_encoder_init_file_w(pFilePath:Pwchar_t; pConfig:Pma_encoder_config; pEncoder:Pma_encoder):ma_result;cdecl; external;

  procedure ma_encoder_uninit(pEncoder:Pma_encoder);cdecl; external;

(* Const before type ignored *)
  function ma_encoder_write_pcm_frames(pEncoder:Pma_encoder; pFramesIn:pointer; frameCount:ma_uint64; pFramesWritten:Pma_uint64):ma_result;cdecl; external;
  function ma_waveform_init(pConfig:Pma_waveform_config; pWaveform:Pma_waveform):ma_result;cdecl; external;

  procedure ma_waveform_uninit(pWaveform:Pma_waveform);cdecl; external;

  function ma_waveform_read_pcm_frames(pWaveform:Pma_waveform; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  function ma_waveform_seek_to_pcm_frame(pWaveform:Pma_waveform; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_waveform_set_amplitude(pWaveform:Pma_waveform; amplitude:double):ma_result;cdecl; external;

  function ma_waveform_set_frequency(pWaveform:Pma_waveform; frequency:double):ma_result;cdecl; external;

  function ma_waveform_set_type(pWaveform:Pma_waveform; _type:ma_waveform_type):ma_result;cdecl; external;

  function ma_waveform_set_sample_rate(pWaveform:Pma_waveform; sampleRate:ma_uint32):ma_result;cdecl; external;
  function ma_pulsewave_config_init(format:ma_format; channels:ma_uint32; sampleRate:ma_uint32; dutyCycle:double; amplitude:double; 
             frequency:double):ma_pulsewave_config;cdecl; external;

  function ma_pulsewave_init(pConfig:Pma_pulsewave_config; pWaveform:Pma_pulsewave):ma_result;cdecl; external;

  procedure ma_pulsewave_uninit(pWaveform:Pma_pulsewave);cdecl; external;

  function ma_pulsewave_read_pcm_frames(pWaveform:Pma_pulsewave; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  function ma_pulsewave_seek_to_pcm_frame(pWaveform:Pma_pulsewave; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_pulsewave_set_amplitude(pWaveform:Pma_pulsewave; amplitude:double):ma_result;cdecl; external;

  function ma_pulsewave_set_frequency(pWaveform:Pma_pulsewave; frequency:double):ma_result;cdecl; external;

  function ma_pulsewave_set_sample_rate(pWaveform:Pma_pulsewave; sampleRate:ma_uint32):ma_result;cdecl; external;

  function ma_pulsewave_set_duty_cycle(pWaveform:Pma_pulsewave; dutyCycle:double):ma_result;cdecl; external;

  function ma_noise_config_init(format:ma_format; channels:ma_uint32; _type:ma_noise_type; seed:ma_int32; amplitude:double):ma_noise_config;cdecl; external;

  function ma_noise_get_heap_size(pConfig:Pma_noise_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_noise_init_preallocated(pConfig:Pma_noise_config; pHeap:pointer; pNoise:Pma_noise):ma_result;cdecl; external;
  function ma_resource_manager_pipeline_notifications_init:ma_resource_manager_pipeline_notifications;cdecl; external;


(* Const before type ignored *)
(* Const before type ignored *)
  function ma_noise_init(pConfig:Pma_noise_config; pAllocationCallbacks:Pma_allocation_callbacks; pNoise:Pma_noise):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_noise_uninit(pNoise:Pma_noise; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_noise_read_pcm_frames(pNoise:Pma_noise; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  function ma_noise_set_amplitude(pNoise:Pma_noise; amplitude:double):ma_result;cdecl; external;

  function ma_noise_set_seed(pNoise:Pma_noise; seed:ma_int32):ma_result;cdecl; external;

  function ma_noise_set_type(pNoise:Pma_noise; _type:ma_noise_type):ma_result;cdecl; external;

  { END BACKWARDS COMPATIBILITY  }
  { Maximum job thread count will be restricted to this, but this may be removed later and replaced with a heap allocation thereby removing any limitation.  }
  function ma_resource_manager_data_source_config_init:ma_resource_manager_data_source_config;cdecl; external;

{$endif}
  { MA_NO_ENGINE  }
  { END SECTION: miniaudio_engine.h  }
{ C++ end of extern C conditionnal removed }
{$endif}

{$ifndef MA_NO_RESOURCE_MANAGER}
  { miniaudio_h  }
  function ma_resource_manager_config_init:ma_resource_manager_config;cdecl; external;
  function ma_resource_manager_init(pConfig:Pma_resource_manager_config; pResourceManager:Pma_resource_manager):ma_result;cdecl; external;

  procedure ma_resource_manager_uninit(pResourceManager:Pma_resource_manager);cdecl; external;

  function ma_resource_manager_get_log(pResourceManager:Pma_resource_manager):Pma_log;cdecl; external;

  { Registration.  }
(* Const before type ignored *)
  function ma_resource_manager_register_file(pResourceManager:Pma_resource_manager; pFilePath:Pchar; flags:ma_uint32):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_register_file_w(pResourceManager:Pma_resource_manager; pFilePath:Pwchar_t; flags:ma_uint32):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_register_decoded_data(pResourceManager:Pma_resource_manager; pName:Pchar; pData:pointer; frameCount:ma_uint64; format:ma_format; 
             channels:ma_uint32; sampleRate:ma_uint32):ma_result;cdecl; external;

  { Does not copy. Increments the reference count if already exists and returns MA_SUCCESS.  }
(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_register_decoded_data_w(pResourceManager:Pma_resource_manager; pName:Pwchar_t; pData:pointer; frameCount:ma_uint64; format:ma_format; 
             channels:ma_uint32; sampleRate:ma_uint32):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_register_encoded_data(pResourceManager:Pma_resource_manager; pName:Pchar; pData:pointer; sizeInBytes:size_t):ma_result;cdecl; external;

  { Does not copy. Increments the reference count if already exists and returns MA_SUCCESS.  }
(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_register_encoded_data_w(pResourceManager:Pma_resource_manager; pName:Pwchar_t; pData:pointer; sizeInBytes:size_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_unregister_file(pResourceManager:Pma_resource_manager; pFilePath:Pchar):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_unregister_file_w(pResourceManager:Pma_resource_manager; pFilePath:Pwchar_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_unregister_data(pResourceManager:Pma_resource_manager; pName:Pchar):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_unregister_data_w(pResourceManager:Pma_resource_manager; pName:Pwchar_t):ma_result;cdecl; external;

  { Data Buffers.  }
(* Const before type ignored *)
  function ma_resource_manager_data_buffer_init_ex(pResourceManager:Pma_resource_manager; pConfig:Pma_resource_manager_data_source_config; pDataBuffer:Pma_resource_manager_data_buffer):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_data_buffer_init(pResourceManager:Pma_resource_manager; pFilePath:Pchar; flags:ma_uint32; pNotifications:Pma_resource_manager_pipeline_notifications; pDataBuffer:Pma_resource_manager_data_buffer):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_data_buffer_init_w(pResourceManager:Pma_resource_manager; pFilePath:Pwchar_t; flags:ma_uint32; pNotifications:Pma_resource_manager_pipeline_notifications; pDataBuffer:Pma_resource_manager_data_buffer):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_buffer_init_copy(pResourceManager:Pma_resource_manager; pExistingDataBuffer:Pma_resource_manager_data_buffer; pDataBuffer:Pma_resource_manager_data_buffer):ma_result;cdecl; external;

  function ma_resource_manager_data_buffer_uninit(pDataBuffer:Pma_resource_manager_data_buffer):ma_result;cdecl; external;

  function ma_resource_manager_data_buffer_read_pcm_frames(pDataBuffer:Pma_resource_manager_data_buffer; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_buffer_seek_to_pcm_frame(pDataBuffer:Pma_resource_manager_data_buffer; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_buffer_get_data_format(pDataBuffer:Pma_resource_manager_data_buffer; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel; 
             channelMapCap:size_t):ma_result;cdecl; external;

  function ma_resource_manager_data_buffer_get_cursor_in_pcm_frames(pDataBuffer:Pma_resource_manager_data_buffer; pCursor:Pma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_buffer_get_length_in_pcm_frames(pDataBuffer:Pma_resource_manager_data_buffer; pLength:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_buffer_result(pDataBuffer:Pma_resource_manager_data_buffer):ma_result;cdecl; external;

  function ma_resource_manager_data_buffer_set_looping(pDataBuffer:Pma_resource_manager_data_buffer; isLooping:ma_bool32):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_buffer_is_looping(pDataBuffer:Pma_resource_manager_data_buffer):ma_bool32;cdecl; external;

  function ma_resource_manager_data_buffer_get_available_frames(pDataBuffer:Pma_resource_manager_data_buffer; pAvailableFrames:Pma_uint64):ma_result;cdecl; external;

  { Data Streams.  }
(* Const before type ignored *)
  function ma_resource_manager_data_stream_init_ex(pResourceManager:Pma_resource_manager; pConfig:Pma_resource_manager_data_source_config; pDataStream:Pma_resource_manager_data_stream):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_data_stream_init(pResourceManager:Pma_resource_manager; pFilePath:Pchar; flags:ma_uint32; pNotifications:Pma_resource_manager_pipeline_notifications; pDataStream:Pma_resource_manager_data_stream):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_data_stream_init_w(pResourceManager:Pma_resource_manager; pFilePath:Pwchar_t; flags:ma_uint32; pNotifications:Pma_resource_manager_pipeline_notifications; pDataStream:Pma_resource_manager_data_stream):ma_result;cdecl; external;

  function ma_resource_manager_data_stream_uninit(pDataStream:Pma_resource_manager_data_stream):ma_result;cdecl; external;

  function ma_resource_manager_data_stream_read_pcm_frames(pDataStream:Pma_resource_manager_data_stream; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_stream_seek_to_pcm_frame(pDataStream:Pma_resource_manager_data_stream; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_stream_get_data_format(pDataStream:Pma_resource_manager_data_stream; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel; 
             channelMapCap:size_t):ma_result;cdecl; external;

  function ma_resource_manager_data_stream_get_cursor_in_pcm_frames(pDataStream:Pma_resource_manager_data_stream; pCursor:Pma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_stream_get_length_in_pcm_frames(pDataStream:Pma_resource_manager_data_stream; pLength:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_stream_result(pDataStream:Pma_resource_manager_data_stream):ma_result;cdecl; external;

  function ma_resource_manager_data_stream_set_looping(pDataStream:Pma_resource_manager_data_stream; isLooping:ma_bool32):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_stream_is_looping(pDataStream:Pma_resource_manager_data_stream):ma_bool32;cdecl; external;

  function ma_resource_manager_data_stream_get_available_frames(pDataStream:Pma_resource_manager_data_stream; pAvailableFrames:Pma_uint64):ma_result;cdecl; external;

  { Data Sources.  }
(* Const before type ignored *)
  function ma_resource_manager_data_source_init_ex(pResourceManager:Pma_resource_manager; pConfig:Pma_resource_manager_data_source_config; pDataSource:Pma_resource_manager_data_source):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_data_source_init(pResourceManager:Pma_resource_manager; pName:Pchar; flags:ma_uint32; pNotifications:Pma_resource_manager_pipeline_notifications; pDataSource:Pma_resource_manager_data_source):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_resource_manager_data_source_init_w(pResourceManager:Pma_resource_manager; pName:Pwchar_t; flags:ma_uint32; pNotifications:Pma_resource_manager_pipeline_notifications; pDataSource:Pma_resource_manager_data_source):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_source_init_copy(pResourceManager:Pma_resource_manager; pExistingDataSource:Pma_resource_manager_data_source; pDataSource:Pma_resource_manager_data_source):ma_result;cdecl; external;

  function ma_resource_manager_data_source_uninit(pDataSource:Pma_resource_manager_data_source):ma_result;cdecl; external;

  function ma_resource_manager_data_source_read_pcm_frames(pDataSource:Pma_resource_manager_data_source; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_source_seek_to_pcm_frame(pDataSource:Pma_resource_manager_data_source; frameIndex:ma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_source_get_data_format(pDataSource:Pma_resource_manager_data_source; pFormat:Pma_format; pChannels:Pma_uint32; pSampleRate:Pma_uint32; pChannelMap:Pma_channel; 
             channelMapCap:size_t):ma_result;cdecl; external;

  function ma_resource_manager_data_source_get_cursor_in_pcm_frames(pDataSource:Pma_resource_manager_data_source; pCursor:Pma_uint64):ma_result;cdecl; external;

  function ma_resource_manager_data_source_get_length_in_pcm_frames(pDataSource:Pma_resource_manager_data_source; pLength:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_source_result(pDataSource:Pma_resource_manager_data_source):ma_result;cdecl; external;

  function ma_resource_manager_data_source_set_looping(pDataSource:Pma_resource_manager_data_source; isLooping:ma_bool32):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_resource_manager_data_source_is_looping(pDataSource:Pma_resource_manager_data_source):ma_bool32;cdecl; external;

  function ma_resource_manager_data_source_get_available_frames(pDataSource:Pma_resource_manager_data_source; pAvailableFrames:Pma_uint64):ma_result;cdecl; external;

  { Job management.  }
(* Const before type ignored *)
  function ma_resource_manager_post_job(pResourceManager:Pma_resource_manager; pJob:Pma_job):ma_result;cdecl; external;

  function ma_resource_manager_post_job_quit(pResourceManager:Pma_resource_manager):ma_result;cdecl; external;

  { Helper for posting a quit job.  }
  function ma_resource_manager_next_job(pResourceManager:Pma_resource_manager; pJob:Pma_job):ma_result;cdecl; external;

  function ma_resource_manager_process_job(pResourceManager:Pma_resource_manager; pJob:Pma_job):ma_result;cdecl; external;

  { DEPRECATED. Use ma_job_process(). Will be removed in version 0.12.  }
  function ma_resource_manager_process_next_job(pResourceManager:Pma_resource_manager):ma_result;cdecl; external;

{$endif}


  { Use this when the bus count is determined by the node instance rather than the vtable.  }

  const
    MA_NODE_BUS_COUNT_UNKNOWN = 255;    

  function ma_node_config_init:ma_node_config;cdecl; external;
  function ma_node_get_heap_size(pNodeGraph:Pma_node_graph; pConfig:Pma_node_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_node_init_preallocated(pNodeGraph:Pma_node_graph; pConfig:Pma_node_config; pHeap:pointer; pNode:Pma_node):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_node_uninit(pNode:Pma_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

(* Const before type ignored *)
  function ma_node_get_node_graph(pNode:Pma_node):Pma_node_graph;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_input_bus_count(pNode:Pma_node):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_output_bus_count(pNode:Pma_node):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_input_channels(pNode:Pma_node; inputBusIndex:ma_uint32):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_output_channels(pNode:Pma_node; outputBusIndex:ma_uint32):ma_uint32;cdecl; external;

  function ma_node_attach_output_bus(pNode:Pma_node; outputBusIndex:ma_uint32; pOtherNode:Pma_node; otherNodeInputBusIndex:ma_uint32):ma_result;cdecl; external;

  function ma_node_detach_output_bus(pNode:Pma_node; outputBusIndex:ma_uint32):ma_result;cdecl; external;

  function ma_node_detach_all_output_buses(pNode:Pma_node):ma_result;cdecl; external;

  function ma_node_set_output_bus_volume(pNode:Pma_node; outputBusIndex:ma_uint32; volume:single):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_output_bus_volume(pNode:Pma_node; outputBusIndex:ma_uint32):single;cdecl; external;

  function ma_node_set_state(pNode:Pma_node; state:ma_node_state):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_state(pNode:Pma_node):ma_node_state;cdecl; external;

  function ma_node_set_state_time(pNode:Pma_node; state:ma_node_state; globalTime:ma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_state_time(pNode:Pma_node; state:ma_node_state):ma_uint64;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_state_by_time(pNode:Pma_node; globalTime:ma_uint64):ma_node_state;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_state_by_time_range(pNode:Pma_node; globalTimeBeg:ma_uint64; globalTimeEnd:ma_uint64):ma_node_state;cdecl; external;

(* Const before type ignored *)
  function ma_node_get_time(pNode:Pma_node):ma_uint64;cdecl; external;

  function ma_node_set_time(pNode:Pma_node; localTime:ma_uint64):ma_result;cdecl; external;

  function ma_node_graph_config_init(channels:ma_uint32):ma_node_graph_config;cdecl; external;
  function ma_node_graph_init(pConfig:Pma_node_graph_config; pAllocationCallbacks:Pma_allocation_callbacks; pNodeGraph:Pma_node_graph):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_node_graph_uninit(pNodeGraph:Pma_node_graph; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_node_graph_get_endpoint(pNodeGraph:Pma_node_graph):Pma_node;cdecl; external;

  function ma_node_graph_read_pcm_frames(pNodeGraph:Pma_node_graph; pFramesOut:pointer; frameCount:ma_uint64; pFramesRead:Pma_uint64):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_node_graph_get_channels(pNodeGraph:Pma_node_graph):ma_uint32;cdecl; external;

(* Const before type ignored *)
  function ma_node_graph_get_time(pNodeGraph:Pma_node_graph):ma_uint64;cdecl; external;

  function ma_node_graph_set_time(pNodeGraph:Pma_node_graph; globalTime:ma_uint64):ma_result;cdecl; external;

  function ma_data_source_node_config_init(pDataSource:Pma_data_source):ma_data_source_node_config;cdecl; external;
  function ma_data_source_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_data_source_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pDataSourceNode:Pma_data_source_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_data_source_node_uninit(pDataSourceNode:Pma_data_source_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_data_source_node_set_looping(pDataSourceNode:Pma_data_source_node; isLooping:ma_bool32):ma_result;cdecl; external;

  function ma_data_source_node_is_looping(pDataSourceNode:Pma_data_source_node):ma_bool32;cdecl; external;

  function ma_splitter_node_config_init(channels:ma_uint32):ma_splitter_node_config;cdecl; external;
  function ma_splitter_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_splitter_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pSplitterNode:Pma_splitter_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_splitter_node_uninit(pSplitterNode:Pma_splitter_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_biquad_node_config_init(channels:ma_uint32; b0:single; b1:single; b2:single; a0:single; 
             a1:single; a2:single):ma_biquad_node_config;cdecl; external;

  function ma_biquad_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_biquad_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_biquad_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_biquad_node_reinit(pConfig:Pma_biquad_config; pNode:Pma_biquad_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_biquad_node_uninit(pNode:Pma_biquad_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;


  function ma_lpf_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; order:ma_uint32):ma_lpf_node_config;cdecl; external;



  function ma_lpf_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_lpf_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_lpf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_lpf_node_reinit(pConfig:Pma_lpf_config; pNode:Pma_lpf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_lpf_node_uninit(pNode:Pma_lpf_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  
  function ma_hpf_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; order:ma_uint32):ma_hpf_node_config;cdecl; external;

  function ma_hpf_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_hpf_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_hpf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hpf_node_reinit(pConfig:Pma_hpf_config; pNode:Pma_hpf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_hpf_node_uninit(pNode:Pma_hpf_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;
  function ma_bpf_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; cutoffFrequency:double; order:ma_uint32):ma_bpf_node_config;cdecl; external;

  function ma_bpf_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_bpf_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_bpf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_bpf_node_reinit(pConfig:Pma_bpf_config; pNode:Pma_bpf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_bpf_node_uninit(pNode:Pma_bpf_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;
  function ma_notch_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; q:double; frequency:double):ma_notch_node_config;cdecl; external;



  function ma_notch_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_notch_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_notch_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_notch_node_reinit(pConfig:Pma_notch_config; pNode:Pma_notch_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_notch_node_uninit(pNode:Pma_notch_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_peak_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; gainDB:double; q:double; frequency:double):ma_peak_node_config;cdecl; external;


  function ma_peak_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_peak_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_peak_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_peak_node_reinit(pConfig:Pma_peak_config; pNode:Pma_peak_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_peak_node_uninit(pNode:Pma_peak_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;


  function ma_loshelf_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; gainDB:double; q:double; frequency:double):ma_loshelf_node_config;cdecl; external;


  function ma_loshelf_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_loshelf_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_loshelf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_loshelf_node_reinit(pConfig:Pma_loshelf_config; pNode:Pma_loshelf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_loshelf_node_uninit(pNode:Pma_loshelf_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;


  function ma_hishelf_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; gainDB:double; q:double; frequency:double):ma_hishelf_node_config;cdecl; external;



  function ma_hishelf_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_hishelf_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pNode:Pma_hishelf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_hishelf_node_reinit(pConfig:Pma_hishelf_config; pNode:Pma_hishelf_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_hishelf_node_uninit(pNode:Pma_hishelf_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;


  function ma_delay_node_config_init(channels:ma_uint32; sampleRate:ma_uint32; delayInFrames:ma_uint32; decay:single):ma_delay_node_config;cdecl; external;

  function ma_delay_node_init(pNodeGraph:Pma_node_graph; pConfig:Pma_delay_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pDelayNode:Pma_delay_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_delay_node_uninit(pDelayNode:Pma_delay_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  procedure ma_delay_node_set_wet(pDelayNode:Pma_delay_node; value:single);cdecl; external;

(* Const before type ignored *)
  function ma_delay_node_get_wet(pDelayNode:Pma_delay_node):single;cdecl; external;

  procedure ma_delay_node_set_dry(pDelayNode:Pma_delay_node; value:single);cdecl; external;

(* Const before type ignored *)
  function ma_delay_node_get_dry(pDelayNode:Pma_delay_node):single;cdecl; external;

  procedure ma_delay_node_set_decay(pDelayNode:Pma_delay_node; value:single);cdecl; external;

(* Const before type ignored *)
  function ma_delay_node_get_decay(pDelayNode:Pma_delay_node):single;cdecl; external;
  { was #define dname def_expr }
  function MA_LISTENER_INDEX_CLOSEST : ma_uint8;cdecl; external;    
  function ma_engine_node_config_init(pEngine:Pma_engine; _type:ma_engine_node_type; flags:ma_uint32):ma_engine_node_config;cdecl; external;
  function ma_engine_node_get_heap_size(pConfig:Pma_engine_node_config; pHeapSizeInBytes:Psize_t):ma_result;cdecl; external;

(* Const before type ignored *)
  function ma_engine_node_init_preallocated(pConfig:Pma_engine_node_config; pHeap:pointer; pEngineNode:Pma_engine_node):ma_result;cdecl; external;

(* Const before type ignored *)
(* Const before type ignored *)
  function ma_engine_node_init(pConfig:Pma_engine_node_config; pAllocationCallbacks:Pma_allocation_callbacks; pEngineNode:Pma_engine_node):ma_result;cdecl; external;

(* Const before type ignored *)
  procedure ma_engine_node_uninit(pEngineNode:Pma_engine_node; pAllocationCallbacks:Pma_allocation_callbacks);cdecl; external;

  function ma_sound_config_init:ma_sound_config;cdecl; external;

  { Deprecated. Will be removed in version 0.12. Use ma_sound_config_2() instead.  }
  function ma_sound_config_init_2(pEngine:Pma_engine):ma_sound_config;cdecl; external;
  function ma_sound_group_config_init:ma_sound_group_config;cdecl; external;

  { Deprecated. Will be removed in version 0.12. Use ma_sound_config_2() instead.  }
  function ma_sound_group_config_init_2(pEngine:Pma_engine):ma_sound_group_config;cdecl; external;

  { Will be renamed to ma_sound_config_init() in version 0.12.  }
  function ma_engine_config_init:ma_engine_config;cdecl; external;
  procedure ma_version(pMajor:Pma_uint32; pMinor:Pma_uint32; pRevision:Pma_uint32);cdecl; external;
  function ma_context_is_loopback_supported(pContext:Pma_context):ma_bool32;cdecl; external;
  function ma_context_get_log(pContext:Pma_context):Pma_log;cdecl; external;
  function ma_context_config_init:ma_context_config;cdecl; external;
  function ma_version_string:Pchar;cdecl; external;
  function ma_paged_audio_buffer_config_init(pData:Pma_paged_audio_buffer_data):ma_paged_audio_buffer_config;cdecl; external;
  function ma_default_vfs_init(pVFS:Pma_default_vfs; pAllocationCallbacks:Pma_allocation_callbacks):ma_result;cdecl; external;



implementation

{$ifdef windows}
{FIX FOR windows}
{see https://forum.lazarus.freepascal.org/index.php?topic=60332.0}
{ https://github.com/skeeto/w64devkit/blob/068236d/src/libchkstk.S }
procedure __chkstk_ms; assembler; nostackframe; public Name '___chkstk_ms';
{$ifdef cpu64}
  label zero, one;
  asm
  	push %rax
	  push %rcx
	  neg  %rax		// rax = frame low address
	  add  %rsp, %rax		// "
	  mov  %gs:(0x10), %rcx	// rcx = stack low address
	  jmp  one
zero:  	sub  $0x1000, %rcx	// extend stack into guard page
	  mov  %eax, (%rcx)	// commit page (two instruction bytes)
one:  	cmp  %rax, %rcx
	  ja   zero
	  pop  %rcx
	  pop  %rax
	  ret
  end;
{$endif}
{$ifdef cpu32}
  label zero, one;
  asm
    push %ecx
    neg  %eax               // 2.
    lea  8(%esp,%eax), %eax // 2.
    mov  %fs:(0x08), %ecx   // 3.
    jmp  one                 // 4.
    zero:sub  $0x1000, %ecx      // 5.
    test %eax, (%ecx)       // 6. page fault (very slow!)
    one:cmp  %eax, %ecx         // 7.
    ja   zero                 // 7.
    pop  %ecx               // 8.
    xchg %eax, %esp         // ?. allocate frame
    jmp  *(%eax)            // 8. return
  end;
{$endif}
{$endif}
{{$ifdef cpu32}
{see https://github.com/synopse/mORMot/blob/master/SynSQLite3Static.pas }
function moddi3(num, den: int64): int64; cdecl; {$ifdef linux}public alias: '__moddi3';{$endif}{$ifdef window}public alias: '___moddi3';{$endif}
begin
  result := num mod den;
end;
function umoddi3(num, den: uint64): uint64; cdecl; {$ifdef linux}public alias: '__umoddi3';{$endif}{$ifdef window}public alias: '__umoddi3';{$endif}
begin
  result := num mod den;
end;
function divdi3(num, den: int64): int64; cdecl; {$ifdef linux}public alias: '__divdi3';{$endif}{$ifdef linux}public alias: '___divdi3';{$endif}
begin
  result := num div den;
end;
function udivdi3(num, den: uint64): uint64; cdecl; {$ifdef linux}public alias: '__udivdi3';{$endif}{$ifdef window}public alias: '___udivdi3';{$endif}
begin
  result := num div den;
end;
{$endif}}
end.
