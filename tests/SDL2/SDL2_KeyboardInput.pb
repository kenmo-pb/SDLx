; +-----------------------+
; | SDL2_KeyboardInput.pb |
; +-----------------------+

;-

;#SDLx_DebugErrors = #True
XIncludeFile "../../SDL2.pbi"

#WinW = 800
#WinH = 600
#RectSize = #WinH/10

If (SDL_Init(#SDL_INIT_VIDEO) = #SDLx_INIT_SUCCESS)
  
  ; Open a basic window...
  *window = SDL_CreateWindow(#PB_Compiler_Filename, #SDL_WINDOWPOS_CENTERED, #SDL_WINDOWPOS_CENTERED, #WinW, #WinH, #SDL_WINDOW_HIDDEN)
  If (*window)
    *renderer = SDL_CreateRenderer(*window, #SDLx_RENDERERINDEX_DEFAULT, #SDL_RENDERER_ACCELERATED | #SDL_RENDERER_PRESENTVSYNC)
    If (*renderer)
      
      ; Initialize some basic gameplay variables
      PlayerX.f = #WinW/2 - #RectSize/2
      PlayerY.f = 0.0
      PlayerXVel.f = 0.0
      PlayerYVel.f = 0.0
      MaxXVel.f = #RectSize / 5
      PlayerInAir.i = #False
      JumpVel.f = #RectSize / 2.0
      Gravity.f = #RectSize / 60.0
      
      ; Prepare some SDL structs
      event.SDL_Event
      rect.SDL_Rect
      rect\w = #RectSize
      rect\h = #RectSize
      HasShown.i = #False
      
      NumKeyStates.i
      *KeyState.SDLx_KeyboardStateArray = SDL_GetKeyboardState(@NumKeyStates)
      
      
      ; Main Loop
      
      ExitFlag.i = #False
      While (Not ExitFlag)
        
        ; Process SDL events...
        SDL_PumpEvents()
        While (SDL_PollEvent(@event))
          If (event\type = #SDL_QUIT)
            ExitFlag = #True
          ElseIf (event\type = #SDL_KEYDOWN)
            
            ; [Escape] or [Ctrl+Q] or [Ctrl+W] to quit
            Select (event\key\keysym\scancode)
              Case #SDL_SCANCODE_ESCAPE
                event\type = #SDL_QUIT
                SDL_PushEvent(@event)
              Case #SDL_SCANCODE_Q, #SDL_SCANCODE_W
                If (event\key\keysym\mod & #KMOD_CTRL)
                  event\type = #SDL_QUIT
                  SDL_PushEvent(@event)
                EndIf
            EndSelect
          EndIf
        Wend
        
        If (Not ExitFlag)
          
          ; Player control and physics...
          
          If (PlayerInAir)
            ; Motion in air
            PlayerYVel - Gravity
            PlayerY + PlayerYVel
            If (PlayerY < 0.0)
              If (PlayerYVel < -JumpVel * 0.25)
                PlayerY - PlayerYVel
                PlayerYVel = -PlayerYVel * 0.5
              Else
                PlayerInAir = #False
              EndIf
            EndIf
          Else
            ; Jump if [Up] or [W] or [Space] pressed
            If (*KeyState\ks[#SDL_SCANCODE_UP] Or *KeyState\ks[#SDL_SCANCODE_W] Or *KeyState\ks[#SDL_SCANCODE_SPACE])
              PlayerInAir = #True
              PlayerYVel = JumpVel
            EndIf
          EndIf
          
          ; Horizontal control (arrows or WASD)
          If (*KeyState\ks[#SDL_SCANCODE_RIGHT] Or *KeyState\ks[#SDL_SCANCODE_D])
            PlayerXVel + 1.0
            If (PlayerXVel > MaxXVel)
              PlayerXVel = MaxXVel
            EndIf
          ElseIf (*KeyState\ks[#SDL_SCANCODE_LEFT] Or *KeyState\ks[#SDL_SCANCODE_A])
            PlayerXVel - 1.0
            If (PlayerXVel < -MaxXVel)
              PlayerXVel = -MaxXVel
            EndIf
          Else
            If (PlayerInAir)
              PlayerXVel * 0.99
            Else
              PlayerXVel * 0.75
            EndIf
          EndIf
          PlayerX + PlayerXVel
          
          ; Bounce or stop at left edge
          If (PlayerX < 0.0)
            If (PlayerXVel < -MaxXVel * 0.7) And (PlayerInAir)
              PlayerX = 0.0
              PlayerXVel * -0.75
            Else
              PlayerX = 0.0
              PlayerXVel = 0.0
            EndIf
          
          ; Bounce or stop at right edge
          ElseIf (PlayerX > #WinW - #RectSize)
            If (PlayerXVel > MaxXVel * 0.7) And (PlayerInAir)
              PlayerX = #WinW - #RectSize
              PlayerXVel * -0.75
            Else
              PlayerX = #WinW - #RectSize
              PlayerXVel = 0.0
            EndIf
          EndIf
          
          ; Stop on "ground"
          If (Not PlayerInAir)
            PlayerY = 0.0
            PlayerYVel = 0.0
          EndIf
          
          
          ; Draw screen...
          
          ; Fill light blue background
          SDL_SetRenderDrawColor(*renderer, 192, 255, 255, #SDL_ALPHA_OPAQUE)
          SDL_RenderClear(*renderer)
          
          ; Draw player (red square)
          rect\x = PlayerX
          rect\y = #WinH - #RectSize - PlayerY
          SDL_SetRenderDrawColor(*renderer, 255, 0, 0, #SDL_ALPHA_OPAQUE)
          SDL_RenderFillRect(*renderer, @rect)
          
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
  
  SDL_Quit()
EndIf

;-
