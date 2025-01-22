; +----------+
; | SDL3.pbi |
; +----------+
; | 2024-09-24 : Creation (PureBasic 6.12)

; Warning: This file should not be directly modified!
; It was automatically generated from 'SDL3_Template.pbi' by 'SDLx_Build.pb'.
;
; Generated 2025-01-22 16:11:19 UTC

; SDL3 Wiki:       https://wiki.libsdl.org/SDL3
; API by Category: https://wiki.libsdl.org/SDL3/APIByCategory
; All Functions:   https://wiki.libsdl.org/SDL3/CategoryAPIFunction
; Complete API:    https://wiki.libsdl.org/SDL3/CategoryAPI
;
; SDL2 --> SDL3 Migration Guide: https://github.com/libsdl-org/SDL/blob/main/docs/README-migration.md

CompilerIf (Not Defined(__SDLx_Included, #PB_Constant))
#__SDLx_Included = #True

CompilerIf (#PB_Compiler_Version < 510)
  CompilerError #PB_Compiler_Filename + " requires PureBasic 5.10 or newer!"
CompilerEndIf

CompilerIf (Defined(SDL_MAJOR_VERSION, #PB_Constant))
  CompilerIf (#SDL_MAJOR_VERSION <> 3)
    CompilerIf (#PB_Compiler_OS = #PB_OS_Linux)
      CompilerError #PB_Compiler_Filename + " conflicts with pre-existing SDL definitions! Try moving 'sdl.res' out of PureBasic 'residents' subfolder and restarting the compiler."
    CompilerElse
      CompilerError #PB_Compiler_Filename + " conflicts with pre-existing SDL definitions!"
    CompilerEndIf
  CompilerEndIf
CompilerEndIf

CompilerIf (#PB_Compiler_IsMainFile)
  EnableExplicit
CompilerEndIf


;-
;- Build Switches

CompilerIf (Not Defined(SDLx_StaticLink, #PB_Constant))
  #SDLx_StaticLink = #False
CompilerEndIf
#SDLx_DynamicLink = Bool(Not #SDLx_StaticLink)

CompilerIf (Not Defined(SDLx_DebugErrors, #PB_Constant))
  #SDLx_DebugErrors = #False
CompilerEndIf
CompilerIf (#PB_Compiler_Debugger)
  #__SDLx_DebugErrors = #SDLx_DebugErrors
CompilerElse
  #__SDLx_DebugErrors = #False
CompilerEndIf
CompilerIf (#__SDLx_DebugErrors)
  Macro __SDLx_Debug(_Message)
    Debug _Message
  EndMacro
CompilerElse
  Macro __SDLx_Debug(_Message)
    ;
  EndMacro
CompilerEndIf

CompilerIf (#True)
  Macro __SDLx_StructInt
    l ; use 32-bit PB Long for SDL struct "int" members
  EndMacro)
  Macro __SDLx_StructEnum
    l ; use 32-bit PB Long for SDL struct enum members
  EndMacro
  Macro SDLx_Int
    l ; use 32-bit PB Long for SDL "int" args
  EndMacro
  Macro SDLx_Enum
    l ; use 32-bit PB Long for SDL enum args
  EndMacro
CompilerEndIf


;-
;- SDL3 Library Files

#SDLx_LibName = "SDL3"

#SDLx_IncludeFilename = #PB_Compiler_Filename

CompilerSelect (#PB_Compiler_OS)
  CompilerCase #PB_OS_Windows
    CompilerIf (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant))
      #SDLx_DynamicLibraryDefaultName = "SDL3.dll"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_StaticLibraryName, #PB_Constant))
      #SDLx_StaticLibraryName = "SDL3.lib"
    CompilerEndIf
    
  CompilerCase #PB_OS_Linux
    CompilerIf (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant))
      #SDLx_DynamicLibraryDefaultName = "libSDL3.so"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_StaticLibraryName, #PB_Constant))
      ;#SDLx_StaticLibraryName = ""
    CompilerEndIf
    
  CompilerCase #PB_OS_MacOS
    CompilerIf (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant))
      ;#SDLx_DynamicLibraryDefaultName = ""
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_StaticLibraryName, #PB_Constant))
      #SDLx_StaticLibraryName = "Frameworks/SDL3.framework/SDL3"
    CompilerEndIf
CompilerEndSelect

CompilerIf (#SDLx_DynamicLink And (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant)))
  CompilerError "#SDLx_DynamicLibraryDefaultName must be defined to dynamically link " + #SDLx_LibName + "!"
CompilerEndIf
CompilerIf (#SDLx_StaticLink And (Not Defined(SDLx_StaticLibraryName, #PB_Constant)))
  CompilerError "#SDLx_StaticLibraryName must be defined to statically link " + #SDLx_LibName + "!"
CompilerEndIf

CompilerIf (Not Defined(SDLx_RequireAllFunctionLoads, #PB_Constant))
  #SDLx_RequireAllFunctionLoads = #False
CompilerEndIf
CompilerIf (Not Defined(SDLx_AssertAllFunctionLoads, #PB_Constant))
  #SDLx_AssertAllFunctionLoads = #PB_Compiler_Debugger
CompilerEndIf

CompilerIf (Not Defined(SDLx_IncludeHelperProcedures, #PB_Constant))
  #SDLx_IncludeHelperProcedures = #True
CompilerEndIf



;-
;- SDL3 Constants

;- - Querying SDL Version

#SDL_MAJOR_VERSION = 3
#SDL_MINOR_VERSION = 2
#SDL_MICRO_VERSION = 0

Macro SDL_VERSIONNUM(major, minor, patch)
  ((major)*1000000 + (minor)*1000 + (patch))
EndMacro
Macro SDL_VERSION()
  SDL_VERSIONNUM(#SDL_MAJOR_VERSION, #SDL_MINOR_VERSION, #SDL_MICRO_VERSION)
EndMacro
Macro SDL_VERSIONNUM_MAJOR(version)
  ((version) / 1000000)
EndMacro
Macro SDL_VERSIONNUM_MINOR(version)
  (((version) / 1000) % 1000)
EndMacro
Macro SDL_VERSIONNUM_MICRO(version)
  ((version) % 1000)
EndMacro
Macro SDL_VERSION_ATLEAST(X, Y, Z)
  (Bool(SDL_VERSION() >= SDL_VERSIONNUM(X, Y, Z)))
EndMacro

;- - Initialization and Shutdown

Enumeration ; SDL_InitFlags for SDL_Init()
  #SDL_INIT_AUDIO          = $00000010 ; implies SDL_INIT_EVENTS
  #SDL_INIT_VIDEO          = $00000020 ; implies SDL_INIT_EVENTS
  #SDL_INIT_JOYSTICK       = $00000200 ; implies SDL_INIT_EVENTS
  #SDL_INIT_HAPTIC         = $00001000
  #SDL_INIT_GAMEPAD        = $00002000 ; implies SDL_INIT_JOYSTICK
  #SDL_INIT_EVENTS         = $00004000
  #SDL_INIT_SENSOR         = $00008000 ; implies SDL_INIT_EVENTS
  #SDL_INIT_CAMERA         = $00010000 ; implies SDL_INIT_EVENTS
EndEnumeration

;- - Display and Window Management

;- - 2D Accelerated Rendering




;-
;- Helper Constants



;-
;- SDL3 Structures





;-
;- SDL3 Prototypes

;- - Querying SDL Version
PrototypeC.i Proto_SDL_GetVersion()

;- - Initialization and Shutdown
PrototypeC.i Proto_SDL_Init(flags.l) ; returns 1 on success
PrototypeC.i Proto_SDL_InitSubSystem(flags.l) ; returns 1 on success
PrototypeC   Proto_SDL_Quit()
PrototypeC   Proto_SDL_QuitSubSystem(flags.l)

;- - Display and Window Management

;- - 2D Accelerated Rendering









;-
;- Dynamic Link Variables

CompilerIf (#SDLx_DynamicLink)

Global __SDLx_DynamicLibPath.s

Global __SDLxLib.i = #Null
Global __SDLx_Init.Proto_SDL_Init
Global __SDLx_Quit.Proto_SDL_Quit

Global __SDLx_InitCallback = #Null

Global SDL_GetVersion.Proto_SDL_GetVersion
Global SDL_InitSubSystem.Proto_SDL_InitSubSystem
Global SDL_QuitSubSystem.Proto_SDL_QuitSubSystem



CompilerEndIf

;-
;- Static Link Imports

CompilerIf (#SDLx_StaticLink)

ImportC #SDLx_StaticLibraryName
  
  SDL_GetVersion.i()
  SDL_Init.i(flags.l)
  SDL_InitSubSystem.i(flags.l)
  SDL_Quit()
  SDL_QuitSubSystem(flags.l)

EndImport

CompilerEndIf



;-
;- PB Wrapper Procedures

CompilerIf (#SDLx_DynamicLink)

Procedure SDL_Quit()
  If (__SDLxLib)
    __SDLx_Quit()
    CloseLibrary(__SDLxLib)
    __SDLxLib = #Null
  Else
    __SDLx_Debug("SDL_Quit() called while not initialized")
  EndIf
EndProcedure

Procedure.i SDL_Init(flags.l)
  Protected Success.i = #False
  
  If (__SDLxLib = #Null)
    If (__SDLx_DynamicLibPath = "")
      __SDLx_DynamicLibPath = #SDLx_DynamicLibraryDefaultName
    EndIf
    __SDLxLib = OpenLibrary(#PB_Any, __SDLx_DynamicLibPath)
    If (Not __SDLxLib)
      __SDLx_Debug("Failed to open SDL library '" + __SDLx_DynamicLibPath + "'")
    EndIf
  Else
    __SDLx_Debug("SDL_Init() called while already initialized")
  EndIf
  
  If (__SDLxLib)
    __SDLx_Init = GetFunction(__SDLxLib, "SDL_Init")
    If (__SDLx_Init)
      __SDLx_Quit = GetFunction(__SDLxLib, "SDL_Quit")
      If (__SDLx_Quit)
        Protected LoadFailed.i = #False
        
        SDL_GetVersion = GetFunction(__SDLxLib, "SDL_GetVersion")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_GetVersion = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_GetVersion'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_InitSubSystem = GetFunction(__SDLxLib, "SDL_InitSubSystem")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_InitSubSystem = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_InitSubSystem'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_QuitSubSystem = GetFunction(__SDLxLib, "SDL_QuitSubSystem")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_QuitSubSystem = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_QuitSubSystem'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        
        
        If (Not LoadFailed)
          If ((__SDLx_InitCallback = #Null) Or (CallFunctionFast(__SDLx_InitCallback) = 0))
            Success = __SDLx_Init(flags)
            CompilerIf (#True)
              If (Success)
                Protected LinkedVer.i = SDL_GetVersion()
                If (SDL_VERSIONNUM_MAJOR(LinkedVer) = #SDL_MAJOR_VERSION)
                  If (SDL_VERSIONNUM_MINOR(LinkedVer) < #SDL_MINOR_VERSION - 1)
                    Protected Message.s = "Warning: Dynamically linked SDL ("
                    Message + Str(SDL_VERSIONNUM_MAJOR(LinkedVer)) + "." + Str(SDL_VERSIONNUM_MINOR(LinkedVer)) + "." + Str(SDL_VERSIONNUM_MICRO(LinkedVer))
                    Message + ") is older than SDLx compiled version ("
                    Message + Str(#SDL_MAJOR_VERSION) + "." + Str(#SDL_MINOR_VERSION) + "." + Str(#SDL_MICRO_VERSION) + ")"
                    __SDLx_Debug(Message)
                  EndIf
                Else
                  __SDLx_Debug("Dynamically linked SDL version (" + Str(SDL_VERSIONNUM_MAJOR(LinkedVer)) + ") does not match compiled SDLx version (" + Str(#SDL_MAJOR_VERSION) + ")!")
                  SDL_Quit()
                  Success = #False
                EndIf
              EndIf
            CompilerEndIf
          Else
            SDL_Quit()
            __SDLx_Debug("SDL_Init aborted by callback returning non-zero")
          EndIf
        EndIf
      Else
        __SDLx_Debug("Failed to load SDL library function: '" + "SDL_Quit" + "'")
      EndIf
    Else
      __SDLx_Debug("Failed to load SDL library function: '" + "SDL_Init" + "'")
    EndIf
  EndIf
  
  ProcedureReturn (Success)
EndProcedure

CompilerEndIf

;-
;- Helper Structures

;-
;- Helper Procedures

CompilerIf (#SDLx_IncludeHelperProcedures)

Procedure.s SDLx_CompiledVersionString()
  ProcedureReturn (Str(#SDL_MAJOR_VERSION) + "." + Str(#SDL_MINOR_VERSION) + "." + Str(#SDL_MICRO_VERSION))
EndProcedure

Procedure.s SDLx_GetVersionString()
  Protected Result.s = ""
  Protected ver.i = SDL_GetVersion()
  If (ver > 0)
    Result = Str(SDL_VERSIONNUM_MAJOR(ver)) + "." + Str(SDL_VERSIONNUM_MINOR(ver)) + "." + Str(SDL_VERSIONNUM_MICRO(ver))
  EndIf
  ProcedureReturn (Result)
EndProcedure

Procedure SDLx_SetPostLoadPreInitCallback(*Procedure)
  CompilerIf (#SDLx_StaticLink)
    Static HasRun.i = #False
    If (*Procedure And (Not HasRun))
      CallFunctionFast(*Procedure)
      HasRun = #True
    EndIf
  CompilerElse
    __SDLx_InitCallback = *Procedure
  CompilerEndIf
EndProcedure

Procedure.i SDLx_InitLibrary(LibraryFile.s, flags.l)
  CompilerIf (#SDLx_DynamicLink)
    If (__SDLxLib = #Null) ; Don't update lib path if it's currently loaded!
      __SDLx_DynamicLibPath = LibraryFile
    EndIf
    ProcedureReturn (SDL_Init(flags))
  CompilerElse
    ProcedureReturn (SDL_Init(flags))
  CompilerEndIf
EndProcedure

CompilerEndIf







;-
;- Template / Main File Warning

CompilerIf (#PB_Compiler_IsMainFile)
  MessageRequester(#PB_Compiler_Filename, "This IncludeFile is not intended to be run by itself." + #LF$ + #LF$ + "See the 'examples' subfolder, or include this in your own project!", #PB_MessageRequester_Warning)
CompilerEndIf

CompilerEndIf
;-
