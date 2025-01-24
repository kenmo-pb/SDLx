; +----------+
; | SDL3.pbi |
; +----------+
; | 2024-09-24 : Creation (PureBasic 6.12)

; Warning: This file should not be directly modified!
; It was automatically generated from 'SDL3_Template.pbi' by 'SDLx_Build.pb'.
;
; Generated 2025-01-24 18:23:00 UTC

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
  Macro __SDLx_StructBool
    a ; use 8-bit PB Ascii for SDL struct bool members
  EndMacro
  Macro SDLx_Int
    l ; use 32-bit PB Long for SDL "int" args
  EndMacro
  Macro SDLx_Enum
    l ; use 32-bit PB Long for SDL enum args
  EndMacro
  Macro SDLx_Bool
    a ; use 8-bit PB Ascii for SDL bool args
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
  #SDL_INIT_AUDIO    = $00000010 ; implies SDL_INIT_EVENTS
  #SDL_INIT_VIDEO    = $00000020 ; implies SDL_INIT_EVENTS
  #SDL_INIT_JOYSTICK = $00000200 ; implies SDL_INIT_EVENTS
  #SDL_INIT_HAPTIC   = $00001000
  #SDL_INIT_GAMEPAD  = $00002000 ; implies SDL_INIT_JOYSTICK
  #SDL_INIT_EVENTS   = $00004000
  #SDL_INIT_SENSOR   = $00008000 ; implies SDL_INIT_EVENTS
  #SDL_INIT_CAMERA   = $00010000 ; implies SDL_INIT_EVENTS
EndEnumeration

Enumeration
  #SDL_FALSE = 0
  #SDL_TRUE  = 1
EndEnumeration

;- - Display and Window Management

Enumeration ; SDL_WindowFlags for SDL_CreateWindow()
  #SDL_WINDOW_FULLSCREEN          = $00000001
  #SDL_WINDOW_OPENGL              = $00000002
  #SDL_WINDOW_OCCLUDED            = $00000004
  #SDL_WINDOW_HIDDEN              = $00000008
  #SDL_WINDOW_BORDERLESS          = $00000010
  #SDL_WINDOW_RESIZABLE           = $00000020
  #SDL_WINDOW_MINIMIZED           = $00000040
  #SDL_WINDOW_MAXIMIZED           = $00000080
  #SDL_WINDOW_MOUSE_GRABBED       = $00000100
  #SDL_WINDOW_INPUT_FOCUS         = $00000200
  #SDL_WINDOW_MOUSE_FOCUS         = $00000400
  #SDL_WINDOW_EXTERNAL            = $00000800
  #SDL_WINDOW_MODAL               = $00001000
  #SDL_WINDOW_HIGH_PIXEL_DENSITY  = $00002000
  #SDL_WINDOW_MOUSE_CAPTURE       = $00004000
  #SDL_WINDOW_MOUSE_RELATIVE_MODE = $00008000
  #SDL_WINDOW_ALWAYS_ON_TOP       = $00010000
  #SDL_WINDOW_UTILITY             = $00020000
  #SDL_WINDOW_TOOLTIP             = $00040000
  #SDL_WINDOW_POPUP_MENU          = $00080000
  #SDL_WINDOW_KEYBOARD_GRABBED    = $00100000
  #SDL_WINDOW_VULKAN              = $01000000
  #SDL_WINDOW_METAL               = $02000000
  #SDL_WINDOW_TRANSPARENT         = $04000000
  #SDL_WINDOW_NOT_FOCUSABLE       = $08000000
EndEnumeration

;- - 2D Accelerated Rendering

Enumeration ; SDL_RendererLogicalPresentation
  #SDL_LOGICAL_PRESENTATION_DISABLED
  #SDL_LOGICAL_PRESENTATION_STRETCH
  #SDL_LOGICAL_PRESENTATION_LETTERBOX
  #SDL_LOGICAL_PRESENTATION_OVERSCAN
  #SDL_LOGICAL_PRESENTATION_INTEGER_SCALE
EndEnumeration

#SDL_ALPHA_TRANSPARENT = 0
#SDL_ALPHA_OPAQUE      = 255

;- - Event Handling

Enumeration ; SDL_EventType
  #SDL_EVENT_FIRST = 0
  
  #SDL_EVENT_QUIT = $100
  
  ; ...
  
  #SDL_EVENT_KEY_DOWN = $300
  #SDL_EVENT_KEY_UP
  #SDL_EVENT_TEXT_EDITING
  #SDL_EVENT_TEXT_INPUT
  #SDL_EVENT_KEYMAP_CHANGED
  #SDL_EVENT_KEYBOARD_ADDED
  #SDL_EVENT_KEYBOARD_REMOVED
  #SDL_EVENT_TEXT_EDITING_CANDIDATES
  
  #SDL_EVENT_MOUSE_MOTION = $400
  #SDL_EVENT_MOUSE_BUTTON_DOWN
  #SDL_EVENT_MOUSE_BUTTON_UP
  #SDL_EVENT_MOUSE_WHEEL
  #SDL_EVENT_MOUSE_ADDED
  #SDL_EVENT_MOUSE_REMOVED
  
  ; ...
  
  #SDL_EVENT_USER = $8000
  
  #SDL_EVENT_LAST = $FFFF
  
  #SDL_EVENT_ENUM_PADDING = $7FFFFFFF
EndEnumeration

Enumeration ; SDL_EventAction
  #SDL_ADDEVENT
  #SDL_PEEKEVENT
  #SDL_GETEVENT
EndEnumeration

;- - Keyboard Support

Enumeration ; SDL_Scancode
  #SDL_SCANCODE_UNKNOWN = 0
  
  #SDL_SCANCODE_A = 4
  #SDL_SCANCODE_B = 5
  #SDL_SCANCODE_C = 6
  #SDL_SCANCODE_D = 7
  #SDL_SCANCODE_E = 8
  #SDL_SCANCODE_F = 9
  #SDL_SCANCODE_G = 10
  #SDL_SCANCODE_H = 11
  #SDL_SCANCODE_I = 12
  #SDL_SCANCODE_J = 13
  #SDL_SCANCODE_K = 14
  #SDL_SCANCODE_L = 15
  #SDL_SCANCODE_M = 16
  #SDL_SCANCODE_N = 17
  #SDL_SCANCODE_O = 18
  #SDL_SCANCODE_P = 19
  #SDL_SCANCODE_Q = 20
  #SDL_SCANCODE_R = 21
  #SDL_SCANCODE_S = 22
  #SDL_SCANCODE_T = 23
  #SDL_SCANCODE_U = 24
  #SDL_SCANCODE_V = 25
  #SDL_SCANCODE_W = 26
  #SDL_SCANCODE_X = 27
  #SDL_SCANCODE_Y = 28
  #SDL_SCANCODE_Z = 29
  
  #SDL_SCANCODE_1 = 30
  #SDL_SCANCODE_2 = 31
  #SDL_SCANCODE_3 = 32
  #SDL_SCANCODE_4 = 33
  #SDL_SCANCODE_5 = 34
  #SDL_SCANCODE_6 = 35
  #SDL_SCANCODE_7 = 36
  #SDL_SCANCODE_8 = 37
  #SDL_SCANCODE_9 = 38
  #SDL_SCANCODE_0 = 39
  
  #SDL_SCANCODE_RETURN    = 40
  #SDL_SCANCODE_ESCAPE    = 41
  #SDL_SCANCODE_BACKSPACE = 42
  #SDL_SCANCODE_TAB       = 43
  #SDL_SCANCODE_SPACE     = 44
  
  #SDL_SCANCODE_MINUS        = 45
  #SDL_SCANCODE_EQUALS       = 46
  #SDL_SCANCODE_LEFTBRACKET  = 47
  #SDL_SCANCODE_RIGHTBRACKET = 48
  #SDL_SCANCODE_BACKSLASH    = 49
  #SDL_SCANCODE_NONUSHASH    = 50
  #SDL_SCANCODE_SEMICOLON    = 51
  #SDL_SCANCODE_APOSTROPHE   = 52
  #SDL_SCANCODE_GRAVE        = 53
  #SDL_SCANCODE_COMMA        = 54
  #SDL_SCANCODE_PERIOD       = 55
  #SDL_SCANCODE_SLASH        = 56
  
  #SDL_SCANCODE_CAPSLOCK = 57
  
  #SDL_SCANCODE_F1 = 58
  #SDL_SCANCODE_F2 = 59
  #SDL_SCANCODE_F3 = 60
  #SDL_SCANCODE_F4 = 61
  #SDL_SCANCODE_F5 = 62
  #SDL_SCANCODE_F6 = 63
  #SDL_SCANCODE_F7 = 64
  #SDL_SCANCODE_F8 = 65
  #SDL_SCANCODE_F9 = 66
  #SDL_SCANCODE_F10 = 67
  #SDL_SCANCODE_F11 = 68
  #SDL_SCANCODE_F12 = 69
  
  #SDL_SCANCODE_PRINTSCREEN = 70
  #SDL_SCANCODE_SCROLLLOCK  = 71
  #SDL_SCANCODE_PAUSE       = 72
  #SDL_SCANCODE_INSERT      = 73
  
  #SDL_SCANCODE_HOME     = 74
  #SDL_SCANCODE_PAGEUP   = 75
  #SDL_SCANCODE_DELETE   = 76
  #SDL_SCANCODE_END      = 77
  #SDL_SCANCODE_PAGEDOWN = 78
  #SDL_SCANCODE_RIGHT    = 79
  #SDL_SCANCODE_LEFT     = 80
  #SDL_SCANCODE_DOWN     = 81
  #SDL_SCANCODE_UP       = 82
  
  ; ...
  
  #SDL_SCANCODE_LCTRL  = 224
  #SDL_SCANCODE_LSHIFT = 225
  #SDL_SCANCODE_LALT   = 226
  #SDL_SCANCODE_LGUI   = 227
  #SDL_SCANCODE_RCTRL  = 228
  #SDL_SCANCODE_RSHIFT = 229
  #SDL_SCANCODE_RALT   = 230
  #SDL_SCANCODE_RGUI   = 231
  
  ; ...
  
  #SDL_SCANCODE_RESERVED = 400
  
  #SDL_SCANCODE_COUNT = 512
  
EndEnumeration

Enumeration ; SDL_Keymod
  #SDL_KMOD_NONE   = $0000
  #SDL_KMOD_LSHIFT = $0001
  #SDL_KMOD_RSHIFT = $0002
  #SDL_KMOD_LEVEL5 = $0004
  #SDL_KMOD_LCTRL  = $0040
  #SDL_KMOD_RCTRL  = $0080
  #SDL_KMOD_LALT   = $0100
  #SDL_KMOD_RALT   = $0200
  #SDL_KMOD_LGUI   = $0400
  #SDL_KMOD_RGUI   = $0800
  #SDL_KMOD_NUM    = $1000
  #SDL_KMOD_CAPS   = $2000
  #SDL_KMOD_MODE   = $4000
  #SDL_KMOD_SCROLL = $8000
  
  #SDL_KMOD_CTRL  = #SDL_KMOD_LCTRL  | #SDL_KMOD_RCTRL
  #SDL_KMOD_SHIFT = #SDL_KMOD_LSHIFT | #SDL_KMOD_RSHIFT
  #SDL_KMOD_ALT   = #SDL_KMOD_LALT   | #SDL_KMOD_RALT
  #SDL_KMOD_GUI   = #SDL_KMOD_LGUI   | #SDL_KMOD_RGUI
  
EndEnumeration

;- - Mouse Support

#SDL_BUTTON_LEFT   = 1
#SDL_BUTTON_MIDDLE = 2
#SDL_BUTTON_RIGHT  = 3
#SDL_BUTTON_X1     = 4
#SDL_BUTTON_X2     = 5

Macro SDL_BUTTON_MASK(X)
  (1 << ((X)-1))
EndMacro
#SDL_BUTTON_LMASK  = SDL_BUTTON_MASK(#SDL_BUTTON_LEFT)
#SDL_BUTTON_MMASK  = SDL_BUTTON_MASK(#SDL_BUTTON_MIDDLE)
#SDL_BUTTON_RMASK  = SDL_BUTTON_MASK(#SDL_BUTTON_RIGHT)
#SDL_BUTTON_X1MASK = SDL_BUTTON_MASK(#SDL_BUTTON_X1)
#SDL_BUTTON_X2MASK = SDL_BUTTON_MASK(#SDL_BUTTON_X2)

Enumeration ; SDL_MouseWheelDirection
  #SDL_MOUSEWHEEL_NORMAL
  #SDL_MOUSEWHEEL_FLIPPED
EndEnumeration





;-
;- Helper Constants



;-
;- SDL3 Structures

Structure SDL_CommonEvent Align #PB_Structure_AlignC
  type.l ; SDL_EventType
  reserved.l
  timestamp.q
EndStructure

Structure SDL_KeyboardEvent Align #PB_Structure_AlignC
  type.l
  reserved.l
  timestamp.q
  
  windowID.l ; SDL_WindowID
  which.l ; SDL_KeyboardID
  scancode.l ; SDL_Scancode
  key.l ; SDL_Keycode
  mod.u ; SDL_Keymod
  raw.u
  down.__SDLx_StructBool ; bool
  repeat_.__SDLx_StructBool ; bool
EndStructure

Structure SDL_MouseMotionEvent Align #PB_Structure_AlignC
  type.l
  reserved.l
  timestamp.q
  
  windowID.l ; SDL_WindowID
  which.l ; SDL_MouseID
  state.l ; SDL_MouseButtonFlags
  x.f
  y.f
  xrel.f
  yrel.f
EndStructure

Structure SDL_MouseWheelEvent Align #PB_Structure_AlignC
  type.l
  reserved.l
  timestamp.q
  
  windowID.l ; SDL_WindowID
  which.l ; SDL_MouseID
  x.f
  y.f
  direction.__SDLx_StructEnum ; SDL_MouseWheelDirection
  mouse_x.f
  mouse_y.f
EndStructure

Structure SDL_Event Align #PB_Structure_AlignC
  StructureUnion
    type.l
    
    common.SDL_CommonEvent
    ;display.SDL_DisplayEvent
    ;window.SDL_WindowEvent
    ;kdevice.SDL_KeyboardDeviceEvent
    key.SDL_KeyboardEvent
    ;edit.SDL_TextEditingEvent
    ;edit_candidates.SDL_TextEditingCandidatesEvent
    ;text.SDL_TextInputEvent
    ;mdevice.SDL_MouseDeviceEvent
    motion.SDL_MouseMotionEvent
    ;button.SDL_MouseButtonEvent
    wheel.SDL_MouseWheelEvent
    ; ...
    ;quit.SDL_QuitEvent
    ; ...
    
    padding.a[128]
  EndStructureUnion
EndStructure

Structure SDL_Rect Align #PB_Structure_AlignC
  x.__SDLx_StructInt
  y.__SDLx_StructInt
  w.__SDLx_StructInt
  h.__SDLx_StructInt
EndStructure

Structure SDL_FRect Align #PB_Structure_AlignC
  x.f
  y.f
  w.f
  h.f
EndStructure

Structure SDL_Renderer
  ;
EndStructure

Structure SDL_Window
  ;
EndStructure





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
PrototypeC.i Proto_SDL_CreateWindow(title.p-utf8, w.SDLx_Int, h.SDLx_Int, flags.q) ; flags now 64-bit
PrototypeC   Proto_SDL_DestroyWindow(*window.SDL_Window)
PrototypeC   Proto_SDL_HideWindow(*window.SDL_Window)
PrototypeC.i Proto_SDL_SetWindowFullscreen(*window.SDL_Window, fullscreen.SDLx_Bool)
PrototypeC   Proto_SDL_ShowWindow(*window.SDL_Window)

;- - 2D Accelerated Rendering
PrototypeC.i Proto_SDL_CreateRenderer(*window.SDL_Window, *name)
PrototypeC   Proto_SDL_DestroyRenderer(*renderer.SDL_Renderer)
PrototypeC.i Proto_SDL_RenderClear(*renderer.SDL_Renderer)
PrototypeC.i Proto_SDL_RenderFillRect(*renderer.SDL_Renderer, *rect.SDL_FRect) ; now expects a FLOAT rect
PrototypeC.i Proto_SDL_RenderPresent(*renderer.SDL_Renderer)
PrototypeC.i Proto_SDL_SetRenderDrawColor(*renderer.SDL_Renderer, r.a, g.a, b.a, a.a)
PrototypeC.i Proto_SDL_SetRenderLogicalPresentation(*renderer.SDL_Renderer, w.SDLx_Int, h.SDLx_Int, mode.SDLx_Enum)

;- - Event Handling
PrototypeC.i Proto_SDL_PeepEvents(*event.SDL_Event, numevents.SDLx_Int, action.SDLx_Enum, minType.l, maxType.l)
PrototypeC.i Proto_SDL_PollEvent(*event.SDL_Event)
PrototypeC   Proto_SDL_PumpEvents()
PrototypeC.i Proto_SDL_PushEvent(*event.SDL_Event)

;- - Keyboard Support
PrototypeC.i Proto_SDL_GetKeyboardState(*numkeys.LONG)

;- - Mouse Support
PrototypeC.l Proto_SDL_GetMouseState(*x.FLOAT, *y.FLOAT)
PrototypeC.i Proto_SDL_HideCursor()
PrototypeC.i Proto_SDL_ShowCursor()







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
Global SDL_CreateWindow.Proto_SDL_CreateWindow
Global SDL_DestroyWindow.Proto_SDL_DestroyWindow
Global SDL_HideWindow.Proto_SDL_HideWindow
Global SDL_SetWindowFullscreen.Proto_SDL_SetWindowFullscreen
Global SDL_ShowWindow.Proto_SDL_ShowWindow
Global SDL_CreateRenderer.Proto_SDL_CreateRenderer
Global SDL_DestroyRenderer.Proto_SDL_DestroyRenderer
Global SDL_RenderClear.Proto_SDL_RenderClear
Global SDL_RenderFillRect.Proto_SDL_RenderFillRect
Global SDL_RenderPresent.Proto_SDL_RenderPresent
Global SDL_SetRenderDrawColor.Proto_SDL_SetRenderDrawColor
Global SDL_SetRenderLogicalPresentation.Proto_SDL_SetRenderLogicalPresentation
Global SDL_PeepEvents.Proto_SDL_PeepEvents
Global SDL_PollEvent.Proto_SDL_PollEvent
Global SDL_PumpEvents.Proto_SDL_PumpEvents
Global SDL_PushEvent.Proto_SDL_PushEvent
Global SDL_GetKeyboardState.Proto_SDL_GetKeyboardState
Global SDL_GetMouseState.Proto_SDL_GetMouseState
Global SDL_HideCursor.Proto_SDL_HideCursor
Global SDL_ShowCursor.Proto_SDL_ShowCursor



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
  SDL_CreateWindow.i(title.p-utf8, w.SDLx_Int, h.SDLx_Int, flags.q)
  SDL_DestroyWindow(*window.SDL_Window)
  SDL_HideWindow(*window.SDL_Window)
  SDL_SetWindowFullscreen.i(*window.SDL_Window, fullscreen.SDLx_Bool)
  SDL_ShowWindow(*window.SDL_Window)
  SDL_CreateRenderer.i(*window.SDL_Window, *name)
  SDL_DestroyRenderer(*renderer.SDL_Renderer)
  SDL_RenderClear.i(*renderer.SDL_Renderer)
  SDL_RenderFillRect.i(*renderer.SDL_Renderer, *rect.SDL_FRect)
  SDL_RenderPresent.i(*renderer.SDL_Renderer)
  SDL_SetRenderDrawColor.i(*renderer.SDL_Renderer, r.a, g.a, b.a, a.a)
  SDL_SetRenderLogicalPresentation.i(*renderer.SDL_Renderer, w.SDLx_Int, h.SDLx_Int, mode.SDLx_Enum)
  SDL_PeepEvents.i(*event.SDL_Event, numevents.SDLx_Int, action.SDLx_Enum, minType.l, maxType.l)
  SDL_PollEvent.i(*event.SDL_Event)
  SDL_PumpEvents()
  SDL_PushEvent.i(*event.SDL_Event)
  SDL_GetKeyboardState.i(*numkeys.LONG)
  SDL_GetMouseState.l(*x.FLOAT, *y.FLOAT)
  SDL_HideCursor.i()
  SDL_ShowCursor.i()

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
        SDL_CreateWindow = GetFunction(__SDLxLib, "SDL_CreateWindow")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_CreateWindow = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_CreateWindow'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_DestroyWindow = GetFunction(__SDLxLib, "SDL_DestroyWindow")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_DestroyWindow = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_DestroyWindow'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_HideWindow = GetFunction(__SDLxLib, "SDL_HideWindow")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_HideWindow = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_HideWindow'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_SetWindowFullscreen = GetFunction(__SDLxLib, "SDL_SetWindowFullscreen")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_SetWindowFullscreen = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_SetWindowFullscreen'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_ShowWindow = GetFunction(__SDLxLib, "SDL_ShowWindow")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_ShowWindow = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_ShowWindow'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_CreateRenderer = GetFunction(__SDLxLib, "SDL_CreateRenderer")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_CreateRenderer = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_CreateRenderer'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_DestroyRenderer = GetFunction(__SDLxLib, "SDL_DestroyRenderer")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_DestroyRenderer = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_DestroyRenderer'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_RenderClear = GetFunction(__SDLxLib, "SDL_RenderClear")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_RenderClear = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_RenderClear'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_RenderFillRect = GetFunction(__SDLxLib, "SDL_RenderFillRect")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_RenderFillRect = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_RenderFillRect'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_RenderPresent = GetFunction(__SDLxLib, "SDL_RenderPresent")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_RenderPresent = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_RenderPresent'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_SetRenderDrawColor = GetFunction(__SDLxLib, "SDL_SetRenderDrawColor")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_SetRenderDrawColor = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_SetRenderDrawColor'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_SetRenderLogicalPresentation = GetFunction(__SDLxLib, "SDL_SetRenderLogicalPresentation")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_SetRenderLogicalPresentation = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_SetRenderLogicalPresentation'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_PeepEvents = GetFunction(__SDLxLib, "SDL_PeepEvents")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_PeepEvents = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_PeepEvents'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_PollEvent = GetFunction(__SDLxLib, "SDL_PollEvent")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_PollEvent = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_PollEvent'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_PumpEvents = GetFunction(__SDLxLib, "SDL_PumpEvents")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_PumpEvents = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_PumpEvents'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_PushEvent = GetFunction(__SDLxLib, "SDL_PushEvent")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_PushEvent = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_PushEvent'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_GetKeyboardState = GetFunction(__SDLxLib, "SDL_GetKeyboardState")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_GetKeyboardState = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_GetKeyboardState'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_GetMouseState = GetFunction(__SDLxLib, "SDL_GetMouseState")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_GetMouseState = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_GetMouseState'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_HideCursor = GetFunction(__SDLxLib, "SDL_HideCursor")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_HideCursor = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_HideCursor'")
            LoadFailed = #SDLx_RequireAllFunctionLoads
          EndIf
        CompilerEndIf
        SDL_ShowCursor = GetFunction(__SDLxLib, "SDL_ShowCursor")
        CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)
          If (SDL_ShowCursor = #Null)
            __SDLx_Debug("Failed to load SDL library function: 'SDL_ShowCursor'")
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

CompilerIf (#True)

Structure SDLx_KeyboardStateArray
  ks.__SDLx_StructBool[0]
EndStructure

CompilerEndIf

;-
;- Helper Procedures

CompilerIf (#SDLx_IncludeHelperProcedures)

Procedure.i SDLx_QuitRequested()
  ; SDL2 SDL_QuitRequested() C macro was officially removed in SDL3
  SDL_PumpEvents()
  ProcedureReturn (Bool(SDL_PeepEvents(#Null, 0, #SDL_PEEKEVENT, #SDL_EVENT_QUIT, #SDL_EVENT_QUIT) > 0))
EndProcedure

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
