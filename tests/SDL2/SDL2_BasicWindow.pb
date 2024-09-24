; +---------------------+
; | SDL2_BasicWindow.pb |
; +---------------------+

;-

;#SDLx_DebugErrors = #True
XIncludeFile "../../SDL2.pbi"

#WinW = 640
#WinH = 480
#RectSize = #WinH/10
#BorderSize = 2

If (SDL_Init(#SDL_INIT_VIDEO) = #SDLx_INIT_SUCCESS)
  
  ; Open a basic window
  *window = SDL_CreateWindow(#PB_Compiler_Filename, #SDL_WINDOWPOS_CENTERED, #SDL_WINDOWPOS_CENTERED, #WinW, #WinH, #SDL_WINDOW_HIDDEN)
  If (*window)
    *renderer = SDL_CreateRenderer(*window, #SDLx_RENDERERINDEX_DEFAULT, #SDL_RENDERER_ACCELERATED)
    If (*renderer)
      
      ; Fill white background
      SDL_ShowWindow(*window)
      SDL_SetRenderDrawColor(*renderer, 255, 255, 255, #SDL_ALPHA_OPAQUE)
      SDL_RenderClear(*renderer)
      
      ; Draw a 4x4 grid of squares, color gradient black to green
      rect.SDL_Rect
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
      
      SDL_RenderPresent(*renderer)
      Delay(1.5 * 1000)
      
      SDL_DestroyRenderer(*renderer)
    EndIf
    
    SDL_DestroyWindow(*window)
  EndIf
  
  SDL_Quit()
EndIf

;-
