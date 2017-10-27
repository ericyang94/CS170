% To use this, you must first install the 'sox' audio package
% This installs command-line audio functions:  play, rec, sox
% Octave uses these to support the wavwrite() and wavread() functions.

% By default, the Octave 'playaudio()' function invokes the 'paplay' command-line function.
% This function implements the Matlab sound() function to use the sox 'play' function.
% It isn't pretty but seems to work; it is based on the function by 'Timmmm' at:
%   http://stackoverflow.com/questions/1478071/how-do-i-play-a-sound-in-octave

function sound(wav, samplerate)
  % Play a single-channel wave at a certain sample rate (defaults to 44100 Hz).
  % Input can be integer, in which case it is assumed to be signed 16-bit, or
  % float, in which case it is in the range -1:1.

  if (nargin < 1 || nargin > 2)
    print_usage();
  endif

  if (nargin < 2)
    samplerate = 44100;
  end

  if (!isvector(wav))
    error("sound: X must be a vector");
  endif

  % Write it as a 16-bit signed, little endian (though the amaaazing docs don't say the endianness)

  % If it is integers we assume it is 16 bit signed. Otherwise we assume in the range -1:1
  if (isfloat(wav))
    X = min(max(wav(:), -1), 1) * 32767; % Why matlab & octave do not have a clip() function... I do not know.
  else
    X = min(max(wav(:), -32767), 32767) + 32767;
  endif
  unwind_protect
    file = sprintf('%s.raw', tmpnam());  % temporary filename
    fid = fopen (file, 'wb');
    fwrite (fid, X, 'int16');
    fclose (fid);
    system(sprintf('play --encoding signed-integer --bits 16 --endian little --channels=1 --rate=%d "%s"', samplerate, file))
  unwind_protect_cleanup
    unlink (file);
  end_unwind_protect

endfunction

%% Usage summary: play   [gopts] [[fopts] infile]... [fopts] [effect [effopt]]...
%% 
%% SPECIAL FILENAMES (infile, outfile):
%% -                        Pipe/redirect input/output (stdin/stdout); may need -t
%% -d, --default-device     Use the default audio device (where available)
%% -n, --null               Use the `null' file handler; e.g. with synth effect
%% -p, --sox-pipe           Alias for `-t sox -'
%% 
%% SPECIAL FILENAMES (infile only):
%% "|program [options] ..." Pipe input from external program (where supported)
%% http://server/file       Use the given URL as input file (where supported)
%% 
%% GLOBAL OPTIONS (gopts) (can be specified at any point before the first effect):
%% --buffer BYTES           Set the size of all processing buffers (default 8192)
%% --clobber                Don't prompt to overwrite output file (default)
%% --combine concatenate    Concatenate all input files (default for sox, rec)
%% --combine sequence       Sequence all input files (default for play)
%% -D, --no-dither          Don't dither automatically
%% --dft-min NUM            Minimum size (log2) for DFT processing (default 10)
%% --effects-file FILENAME  File containing effects and options
%% -G, --guard              Use temporary files to guard against clipping
%% -h, --help               Display version number and usage information
%% --help-effect NAME       Show usage of effect NAME, or NAME=all for all
%% --help-format NAME       Show info on format NAME, or NAME=all for all
%% --i, --info              Behave as soxi(1)
%% --input-buffer BYTES     Override the input buffer size (default: as --buffer)
%% --no-clobber             Prompt to overwrite output file
%% -m, --combine mix        Mix multiple input files (instead of concatenating)
%% --combine mix-power      Mix to equal power (instead of concatenating)
%% -M, --combine merge      Merge multiple input files (instead of concatenating)
%% --magic                  Use `magic' file-type detection
%% --norm                   Guard (see --guard) & normalise
%% --play-rate-arg ARG      Default `rate' argument for auto-resample with `play'
%% --plot gnuplot|octave    Generate script to plot response of filter effect
%% -q, --no-show-progress   Run in quiet mode; opposite of -S
%% --replay-gain track|album|off  Default: off (sox, rec), track (play)
%% -R                       Use default random numbers (same on each run of SoX)
%% -S, --show-progress      Display progress while processing audio data
%% --single-threaded        Disable parallel effects channels processing
%% --temp DIRECTORY         Specify the directory to use for temporary files
%% -T, --combine multiply   Multiply samples of corresponding channels from all
%%                          input files (instead of concatenating)
%% --version                Display version number of SoX and exit
%% -V[LEVEL]                Increment or set verbosity level (default 2); levels:
%%                            1: failure messages
%%                            2: warnings
%%                            3: details of processing
%%                            4-6: increasing levels of debug messages
%% FORMAT OPTIONS (fopts):
%% Input file format options need only be supplied for files that are headerless.
%% Output files will have the same format as the input file where possible and not
%% overridden by any of various means including providing output format options.
%% 
%% -v|--volume FACTOR       Input file volume adjustment factor (real number)
%% --ignore-length          Ignore input file length given in header; read to EOF
%% -t|--type FILETYPE       File type of audio
%% -e|--encoding ENCODING   Set encoding (ENCODING may be one of signed-integer,
%%                          unsigned-integer, floating-point, mu-law, a-law,
%%                          ima-adpcm, ms-adpcm, gsm-full-rate)
%% -b|--bits BITS           Encoded sample size in bits
%% -N|--reverse-nibbles     Encoded nibble-order
%% -X|--reverse-bits        Encoded bit-order
%% --endian little|big|swap Encoded byte-order; swap means opposite to default
%% -L/-B/-x                 Short options for the above
%% -c|--channels CHANNELS   Number of channels of audio data; e.g. 2 = stereo
%% -r|--rate RATE           Sample rate of audio
%% -C|--compression FACTOR  Compression factor for output format
%% --add-comment TEXT       Append output file comment
%% --comment TEXT           Specify comment text for the output file
%% --comment-file FILENAME  File containing comment text for the output file
%% --no-glob                Don't `glob' wildcard match the following filename
%% 
%% AUDIO FILE FORMATS: 8svx aif aifc aiff aiffc al amb amr-nb amr-wb anb au avr awb caf cdda cdr cvs cvsd cvu dat dvms f32 f4 f64 f8 fap flac fssd gsm gsrt hcom htk ima ircam la lpc lpc10 lu mat mat4 mat5 maud mp2 mp3 nist ogg opus paf prc pvf raw s1 s16 s2 s24 s3 s32 s4 s8 sb sd2 sds sf sl sln smp snd sndfile sndr sndt sou sox sph sw txw u1 u16 u2 u24 u3 u32 u4 u8 ub ul uw vms voc vorbis vox w64 wav wavpcm wv wve xa xi
%% PLAYLIST FORMATS: m3u pls
%% AUDIO DEVICE DRIVERS: coreaudio
%% 
%% EFFECTS: allpass band bandpass bandreject bass bend biquad chorus channels compand contrast dcshift deemph delay dither divide+ downsample earwax echo echos equalizer fade fir firfit+ flanger gain highpass hilbert input# loudness lowpass mcompand noiseprof noisered norm oops output# overdrive pad phaser pitch rate remix repeat reverb reverse riaa silence sinc spectrogram speed splice stat stats stretch swap synth tempo treble tremolo trim upsample vad vol
%%   * Deprecated effect    + Experimental effect    % LibSoX-only effect
%% EFFECT OPTIONS (effopts): effect dependent; see --help-effect
