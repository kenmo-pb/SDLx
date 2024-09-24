; +---------------------+
; | SDL2_VersionInfo.pb |
; +---------------------+

;-

#SDLx_DebugErrors = #True
XIncludeFile "../../SDL2.pbi"

Debug "Loading " + #SDLx_LibName + " library via SDLx includefiles..."

Debug "Compiled for SDL " + SDLx_CompiledVersionString()

If (SDL_Init(0) = #SDLx_INIT_SUCCESS)
  
  If (#SDLx_StaticLink)
    Debug "Statically linked SDL " + SDLx_GetVersionString()
  Else
    Debug "Dynamically linked SDL " + SDLx_GetVersionString()
  EndIf
  
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
