; +---------------------+
; | SDL3_VersionInfo.pb |
; +---------------------+

;-

;#SDLx_UseImport = #True
#SDLx_DebugErrors = #True
XIncludeFile "../SDL3.pbi"

Debug "Loading " + #SDLx_LibName + " via '" + #SDLx_IncludeFilename + "'..."
Debug "(IncludeFile based on SDL version " + SDLx_CompiledVersionString() + ")"
Debug ""

If (SDL_Init(0))
  
  If (#SDLx_UseImport)
    Debug "Initialized OK!"
  Else
    Debug "Loaded and initialized OK!"
  EndIf
  Debug "Linked SDL version " + SDLx_GetVersionString()
  
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
