; +--------------------+
; | SDL2_MouseInput.pb |
; +--------------------+

;-

;#SDLx_StaticLink = #True
;#SDLx_DebugErrors = #True
XIncludeFile "../../SDL2.pbi"

#WinW = 800
#WinH = 600
RectSize.f = #WinH / 20
#RectMinSize = 2.0

If (SDL_Init(#SDL_INIT_VIDEO) = #SDLx_INIT_SUCCESS)
  
  ; Open a basic window...
  *window = SDL_CreateWindow(#PB_Compiler_Filename, #SDL_WINDOWPOS_CENTERED, #SDL_WINDOWPOS_CENTERED, #WinW, #WinH, #SDL_WINDOW_HIDDEN)
  If (*window)
    *renderer = SDL_CreateRenderer(*window, #SDLx_RENDERERINDEX_DEFAULT, #SDL_RENDERER_ACCELERATED | #SDL_RENDERER_PRESENTVSYNC)
    If (*renderer)
      
      SDL_ShowCursor(#SDL_DISABLE)
      
      ; Prepare some SDL structs
      event.SDL_Event
      MouseX.i = #WinW/2
      MouseY.i = #WinH/2
      MouseButtons.i
      rect.SDL_Rect
      HasShown.i = #False
      
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
          
          ElseIf (event\type = #SDL_MOUSEMOTION)
            MouseX = event\motion\x
            MouseY = event\motion\y
            
          ElseIf (event\type = #SDL_MOUSEWHEEL)
            ; check \direction here to flip scroll value?
            If (event\wheel\preciseY <> 0.0)
              RectSize * (1.0 + (0.1 * event\wheel\preciseY))
            Else
              RectSize / (1.0 + (0.1 * event\wheel\y))
            EndIf
            If (RectSize < #RectMinSize)
              RectSize = #RectMinSize
            EndIf
          
          EndIf
        Wend
        
        If (Not ExitFlag)
          
          ; Get mouse status
          ;MouseButtons = SDL_GetMouseState(@MouseX, @MouseY) ; get coordinates from MOUSEMOTION events instead, above
          MouseButtons = SDL_GetMouseState(#Null, #Null)
          
          ; Draw screen...
          
          ; Fill light green background
          SDL_SetRenderDrawColor(*renderer, 192, 255, 192, #SDL_ALPHA_OPAQUE)
          SDL_RenderClear(*renderer)
          
          ; Draw "cursor" square
          rect\x = MouseX - RectSize/2
          rect\y = MouseY - RectSize/2
          rect\w = RectSize
          rect\h = RectSize
          SDL_SetRenderDrawColor(*renderer, 255*Bool(MouseButtons & #SDL_BUTTON_LMASK), 255*Bool(MouseButtons & #SDL_BUTTON_MMASK), 255*Bool(MouseButtons & #SDL_BUTTON_RMASK), #SDL_ALPHA_OPAQUE)
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
