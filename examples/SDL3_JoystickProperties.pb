; +----------------------------+
; | SDL3_JoystickProperties.pb |
; +----------------------------+
; | https://wiki.libsdl.org/SDL3/CategoryGamepad
; | https://wiki.libsdl.org/SDL3/CategoryJoystick
; | https://wiki.libsdl.org/SDL3/CategoryHaptic

;-

;#SDLx_UseImport = #True
;#SDLx_DebugErrors = #True
#SDLx_ExcludeHapticSupport = #False
XIncludeFile "../SDL3.pbi"

#RumbleStrength = $8000
#RumbleMS = 250

If (SDL_Init(#SDL_INIT_JOYSTICK | #SDL_INIT_GAMEPAD | #SDL_INIT_HAPTIC))
  
  Debug "HasJoystick() = " + Str(SDL_HasJoystick())
  Debug "HasGamepad() = " + Str(SDL_HasGamepad())
  
  If (SDL_HasJoystick())
    
    count.l = 0
    *joysticks.SDLx_IDArray = SDL_GetJoysticks(@count)
    Debug ""
    Debug "Number of Joysticks = " + Str(count)
    
    For j.i = 0 To count-1
      jid.SDL_JoystickID = *joysticks\id[j]
      Debug ""
      Debug RSet("", 40, "-")
      Debug "JoystickID " + Str(jid)
      *joystick.SDL_Joystick = SDL_OpenJoystick(jid)
      If (*joystick)
        Debug "OpenJoystick() OK"
        
        Debug "GetJoystickName() = " + #DQUOTE$ + SDLx_GetJoystickNameString(*joystick) + #DQUOTE$
        
        Select (SDL_GetJoystickConnectionState(*joystick))
          Case #SDL_JOYSTICK_CONNECTION_WIRED
            Debug "ConnectionState Wired"
          Case #SDL_JOYSTICK_CONNECTION_WIRELESS
            Debug "ConnectionState Wireless"
          Case #SDL_JOYSTICK_CONNECTION_UNKNOWN
            Debug "ConnectionState Unknown"
          Default
            Debug "ConnectionState Invalid"
        EndSelect
        
        percent.l
        state.l = SDL_GetJoystickPowerInfo(*joystick, @percent)
        Select (state)
          Case #SDL_POWERSTATE_NO_BATTERY
            Debug "Wired"
          Case #SDL_POWERSTATE_ON_BATTERY, #SDL_POWERSTATE_CHARGING, #SDL_POWERSTATE_CHARGED
            If (percent > 0)
              Debug "Wireless (" + Str(percent) + "%)"
            Else
              Debug "Wireless"
            EndIf
          Case #SDL_POWERSTATE_ERROR
            Debug "PowerInfo Error"
          Default
            Debug "PowerInfo Unknown"
        EndSelect
        
        Debug "IsJoystickHaptic() = " + Str(SDL_IsJoystickHaptic(*joystick))
        
        Debug "RumbleJoystick() = " + Str(SDL_RumbleJoystick(*joystick, #RumbleStrength, #RumbleStrength, #RumbleMS))
        Delay(2 * #RumbleMS)
        SDL_RumbleJoystick(*joystick, 0, 0, 1)
        
        props.SDL_PropertiesID = SDL_GetJoystickProperties(*joystick)
        If (props)
          Debug "GetJoystickProperties():"
          Debug RTrim(SDLx_GetPropertiesStringRepresentations(props, "(none)"), #LF$)
        EndIf
        
        SDL_CloseJoystick(*joystick)
        
        If (SDL_IsGamepad(jid))
          Debug "..."
          Debug "IsGamepad() = 1"
          *gamepad.SDL_Gamepad = SDL_OpenGamepad(jid)
          If (*gamepad)
            Debug "OpenGamepad() OK"
            
            Debug "GetGamepadName() = " + #DQUOTE$ + SDLx_GetGamepadNameString(*gamepad) + #DQUOTE$
            
            Debug "Mapping = " + SDLx_GetGamepadMappingString(*gamepad)
            
            Select (SDL_GetGamepadConnectionState(*gamepad))
              Case #SDL_JOYSTICK_CONNECTION_WIRED
                Debug "ConnectionState Wired"
              Case #SDL_JOYSTICK_CONNECTION_WIRELESS
                Debug "ConnectionState Wireless"
              Case #SDL_JOYSTICK_CONNECTION_UNKNOWN
                Debug "ConnectionState Unknown"
              Default
                Debug "ConnectionState Invalid"
            EndSelect
            
            state.l = SDL_GetGamepadPowerInfo(*gamepad, @percent)
            Select (state)
              Case #SDL_POWERSTATE_NO_BATTERY
                Debug "Wired"
              Case #SDL_POWERSTATE_ON_BATTERY, #SDL_POWERSTATE_CHARGING, #SDL_POWERSTATE_CHARGED
                If (percent > 0)
                  Debug "Wireless (" + Str(percent) + "%)"
                Else
                  Debug "Wireless"
                EndIf
              Case #SDL_POWERSTATE_ERROR
                Debug "PowerInfo Error"
              Default
                Debug "PowerInfo Unknown"
            EndSelect
            
            Debug "RumbleGamepad() = " + Str(SDL_RumbleGamepad(*gamepad, #RumbleStrength, #RumbleStrength, #RumbleMS))
            Delay(2 * #RumbleMS)
            SDL_RumbleGamepad(*gamepad, 0, 0, 1)
            
            props.SDL_PropertiesID = SDL_GetGamepadProperties(*gamepad)
            If (props)
              Debug "GetGamepadProperties():"
              Debug RTrim(SDLx_GetPropertiesStringRepresentations(props, "(none)"), #LF$)
            EndIf
            
            SDL_CloseGamepad(*gamepad)
          Else
            Debug "OpenGamepad() failed!"
          EndIf
        Else
          Debug "IsGamepad() = 0"
        EndIf
      Else
        Debug "OpenJoystick() failed!"
      EndIf
      Debug RSet("", 40, "-")
      Delay(500)
    Next j
    
  EndIf
  
  SDL_Quit()
EndIf

;-
