;%===================================================================================%
;% Note: This is the TEMPLATE FILE which is used to generate the complete 'SDL3.pbi' %
;%===================================================================================%
; +----------+
; | SDL3.pbi |
; +----------+
; | 2024-09-24 : Creation (PureBasic 6.12)

;% MODIFY_DISCLAIMER
;
;% GEN_TIMESTAMP

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


;-
;- SDL3 Library Files

#SDLx_LibName = "SDL3"

#SDLx_IncludeFilename = #PB_Compiler_Filename

CompilerSelect (#PB_Compiler_OS)
  CompilerCase #PB_OS_Linux
    CompilerIf (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant))
      #SDLx_DynamicLibraryDefaultName = "libSDL3.so"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_StaticLibraryName, #PB_Constant))
      ;#SDLx_StaticLibraryName = ""
    CompilerEndIf
CompilerEndSelect

CompilerIf (#SDLx_DynamicLink And (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant)))
  CompilerError "#SDLx_DynamicLibraryDefaultName must be defined to dynamically link " + #SDLx_LibName + "!"
CompilerEndIf
CompilerIf (#SDLx_StaticLink And (Not Defined(SDLx_StaticLibraryName, #PB_Constant)))
  CompilerError "#SDLx_StaticLibraryName must be defined to statically link " + #SDLx_LibName + "!"
CompilerEndIf

CompilerIf (Not Defined(SDLx_RequireAllFunctionLoads, #PB_Constant))
  #SDLx_RequireAllFunctionLoads = #True
CompilerEndIf
CompilerIf (Not Defined(SDLx_AssertAllFunctionLoads, #PB_Constant))
  #SDLx_AssertAllFunctionLoads = #True
CompilerEndIf

CompilerIf (Not Defined(SDLx_IncludeHelperProcedures, #PB_Constant))
  #SDLx_IncludeHelperProcedures = #True
CompilerEndIf



;-
;- SDL3 Constants

;- - Querying SDL Version

;- - Initialization and Shutdown

;- - Display and Window Management

;- - 2D Accelerated Rendering




;-
;- Helper Constants



;-
;- SDL3 Structures





;-
;- SDL3 Prototypes

;- - Querying SDL Version

;- - Initialization and Shutdown
PrototypeC.i Proto_SDL_Init(flags.l)
PrototypeC   Proto_SDL_Quit()

;- - Display and Window Management

;- - 2D Accelerated Rendering









;-
;- PB Wrapper Variables

CompilerIf (#SDLx_DynamicLink)

Global __SDLx_DynamicLibPath.s

Global __SDLxLib.i = #Null
Global __SDLx_Init.Proto_SDL_Init
Global __SDLx_Quit.Proto_SDL_Quit

;% DECLARE_DYNAMIC_PROTOTYPES

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
        
;% INDENT=4
;% LOAD_DYNAMIC_FUNCTIONS
        
        If (Not LoadFailed)
          Success = __SDLx_Init(flags)
          CompilerIf (#True)
            If (Success)
              ; ...
            EndIf
          CompilerEndIf
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
;- Helper Procedures

CompilerIf (#SDLx_IncludeHelperProcedures)

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

;% DELETESTART
MessageRequester(#PB_Compiler_Filename, "This template file is not intended to be used as-is." + #LF$ + #LF$ + "Please run 'SDLx_Build.pb' to generate the full IncludeFile.", #PB_MessageRequester_Warning)
End
;% DELETEEND
CompilerIf (#PB_Compiler_IsMainFile)
  MessageRequester(#PB_Compiler_Filename, "This IncludeFile is not intended to be run by itself." + #LF$ + #LF$ + "See the 'examples' subfolder, or include this in your own project!", #PB_MessageRequester_Warning)
CompilerEndIf

CompilerEndIf
;-
