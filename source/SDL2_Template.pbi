;%===================================================================================%
;% Note: This is the TEMPLATE FILE which is used to generate the complete 'SDL2.pbi' %
;%===================================================================================%
; +----------+
; | SDL2.pbi |
; +----------+
; | 2024-09-23 : Creation (PureBasic 6.12)

;% MODIFY_DISCLAIMER
;
;% GEN_TIMESTAMP

; SDL2 Wiki:       https://wiki.libsdl.org/SDL2
; API by Category: https://wiki.libsdl.org/SDL2/APIByCategory
; All Functions:   https://wiki.libsdl.org/SDL2/CategoryAPIFunction
; Complete API:    https://wiki.libsdl.org/SDL2/CategoryAPI


CompilerIf (Not Defined(__SDLx_Included, #PB_Constant))
#__SDLx_Included = #True

CompilerIf (#PB_Compiler_Version < 510)
  CompilerError #PB_Compiler_Filename + " requires PureBasic 5.10 or newer!"
CompilerEndIf

CompilerIf (Defined(SDL_MAJOR_VERSION, #PB_Constant))
  CompilerIf (#SDL_MAJOR_VERSION <> 2)
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
CompilerIf (#SDLx_DebugErrors)
  Macro __SDLx_Debug(_Message)
    Debug _Message
  EndMacro
CompilerElse
  Macro __SDLx_Debug(_Message)
    ;
  EndMacro
CompilerEndIf


;-
;- SDL2 Library Files

#SDLx_LibName = "SDL2"

#SDLx_IncludeFilename = #PB_Compiler_Filename

CompilerSelect (#PB_Compiler_OS)
  CompilerCase #PB_OS_Linux
    CompilerIf (Not Defined(SDLx_DynamicLibraryName, #PB_Constant))
      #SDLx_DynamicLibraryName = "libSDL2.so"
    CompilerEndIf
CompilerEndSelect

CompilerIf (#SDLx_StaticLink And (Not Defined(SDLx_StaticLibraryName, #PB_Constant)))
  CompilerError "#SDLx_StaticLibraryName must be defined to statically link " + #SDLx_LibName + "!"
CompilerEndIf
CompilerIf (#SDLx_DynamicLink And (Not Defined(SDLx_DynamicLibraryName, #PB_Constant)))
  CompilerError "#SDLx_DynamicLibraryName must be defined to dynamically link " + #SDLx_LibName + "!"
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
;- SDL2 Constants

;- - Querying SDL Version

#SDL_MAJOR_VERSION = 2
#SDL_MINOR_VERSION = 31
#SDL_PATCHLEVEL    = 0

Macro SDL_VERSIONNUM(X, Y, Z)
  ((X)*1000 + (Y)*100 + (Z))
EndMacro
Macro SDL_COMPILEDVERSION()
  SDL_VERSIONNUM(#SDL_MAJOR_VERSION, #SDL_MINOR_VERSION, #SDL_PATCHLEVEL)
EndMacro
Macro SDL_VERSIONATLEAST(X, Y, Z)
  (Bool((#SDL_MAJOR_VERSION >= (X)) And ((#SDL_MAJOR_VERSION > (X)) Or (#SDL_MINOR_VERSION >= (Y))) And ((#SDL_MAJOR_VERSION > (X)) Or (#SDL_MINOR_VERSION > (Y)) Or (#SDL_PATCHLEVEL >= (Z)))))
EndMacro

;- - Initialization and Shutdown

Enumeration ; SDL_INIT_* for SDL_Init()
  #SDL_INIT_TIMER          = $00000001
  #SDL_INIT_AUDIO          = $00000010
  #SDL_INIT_VIDEO          = $00000020 ; implies SDL_INIT_EVENTS
  #SDL_INIT_JOYSTICK       = $00000200 ; implies SDL_INIT_EVENTS
  #SDL_INIT_HAPTIC         = $00001000
  #SDL_INIT_GAMECONTROLLER = $00002000 ; implies SDL_INIT_JOYSTICK
  #SDL_INIT_EVENTS         = $00004000
  #SDL_INIT_SENSOR         = $00008000
  #SDL_INIT_NOPARACHUTE    = $00100000 ; "this flag is ignored"
  ;
  CompilerIf (Not Defined(SDL_INIT_EVERYTHING, #PB_Constant))
    ; This is the definition in SDL2.h, but PB Linux 6.12 seems to have it predefined as conflicting $FFFF
    #SDL_INIT_EVERYTHING = #SDL_INIT_TIMER | #SDL_INIT_AUDIO | #SDL_INIT_VIDEO | #SDL_INIT_EVENTS | #SDL_INIT_JOYSTICK | #SDL_INIT_HAPTIC | #SDL_INIT_GAMECONTROLLER | #SDL_INIT_SENSOR
  CompilerEndIf
EndEnumeration

;- - Display and Window Management

Enumeration ; SDL_WINDOW_* for SDL_CreateWindow()
  #SDL_WINDOW_FULLSCREEN         = $00000001
  #SDL_WINDOW_OPENGL             = $00000002
  #SDL_WINDOW_SHOWN              = $00000004
  #SDL_WINDOW_HIDDEN             = $00000008
  #SDL_WINDOW_BORDERLESS         = $00000010
  #SDL_WINDOW_RESIZABLE          = $00000020
  #SDL_WINDOW_MINIMIZED          = $00000040
  #SDL_WINDOW_MAXIMIZED          = $00000080
  #SDL_WINDOW_MOUSE_GRABBED      = $00000100
  #SDL_WINDOW_INPUT_FOCUS        = $00000200
  #SDL_WINDOW_MOUSE_FOCUS        = $00000400
  #SDL_WINDOW_FOREIGN            = $00000800
  #SDL_WINDOW_FULLSCREEN_DESKTOP = $00001000 | #SDL_WINDOW_FULLSCREEN
  #SDL_WINDOW_ALLOW_HIGHDPI      = $00002000
  #SDL_WINDOW_MOUSE_CAPTURE      = $00004000
  #SDL_WINDOW_ALWAYS_ON_TOP      = $00008000
  #SDL_WINDOW_SKIP_TASKBAR       = $00010000
  #SDL_WINDOW_UTILITY            = $00020000
  #SDL_WINDOW_TOOLTIP            = $00040000
  #SDL_WINDOW_POPUP_MENU         = $00080000
  #SDL_WINDOW_KEYBOARD_GRABBED   = $00100000
  #SDL_WINDOW_VULKAN             = $10000000
  #SDL_WINDOW_METAL              = $20000000
  #SDL_WINDOW_INPUT_GRABBED      = #SDL_WINDOW_MOUSE_GRABBED ; "for compatibility"
EndEnumeration

; SDL_WINDOWPOS_* SDL_WindowFlags for SDL_CreateWindow()
#SDL_WINDOWPOS_UNDEFINED_MASK = $1FFF0000
Macro SDL_WINDOWPOS_UNDEFINED_DISPLAY(X)
  (#SDL_WINDOWPOS_UNDEFINED_MASK | (X))
EndMacro
#SDL_WINDOWPOS_UNDEFINED      = SDL_WINDOWPOS_UNDEFINED_DISPLAY(0)
#SDL_WINDOWPOS_CENTERED_MASK  = $2FFF0000
Macro SDL_WINDOWPOS_CENTERED_DISPLAY(X)
  (#SDL_WINDOWPOS_CENTERED_MASK | (X))
EndMacro
#SDL_WINDOWPOS_CENTERED       = SDL_WINDOWPOS_CENTERED_DISPLAY(0)

;- - 2D Accelerated Rendering

Enumeration ; SDL_RENDERER_* SDL_RendererFlags for SDL_CreateRenderer()
  #SDL_RENDERER_SOFTWARE      = $00000001
  #SDL_RENDERER_ACCELERATED   = $00000002
  #SDL_RENDERER_PRESENTVSYNC  = $00000004
  #SDL_RENDERER_TARGETTEXTURE = $00000008
EndEnumeration

#SDL_ALPHA_TRANSPARENT = 0
#SDL_ALPHA_OPAQUE      = 255

;- - Event Handling

Enumeration ; SDL_EventType
  #SDL_FIRSTEVENT = 0
  
  #SDL_QUIT = $100
  #SDL_APP_TERMINATING
  #SDL_APP_LOWMEMORY
  #SDL_APP_WILLENTERBACKGROUND
  #SDL_APP_DIDENTERBACKGROUND
  #SDL_APP_WILLENTERFOREGROUND
  #SDL_APP_DIDENTERFOREGROUND
  #SDL_APP_LOCALECHANGED
  
  #SDL_DISPLAYEVENT = $150
  
  #SDL_WINDOWEVENT = $200
  #SDL_SYSWMEVENT
  
  #SDL_KEYDOWN = $300
  #SDL_KEYUP
  #SDL_TEXTEDITING
  #SDL_TEXTINPUT
  #SDL_KEYMAPCHANGED
  #SDL_TEXTEDITING_EXT
  
  #SDL_MOUSEMOTION = $400
  #SDL_MOUSEBUTTONDOWN
  #SDL_MOUSEBUTTONUP
  #SDL_MOUSEWHEEL
  
  ; ...
  
EndEnumeration

;- - Keyboard Support

Enumeration ; KMOD_* SDL_Keymod
  #KMOD_NONE   = $0000
  #KMOD_LSHIFT = $0001
  #KMOD_RSHIFT = $0002
  #KMOD_LCTRL  = $0040
  #KMOD_RCTRL  = $0080
  #KMOD_LALT   = $0100
  #KMOD_RALT   = $0200
  #KMOD_LGUI   = $0400
  #KMOD_RGUI   = $0800
  #KMOD_NUM    = $1000
  #KMOD_CAPS   = $2000
  #KMOD_MODE   = $4000
  #KMOD_SCROLL = $8000
  
  #KMOD_CTRL  = #KMOD_LCTRL  | #KMOD_RCTRL
  #KMOD_SHIFT = #KMOD_LSHIFT | #KMOD_RSHIFT
  #KMOD_ALT   = #KMOD_LALT   | #KMOD_RALT
  #KMOD_GUI   = #KMOD_LGUI   | #KMOD_RGUI
  
  #KMOD_RESERVED = #KMOD_SCROLL
EndEnumeration




;-
;- Helper Constants

#SDLx_INIT_SUCCESS = 0

#SDLx_WINDOW_DEFAULT = 0

#SDLx_RENDERER_SUCCESS = 0
#SDLx_RENDERERINDEX_DEFAULT = -1



;-
;- SDL2 Structures

Structure SDL_Keysym Align #PB_Structure_AlignC
  scancode.l ; SDL_Scancode (enum)
  sym.l ; SDL_Keycode (Sint32)
  mod.u
  unused.l
EndStructure

Structure SDL_KeyboardEvent Align #PB_Structure_AlignC
  type.l
  timestamp.l
  windowID.l
  state.a
  repeat_.a
  padding2.a
  padding3.a
  keysym.SDL_Keysym
EndStructure

Structure SDL_QuitEvent Align #PB_Structure_AlignC
  type.l
  timestamp.l
EndStructure

Structure SDL_CommonEvent Align #PB_Structure_AlignC
  type.l
  timestamp.l
EndStructure

Structure SDL_Event Align #PB_Structure_AlignC
  StructureUnion
    type.l
    
    common.SDL_CommonEvent
    ;display.SDL_DisplayEvent
    ;window.SDL_WindowEvent
    key.SDL_KeyboardEvent
    ;edit.SDL_TextEditingEvent
    ;editExt.SDL_TextEditingExtEvent
    ;text.SDL_TextInputEvent
    ;motion.SDL_MouseMotionEvent
    ;button.SDL_MouseButtonEvent
    ;wheel.SDL_MouseWheelEvent
    ; ...
    quit.SDL_QuitEvent
    ;user.SDL_UserEvent
    ;syswm.SDL_SysWMEvent
    ;tfinger.SDL_TouchFingerEvent
    ;mgesture.SDL_MultiGestureEvent
    ;dgesture.SDL_DollarGestureEvent
    ;drop.SDL_DropEvent
    
    padding.a[56] ; PB pointers never larger than 8 bytes
  EndStructureUnion
EndStructure

Structure SDL_Rect Align #PB_Structure_AlignC
  x.l
  y.l
  w.l
  h.l
EndStructure

Structure SDL_version Align #PB_Structure_AlignC
  major.a
  minor.a
  patch.a
EndStructure

Structure SDL_Renderer
  ;
EndStructure

Structure SDL_Window
  ;
EndStructure





;-
;- SDL2 Prototypes

;- - Querying SDL Version
PrototypeC   Proto_SDL_GetVersion(*ver.SDL_version)

;- - Initialization and Shutdown
PrototypeC.i Proto_SDL_Init(flags.l) ; returns 0 on success
PrototypeC.i Proto_SDL_InitSubSystem(flags.l) ; returns 0 on success
PrototypeC   Proto_SDL_Quit()
PrototypeC   Proto_SDL_QuitSubSystem(flags.l)

;- - Display and Window Management

PrototypeC.i Proto_SDL_CreateWindow(title.p-utf8, x.i, y.i, w.i, h.i, flags.i) ; returns *SDL_Window
PrototypeC   Proto_SDL_DestroyWindow(*window.SDL_Window)
PrototypeC   Proto_SDL_HideWindow(*window.SDL_Window)
PrototypeC   Proto_SDL_ShowWindow(*window.SDL_Window)

;- - 2D Accelerated Rendering

PrototypeC.i Proto_SDL_CreateRenderer(*window.SDL_Window, index.i, flags.l) ; returns *SDL_Renderer
PrototypeC   Proto_SDL_DestroyRenderer(*renderer.SDL_Renderer)
PrototypeC.i Proto_SDL_SetRenderDrawColor(*renderer.SDL_Renderer, r.a, g.a, b.a, a.a) ; returns 0 on success
PrototypeC.i Proto_SDL_RenderClear(*renderer.SDL_Renderer) ; returns 0 on success
PrototypeC.i Proto_SDL_RenderFillRect(*renderer.SDL_Renderer, *rect.SDL_Rect) ; returns 0 on success
PrototypeC   Proto_SDL_RenderPresent(*renderer.SDL_Renderer)

;- - Event Handling

PrototypeC.i Proto_SDL_PollEvent(*event.SDL_Event)









;-
;- PB Wrapper Variables

CompilerIf (#SDLx_DynamicLink)

Global __SDLxLib.i = #Null
Global __SDLx_Init.Proto_SDL_Init
Global __SDLx_Quit.Proto_SDL_Quit

;% DECLARE_DYNAMIC_PROTOTYPES

;% DELETESTART
Global SDL_GetVersion.Proto_SDL_GetVersion
Global SDL_SetRenderDrawColor.Proto_SDL_SetRenderDrawColor
;% DELETEEND

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
  Protected Result.i = -1
  
  If (__SDLxLib = #Null)
    __SDLxLib = OpenLibrary(#PB_Any, #SDLx_DynamicLibraryName)
    If (Not __SDLxLib)
      __SDLx_Debug("Failed to open SDL library '" + #SDLx_DynamicLibraryName + "'")
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
          Result = __SDLx_Init(flags)
          CompilerIf (#True)
            If (Result = #SDLx_INIT_SUCCESS)
              Protected LinkedVer.SDL_version
              SDL_GetVersion(@LinkedVer)
              If (LinkedVer\major = #SDL_MAJOR_VERSION)
                If (LinkedVer\minor < #SDL_MINOR_VERSION - 1)
                  Protected Message.s = "Warning: Dynamically linked SDL ("
                  Message + Str(LinkedVer\major) + "." + Str(LinkedVer\minor) + "." + Str(LinkedVer\patch)
                  Message + ") is older than SDLx compiled version ("
                  Message + Str(#SDL_MAJOR_VERSION) + "." + Str(#SDL_MINOR_VERSION) + "." + Str(#SDL_PATCHLEVEL) + ")"
                  __SDLx_Debug(Message)
                EndIf
              Else
                __SDLx_Debug("Dynamically linked SDL version (" + Str(LinkedVer\major) + ") does not match compiled SDLx version (" + Str(#SDL_MAJOR_VERSION) + ")!")
                SDL_Quit()
                Result = -1
              EndIf
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
  
  ProcedureReturn (Result)
EndProcedure

CompilerEndIf

;-
;- Helper Procedures

CompilerIf (#SDLx_IncludeHelperProcedures)

Procedure SDLx_SetRenderDrawColorValue(*renderer.SDL_Renderer, RGBAValue.i)
  SDL_SetRenderDrawColor(*renderer, Red(RGBAValue), Green(RGBAValue), Blue(RGBAValue), Alpha(RGBAValue))
EndProcedure

Procedure.s SDLx_CompiledVersionString()
  ProcedureReturn (Str(#SDL_MAJOR_VERSION) + "." + Str(#SDL_MINOR_VERSION) + "." + Str(#SDL_PATCHLEVEL))
EndProcedure

Procedure.s SDLx_GetVersionString()
  Protected Result.s = ""
  Protected ver.SDL_version
  SDL_GetVersion(@ver)
  If (ver\major > 0)
    Result = Str(ver\major) + "." + Str(ver\minor) + "." + Str(ver\patch)
  EndIf
  ProcedureReturn (Result)
EndProcedure

CompilerEndIf







;-
;- Main File Warning

CompilerIf (#PB_Compiler_IsMainFile)
  MessageRequester(#PB_Compiler_Filename, "This IncludeFile is not intended to be run by itself." + #LF$ + #LF$ + "See the 'tests' subfolder, or include this in your own project!", #PB_MessageRequester_Warning)
CompilerEndIf

CompilerEndIf
;-
