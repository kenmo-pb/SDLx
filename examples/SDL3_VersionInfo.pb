; +---------------------+
; | SDL3_VersionInfo.pb |
; +---------------------+
; | https://wiki.libsdl.org/SDL3/CategoryInit
; | https://wiki.libsdl.org/SDL3/CategoryVersion

;-

;#SDLx_UseImport = #True
#SDLx_DebugErrors = #True
#SDLx_AssertAllFunctionLoads = #True
XIncludeFile "../SDL3.pbi"

Debug "Loading " + #SDLx_LibName + " via '" + #SDLx_IncludeFilename + "'..."
Debug "(IncludeFile based on SDL version " + SDLx_CompiledVersionString() + ")"
Debug ""

If (SDL_Init(0))
  
  If (#SDLx_UseImport)
    Debug "Initialized OK!"
  Else
    Debug ""
    Debug "Loaded and initialized OK!"
  EndIf
  Debug "Linked SDL version " + SDLx_GetVersionString()
  Debug SDLx_LibraryPath()
  Debug "Revision: "  + SDLx_GetRevisionString()
  
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
