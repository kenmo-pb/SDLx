; +-------------------+
; | SDL3_PowerInfo.pb |
; +-------------------+

;-

;#SDLx_StaticLink = #True
#SDLx_DebugErrors = #True
XIncludeFile "../SDL3.pbi"

If (SDL_Init(0))
  
  seconds.l
  percent.l
  
  Select SDL_GetPowerInfo(@seconds, @percent)
    
    Case #SDL_POWERSTATE_ERROR
      Debug "GetPowerInfo returned ERROR"
    Case #SDL_POWERSTATE_UNKNOWN
      Debug "GetPowerInfo returned UNKNOWN"
    Case #SDL_POWERSTATE_NO_BATTERY
      Debug "GetPowerInfo returned NO BATTERY"
      
    Case #SDL_POWERSTATE_ON_BATTERY
      Debug "You are ON BATTERY"
      If (percent >= 0)
        Debug Str(percent) + "%"
      EndIf
      If (seconds >= 0)
        Debug Str(seconds / 60) + " minutes remaining"
      EndIf
      
    Case #SDL_POWERSTATE_CHARGING
      Debug "You are CHARGING"
      If (percent >= 0)
        Debug Str(percent) + "%"
      EndIf
      
    Case #SDL_POWERSTATE_CHARGED
      Debug "You are CHARGED"
      If (percent >= 0)
        Debug Str(percent) + "%"
      EndIf
      
  EndSelect
  
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
