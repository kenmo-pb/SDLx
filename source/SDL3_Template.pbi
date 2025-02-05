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

CompilerIf (Not Defined(SDLx_UseImport, #PB_Constant))
  #SDLx_UseImport = #False
CompilerEndIf
#SDLx_UseOpenLibrary = Bool(Not #SDLx_UseImport)

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
  CompilerCase #PB_OS_Windows
    CompilerIf (Not Defined(SDLx_OpenLibraryDefaultName, #PB_Constant))
      #SDLx_OpenLibraryDefaultName = "SDL3.dll"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_ImportLibraryName, #PB_Constant))
      #SDLx_ImportLibraryName = "SDL3.lib"
    CompilerEndIf
    
  CompilerCase #PB_OS_Linux
    CompilerIf (Not Defined(SDLx_OpenLibraryDefaultName, #PB_Constant))
      #SDLx_OpenLibraryDefaultName = "libSDL3.so"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_ImportLibraryName, #PB_Constant))
      ;#SDLx_ImportLibraryName = ""
    CompilerEndIf
    
  CompilerCase #PB_OS_MacOS
    CompilerIf (Not Defined(SDLx_OpenLibraryDefaultName, #PB_Constant))
      ;#SDLx_OpenLibraryDefaultName = ""
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_ImportLibraryName, #PB_Constant))
      #SDLx_ImportLibraryName = "Frameworks/SDL3.framework/SDL3"
    CompilerEndIf
CompilerEndSelect

CompilerIf (#SDLx_UseOpenLibrary And (Not Defined(SDLx_OpenLibraryDefaultName, #PB_Constant)))
  CompilerError "#SDLx_OpenLibraryDefaultName must be defined to open " + #SDLx_LibName + "!"
CompilerEndIf
CompilerIf (#SDLx_UseImport And (Not Defined(SDLx_ImportLibraryName, #PB_Constant)))
  CompilerError "#SDLx_ImportLibraryName must be defined to Import " + #SDLx_LibName + "!"
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
Macro POINTER_TO_A_POINTER
  INTEGER
EndMacro

;-
;- SDL3 Type Aliases

Macro SDL_CameraID
  Sint32
EndMacro
Macro SDL_Colorspace
  Sint32 ; enum
EndMacro
Macro SDL_DisplayID
  Uint32
EndMacro
Macro SDL_EventAction
  Sint32 ; enum
EndMacro
Macro SDL_EventType
  Sint32 ; enum
EndMacro
Macro SDL_FlipMode
  Sint32 ; enum
EndMacro
Macro SDL_GamepadAxis
  Sint32 ; enum
EndMacro
Macro SDL_GamepadButton
  Sint32 ; enum
EndMacro
Macro SDL_GamepadType
  Sint32 ; enum
EndMacro
Macro SDL_InitFlags
  Uint32
EndMacro
Macro SDL_JoystickConnectionState
  Sint32 ; enum
EndMacro
Macro SDL_JoystickID
  Uint32
EndMacro
Macro SDL_JoystickType
  Sint32 ; enum
EndMacro
Macro SDL_KeyboardID
  Uint32
EndMacro
Macro SDL_Keycode
  Uint32
EndMacro
Macro SDL_Keymod
  Uint16
EndMacro
Macro SDL_MessageBoxButtonFlags
  Uint32
EndMacro
Macro SDL_MessageBoxFlags
  Uint32
EndMacro
Macro SDL_MouseButtonFlags
  Uint32
EndMacro
Macro SDL_MouseID
  Uint32
EndMacro
Macro SDL_MouseWheelDirection
  Sint32 ; enum
EndMacro
Macro SDL_PixelFormat
  Sint32 ; enum
EndMacro
Macro SDL_PowerState
  Sint32 ; enum
EndMacro
Macro SDL_RendererLogicalPresentation
  Sint32 ; enum
EndMacro
Macro SDL_Scancode
  Sint32 ; enum
EndMacro
Macro SDL_SurfaceFlags
  Uint32
EndMacro
Macro SDL_TextureAccess
  Uint32 ; enum
EndMacro
Macro SDL_WindowFlags
  Uint64
EndMacro
Macro SDL_WindowID
  Uint32
EndMacro


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

#SDL_ALPHA_TRANSPARENT_FLOAT = 0.0
#SDL_ALPHA_OPAQUE_FLOAT      = 1.0

Enumeration ; SDL_TextureAccess
  #SDL_TEXTUREACCESS_STATIC
  #SDL_TEXTUREACCESS_STREAMING
  #SDL_TEXTUREACCESS_TARGET
EndEnumeration

#SDL_DEBUG_TEXT_FONT_CHARACTER_SIZE = 8

;- - Pixel Formats and Conversion Routines

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
  ;
  #SDL_PIXELTYPE_INDEX2
EndEnumeration

Enumeration ; SDL_PixelFormat
  #SDL_PIXELFORMAT_UNKNOWN = 0
  
  #SDL_PIXELFORMAT_INDEX1LSB = $11100100
  #SDL_PIXELFORMAT_INDEX1MSB = $11200100
  #SDL_PIXELFORMAT_INDEX2LSB = $1c100200
  #SDL_PIXELFORMAT_INDEX2MSB = $1c200200
  #SDL_PIXELFORMAT_INDEX4LSB = $12100400
  #SDL_PIXELFORMAT_INDEX4MSB = $12200400
  #SDL_PIXELFORMAT_INDEX8 = $13000801
  
  #SDL_PIXELFORMAT_RGB332 = $14110801
  
  #SDL_PIXELFORMAT_XRGB4444 = $15120c02
  #SDL_PIXELFORMAT_XBGR4444 = $15520c02
  #SDL_PIXELFORMAT_XRGB1555 = $15130f02
  #SDL_PIXELFORMAT_XBGR1555 = $15530f02
  
  #SDL_PIXELFORMAT_ARGB4444 = $15321002
  #SDL_PIXELFORMAT_RGBA4444 = $15421002
  #SDL_PIXELFORMAT_ABGR4444 = $15721002
  #SDL_PIXELFORMAT_BGRA4444 = $15821002
  
  #SDL_PIXELFORMAT_ARGB1555 = $15331002
  #SDL_PIXELFORMAT_RGBA5551 = $15441002
  #SDL_PIXELFORMAT_ABGR1555 = $15731002
  #SDL_PIXELFORMAT_BGRA5551 = $15841002
  
  #SDL_PIXELFORMAT_RGB565 = $15151002
  #SDL_PIXELFORMAT_BGR565 = $15551002
  
  #SDL_PIXELFORMAT_RGB24 = $17101803
  #SDL_PIXELFORMAT_BGR24 = $17401803
  
  #SDL_PIXELFORMAT_XRGB8888 = $16161804
  #SDL_PIXELFORMAT_RGBX8888 = $16261804
  #SDL_PIXELFORMAT_XBGR8888 = $16561804
  #SDL_PIXELFORMAT_BGRX8888 = $16661804
  
  #SDL_PIXELFORMAT_ARGB8888 = $16362004
  #SDL_PIXELFORMAT_RGBA8888 = $16462004
  #SDL_PIXELFORMAT_ABGR8888 = $16762004
  #SDL_PIXELFORMAT_BGRA8888 = $16862004
  
  #SDL_PIXELFORMAT_XRGB2101010 = $16172004
  #SDL_PIXELFORMAT_XBGR2101010 = $16572004
  #SDL_PIXELFORMAT_ARGB2101010 = $16372004
  #SDL_PIXELFORMAT_ABGR2101010 = $16772004
  
  #SDL_PIXELFORMAT_RGB48 = $18103006
  #SDL_PIXELFORMAT_BGR48 = $18403006
  
  #SDL_PIXELFORMAT_RGBA64 = $18204008
  #SDL_PIXELFORMAT_ARGB64 = $18304008
  #SDL_PIXELFORMAT_BGRA64 = $18504008
  #SDL_PIXELFORMAT_ABGR64 = $18604008
  
  #SDL_PIXELFORMAT_RGB48_FLOAT = $1a103006
  #SDL_PIXELFORMAT_BGR48_FLOAT = $1a403006
  #SDL_PIXELFORMAT_RGBA64_FLOAT = $1a204008
  #SDL_PIXELFORMAT_ARGB64_FLOAT = $1a304008
  #SDL_PIXELFORMAT_BGRA64_FLOAT = $1a504008
  #SDL_PIXELFORMAT_ABGR64_FLOAT = $1a604008
  #SDL_PIXELFORMAT_RGB96_FLOAT = $1b10600c
  #SDL_PIXELFORMAT_BGR96_FLOAT = $1b40600c
  #SDL_PIXELFORMAT_RGBA128_FLOAT = $1b208010
  #SDL_PIXELFORMAT_ARGB128_FLOAT = $1b308010
  #SDL_PIXELFORMAT_BGRA128_FLOAT = $1b508010
  #SDL_PIXELFORMAT_ABGR128_FLOAT = $1b608010
  
  #SDL_PIXELFORMAT_YV12 = $32315659
  #SDL_PIXELFORMAT_IYUV = $56555949
  #SDL_PIXELFORMAT_YUY2 = $32595559
  #SDL_PIXELFORMAT_UYVY = $59565955
  #SDL_PIXELFORMAT_YVYU = $55595659
  #SDL_PIXELFORMAT_NV12 = $3231564e
  #SDL_PIXELFORMAT_NV21 = $3132564e
  #SDL_PIXELFORMAT_P010 = $30313050
  
  #SDL_PIXELFORMAT_EXTERNAL_OES = $2053454f
  
  CompilerIf (#False) ; PureBasic never Big Endian
    #SDL_PIXELFORMAT_RGBA32 = #SDL_PIXELFORMAT_RGBA8888
    #SDL_PIXELFORMAT_ARGB32 = #SDL_PIXELFORMAT_ARGB8888
    #SDL_PIXELFORMAT_BGRA32 = #SDL_PIXELFORMAT_BGRA8888
    #SDL_PIXELFORMAT_ABGR32 = #SDL_PIXELFORMAT_ABGR8888
    #SDL_PIXELFORMAT_RGBX32 = #SDL_PIXELFORMAT_RGBX8888
    #SDL_PIXELFORMAT_XRGB32 = #SDL_PIXELFORMAT_XRGB8888
    #SDL_PIXELFORMAT_BGRX32 = #SDL_PIXELFORMAT_BGRX8888
    #SDL_PIXELFORMAT_XBGR32 = #SDL_PIXELFORMAT_XBGR8888
  CompilerElse ; PureBasic always Little Endian
    #SDL_PIXELFORMAT_RGBA32 = #SDL_PIXELFORMAT_ABGR8888
    #SDL_PIXELFORMAT_ARGB32 = #SDL_PIXELFORMAT_BGRA8888
    #SDL_PIXELFORMAT_BGRA32 = #SDL_PIXELFORMAT_ARGB8888
    #SDL_PIXELFORMAT_ABGR32 = #SDL_PIXELFORMAT_RGBA8888
    #SDL_PIXELFORMAT_RGBX32 = #SDL_PIXELFORMAT_XBGR8888
    #SDL_PIXELFORMAT_XRGB32 = #SDL_PIXELFORMAT_BGRX8888
    #SDL_PIXELFORMAT_BGRX32 = #SDL_PIXELFORMAT_XRGB8888
    #SDL_PIXELFORMAT_XBGR32 = #SDL_PIXELFORMAT_RGBX8888
  CompilerEndIf
EndEnumeration

Macro SDL_DEFINE_PIXELFORMAT(type, order, layout, bits, bytes)
  ((1 << 28) | ((type) << 24) | ((order) << 20) | ((layout) << 16) | ((bits) << 8) | ((bytes) << 0))
EndMacro

;- - Surface Creation and Simple Drawing

Enumeration ; SDL_FlipMode
  #SDL_FLIP_NONE
  #SDL_FLIP_HORIZONTAL
  #SDL_FLIP_VERTICAL
EndEnumeration

;- - Camera Support

Enumeration ; SDL_CameraPosition
  #SDL_CAMERA_POSITION_UNKNOWN
  #SDL_CAMERA_POSITION_FRONT_FACING
  #SDL_CAMERA_POSITION_BACK_FACING
EndEnumeration

;- - Event Handling

Enumeration ; SDL_EventType
  #SDL_EVENT_FIRST = 0
  
  #SDL_EVENT_QUIT = $100
  
  #SDL_EVENT_TERMINATING
  #SDL_EVENT_LOW_MEMORY
  #SDL_EVENT_WILL_ENTER_BACKGROUND
  #SDL_EVENT_DID_ENTER_BACKGROUND
  #SDL_EVENT_WILL_ENTER_FOREGROUND
  #SDL_EVENT_DID_ENTER_FOREGROUND
  
  #SDL_EVENT_LOCALE_CHANGED
  
  #SDL_EVENT_SYSTEM_THEME_CHANGED
  
  #SDL_EVENT_DISPLAY_ORIENTATION = $151
  #SDL_EVENT_DISPLAY_ADDED
  #SDL_EVENT_DISPLAY_REMOVED
  #SDL_EVENT_DISPLAY_MOVED
  #SDL_EVENT_DISPLAY_DESKTOP_MODE_CHANGED
  #SDL_EVENT_DISPLAY_CURRENT_MODE_CHANGED
  #SDL_EVENT_DISPLAY_CONTENT_SCALE_CHANGED
  #SDL_EVENT_DISPLAY_FIRST = #SDL_EVENT_DISPLAY_ORIENTATION
  #SDL_EVENT_DISPLAY_LAST = #SDL_EVENT_DISPLAY_CONTENT_SCALE_CHANGED
  
  #SDL_EVENT_WINDOW_SHOWN = $202
  #SDL_EVENT_WINDOW_HIDDEN
  #SDL_EVENT_WINDOW_EXPOSED
  #SDL_EVENT_WINDOW_MOVED
  #SDL_EVENT_WINDOW_RESIZED
  #SDL_EVENT_WINDOW_PIXEL_SIZE_CHANGED
  #SDL_EVENT_WINDOW_METAL_VIEW_RESIZED
  #SDL_EVENT_WINDOW_MINIMIZED
  #SDL_EVENT_WINDOW_MAXIMIZED
  #SDL_EVENT_WINDOW_RESTORED
  #SDL_EVENT_WINDOW_MOUSE_ENTER
  #SDL_EVENT_WINDOW_MOUSE_LEAVE
  #SDL_EVENT_WINDOW_FOCUS_GAINED
  #SDL_EVENT_WINDOW_FOCUS_LOST
  #SDL_EVENT_WINDOW_CLOSE_REQUESTED
  #SDL_EVENT_WINDOW_HIT_TEST
  #SDL_EVENT_WINDOW_ICCPROF_CHANGED
  #SDL_EVENT_WINDOW_DISPLAY_CHANGED
  #SDL_EVENT_WINDOW_DISPLAY_SCALE_CHANGED
  #SDL_EVENT_WINDOW_SAFE_AREA_CHANGED
  #SDL_EVENT_WINDOW_OCCLUDED
  #SDL_EVENT_WINDOW_ENTER_FULLSCREEN
  #SDL_EVENT_WINDOW_LEAVE_FULLSCREEN
  #SDL_EVENT_WINDOW_DESTROYED
  #SDL_EVENT_WINDOW_HDR_STATE_CHANGED
  #SDL_EVENT_WINDOW_FIRST = #SDL_EVENT_WINDOW_SHOWN
  #SDL_EVENT_WINDOW_LAST = #SDL_EVENT_WINDOW_HDR_STATE_CHANGED
  
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
  
  #SDL_EVENT_JOYSTICK_AXIS_MOTION = $600
  #SDL_EVENT_JOYSTICK_BALL_MOTION
  #SDL_EVENT_JOYSTICK_HAT_MOTION
  #SDL_EVENT_JOYSTICK_BUTTON_DOWN
  #SDL_EVENT_JOYSTICK_BUTTON_UP
  #SDL_EVENT_JOYSTICK_ADDED
  #SDL_EVENT_JOYSTICK_REMOVED
  #SDL_EVENT_JOYSTICK_BATTERY_UPDATED
  #SDL_EVENT_JOYSTICK_UPDATE_COMPLETE
  
  #SDL_EVENT_GAMEPAD_AXIS_MOTION = $650
  #SDL_EVENT_GAMEPAD_BUTTON_DOWN
  #SDL_EVENT_GAMEPAD_BUTTON_UP
  #SDL_EVENT_GAMEPAD_ADDED
  #SDL_EVENT_GAMEPAD_REMOVED
  #SDL_EVENT_GAMEPAD_REMAPPED
  #SDL_EVENT_GAMEPAD_TOUCHPAD_DOWN
  #SDL_EVENT_GAMEPAD_TOUCHPAD_MOTION
  #SDL_EVENT_GAMEPAD_TOUCHPAD_UP
  #SDL_EVENT_GAMEPAD_SENSOR_UPDATE
  #SDL_EVENT_GAMEPAD_UPDATE_COMPLETE
  #SDL_EVENT_GAMEPAD_STEAM_HANDLE_UPDATED
  
  #SDL_EVENT_FINGER_DOWN = $700
  #SDL_EVENT_FINGER_UP
  #SDL_EVENT_FINGER_MOTION
  #SDL_EVENT_FINGER_CANCELED
  
  #SDL_EVENT_CLIPBOARD_UPDATE = $900
  
  #SDL_EVENT_DROP_FILE = $1000
  #SDL_EVENT_DROP_TEXT
  #SDL_EVENT_DROP_BEGIN
  #SDL_EVENT_DROP_COMPLETE
  #SDL_EVENT_DROP_POSITION
  
  #SDL_EVENT_AUDIO_DEVICE_ADDED = $1100
  #SDL_EVENT_AUDIO_DEVICE_REMOVED
  #SDL_EVENT_AUDIO_DEVICE_FORMAT_CHANGED
  
  #SDL_EVENT_SENSOR_UPDATE = $1200
  
  #SDL_EVENT_PEN_PROXIMITY_IN = $1300
  #SDL_EVENT_PEN_PROXIMITY_OUT
  #SDL_EVENT_PEN_DOWN
  #SDL_EVENT_PEN_UP
  #SDL_EVENT_PEN_BUTTON_DOWN
  #SDL_EVENT_PEN_BUTTON_UP
  #SDL_EVENT_PEN_MOTION
  #SDL_EVENT_PEN_AXIS
  
  #SDL_EVENT_CAMERA_DEVICE_ADDED = $1400
  #SDL_EVENT_CAMERA_DEVICE_REMOVED
  #SDL_EVENT_CAMERA_DEVICE_APPROVED
  #SDL_EVENT_CAMERA_DEVICE_DENIED
  
  #SDL_EVENT_RENDER_TARGETS_RESET = $2000
  #SDL_EVENT_RENDER_DEVICE_RESET
  #SDL_EVENT_RENDER_DEVICE_LOST
  
  #SDL_EVENT_PRIVATE0 = $4000
  #SDL_EVENT_PRIVATE1
  #SDL_EVENT_PRIVATE2
  #SDL_EVENT_PRIVATE3
  
  #SDL_EVENT_POLL_SENTINEL = $7F00
  
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
  
  #SDL_SCANCODE_RETURN = 40
  #SDL_SCANCODE_ESCAPE = 41
  #SDL_SCANCODE_BACKSPACE = 42
  #SDL_SCANCODE_TAB = 43
  #SDL_SCANCODE_SPACE = 44
  
  #SDL_SCANCODE_MINUS = 45
  #SDL_SCANCODE_EQUALS = 46
  #SDL_SCANCODE_LEFTBRACKET = 47
  #SDL_SCANCODE_RIGHTBRACKET = 48
  #SDL_SCANCODE_BACKSLASH = 49
  #SDL_SCANCODE_NONUSHASH = 50
  #SDL_SCANCODE_SEMICOLON = 51
  #SDL_SCANCODE_APOSTROPHE = 52
  #SDL_SCANCODE_GRAVE = 53
  #SDL_SCANCODE_COMMA = 54
  #SDL_SCANCODE_PERIOD = 55
  #SDL_SCANCODE_SLASH = 56
  
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
  #SDL_SCANCODE_SCROLLLOCK = 71
  #SDL_SCANCODE_PAUSE = 72
  #SDL_SCANCODE_INSERT = 73
  #SDL_SCANCODE_HOME = 74
  #SDL_SCANCODE_PAGEUP = 75
  #SDL_SCANCODE_DELETE = 76
  #SDL_SCANCODE_END = 77
  #SDL_SCANCODE_PAGEDOWN = 78
  #SDL_SCANCODE_RIGHT = 79
  #SDL_SCANCODE_LEFT = 80
  #SDL_SCANCODE_DOWN = 81
  #SDL_SCANCODE_UP = 82
  
  #SDL_SCANCODE_NUMLOCKCLEAR = 83
  #SDL_SCANCODE_KP_DIVIDE = 84
  #SDL_SCANCODE_KP_MULTIPLY = 85
  #SDL_SCANCODE_KP_MINUS = 86
  #SDL_SCANCODE_KP_PLUS = 87
  #SDL_SCANCODE_KP_ENTER = 88
  #SDL_SCANCODE_KP_1 = 89
  #SDL_SCANCODE_KP_2 = 90
  #SDL_SCANCODE_KP_3 = 91
  #SDL_SCANCODE_KP_4 = 92
  #SDL_SCANCODE_KP_5 = 93
  #SDL_SCANCODE_KP_6 = 94
  #SDL_SCANCODE_KP_7 = 95
  #SDL_SCANCODE_KP_8 = 96
  #SDL_SCANCODE_KP_9 = 97
  #SDL_SCANCODE_KP_0 = 98
  #SDL_SCANCODE_KP_PERIOD = 99
  
  #SDL_SCANCODE_NONUSBACKSLASH = 100
  #SDL_SCANCODE_APPLICATION = 101
  #SDL_SCANCODE_POWER = 102
  #SDL_SCANCODE_KP_EQUALS = 103
  #SDL_SCANCODE_F13 = 104
  #SDL_SCANCODE_F14 = 105
  #SDL_SCANCODE_F15 = 106
  #SDL_SCANCODE_F16 = 107
  #SDL_SCANCODE_F17 = 108
  #SDL_SCANCODE_F18 = 109
  #SDL_SCANCODE_F19 = 110
  #SDL_SCANCODE_F20 = 111
  #SDL_SCANCODE_F21 = 112
  #SDL_SCANCODE_F22 = 113
  #SDL_SCANCODE_F23 = 114
  #SDL_SCANCODE_F24 = 115
  #SDL_SCANCODE_EXECUTE = 116
  #SDL_SCANCODE_HELP = 117
  #SDL_SCANCODE_MENU = 118
  #SDL_SCANCODE_SELECT = 119
  #SDL_SCANCODE_STOP = 120
  #SDL_SCANCODE_AGAIN = 121
  #SDL_SCANCODE_UNDO = 122
  #SDL_SCANCODE_CUT = 123
  #SDL_SCANCODE_COPY = 124
  #SDL_SCANCODE_PASTE = 125
  #SDL_SCANCODE_FIND = 126
  #SDL_SCANCODE_MUTE = 127
  #SDL_SCANCODE_VOLUMEUP = 128
  #SDL_SCANCODE_VOLUMEDOWN = 129
  
  #SDL_SCANCODE_KP_COMMA = 133
  #SDL_SCANCODE_KP_EQUALSAS400 = 134
  
  #SDL_SCANCODE_INTERNATIONAL1 = 135
  #SDL_SCANCODE_INTERNATIONAL2 = 136
  #SDL_SCANCODE_INTERNATIONAL3 = 137
  #SDL_SCANCODE_INTERNATIONAL4 = 138
  #SDL_SCANCODE_INTERNATIONAL5 = 139
  #SDL_SCANCODE_INTERNATIONAL6 = 140
  #SDL_SCANCODE_INTERNATIONAL7 = 141
  #SDL_SCANCODE_INTERNATIONAL8 = 142
  #SDL_SCANCODE_INTERNATIONAL9 = 143
  #SDL_SCANCODE_LANG1 = 144
  #SDL_SCANCODE_LANG2 = 145
  #SDL_SCANCODE_LANG3 = 146
  #SDL_SCANCODE_LANG4 = 147
  #SDL_SCANCODE_LANG5 = 148
  #SDL_SCANCODE_LANG6 = 149
  #SDL_SCANCODE_LANG7 = 150
  #SDL_SCANCODE_LANG8 = 151
  #SDL_SCANCODE_LANG9 = 152
  
  #SDL_SCANCODE_ALTERASE = 153
  #SDL_SCANCODE_SYSREQ = 154
  #SDL_SCANCODE_CANCEL = 155
  #SDL_SCANCODE_CLEAR = 156
  #SDL_SCANCODE_PRIOR = 157
  #SDL_SCANCODE_RETURN2 = 158
  #SDL_SCANCODE_SEPARATOR = 159
  #SDL_SCANCODE_OUT = 160
  #SDL_SCANCODE_OPER = 161
  #SDL_SCANCODE_CLEARAGAIN = 162
  #SDL_SCANCODE_CRSEL = 163
  #SDL_SCANCODE_EXSEL = 164
  
  #SDL_SCANCODE_KP_00 = 176
  #SDL_SCANCODE_KP_000 = 177
  #SDL_SCANCODE_THOUSANDSSEPARATOR = 178
  #SDL_SCANCODE_DECIMALSEPARATOR = 179
  #SDL_SCANCODE_CURRENCYUNIT = 180
  #SDL_SCANCODE_CURRENCYSUBUNIT = 181
  #SDL_SCANCODE_KP_LEFTPAREN = 182
  #SDL_SCANCODE_KP_RIGHTPAREN = 183
  #SDL_SCANCODE_KP_LEFTBRACE = 184
  #SDL_SCANCODE_KP_RIGHTBRACE = 185
  #SDL_SCANCODE_KP_TAB = 186
  #SDL_SCANCODE_KP_BACKSPACE = 187
  #SDL_SCANCODE_KP_A = 188
  #SDL_SCANCODE_KP_B = 189
  #SDL_SCANCODE_KP_C = 190
  #SDL_SCANCODE_KP_D = 191
  #SDL_SCANCODE_KP_E = 192
  #SDL_SCANCODE_KP_F = 193
  #SDL_SCANCODE_KP_XOR = 194
  #SDL_SCANCODE_KP_POWER = 195
  #SDL_SCANCODE_KP_PERCENT = 196
  #SDL_SCANCODE_KP_LESS = 197
  #SDL_SCANCODE_KP_GREATER = 198
  #SDL_SCANCODE_KP_AMPERSAND = 199
  #SDL_SCANCODE_KP_DBLAMPERSAND = 200
  #SDL_SCANCODE_KP_VERTICALBAR = 201
  #SDL_SCANCODE_KP_DBLVERTICALBAR = 202
  #SDL_SCANCODE_KP_COLON = 203
  #SDL_SCANCODE_KP_HASH = 204
  #SDL_SCANCODE_KP_SPACE = 205
  #SDL_SCANCODE_KP_AT = 206
  #SDL_SCANCODE_KP_EXCLAM = 207
  #SDL_SCANCODE_KP_MEMSTORE = 208
  #SDL_SCANCODE_KP_MEMRECALL = 209
  #SDL_SCANCODE_KP_MEMCLEAR = 210
  #SDL_SCANCODE_KP_MEMADD = 211
  #SDL_SCANCODE_KP_MEMSUBTRACT = 212
  #SDL_SCANCODE_KP_MEMMULTIPLY = 213
  #SDL_SCANCODE_KP_MEMDIVIDE = 214
  #SDL_SCANCODE_KP_PLUSMINUS = 215
  #SDL_SCANCODE_KP_CLEAR = 216
  #SDL_SCANCODE_KP_CLEARENTRY = 217
  #SDL_SCANCODE_KP_BINARY = 218
  #SDL_SCANCODE_KP_OCTAL = 219
  #SDL_SCANCODE_KP_DECIMAL = 220
  #SDL_SCANCODE_KP_HEXADECIMAL = 221
  
  #SDL_SCANCODE_LCTRL = 224
  #SDL_SCANCODE_LSHIFT = 225
  #SDL_SCANCODE_LALT = 226
  #SDL_SCANCODE_LGUI = 227
  #SDL_SCANCODE_RCTRL = 228
  #SDL_SCANCODE_RSHIFT = 229
  #SDL_SCANCODE_RALT = 230
  #SDL_SCANCODE_RGUI = 231
  
  #SDL_SCANCODE_MODE = 257
  
  #SDL_SCANCODE_SLEEP = 258
  #SDL_SCANCODE_WAKE = 259
  
  #SDL_SCANCODE_CHANNEL_INCREMENT = 260
  #SDL_SCANCODE_CHANNEL_DECREMENT = 261
  
  #SDL_SCANCODE_MEDIA_PLAY = 262
  #SDL_SCANCODE_MEDIA_PAUSE = 263
  #SDL_SCANCODE_MEDIA_RECORD = 264
  #SDL_SCANCODE_MEDIA_FAST_FORWARD = 265
  #SDL_SCANCODE_MEDIA_REWIND = 266
  #SDL_SCANCODE_MEDIA_NEXT_TRACK = 267
  #SDL_SCANCODE_MEDIA_PREVIOUS_TRACK = 268
  #SDL_SCANCODE_MEDIA_STOP = 269
  #SDL_SCANCODE_MEDIA_EJECT = 270
  #SDL_SCANCODE_MEDIA_PLAY_PAUSE = 271
  #SDL_SCANCODE_MEDIA_SELECT = 272
  
  #SDL_SCANCODE_AC_NEW = 273
  #SDL_SCANCODE_AC_OPEN = 274
  #SDL_SCANCODE_AC_CLOSE = 275
  #SDL_SCANCODE_AC_EXIT = 276
  #SDL_SCANCODE_AC_SAVE = 277
  #SDL_SCANCODE_AC_PRINT = 278
  #SDL_SCANCODE_AC_PROPERTIES = 279
  
  #SDL_SCANCODE_AC_SEARCH = 280
  #SDL_SCANCODE_AC_HOME = 281
  #SDL_SCANCODE_AC_BACK = 282
  #SDL_SCANCODE_AC_FORWARD = 283
  #SDL_SCANCODE_AC_STOP = 284
  #SDL_SCANCODE_AC_REFRESH = 285
  #SDL_SCANCODE_AC_BOOKMARKS = 286
  
  #SDL_SCANCODE_SOFTLEFT = 287
  #SDL_SCANCODE_SOFTRIGHT = 288
  #SDL_SCANCODE_CALL = 289
  #SDL_SCANCODE_ENDCALL = 290
  
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

;- - Joystick Support

Enumeration ; SDL_JoystickType
  #SDL_JOYSTICK_TYPE_UNKNOWN
  #SDL_JOYSTICK_TYPE_GAMEPAD
  #SDL_JOYSTICK_TYPE_WHEEL
  #SDL_JOYSTICK_TYPE_ARCADE_STICK
  #SDL_JOYSTICK_TYPE_FLIGHT_STICK
  #SDL_JOYSTICK_TYPE_DANCE_PAD
  #SDL_JOYSTICK_TYPE_GUITAR
  #SDL_JOYSTICK_TYPE_DRUM_KIT
  #SDL_JOYSTICK_TYPE_ARCADE_PAD
  #SDL_JOYSTICK_TYPE_THROTTLE
  #SDL_JOYSTICK_TYPE_COUNT
EndEnumeration

Enumeration ; SDL_JoystickConnectionState
  #SDL_JOYSTICK_CONNECTION_INVALID = -1
  #SDL_JOYSTICK_CONNECTION_UNKNOWN
  #SDL_JOYSTICK_CONNECTION_WIRED
  #SDL_JOYSTICK_CONNECTION_WIRELESS
EndEnumeration

#SDL_JOYSTICK_AXIS_MIN = -32768
#SDL_JOYSTICK_AXIS_MAX =  32767

;- - Gamepad Support

Enumeration ; SDL_GamepadType
  #SDL_GAMEPAD_TYPE_UNKNOWN = 0
  #SDL_GAMEPAD_TYPE_STANDARD
  #SDL_GAMEPAD_TYPE_XBOX360
  #SDL_GAMEPAD_TYPE_XBOXONE
  #SDL_GAMEPAD_TYPE_PS3
  #SDL_GAMEPAD_TYPE_PS4
  #SDL_GAMEPAD_TYPE_PS5
  #SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_PRO
  #SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_LEFT
  #SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_RIGHT
  #SDL_GAMEPAD_TYPE_NINTENDO_SWITCH_JOYCON_PAIR
  #SDL_GAMEPAD_TYPE_COUNT
EndEnumeration

Enumeration ; SDL_GamepadButton
  #SDL_GAMEPAD_BUTTON_INVALID = -1
  #SDL_GAMEPAD_BUTTON_SOUTH
  #SDL_GAMEPAD_BUTTON_EAST
  #SDL_GAMEPAD_BUTTON_WEST
  #SDL_GAMEPAD_BUTTON_NORTH
  #SDL_GAMEPAD_BUTTON_BACK
  #SDL_GAMEPAD_BUTTON_GUIDE
  #SDL_GAMEPAD_BUTTON_START
  #SDL_GAMEPAD_BUTTON_LEFT_STICK
  #SDL_GAMEPAD_BUTTON_RIGHT_STICK
  #SDL_GAMEPAD_BUTTON_LEFT_SHOULDER
  #SDL_GAMEPAD_BUTTON_RIGHT_SHOULDER
  #SDL_GAMEPAD_BUTTON_DPAD_UP
  #SDL_GAMEPAD_BUTTON_DPAD_DOWN
  #SDL_GAMEPAD_BUTTON_DPAD_LEFT
  #SDL_GAMEPAD_BUTTON_DPAD_RIGHT
  #SDL_GAMEPAD_BUTTON_MISC1
  #SDL_GAMEPAD_BUTTON_RIGHT_PADDLE1
  #SDL_GAMEPAD_BUTTON_LEFT_PADDLE1
  #SDL_GAMEPAD_BUTTON_RIGHT_PADDLE2
  #SDL_GAMEPAD_BUTTON_LEFT_PADDLE2
  #SDL_GAMEPAD_BUTTON_TOUCHPAD
  #SDL_GAMEPAD_BUTTON_MISC2
  #SDL_GAMEPAD_BUTTON_MISC3
  #SDL_GAMEPAD_BUTTON_MISC4
  #SDL_GAMEPAD_BUTTON_MISC5
  #SDL_GAMEPAD_BUTTON_MISC6
  #SDL_GAMEPAD_BUTTON_COUNT
EndEnumeration

Enumeration ; SDL_GamepadAxis
  #SDL_GAMEPAD_AXIS_INVALID = -1
  #SDL_GAMEPAD_AXIS_LEFTX
  #SDL_GAMEPAD_AXIS_LEFTY
  #SDL_GAMEPAD_AXIS_RIGHTX
  #SDL_GAMEPAD_AXIS_RIGHTY
  #SDL_GAMEPAD_AXIS_LEFT_TRIGGER
  #SDL_GAMEPAD_AXIS_RIGHT_TRIGGER
  #SDL_GAMEPAD_AXIS_COUNT
EndEnumeration

;- - Power Management Status

Enumeration ; SDL_PowerState
  #SDL_POWERSTATE_ERROR = -1
  #SDL_POWERSTATE_UNKNOWN
  #SDL_POWERSTATE_ON_BATTERY
  #SDL_POWERSTATE_NO_BATTERY
  #SDL_POWERSTATE_CHARGING
  #SDL_POWERSTATE_CHARGED
EndEnumeration

;- - Message Boxes

Enumeration ; SDL_MessageBoxFlags
  #SDL_MESSAGEBOX_ERROR       = $00000010
  #SDL_MESSAGEBOX_WARNING     = $00000020
  #SDL_MESSAGEBOX_INFORMATION = $00000040
  
  #SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = $00000080
  #SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = $00000100
EndEnumeration

Enumeration ; SDL_MessageBoxColorType
  #SDL_MESSAGEBOX_COLOR_BACKGROUND
  #SDL_MESSAGEBOX_COLOR_TEXT
  #SDL_MESSAGEBOX_COLOR_BUTTON_BORDER
  #SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND
  #SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED
  #SDL_MESSAGEBOX_COLOR_COUNT
EndEnumeration

#SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = $00000001
#SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = $00000002





;-
;- Helper Constants



;-
;- SDL3 Structures

Structure  SDL_CommonEvent Align #PB_Structure_AlignC
  type.Uint32
  reserved.Uint32
  timestamp.Uint64
EndStructure

Structure  SDL_KeyboardEvent Align #PB_Structure_AlignC
  type.SDL_EventType
  reserved.Uint32
  timestamp.Uint64
  windowID.SDL_WindowID
  which.SDL_KeyboardID
  scancode.SDL_Scancode
  key.SDL_Keycode
  mod.SDL_Keymod
  raw.Uint16
  down.Uint8
  repeat_.Uint8
EndStructure

Structure  SDL_MouseMotionEvent Align #PB_Structure_AlignC
  type.SDL_EventType
  reserved.Uint32
  timestamp.Uint64
  windowID.SDL_WindowID
  which.SDL_MouseID
  state.SDL_MouseButtonFlags
  x.f
  y.f
  xrel.f
  yrel.f
EndStructure

Structure  SDL_MouseButtonEvent Align #PB_Structure_AlignC
  type.SDL_EventType
  reserved.Uint32
  timestamp.Uint64
  windowID.SDL_WindowID
  which.SDL_MouseID
  button.Uint8
  down.Uint8
  clicks.Uint8
  padding.Uint8
  x.f
  y.f
EndStructure

Structure  SDL_MouseWheelEvent Align #PB_Structure_AlignC
  type.SDL_EventType
  reserved.Uint32
  timestamp.Uint64
  windowID.SDL_WindowID
  which.SDL_MouseID
  x.f
  y.f
  direction.SDL_MouseWheelDirection
  mouse_x.f
  mouse_y.f
EndStructure

Structure  SDL_CameraDeviceEvent Align #PB_Structure_AlignC
  type.SDL_EventType
  reserved.Uint32
  timestamp.Uint64
  which.SDL_CameraID
EndStructure

Structure  SDL_QuitEvent Align #PB_Structure_AlignC
  type.SDL_EventType
  reserved.Uint32
  timestamp.Uint64
EndStructure

Structure  SDL_ClipboardEvent Align #PB_Structure_AlignC
  type.SDL_EventType
  reserved.Uint32
  timestamp.Uint64
  owner.Uint8
  num_mime_types.Sint32
  *mime_types.POINTER_TO_A_POINTER
EndStructure

Structure  SDL_Event Align #PB_Structure_AlignC
  StructureUnion
    type.Uint32
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
    button.SDL_MouseButtonEvent
    wheel.SDL_MouseWheelEvent
    ;jdevice.SDL_JoyDeviceEvent
    ;jaxis.SDL_JoyAxisEvent
    ;jball.SDL_JoyBallEvent
    ;jhat.SDL_JoyHatEvent
    ;jbutton.SDL_JoyButtonEvent
    ;jbattery.SDL_JoyBatteryEvent
    ;gdevice.SDL_GamepadDeviceEvent
    ;gaxis.SDL_GamepadAxisEvent
    ;gbutton.SDL_GamepadButtonEvent
    ;gtouchpad.SDL_GamepadTouchpadEvent
    ;gsensor.SDL_GamepadSensorEvent
    ;adevice.SDL_AudioDeviceEvent
    cdevice.SDL_CameraDeviceEvent
    ;sensor.SDL_SensorEvent
    quit.SDL_QuitEvent
    ;user.SDL_UserEvent
    ;tfinger.SDL_TouchFingerEvent
    ;pproximity.SDL_PenProximityEvent
    ;ptouch.SDL_PenTouchEvent
    ;pmotion.SDL_PenMotionEvent
    ;pbutton.SDL_PenButtonEvent
    ;paxis.SDL_PenAxisEvent
    ;render.SDL_RenderEvent
    ;drop.SDL_DropEvent
    clipboard.SDL_ClipboardEvent
    
    padding.Uint8[128]
  EndStructureUnion
EndStructure

Structure  SDL_Point Align #PB_Structure_AlignC
  x.Sint32
  y.Sint32
EndStructure
Structure  SDL_FPoint Align #PB_Structure_AlignC
  x.f
  y.f
EndStructure

Structure SDL_Rect Align #PB_Structure_AlignC
  x.Sint32
  y.Sint32
  w.Sint32
  h.Sint32
EndStructure
Structure  SDL_FRect Align #PB_Structure_AlignC
  x.f
  y.f
  w.f
  h.f
EndStructure

Structure SDL_Surface Align #PB_Structure_AlignC
  flags.SDL_SurfaceFlags
  format.SDL_PixelFormat
  w.Sint32
  h.Sint32
  pitch.Sint32
  *pixels
  refcount.Sint32
  *reserved
EndStructure

Structure  SDL_MessageBoxButtonData Align #PB_Structure_AlignC
  flags.SDL_MessageBoxButtonFlags
  buttonID.Sint32
  *text
EndStructure

Structure SDL_MessageBoxColor Align #PB_Structure_AlignC
  r.Uint8
  g.Uint8
  b.Uint8
EndStructure

Structure SDL_MessageBoxColorScheme Align #PB_Structure_AlignC
  colors.SDL_MessageBoxColor[#SDL_MESSAGEBOX_COLOR_COUNT]
EndStructure

Structure  SDL_MessageBoxData Align #PB_Structure_AlignC
  flags.SDL_MessageBoxFlags
  *window.SDL_Window
  *title
  *message
  
  numbuttons.Sint32
  *buttons.SDL_MessageBoxButtonData
  
  *colorScheme.SDL_MessageBoxColorScheme
EndStructure

Structure SDL_Texture Align #PB_Structure_AlignC
  format.SDL_PixelFormat
  w.Sint32
  h.Sint32
  refcount.Sint32
EndStructure

Structure  SDL_CameraSpec Align #PB_Structure_AlignC
  format.SDL_PixelFormat
  colorspace.SDL_Colorspace
  width.Sint32
  height.Sint32
  framerate_numerator.Sint32
  framerate_denominator.Sint32
EndStructure

Structure  SDL_DisplayMode Align #PB_Structure_AlignC
  displayID.SDL_DisplayID
  format.SDL_PixelFormat
  w.Sint32
  h.Sint32
  pixel_density.f
  refresh_rate.f
  refresh_rate_numerator.Sint32
  refresh_rate_denominator.Sint32
  
  *internal.SDL_DisplayModeData

EndStructure

Structure SDL_Camera Align #PB_Structure_AlignC
  ;
EndStructure

Structure SDL_Gamepad Align #PB_Structure_AlignC
  ;
EndStructure

Structure SDL_Joystick Align #PB_Structure_AlignC
  ;
EndStructure

Structure SDL_Renderer Align #PB_Structure_AlignC
  ;
EndStructure

Structure SDL_Window Align #PB_Structure_AlignC
  ;
EndStructure





;-
;- SDL3 Prototypes

;- - Standard Include
PrototypeC   Proto_SDL_free(*mem)

;- - Querying SDL Version
PrototypeC.l Proto_SDL_GetVersion() ; returns int

;- - Initialization and Shutdown
PrototypeC.a Proto_SDL_Init(flags.SDL_InitFlags) ; returns bool
PrototypeC.a Proto_SDL_InitSubSystem(flags.SDL_InitFlags) ; returns bool
PrototypeC   Proto_SDL_Quit()
PrototypeC   Proto_SDL_QuitSubSystem(flags.SDL_InitFlags)
PrototypeC.l Proto_SDL_WasInit(flags.SDL_InitFlags) ; returns SDL_InitFlags

;- - Error Handling
PrototypeC.i Proto_SDL_GetError() ; returns const char *

;- - Display and Window Management
PrototypeC.i Proto_SDL_CreateWindow(title.p-utf8, w.Sint32, h.Sint32, flags.SDL_WindowFlags) ; returns SDL_Window *
PrototypeC   Proto_SDL_DestroyWindow(*window.SDL_Window)
PrototypeC.a Proto_SDL_HideWindow(*window.SDL_Window) ; returns bool
PrototypeC.a Proto_SDL_MaximizeWindow(*window.SDL_Window) ; returns bool
PrototypeC.a Proto_SDL_MinimizeWindow(*window.SDL_Window) ; returns bool
PrototypeC.a Proto_SDL_RaiseWindow(*window.SDL_Window) ; returns bool
PrototypeC.a Proto_SDL_RestoreWindow(*window.SDL_Window) ; returns bool
PrototypeC.a Proto_SDL_SetWindowAlwaysOnTop(*window.SDL_Window, on_top.Uint8) ; returns bool
PrototypeC.a Proto_SDL_SetWindowFullscreen(*window.SDL_Window, fullscreen.Uint8) ; returns bool
PrototypeC.a Proto_SDL_SetWindowFullscreenMode(*window.SDL_Window, *mode.SDL_DisplayMode) ; returns bool
PrototypeC.a Proto_SDL_SetWindowSize(*window.SDL_Window, w.Sint32, h.Sint32) ; returns bool
PrototypeC.a Proto_SDL_ShowWindow(*window.SDL_Window) ; returns bool

;- - 2D Accelerated Rendering
PrototypeC.i Proto_SDL_CreateRenderer(*window.SDL_Window, name.p-utf8) ; returns SDL_Renderer *
PrototypeC.i Proto_SDL_CreateTexture(*renderer.SDL_Renderer, format.SDL_PixelFormat, access.SDL_TextureAccess, w.Sint32, h.Sint32) ; returns SDL_Texture *
PrototypeC.i Proto_SDL_CreateTextureFromSurface(*renderer.SDL_Renderer, *surface.SDL_Surface) ; returns SDL_Texture *
PrototypeC   Proto_SDL_DestroyRenderer(*renderer.SDL_Renderer)
PrototypeC   Proto_SDL_DestroyTexture(*texture.SDL_Texture)
PrototypeC.a Proto_SDL_RenderClear(*renderer.SDL_Renderer) ; returns bool
PrototypeC.a Proto_SDL_RenderDebugText(*renderer.SDL_Renderer, x.f, y.f, str.p-utf8) ; returns bool
PrototypeC.a Proto_SDL_RenderFillRect(*renderer.SDL_Renderer, *rect.SDL_FRect) ; returns bool
PrototypeC.a Proto_SDL_RenderPresent(*renderer.SDL_Renderer) ; returns bool
PrototypeC.a Proto_SDL_RenderTexture(*renderer.SDL_Renderer, *texture.SDL_Texture, *srcrect.SDL_FRect, *dstrect.SDL_FRect) ; returns bool
PrototypeC.a Proto_SDL_RenderTextureRotated(*renderer.SDL_Renderer, *texture.SDL_Texture, *srcrect.SDL_FRect, *dstrect.SDL_FRect, angle.d, *center.SDL_FPoint, flip.SDL_FlipMode) ; returns bool
PrototypeC.a Proto_SDL_SetRenderDrawColor(*renderer.SDL_Renderer, r.Uint8, g.Uint8, b.Uint8, a.Uint8) ; returns bool
PrototypeC.a Proto_SDL_SetRenderLogicalPresentation(*renderer.SDL_Renderer, w.Sint32, h.Sint32, mode.SDL_RendererLogicalPresentation) ; returns bool
PrototypeC.a Proto_SDL_UpdateTexture(*texture.SDL_Texture, *rect.SDL_Rect, *pixels, pitch.Sint32) ; returns bool

;- - Pixel Formats and Conversion Routines
PrototypeC.i Proto_SDL_GetPixelFormatName(format.SDL_PixelFormat) ; returns const char *

;- - Surface Creation and Simple Drawing
PrototypeC.a Proto_SDL_ConvertPixels(width.Sint32, height.Sint32, src_format.SDL_PixelFormat, *src, src_pitch.Sint32, dst_format.SDL_PixelFormat, *dst, dst_pitch.Sint32) ; returns bool
PrototypeC   Proto_SDL_DestroySurface(*surface.SDL_Surface)
PrototypeC.a Proto_SDL_FlipSurface(*surface.SDL_Surface, flip.SDL_FlipMode) ; returns bool
PrototypeC.i Proto_SDL_LoadBMP(file.p-utf8) ; returns SDL_Surface *
PrototypeC.a Proto_SDL_LockSurface(*surface.SDL_Surface) ; returns bool
PrototypeC.a Proto_SDL_SaveBMP(*surface.SDL_Surface, file.p-utf8) ; returns bool
PrototypeC   Proto_SDL_UnlockSurface(*surface.SDL_Surface)

;- - Clipboard Handling
PrototypeC.a Proto_SDL_SetClipboardText(text.p-utf8) ; returns bool

;- - Camera Support
PrototypeC.i Proto_SDL_AcquireCameraFrame(*camera.SDL_Camera, *timestampNS.QUAD) ; returns SDL_Surface *
PrototypeC   Proto_SDL_CloseCamera(*camera.SDL_Camera)
PrototypeC.a Proto_SDL_GetCameraFormat(*camera.SDL_Camera, *spec.SDL_CameraSpec) ; returns bool
PrototypeC.i Proto_SDL_GetCameraName(instance_id.SDL_CameraID) ; returns const char *
PrototypeC.l Proto_SDL_GetCameraPermissionState(*camera.SDL_Camera) ; returns int
PrototypeC.i Proto_SDL_GetCameraSupportedFormats(devid.SDL_CameraID, *count.LONG) ; returns SDL_CameraSpec **
PrototypeC.i Proto_SDL_GetCameras(*count.LONG) ; returns SDL_CameraID *
PrototypeC.l Proto_SDL_GetNumCameraDrivers() ; returns int
PrototypeC.i Proto_SDL_OpenCamera(instance_id.SDL_CameraID, *spec.SDL_CameraSpec) ; returns SDL_Camera *
PrototypeC   Proto_SDL_ReleaseCameraFrame(*camera.SDL_Camera, *frame.SDL_Surface)

;- - Event Handling
PrototypeC.l Proto_SDL_PeepEvents(*events.SDL_Event, numevents.Sint32, action.SDL_EventAction, minType.Uint32, maxType.Uint32) ; returns int
PrototypeC.a Proto_SDL_PollEvent(*event.SDL_Event) ; returns bool
PrototypeC   Proto_SDL_PumpEvents()
PrototypeC.a Proto_SDL_PushEvent(*event.SDL_Event) ; returns bool

;- - Keyboard Support
PrototypeC.i Proto_SDL_GetKeyboardState(*numkeys.LONG) ; returns const bool *

;- - Mouse Support
PrototypeC.l Proto_SDL_GetMouseState(*x.FLOAT, *y.FLOAT) ; returns SDL_MouseButtonFlags
PrototypeC.a Proto_SDL_HideCursor() ; returns bool
PrototypeC.a Proto_SDL_ShowCursor() ; returns bool

;- - Gamepad Support
PrototypeC.l Proto_SDL_AddGamepadMappingsFromFile(file.p-utf8) ; returns int
PrototypeC   Proto_SDL_CloseGamepad(*gamepad.SDL_Gamepad)
PrototypeC.w Proto_SDL_GetGamepadAxis(*gamepad.SDL_Gamepad, axis.SDL_GamepadAxis) ; returns Sint16
PrototypeC.a Proto_SDL_GetGamepadButton(*gamepad.SDL_Gamepad, button.SDL_GamepadButton) ; returns bool
PrototypeC.l Proto_SDL_GetGamepadID(*gamepad.SDL_Gamepad) ; returns SDL_JoystickID
PrototypeC.i Proto_SDL_GetGamepadJoystick(*gamepad.SDL_Gamepad) ; returns SDL_Joystick *
PrototypeC.i Proto_SDL_GetGamepadName(*gamepad.SDL_Gamepad) ; returns const char *
PrototypeC.i Proto_SDL_GetGamepads(*count.LONG) ; returns SDL_JoystickID *
PrototypeC.l Proto_SDL_GetGamepadType(*gamepad.SDL_Gamepad) ; returns SDL_GamepadType
PrototypeC.a Proto_SDL_HasGamepad() ; returns bool
PrototypeC.a Proto_SDL_IsGamepad(instance_id.SDL_JoystickID) ; returns bool
PrototypeC.i Proto_SDL_OpenGamepad(instance_id.SDL_JoystickID) ; returns SDL_Gamepad *
PrototypeC.a Proto_SDL_RumbleGamepad(*gamepad.SDL_Gamepad, low_frequency_rumble.Uint16, high_frequency_rumble.Uint16, duration_ms.Uint32) ; returns bool
PrototypeC   Proto_SDL_UpdateGamepads()

;- - Power Management Status
PrototypeC.l Proto_SDL_GetPowerInfo(*seconds.LONG, *percent.LONG) ; returns SDL_PowerState

;- - Message Boxes
PrototypeC.a Proto_SDL_ShowSimpleMessageBox(flags.SDL_MessageBoxFlags, title.p-utf8, message.p-utf8, *window.SDL_Window) ; returns bool
PrototypeC.a Proto_SDL_ShowMessageBox(*messageboxdata.SDL_MessageBoxData, *buttonid.LONG) ; returns bool







;-
;- OpenLibrary Variables

CompilerIf (#SDLx_UseOpenLibrary)

Global __SDLx_DynamicLibPath.s

Global __SDLxLib.i = #Null
Global __SDLx_Init.Proto_SDL_Init
Global __SDLx_Quit.Proto_SDL_Quit

Global __SDLx_InitCallback = #Null

;% DECLARE_DYNAMIC_PROTOTYPES

;% DELETESTART
Global SDL_free.Proto_SDL_free
Global SDL_GetCameraName.Proto_SDL_GetCameraName
Global SDL_GetGamepadName.Proto_SDL_GetGamepadName
Global SDL_GetError.Proto_SDL_GetError
Global SDL_GetPixelFormatName.Proto_SDL_GetPixelFormatName
Global SDL_GetVersion.Proto_SDL_GetVersion
Global SDL_InitSubsystem.Proto_SDL_InitSubsystem
Global SDL_PeepEvents.Proto_SDL_PeepEvents
Global SDL_PumpEvents.Proto_SDL_PumpEvents
Global SDL_QuitSubsystem.Proto_SDL_QuitSubsystem
Global SDL_SetRenderDrawColor.Proto_SDL_SetRenderDrawColor
;% DELETEEND

CompilerEndIf

;-
;- Function Imports

CompilerIf (#SDLx_UseImport)

ImportC #SDLx_ImportLibraryName
  
;% INDENT=1
;% STATIC_IMPORTS
;% INDENT=0
EndImport

CompilerEndIf



;-
;- PB Wrapper Procedures

CompilerIf (#SDLx_UseOpenLibrary)

Procedure SDL_Quit()
  If (__SDLxLib)
    __SDLx_Quit()
    CloseLibrary(__SDLxLib)
    __SDLxLib   = #Null
    __SDLx_Init = #Null
    __SDLx_Quit = #Null
    SDL_InitSubsystem = #Null
    SDL_QuitSubsystem = #Null
  Else
    __SDLx_Debug("SDL_Quit() called while not initialized")
  EndIf
EndProcedure

Procedure.a SDL_Init(flags.SDL_InitFlags)
  Protected Success.i = #False
  
  If (__SDLxLib = #Null)
    If (__SDLx_DynamicLibPath = "")
      __SDLx_DynamicLibPath = #SDLx_OpenLibraryDefaultName
    EndIf
    __SDLxLib = OpenLibrary(#PB_Any, __SDLx_DynamicLibPath)
    If (Not __SDLxLib)
      __SDLx_Debug("Failed to open SDL library '" + __SDLx_DynamicLibPath + "'")
    EndIf
  Else
    __SDLx_Debug("SDL_Init() called while already initialized")
  EndIf
  
  If (__SDLxLib)
    If (SDL_InitSubsystem)
      Success = SDL_InitSubsystem(flags)
    Else
      __SDLx_Init = GetFunction(__SDLxLib, "SDL_Init")
      If (__SDLx_Init)
        __SDLx_Quit = GetFunction(__SDLxLib, "SDL_Quit")
        If (__SDLx_Quit)
          Protected LoadFailed.i = #False
          
;% INDENT=5
;% LOAD_DYNAMIC_FUNCTIONS
          
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
  EndIf
  
  ProcedureReturn (Success)
EndProcedure

CompilerEndIf

;-
;- Helper Structures

CompilerIf (#True)

Structure SDLx_KeyboardStateArray
  ks.Uint8[0]
EndStructure

CompilerEndIf

;-
;- Helper Procedures

CompilerIf (#SDLx_IncludeHelperProcedures)

Procedure.i SDLx_LibraryLoaded()
  CompilerIf (#SDLx_UseImport)
    ProcedureReturn (#True)
  CompilerElse
    ProcedureReturn (Bool(__SDLx_Init))
  CompilerEndIf
EndProcedure

Procedure.s SDLx_PeekString(*strPtr, Free.i)
  Protected Result.s = ""
  If (*strPtr)
    Result = PeekS(*strPtr, -1, #PB_UTF8)
    If (Free)
      SDL_free(*strPtr)
    EndIf
  EndIf
  ProcedureReturn (Result)
EndProcedure

Procedure.s SDLx_GetCameraNameString(instance_id.SDL_CameraID)
  ProcedureReturn (SDLx_PeekString(SDL_GetCameraName(instance_id), #False))
EndProcedure

Procedure.s SDLx_GetGamepadNameString(*gamepad.SDL_Gamepad)
  ProcedureReturn (SDLx_PeekString(SDL_GetGamepadName(*gamepad), #False))
EndProcedure

Procedure.s SDLx_GetPixelFormatNameString(format.SDL_PixelFormat)
  ProcedureReturn (SDLx_PeekString(SDL_GetPixelFormatName(format), #False))
EndProcedure

Procedure.s SDLx_GetErrorString()
  ProcedureReturn (SDLx_PeekString(SDL_GetError(), #False))
EndProcedure

Procedure.a SDLx_SetRenderDrawRGBAValue(*renderer.SDL_Renderer, RGBAValue.i)
  ProcedureReturn (SDL_SetRenderDrawColor(*renderer, Red(RGBAValue), Green(RGBAValue), Blue(RGBAValue), Alpha(RGBAValue)))
EndProcedure

Procedure.a SDLx_SetRenderDrawRGBValue(*renderer.SDL_Renderer, RGBValue.i)
  ProcedureReturn (SDL_SetRenderDrawColor(*renderer, Red(RGBValue), Green(RGBValue), Blue(RGBValue), #SDL_ALPHA_OPAQUE))
EndProcedure

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
  CompilerIf (#SDLx_UseImport)
    Static HasRun.i = #False
    If (*Procedure And (Not HasRun))
      CallFunctionFast(*Procedure)
      HasRun = #True
    EndIf
  CompilerElse
    __SDLx_InitCallback = *Procedure
  CompilerEndIf
EndProcedure

Procedure.a SDLx_InitLibrary(LibraryFile.s, flags.SDL_InitFlags)
  CompilerIf (#SDLx_UseOpenLibrary)
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
