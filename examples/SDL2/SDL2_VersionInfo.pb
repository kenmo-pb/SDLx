; +---------------------+
; | SDL2_VersionInfo.pb |
; +---------------------+

;-

;#SDLx_StaticLink = #True
#SDLx_DebugErrors = #True
XIncludeFile "../../SDL2.pbi"

Debug "Loading " + #SDLx_LibName + " via '" + #SDLx_IncludeFilename + "'..."
Debug "(IncludeFile based on SDL version " + SDLx_CompiledVersionString() + ")"
Debug ""

If (SDL_Init(0) = #SDLx_INIT_SUCCESS)
  
  If (#SDLx_StaticLink)
    Debug "Initialized OK!"
    Debug "Statically linked SDL version " + SDLx_GetVersionString()
  Else
    Debug "Loaded and initialized OK!"
    Debug "Dynamically linked SDL version " + SDLx_GetVersionString()
  EndIf
  
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
