﻿;%===================================================================================%
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
;- SDL2 Library Files

#SDLx_LibName = "SDL2"

#SDLx_IncludeFilename = #PB_Compiler_Filename

CompilerSelect (#PB_Compiler_OS)
  CompilerCase #PB_OS_Windows
    CompilerIf (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant))
      #SDLx_DynamicLibraryDefaultName = "SDL2.dll"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_StaticLibraryName, #PB_Constant))
      #SDLx_StaticLibraryName = "SDL2.lib"
    CompilerEndIf
    
  CompilerCase #PB_OS_Linux
    CompilerIf (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant))
      #SDLx_DynamicLibraryDefaultName = "libSDL2.so"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_StaticLibraryName, #PB_Constant))
      ;#SDLx_StaticLibraryName = ""
    CompilerEndIf
    
  CompilerCase #PB_OS_MacOS
    CompilerIf (Not Defined(SDLx_DynamicLibraryDefaultName, #PB_Constant))
      ;#SDLx_DynamicLibraryDefaultName = ""
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_StaticLibraryName, #PB_Constant))
      #SDLx_StaticLibraryName = "Frameworks/SDL2.framework/SDL2"
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

Enumeration ; SDL_bool
  #SDL_FALSE = 0
  #SDL_TRUE  = 1
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

Enumeration ; SDL_TextureAccess
  #SDL_TEXTUREACCESS_STATIC
  #SDL_TEXTUREACCESS_STREAMING
  #SDL_TEXTUREACCESS_TARGET
EndEnumeration

Macro SDL_DEFINE_PIXELFORMAT(type, order, layout, bits, bytes)
  ((1 << 28) | ((type) << 24) | ((order) << 20) | ((layout) << 16) | ((bits) << 8) | ((bytes) << 0))
EndMacro

Enumeration ; SDL_PixelType
  #SDL_PIXELTYPE_UNKNOWN
  #SDL_PIXELTYPE_INDEX1
  #SDL_PIXELTYPE_INDEX4
  #SDL_PIXELTYPE_INDEX8
  #SDL_PIXELTYPE_PACKED8
  #SDL_PIXELTYPE_PACKED16
  #SDL_PIXELTYPE_PACKED32
  #SDL_PIXELTYPE_ARRAYU8
  #SDL_PIXELTYPE_ARRAYU16
  #SDL_PIXELTYPE_ARRAYU32
  #SDL_PIXELTYPE_ARRAYF16
  #SDL_PIXELTYPE_ARRAYF32
  #SDL_PIXELTYPE_INDEX2
EndEnumeration

Enumeration ; SDL_PackedOrder
  #SDL_PACKEDORDER_NONE
  #SDL_PACKEDORDER_XRGB
  #SDL_PACKEDORDER_RGBX
  #SDL_PACKEDORDER_ARGB
  #SDL_PACKEDORDER_RGBA
  #SDL_PACKEDORDER_XBGR
  #SDL_PACKEDORDER_BGRX
  #SDL_PACKEDORDER_ABGR
  #SDL_PACKEDORDER_BGRA
EndEnumeration

Enumeration ; SDL_PackedLayout
  #SDL_PACKEDLAYOUT_NONE
  #SDL_PACKEDLAYOUT_332
  #SDL_PACKEDLAYOUT_4444
  #SDL_PACKEDLAYOUT_1555
  #SDL_PACKEDLAYOUT_5551
  #SDL_PACKEDLAYOUT_565
  #SDL_PACKEDLAYOUT_8888
  #SDL_PACKEDLAYOUT_2101010
  #SDL_PACKEDLAYOUT_1010102
EndEnumeration

Enumeration ; SDL_PixelFormatEnum
  ; ...
  
  ;#SDL_PIXELFORMAT_ARGB8888 = SDL_DEFINE_PIXELFORMAT(#SDL_PIXELTYPE_PACKED32, #SDL_PACKEDORDER_ARGB, #SDL_PACKEDLAYOUT_8888, 32, 4)
  #SDL_PIXELFORMAT_ABGR8888 = SDL_DEFINE_PIXELFORMAT(#SDL_PIXELTYPE_PACKED32, #SDL_PACKEDORDER_ABGR, #SDL_PACKEDLAYOUT_8888, 32, 4)
  
  ; ...
  
  CompilerIf (#False) ; Big-Endian systems
    ; ...
  CompilerElse ; Little-Endian systems (always true for PureBasic?)
    #SDL_PIXELFORMAT_RGBA32 = #SDL_PIXELFORMAT_ABGR8888
    ; ...
  CompilerEndIf
  
  ; ...
EndEnumeration

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
  
  #SDL_LASTEVENT = $FFFF
EndEnumeration

Enumeration ; SDL_eventaction
  #SDL_ADDEVENT
  #SDL_PEEKEVENT
  #SDL_GETEVENT
EndEnumeration

#SDL_RELEASED = 0
#SDL_PRESSED  = 1

#SDL_QUERY   = -1
#SDL_IGNORE  = 0
#SDL_DISABLE = 0
#SDL_ENABLE  = 1

;- - Keyboard Support

Enumeration ; SDL_SCANCODE_* SDL_Scancode
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
  
EndEnumeration

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

;- - Mouse Support

#SDL_BUTTON_LEFT   = 1
#SDL_BUTTON_MIDDLE = 2
#SDL_BUTTON_RIGHT  = 3
#SDL_BUTTON_X1     = 4
#SDL_BUTTON_X2     = 5

Macro SDL_BUTTON(X)
  (1 << ((X)-1))
EndMacro
#SDL_BUTTON_LMASK  = SDL_BUTTON(#SDL_BUTTON_LEFT)
#SDL_BUTTON_MMASK  = SDL_BUTTON(#SDL_BUTTON_MIDDLE)
#SDL_BUTTON_RMASK  = SDL_BUTTON(#SDL_BUTTON_RIGHT)
#SDL_BUTTON_X1MASK = SDL_BUTTON(#SDL_BUTTON_X1)
#SDL_BUTTON_X2MASK = SDL_BUTTON(#SDL_BUTTON_X2)

;- - Message Boxes

Enumeration ; SDL_MESSAGEBOX_* SDL_MessageBoxFlags
  #SDL_MESSAGEBOX_ERROR                 = $00000010
  #SDL_MESSAGEBOX_WARNING               = $00000020
  #SDL_MESSAGEBOX_INFORMATION           = $00000040
  #SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = $00000080
  #SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = $00000100
EndEnumeration

Enumeration ; SDL_MessageBoxButtonFlags
  #SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = $00000001
  #SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = $00000002
EndEnumeration

Enumeration ; SDL_MessageBoxColorType
  #SDL_MESSAGEBOX_COLOR_BACKGROUND
  #SDL_MESSAGEBOX_COLOR_TEXT
  #SDL_MESSAGEBOX_COLOR_BUTTON_BORDER
  #SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND
  #SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED
  #SDL_MESSAGEBOX_COLOR_MAX
EndEnumeration




;-
;- Helper Constants

#SDLx_INIT_SUCCESS = 0

#SDLx_WINDOW_DEFAULT = 0

#SDLx_WINDOW_NOT_FULLSCREEN = 0

#SDLx_RENDERER_SUCCESS = 0
#SDLx_RENDERERINDEX_DEFAULT = -1



;-
;- SDL2 Structures

Structure SDL_Keysym Align #PB_Structure_AlignC
  scancode.__SDLx_StructEnum ; SDL_Scancode (enum)
  sym.l ; SDL_Keycode (typedef Sint32)
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

Structure SDL_MouseMotionEvent Align #PB_Structure_AlignC
  type.l
  timestamp.l
  windowID.l
  which.l
  state.l
  x.l
  y.l
  xrel.l
  yrel.l
EndStructure

Structure SDL_MouseWheelEvent Align #PB_Structure_AlignC
  type.l
  timestamp.l
  windowID.l
  which.l
  x.l
  y.l
  direction.l
  preciseX.f
  preciseY.f
  mouseX.l
  mouseY.l
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
    motion.SDL_MouseMotionEvent
    ;button.SDL_MouseButtonEvent
    wheel.SDL_MouseWheelEvent
    ; ...
    quit.SDL_QuitEvent
    ;user.SDL_UserEvent
    ;syswm.SDL_SysWMEvent
    ;tfinger.SDL_TouchFingerEvent
    ;mgesture.SDL_MultiGestureEvent
    ;dgesture.SDL_DollarGestureEvent
    ;drop.SDL_DropEvent
    
    padding.a[56] ; PB pointers never larger than 8 bytes, so use this padding per SDL_events.h
  EndStructureUnion
EndStructure

Structure SDL_Rect Align #PB_Structure_AlignC
  x.__SDLx_StructInt
  y.__SDLx_StructInt
  w.__SDLx_StructInt
  h.__SDLx_StructInt
EndStructure

Structure SDL_version Align #PB_Structure_AlignC
  major.a
  minor.a
  patch.a
EndStructure

Structure SDL_Surface Align #PB_Structure_AlignC
  flags.l
  *format.SDL_PixelFormat
  w.__SDLx_StructInt
  h.__SDLx_StructInt
  pitch.__SDLx_StructInt
  *pixels
  *userdata
  locked.__SDLx_StructInt
  *list_blitmap
  clip_rect.SDL_Rect
  *map.SDL_BlitMap
  refcount.__SDLx_StructInt
EndStructure

Structure SDL_MessageBoxButtonData Align #PB_Structure_AlignC
  flags.l
  buttonid.__SDLx_StructInt
  *text
EndStructure

Structure SDL_MessageBoxColor Align #PB_Structure_AlignC
  r.a
  g.a
  b.a
EndStructure

Structure SDL_MessageBoxColorScheme Align #PB_Structure_AlignC
  colors.SDL_MessageBoxColor[#SDL_MESSAGEBOX_COLOR_MAX]
EndStructure

Structure SDL_MessageBoxData Align #PB_Structure_AlignC
  flags.l
  *window.SDL_Window
  *title
  *message
  numbuttons.__SDLx_StructInt
  *buttons.SDL_MessageBoxButtonData
  *colorScheme.SDL_MessageBoxColorScheme
EndStructure

Structure SDL_Renderer
  ;
EndStructure

Structure SDL_RWops
  ;
EndStructure

Structure SDL_Texture
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
PrototypeC.i Proto_SDL_CreateWindow(title.p-utf8, x.SDLx_Int, y.SDLx_Int, w.SDLx_Int, h.SDLx_Int, flags.l) ; returns *SDL_Window
PrototypeC   Proto_SDL_DestroyWindow(*window.SDL_Window)
PrototypeC   Proto_SDL_HideWindow(*window.SDL_Window)
PrototypeC.l Proto_SDL_SetWindowFullscreen(*window.SDL_Window, flags.l) ; returns 0 on success
PrototypeC   Proto_SDL_ShowWindow(*window.SDL_Window)

;- - 2D Accelerated Rendering
PrototypeC.i Proto_SDL_CreateRenderer(*window.SDL_Window, index.SDLx_Int, flags.l) ; returns *SDL_Renderer
PrototypeC.i Proto_SDL_CreateTexture(*renderer.SDL_Renderer, format.l, access.SDLx_Int, w.SDLx_Int, h.SDLx_Int) ; returns *SDL_Texture
PrototypeC.i Proto_SDL_CreateTextureFromSurface(*renderer.SDL_Renderer, *surface.SDL_Surface) ; returns *SDL_Texture
PrototypeC   Proto_SDL_DestroyRenderer(*renderer.SDL_Renderer)
PrototypeC   Proto_SDL_DestroyTexture(*texture.SDL_Texture)
PrototypeC.l Proto_SDL_LockTexture(*texture.SDL_Texture, *rect.SDL_Rect, *pixelsPtr, *pitch.LONG)
PrototypeC.l Proto_SDL_SetRenderDrawColor(*renderer.SDL_Renderer, r.a, g.a, b.a, a.a) ; returns 0 on success
PrototypeC.l Proto_SDL_RenderClear(*renderer.SDL_Renderer) ; returns 0 on success
PrototypeC.l Proto_SDL_RenderCopy(*renderer.SDL_Renderer, *texture.SDL_Texture, *srcrect.SDL_Rect, *destrect.SDL_Rect) ; returns 0 on success
PrototypeC.l Proto_SDL_RenderFillRect(*renderer.SDL_Renderer, *rect.SDL_Rect) ; returns 0 on success
PrototypeC   Proto_SDL_RenderPresent(*renderer.SDL_Renderer)
PrototypeC.l Proto_SDL_RenderSetLogicalSize(*renderer.SDL_Renderer, w.SDLx_Int, h.SDLx_Int) ; returns 0 on success
PrototypeC   Proto_SDL_UnlockTexture(*texture.SDL_Texture)

;- - Surface Creation and Simple Drawing
PrototypeC   Proto_SDL_FreeSurface(*surface.SDL_Surface)
PrototypeC.i Proto_SDL_LoadBMP_RW(*src.SDL_RWops, freesrc.SDLx_Int) ; returns *SDL_Surface

;- - Event Handling
PrototypeC.l Proto_SDL_PeepEvents(*events.SDL_Event, numevents.SDLx_Int, action.SDLx_Enum, minType.l, maxType.l) ; returns number of events
PrototypeC.l Proto_SDL_PollEvent(*event.SDL_Event) ; returns 1 on success
PrototypeC   Proto_SDL_PumpEvents()
PrototypeC.l Proto_SDL_PushEvent(*event.SDL_Event)

;- - Keyboard Support
PrototypeC.i Proto_SDL_GetKeyboardState(*numkeys.LONG) ; returns pointer to Uint8 array

;- - Mouse Support
PrototypeC.l Proto_SDL_GetMouseState(*x.LONG, *y.LONG) ; returns Uint32 buttons bitmask
PrototypeC.l Proto_SDL_ShowCursor(toggle.SDLx_Int)

;- - File I/O Abstraction
PrototypeC.i Proto_SDL_RWFromFile(file.p-utf8, mode.p-utf8) ; returns *SDL_RWops

;- - Message Boxes
PrototypeC.l Proto_SDL_ShowMessageBox(*messageboxdata.SDL_MessageBoxData, *buttonid.LONG) ; returns 0 on success
PrototypeC.l Proto_SDL_ShowSimpleMessageBox(flags.l, title.p-utf8, message.p-utf8, *window.SDL_Window) ; returns 0 on success









;-
;- PB Wrapper Variables

CompilerIf (#SDLx_DynamicLink)

Global __SDLx_DynamicLibPath.s

Global __SDLxLib.i = #Null
Global __SDLx_Init.Proto_SDL_Init
Global __SDLx_Quit.Proto_SDL_Quit

;% DECLARE_DYNAMIC_PROTOTYPES

;% DELETESTART
Global SDL_GetVersion.Proto_SDL_GetVersion
Global SDL_PeepEvents.Proto_SDL_PeepEvents
Global SDL_PumpEvents.Proto_SDL_PumpEvents
Global SDL_SetRenderDrawColor.Proto_SDL_SetRenderDrawColor
;% DELETEEND

CompilerEndIf

;-
;- Static Imports

CompilerIf (#SDLx_StaticLink)

ImportC #SDLx_StaticLibraryName
  
;% INDENT=1
;% STATIC_IMPORTS
;% INDENT=0
EndImport

CompilerEndIf




;-
;- PB Wrapper Procedures

Procedure.i SDL_QuitRequested()
  ; This is actually a C macro in SDL_quit.h, but it calls multiple functions so it is better as a procedure in PB
  SDL_PumpEvents()
  ProcedureReturn (Bool(SDL_PeepEvents(#Null, 0, #SDL_PEEKEVENT, #SDL_QUIT, #SDL_QUIT) > 0))
EndProcedure

Macro SDL_LoadBMP(file)
  SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
EndMacro

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
;- Helper Structures

CompilerIf (#True)

Structure SDLx_KeyboardStateArray
  ks.a[0]
EndStructure

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
