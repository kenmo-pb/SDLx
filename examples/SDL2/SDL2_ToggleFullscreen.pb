; +--------------------------+
; | SDL2_FullscreenToggle.pb |
; +--------------------------+

;-

;#SDLx_DebugErrors = #True
XIncludeFile "../../SDL2.pbi"

#WinW = 600
#WinH = 600
#RectSize = #WinH/10
#BorderSize = 2

Global *window, *renderer
Global IsFullscreen.i = #False

Procedure Redraw()
  Static HasShown.i = #False
  Static rect.SDL_Rect
  
  If (IsFullscreen Or (#True))
    ; Black borders
    SDL_SetRenderDrawColor(*renderer, 0, 0, 0, #SDL_ALPHA_OPAQUE)
    SDL_RenderClear(*renderer)
    ; Fill light yellow area
    SDL_SetRenderDrawColor(*renderer, 255, 255, 192, #SDL_ALPHA_OPAQUE)
    rect\x = 0
    rect\y = 0
    rect\w = #WinW
    rect\h = #WinH
    SDL_RenderFillRect(*renderer, @rect)
  Else
    ; Fill light yellow background
    SDL_SetRenderDrawColor(*renderer, 255, 255, 192, #SDL_ALPHA_OPAQUE)
    SDL_RenderClear(*renderer)
  EndIf
  
  ; Draw a 4x4 grid of squares, color gradient red to blue
  rect\w = #RectSize - 2*#BorderSize
  rect\h = #RectSize - 2*#BorderSize
  For y = 0 To 3
    For x = 0 To 3
      i = x + (y*4)
      rect\x = #WinW/2 - #RectSize*2 + x*#RectSize + #BorderSize
      rect\y = #WinH/2 - #RectSize*2 + y*#RectSize + #BorderSize
      SDL_SetRenderDrawColor(*renderer, 255 - i*17, 0, i*17, #SDL_ALPHA_OPAQUE)
      SDL_RenderFillRect(*renderer, @rect)
    Next x
  Next y
  If (Not HasShown)
    SDL_ShowWindow(*window)
    HasShown = #True
  EndIf
  SDL_RenderPresent(*renderer)
  
EndProcedure

If (SDL_Init(#SDL_INIT_VIDEO) = #SDLx_INIT_SUCCESS)
  
  ; Open a basic window...
  *window = SDL_CreateWindow(#PB_Compiler_Filename, #SDL_WINDOWPOS_CENTERED, #SDL_WINDOWPOS_CENTERED, #WinW, #WinH, #SDL_WINDOW_RESIZABLE | #SDL_WINDOW_HIDDEN)
  If (*window)
    *renderer = SDL_CreateRenderer(*window, #SDLx_RENDERERINDEX_DEFAULT, #SDL_RENDERER_ACCELERATED)
    If (*renderer)
      
      ; Wait until Quit Requested (typically window close button, or Alt+F4, etc.)
      event.SDL_Event
      Redraw()
      While (Not SDL_QuitRequested())
        While (SDL_PollEvent(@event))
          If (event\type = #SDL_KEYDOWN)
            Select (event\key\keysym\scancode)
              
              ; [Escape] or [Ctrl-W] or [Ctrl-Q] to quit
              Case #SDL_SCANCODE_ESCAPE
                event\type = #SDL_QUIT
                SDL_PushEvent(@event)
              Case #SDL_SCANCODE_W, #SDL_SCANCODE_Q
                If (event\key\keysym\mod & #KMOD_CTRL)
                  event\type = #SDL_QUIT
                  SDL_PushEvent(@event)
                EndIf
                
              Case #SDL_SCANCODE_F ; Press [F] to toggle between Windows and Fullscreen Desktop!
                If (IsFullscreen)
                  SDL_SetWindowFullscreen(*window, #SDLx_WINDOW_NOT_FULLSCREEN)
                  SDL_ShowCursor(#SDL_ENABLE)
                  IsFullscreen = #False
                Else
                  SDL_RenderSetLogicalSize(*renderer, #WinW, #WinH)
                  SDL_SetWindowFullscreen(*window, #SDL_WINDOW_FULLSCREEN_DESKTOP)
                  SDL_ShowCursor(#SDL_DISABLE)
                  IsFullscreen = #True
                EndIf
                
            EndSelect
          EndIf
        Wend
        
        Redraw()
        Delay(10)
      Wend
      
      SDL_DestroyRenderer(*renderer)
    EndIf
    
    SDL_DestroyWindow(*window)
  EndIf
  
  SDL_Quit()
EndIf

;-
