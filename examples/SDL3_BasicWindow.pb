; +---------------------+
; | SDL3_BasicWindow.pb |
; +---------------------+

;-

;#SDLx_UseImport = #True
;#SDLx_DebugErrors = #True
XIncludeFile "../SDL3.pbi"

#WinW = 800
#WinH = 600
#RectSize = #WinH/10
#BorderSize = 2

If (SDL_Init(#SDL_INIT_VIDEO))
  
  ; Open a basic window...
  *window = SDL_CreateWindow(#PB_Compiler_Filename, #WinW, #WinH, #SDL_WINDOW_HIDDEN)
  If (*window)
    *renderer = SDL_CreateRenderer(*window, #Null$)
    If (*renderer)
      
      ; Fill white background
      SDL_ShowWindow(*window)
      SDL_SetRenderDrawColor(*renderer, 255, 255, 255, #SDL_ALPHA_OPAQUE)
      SDL_RenderClear(*renderer)
      
      ; Draw a 4x4 grid of squares, color gradient black to green
      rect.SDL_FRect
      rect\w = #RectSize - 2*#BorderSize
      rect\h = #RectSize - 2*#BorderSize
      For y = 0 To 3
        For x = 0 To 3
          i = x + (y*4)
          rect\x = #WinW/2 - #RectSize*2 + x*#RectSize + #BorderSize
          rect\y = #WinH/2 - #RectSize*2 + y*#RectSize + #BorderSize
          SDL_SetRenderDrawColor(*renderer, 0, i*17, 0, #SDL_ALPHA_OPAQUE)
          SDL_RenderFillRect(*renderer, @rect)
        Next x
      Next y
      
      ; Wait until Quit Requested (typically window close button, or Alt+F4, etc.)
      SDL_RenderPresent(*renderer)
      While (Not SDLx_QuitRequested())
        Delay(10)
      Wend
      
      SDL_DestroyRenderer(*renderer)
    EndIf
    
    SDL_DestroyWindow(*window)
  EndIf
  
  SDL_Quit()
EndIf

;-
