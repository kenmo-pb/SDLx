;%=========================================================================================%
;% Note: This is the TEMPLATE FILE which is used to generate the complete 'SDL3_mixer.pbi' %
;%=========================================================================================%
; +----------------+
; | SDL3_mixer.pbi |
; +----------------+
; | 2026-03-10 : Creation (PureBasic 6.21)

;% MODIFY_DISCLAIMER
;
;% GEN_TIMESTAMP

; SDL_mixer Wiki: https://wiki.libsdl.org/SDL3_mixer/FrontPage
; Complete API:   https://wiki.libsdl.org/SDL3_mixer/CategorySDLMixer
; C Include:      https://github.com/libsdl-org/SDL_mixer/blob/main/include/SDL3_mixer/SDL_mixer.h


CompilerIf (Not Defined(__SDLx_mixer_Included, #PB_Constant))
#__SDLx_mixer_Included = #True

CompilerIf (#PB_Compiler_Version < 510)
  CompilerError #PB_Compiler_Filename + " requires PureBasic 5.10 or newer!"
CompilerEndIf

CompilerIf (#PB_Compiler_IsMainFile)
  EnableExplicit
CompilerEndIf

;-
;- SDL3 Include

CompilerIf (Not Defined(__SDLx_Included, #PB_Constant))
;% DELETESTART
CompilerIf (#True)
  XIncludeFile "../SDL3.pbi"
CompilerElse
;% DELETEEND
  XIncludeFile "SDL3.pbi"
;% DELETESTART
CompilerEndIf
;% DELETEEND
CompilerEndIf


;-
;- Build Switches

CompilerIf (Not Defined(SDLx_mixer_DebugErrors, #PB_Constant))
  #SDLx_mixer_DebugErrors = #SDLx_DebugErrors
CompilerEndIf

CompilerIf (#PB_Compiler_Debugger)
  #__SDLx_mixer_DebugErrors = #SDLx_mixer_DebugErrors
CompilerElse
  #__SDLx_mixer_DebugErrors = #False
CompilerEndIf
CompilerIf (#__SDLx_mixer_DebugErrors)
  Macro __SDLx_mixer_Debug(_Message)
    Debug _Message
  EndMacro
CompilerElse
  Macro __SDLx_mixer_Debug(_Message)
    ;
  EndMacro
CompilerEndIf


;-
;- SDL3_mixer Library Files

#SDLx_mixer_LibName = "SDL3_mixer"

#SDLx_mixer_IncludeFilename = #PB_Compiler_Filename

CompilerSelect (#PB_Compiler_OS)
  CompilerCase #PB_OS_Windows
    CompilerIf (Not Defined(SDLx_mixer_OpenLibraryDefaultName, #PB_Constant))
      #SDLx_mixer_OpenLibraryDefaultName = "SDL3_mixer.dll"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_mixer_ImportLibraryName, #PB_Constant))
      #SDLx_mixer_ImportLibraryName = "SDL3_mixer.lib"
    CompilerEndIf
    
  CompilerCase #PB_OS_Linux
    CompilerIf (Not Defined(SDLx_mixer_OpenLibraryDefaultName, #PB_Constant))
      #SDLx_mixer_OpenLibraryDefaultName = "libSDL3_mixer.so"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_mixer_ImportLibraryName, #PB_Constant))
      ;#SDLx_mixer_ImportLibraryName = ""
    CompilerEndIf
    
  CompilerCase #PB_OS_MacOS
    CompilerIf (Not Defined(SDLx_mixer_OpenLibraryDefaultName, #PB_Constant))
      ;#SDLx_mixer_OpenLibraryDefaultName = ""
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_mixer_ImportLibraryName, #PB_Constant))
      #SDLx_mixer_ImportLibraryName = "Frameworks/SDL3_mixer.framework/SDL3_mixer"
    CompilerEndIf
CompilerEndSelect

CompilerIf (Not Defined(SDLx_mixer_UseImport, #PB_Constant))
  CompilerIf (Not Defined(SDLx_mixer_OpenLibraryDefaultName, #PB_Constant))
    #SDLx_mixer_UseImport = #True
  CompilerElse
    #SDLx_mixer_UseImport = #False
  CompilerEndIf
CompilerEndIf
#SDLx_mixer_UseOpenLibrary = Bool(Not #SDLx_mixer_UseImport)

CompilerIf (#SDLx_mixer_UseOpenLibrary And (Not Defined(SDLx_mixer_OpenLibraryDefaultName, #PB_Constant)))
  CompilerError "#SDLx_mixer_OpenLibraryDefaultName must be defined to open " + #SDLx_mixer_LibName + "!"
CompilerEndIf
CompilerIf (#SDLx_mixer_UseImport And (Not Defined(SDLx_mixer_ImportLibraryName, #PB_Constant)))
  CompilerError "#SDLx_mixer_ImportLibraryName must be defined to import " + #SDLx_mixer_LibName + "!"
CompilerEndIf

CompilerIf (Not Defined(SDLx_mixer_RequireAllFunctionLoads, #PB_Constant))
  #SDLx_mixer_RequireAllFunctionLoads = #SDLx_RequireAllFunctionLoads
CompilerEndIf
CompilerIf (Not Defined(SDLx_mixer_AssertAllFunctionLoads, #PB_Constant))
  #SDLx_mixer_AssertAllFunctionLoads = #SDLx_AssertAllFunctionLoads
CompilerEndIf

;% DELETESTART
CompilerIf (#PB_Compiler_IsMainFile)
  #SDLx_mixer_IncludeHelperProcedures = #False
CompilerEndIf
;% DELETEEND
CompilerIf (Not Defined(SDLx_mixer_IncludeHelperProcedures, #PB_Constant))
  #SDLx_mixer_IncludeHelperProcedures = #True
CompilerEndIf


;-
;- Standard Types

UndefineMacro Uint8
Macro Uint8
  a
EndMacro
UndefineMacro Sint8
Macro Sint8
  b
EndMacro
UndefineMacro Uint16
Macro Uint16
  u
EndMacro
UndefineMacro Sint16
Macro Sint16
  w
EndMacro
UndefineMacro Uint32
Macro Uint32
  l
EndMacro
UndefineMacro Sint32
Macro Sint32
  l
EndMacro
UndefineMacro Uint64
Macro Uint64
  q
EndMacro
UndefineMacro Sint64
Macro Sint64
  q
EndMacro
UndefineMacro POINTER_TO_A_POINTER
Macro POINTER_TO_A_POINTER
  INTEGER
EndMacro




;-
;- SDL3_mixer Constants

;- - Querying SDL Version

#SDL_MIXER_MAJOR_VERSION = 3
#SDL_MIXER_MINOR_VERSION = 2
#SDL_MIXER_MICRO_VERSION = 0

Macro SDL_MIXER_VERSION()
  SDL_VERSIONNUM(#SDL_MIXER_MAJOR_VERSION, #SDL_MIXER_MINOR_VERSION, #SDL_MIXER_MICRO_VERSION)
EndMacro
Macro SDL_MIXER_VERSION_ATLEAST(X, Y, Z)
  (Bool(SDL_MIXER_VERSION() >= SDL_VERSIONNUM(X, Y, Z)))
EndMacro



;-
;- SDL3_mixer Structures

Structure MIX_Point3D Align #PB_Structure_AlignC
  x.f ; X coordinate (negative left, positive right)
  y.f ; Y coordinate (negative down, positive up)
  z.f ; Z coordinate (negative forward, positive back)
EndStructure

Structure MIX_StereoGains Align #PB_Structure_AlignC
  left.f  ; left  channel gain
  right.f ; right channel gain
EndStructure

Structure MIX_Audio Align #PB_Structure_AlignC
  ;
EndStructure

Structure MIX_AudioDecoder Align #PB_Structure_AlignC
  ;
EndStructure

Structure MIX_Group Align #PB_Structure_AlignC
  ;
EndStructure

Structure MIX_Mixer Align #PB_Structure_AlignC
  ;
EndStructure

Structure MIX_Track Align #PB_Structure_AlignC
  ;
EndStructure





;-
;- SDL3_mixer Prototypes

; TODO define SDL3_mixer callbacks:
; MIX_GroupMixCallback
; MIX_PostMixCallback
; MIX_TrackMixCallback
; MIX_TrackStoppedCallback

;% CATEGORY=
PrototypeC.a Proto_MIX_Init() ; returns bool
PrototypeC   Proto_MIX_Quit()
PrototypeC.l Proto_MIX_Version() ; returns int

PrototypeC.q Proto_MIX_AudioFramesToMS(*audio.MIX_Audio, frames.Sint64) ; returns Sint64
PrototypeC.q Proto_MIX_AudioMSToFrames(*audio.MIX_Audio, ms.Sint64) ; returns Sint64
PrototypeC.i Proto_MIX_CreateAudioDecoder(path.p-utf8, props.SDL_PropertiesID) ; returns MIX_AudioDecoder *
PrototypeC.i Proto_MIX_CreateAudioDecoder_IO(*io.SDL_IOStream, closeio.Uint8, props.SDL_PropertiesID) ; returns MIX_AudioDecoder *
PrototypeC.i Proto_MIX_CreateGroup(*mixer.MIX_Mixer) ; returns MIX_Group *
PrototypeC.i Proto_MIX_CreateMixer(*spec.SDL_AudioSpec) ; returns MIX_Mixer *
PrototypeC.i Proto_MIX_CreateMixerDevice(devid.SDL_AudioDeviceID, *spec.SDL_AudioSpec) ; returns MIX_Mixer *
PrototypeC.i Proto_MIX_CreateSineWaveAudio(*mixer.MIX_Mixer, hz.Sint32, amplitude.f, ms.Sint64) ; returns MIX_Audio *
PrototypeC.i Proto_MIX_CreateTrack(*mixer.MIX_Mixer) ; returns MIX_Track *
PrototypeC.l Proto_MIX_DecodeAudio(*audiodecoder.MIX_AudioDecoder, *buffer, buflen.Sint32, *spec.SDL_AudioSpec) ; returns int
PrototypeC   Proto_MIX_DestroyAudio(*audio.MIX_Audio)
PrototypeC   Proto_MIX_DestroyAudioDecoder(*audiodecoder.MIX_AudioDecoder)
PrototypeC   Proto_MIX_DestroyGroup(*group.MIX_Group)
PrototypeC   Proto_MIX_DestroyMixer(*mixer.MIX_Mixer)
PrototypeC   Proto_MIX_DestroyTrack(*track.MIX_Track)
PrototypeC.q Proto_MIX_FramesToMS(sample_rate.Sint32, frames.Sint64) ; returns Sint64
;
; TODO all remaining MIX_ prototypes
;
PrototypeC.a Proto_MIX_TagTrack(*track.MIX_Track, tag.p-utf8) ; returns bool
PrototypeC.q Proto_MIX_TrackFramesToMS(*track.MIX_Track, frames.Sint64) ; returns Sint64
PrototypeC.q Proto_MIX_TrackMSToFrames(*track.MIX_Track, ms.Sint64) ; returns Sint64
PrototypeC.a Proto_MIX_TrackPaused(*track.MIX_Track) ; returns bool
PrototypeC.a Proto_MIX_TrackPlaying(*track.MIX_Track) ; returns bool
PrototypeC   Proto_MIX_UnlockMixer(*mixer.MIX_Mixer)
PrototypeC   Proto_MIX_UntagTrack(*track.MIX_Track, tag.p-utf8)




;-
;- OpenLibrary Variables

CompilerIf (#SDLx_mixer_UseOpenLibrary)

Global __SDLx_mixer_DynamicLibPath.s

Global __SDLx_mixer_Lib.i = #Null
Global __SDLx_MIX_Init.Proto_MIX_Init
Global __SDLx_MIX_Quit.Proto_MIX_Quit

;% DECLARE_DYNAMIC_PROTOTYPES

;% DELETESTART
Global MIX_Version.Proto_MIX_Version
;% DELETEEND

Macro _SDLx_mixer_DQ
  "
EndMacro

Macro _SDLx_LoadFunction(_Name)
  _Name = GetFunction(__SDLx_mixer_Lib, _SDLx_mixer_DQ#_Name#_SDLx_mixer_DQ)
  CompilerIf ((#SDLx_mixer_AssertAllFunctionLoads And #__SDLx_mixer_DebugErrors) Or #SDLx_mixer_RequireAllFunctionLoads)
    If (_Name = #Null)
      __SDLx_mixer_Debug("Could not find SDL3_mixer library function: " + _SDLx_mixer_DQ#_Name#_SDLx_mixer_DQ)
      LoadFailed = #SDLx_mixer_RequireAllFunctionLoads
    EndIf
  CompilerEndIf
EndMacro

CompilerEndIf

;-
;- Function Imports

CompilerIf (#SDLx_mixer_UseImport)

ImportC #SDLx_mixer_ImportLibraryName
  
;% INDENT=1
;% STATIC_IMPORTS
;% INDENT=0
EndImport

CompilerEndIf



;-
;- PB Wrapper Procedures

CompilerIf (#SDLx_mixer_UseOpenLibrary)

Procedure MIX_Quit()
  If (__SDLx_mixer_Lib)
    __SDLx_MIX_Quit()
    CloseLibrary(__SDLx_mixer_Lib)
    __SDLx_mixer_Lib   = #Null
    __SDLx_MIX_Init = #Null
    __SDLx_MIX_Quit = #Null
  Else
    __SDLx_mixer_Debug("MIX_Quit() called while not initialized")
  EndIf
EndProcedure

Procedure.a MIX_Init()
  Protected Success.i = #False
  
  CompilerIf (#SDLx_UseOpenLibrary)
    If (__SDLxLib = #Null)
      __SDLx_mixer_Debug("SDL_Init() must be called before MIX_Init()")
      ProcedureReturn (#False)
    EndIf
  CompilerEndIf
  
  If (__SDLx_mixer_Lib = #Null)
    If (__SDLx_mixer_DynamicLibPath = "")
      __SDLx_mixer_DynamicLibPath = #SDLx_mixer_OpenLibraryDefaultName
    EndIf
    __SDLx_mixer_Lib = OpenLibrary(#PB_Any, __SDLx_mixer_DynamicLibPath)
    If (Not __SDLx_mixer_Lib)
      __SDLx_mixer_Debug("Failed to open SDL3_mixer library '" + __SDLx_mixer_DynamicLibPath + "'")
    EndIf
  Else
    __SDLx_mixer_Debug("MIX_Init() called while already initialized")
  EndIf
  
  If (__SDLx_mixer_Lib)
    If (#True)
      __SDLx_MIX_Init = GetFunction(__SDLx_mixer_Lib, "MIX_Init")
      If (__SDLx_MIX_Init)
        __SDLx_MIX_Quit = GetFunction(__SDLx_mixer_Lib, "MIX_Quit")
        If (__SDLx_MIX_Quit)
          Protected LoadFailed.i = #False
          
;% INDENT=5
;% LOAD_DYNAMIC_FUNCTIONS
          
          If (Not LoadFailed)
            If (#True)
              Success = __SDLx_MIX_Init()
              CompilerIf (#True)
                If (Success)
                  Protected LinkedVer.i = MIX_Version()
                  If (#True);(SDL_VERSIONNUM_MAJOR(LinkedVer) = #SDL_MIXER_MAJOR_VERSION)
                    If (#True);(SDL_VERSIONNUM_MINOR(LinkedVer) < #SDL_MINOR_VERSION - 1)
                      ;Protected Message.s = "Warning: Dynamically linked SDL ("
                      ;Message + Str(SDL_VERSIONNUM_MAJOR(LinkedVer)) + "." + Str(SDL_VERSIONNUM_MINOR(LinkedVer)) + "." + Str(SDL_VERSIONNUM_MICRO(LinkedVer))
                      ;Message + ") is older than SDLx compiled version ("
                      ;Message + Str(#SDL_MAJOR_VERSION) + "." + Str(#SDL_MINOR_VERSION) + "." + Str(#SDL_MICRO_VERSION) + ")"
                      ;__SDLx_Debug(Message)
                    EndIf
                  Else
                    __SDLx_mixer_Debug("Dynamically linked SDL3_mixer version (" + Str(SDL_VERSIONNUM_MAJOR(LinkedVer)) + ") does not match compiled SDLx version (" + Str(#SDL_MIXER_MAJOR_VERSION) + ")!")
                    MIX_Quit()
                    Success = #False
                  EndIf
                EndIf
              CompilerEndIf
            EndIf
          EndIf
        Else
          __SDLx_mixer_Debug("Failed to load SDL library function: '" + "MIX_Quit" + "'")
        EndIf
      Else
        __SDLx_mixer_Debug("Failed to load SDL library function: '" + "MIX_Init" + "'")
      EndIf
    EndIf
  EndIf
  
  ProcedureReturn (Success)
EndProcedure

UndefineMacro _SDLx_LoadFunction

CompilerEndIf

;-
;- Helper Procedures

CompilerIf (#SDLx_mixer_IncludeHelperProcedures)

CompilerEndIf







;-
;- Template / Main File Warning

;% DELETESTART
MessageRequester(#PB_Compiler_Filename, "This template file is not intended to be used as-is." + #LF$ + #LF$ + "Please run 'SDLx_Build.pb' to generate the full IncludeFile.", #PB_MessageRequester_Warning)
End
;% DELETEEND
CompilerIf (#PB_Compiler_IsMainFile)
  MessageRequester(#PB_Compiler_Filename, "This IncludeFile is not intended to be run by itself." + #LF$ + #LF$ + "See the 'examples' subfolder, or include this in your own project!", #PB_MessageRequester_Warning)
CompilerEndIf

CompilerEndIf
;-
