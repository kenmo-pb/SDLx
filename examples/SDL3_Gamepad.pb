; +-----------------+
; | SDL3_Gamepad.pb |
; +-----------------+
; | https://wiki.libsdl.org/SDL3/CategoryGamepad
; | https://wiki.libsdl.org/SDL3/CategoryJoystick
; | https://wiki.libsdl.org/SDL3/CategoryHaptic

;-

;#SDLx_UseImport = #True
;#SDLx_DebugErrors = #True
#SDLx_ExcludeHapticSupport = #False
XIncludeFile "../SDL3.pbi"

#WinW = 800
#WinH = 600
RectSize.f = #WinH / 20
#RectMinSize = 2.0

Macro ColorForButton(GamepadButton)
  ($404040) + Bool(SDL_GetGamepadButton(*gamepad, (GamepadButton))) * $00A000
EndMacro

Macro ColorForAxis(GamepadAxis)
  ($404040) + Bool(SDLx_GetGamepadAxisFloat(*gamepad, (GamepadAxis)) > 0.10) * $00A000
EndMacro

If (SDL_Init(#SDL_INIT_VIDEO | #SDL_INIT_GAMEPAD | #SDL_INIT_HAPTIC))
  
  ; Check for at least one gamepad...
  If (Not SDL_HasGamepad())
    MessageRequester(#PB_Compiler_Filename, "No gamepad connected (or gamepad not recognized by SDL)!", #PB_MessageRequester_Error)
    SDL_Quit()
    End
  EndIf
  
  *gamepad.SDL_Gamepad = #Null
  count.l = 0
  *IDA.SDLx_IDArray = SDL_GetGamepads(@count)
  If (*IDA)
    Debug "Recognized " + Str(count) + " gamepad(s)"
    If (count > 0)
      For i = 0 To count - 1
        Debug "  [" + Str(i) + "] " + SDLx_GetGamepadNameForIDString(*IDA\id[i])
        If (Not *gamepad)
          *gamepad = SDL_OpenGamepad(*IDA\id[i])
          If (*gamepad)
            Debug "    (Opened!)"
          EndIf
        EndIf
      Next i
    EndIf
    SDL_free(*IDA)
    Debug ""
  EndIf
  
  count.l = 0
  *IDA.SDLx_IDArray = SDL_GetHaptics(@count)
  If (*IDA)
    If (count > 0)
      *haptic = SDL_OpenHaptic(*IDA\id[0])
      If (*haptic)
        If (Not SDL_InitHapticRumble(*haptic))
          SDL_CloseHaptic(*haptic)
          *haptic = #Null
        EndIf
      EndIf
      If (Not *haptic)
        Debug "Could not open Haptic (Force Feedback / Rumble)"
        Debug ""
      EndIf
    EndIf
    SDL_free(*IDA)
  EndIf
  
  ; Open a basic window...
  *window = SDLx_CreateWindowCentered(#PB_Compiler_Filename, #WinW, #WinH, #SDL_WINDOW_HIDDEN)
  If (*window)
    *renderer = SDL_CreateRenderer(*window, #Null$)
    If (*renderer)
      
      ; Prepare some SDL structs
      event.SDL_Event
      HasShown.i = #False
      
      ; Main Loop
      
      ExitFlag.i = #False
      While (Not ExitFlag)
        
        ; Process SDL events...
        SDL_PumpEvents()
        While (SDL_PollEvent(@event))
          If (event\type = #SDL_EVENT_QUIT)
            ExitFlag = #True
          ElseIf (event\type = #SDL_EVENT_KEY_DOWN)
            
            ; [Escape] or [Ctrl+Q] or [Ctrl+W] to quit
            Select (event\key\scancode)
              Case #SDL_SCANCODE_ESCAPE
                event\type = #SDL_EVENT_QUIT
                SDL_PushEvent(@event)
              Case #SDL_SCANCODE_Q, #SDL_SCANCODE_W
                If (event\key\mod & #SDL_KMOD_CTRL)
                  event\type = #SDL_EVENT_QUIT
                  SDL_PushEvent(@event)
                EndIf
            EndSelect
          
          ElseIf (event\type = #SDL_EVENT_GAMEPAD_BUTTON_DOWN)
            If (event\gbutton\button = #SDL_GAMEPAD_BUTTON_START)
              If (*haptic)
                Debug "Start! Rumble!"
                SDL_PlayHapticRumble(*haptic, 1.0, 250)
              Else
                Debug "Start! (No rumble)"
              EndIf
            EndIf
          
          EndIf
        Wend
        
        If (Not ExitFlag)
          
          ; Draw screen...
          
          ; Fill background
          SDL_SetRenderDrawColor(*renderer, 192, 192, 192, #SDL_ALPHA_OPAQUE)
          SDL_RenderClear(*renderer)
          
          
          ; Draw four main "letter" buttons
          rad.f = #WinH * 0.10
          cx.f = #WinW * 0.75
          cy.f = #WinH * 0.40
          SDLx_DrawRect(*renderer, cx, cy - rad, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_NORTH))
          SDLx_DrawRect(*renderer, cx, cy + rad, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_SOUTH))
          SDLx_DrawRect(*renderer, cx - rad, cy, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_WEST))
          SDLx_DrawRect(*renderer, cx + rad, cy, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_EAST))
          
          ; Draw d-pad
          rad.f = RectSize
          cx.f = #WinW * 0.25
          cy.f = #WinH * 0.40
          SDLx_DrawRect(*renderer, cx, cy - rad, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_DPAD_UP))
          SDLx_DrawRect(*renderer, cx, cy + rad, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_DPAD_DOWN))
          SDLx_DrawRect(*renderer, cx - rad, cy, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_DPAD_LEFT))
          SDLx_DrawRect(*renderer, cx + rad, cy, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_DPAD_RIGHT))
          
          ; Draw shoulders
          SDLx_DrawRect(*renderer, #WinW * 0.25, #WinH * 0.20, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_LEFT_SHOULDER))
          SDLx_DrawRect(*renderer, #WinW * 0.75, #WinH * 0.20, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_RIGHT_SHOULDER))
          
          ; Draw triggers
          rad.f = RectSize
          SDLx_DrawRect(*renderer, #WinW * 0.25, #WinH * 0.15 - rad*SDLx_GetGamepadAxisFloat(*gamepad, #SDL_GAMEPAD_AXIS_LEFT_TRIGGER), RectSize, RectSize, ColorForAxis(#SDL_GAMEPAD_AXIS_LEFT_TRIGGER))
          SDLx_DrawRect(*renderer, #WinW * 0.75, #WinH * 0.15 - rad*SDLx_GetGamepadAxisFloat(*gamepad, #SDL_GAMEPAD_AXIS_RIGHT_TRIGGER), RectSize, RectSize, ColorForAxis(#SDL_GAMEPAD_AXIS_RIGHT_TRIGGER))
          
          ; Draw Start/Back
          SDLx_DrawRect(*renderer, #WinW * 0.45, #WinH * 0.35, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_BACK))
          SDLx_DrawRect(*renderer, #WinW * 0.55, #WinH * 0.35, RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_START))
          
          ; Draw Left/Right sticks
          rad.f = #WinH * 0.10
          cx.f = #WinW * 0.25
          cy.f = #WinH * 0.70
          SDLx_DrawRect(*renderer, cx + rad*SDLx_GetGamepadAxisFloat(*gamepad, #SDL_GAMEPAD_AXIS_LEFTX), cy + rad*SDLx_GetGamepadAxisFloat(*gamepad, #SDL_GAMEPAD_AXIS_LEFTY), RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_LEFT_STICK))
          cx.f = #WinW * 0.75
          SDLx_DrawRect(*renderer, cx + rad*SDLx_GetGamepadAxisFloat(*gamepad, #SDL_GAMEPAD_AXIS_RIGHTX), cy + rad*SDLx_GetGamepadAxisFloat(*gamepad, #SDL_GAMEPAD_AXIS_RIGHTY), RectSize, RectSize, ColorForButton(#SDL_GAMEPAD_BUTTON_RIGHT_STICK))
          
          
          If (Not HasShown)
            SDL_ShowWindow(*window)
          EndIf
          SDL_RenderPresent(*renderer)
          Delay(16)
        EndIf
      Wend
      
      
      SDL_DestroyRenderer(*renderer)
    EndIf
    
    SDL_DestroyWindow(*window)
  EndIf
  
  SDL_CloseHaptic(*haptic)
  SDL_CloseGamepad(*gamepad)
  
  SDL_Quit()
  CloseDebugOutput()
EndIf

;-
