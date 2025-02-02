; +--------------------+
; | SDL3_LoadBitmap.pb |
; +--------------------+

;-

;#SDLx_UseImport = #True
;#SDLx_DebugErrors = #True
XIncludeFile "../SDL3.pbi"

#WinW = 640
#WinH = 480

If (SDL_Init(#SDL_INIT_VIDEO))
  
  ; Open a basic window...
  *window = SDL_CreateWindow(#PB_Compiler_Filename, #WinW, #WinH, #SDL_WINDOW_HIDDEN)
  If (*window)
    *renderer = SDL_CreateRenderer(*window, #Null$)
    If (*renderer)
      
      ImageFile.s = #PB_Compiler_Home + "examples" + #PS$ + "sources" + #PS$ + "Data" + #PS$ + "PureBasicLogo.bmp"
      *surface.SDL_Surface = SDL_LoadBMP(ImageFile)
      If (*surface)
        rect.SDL_FRect
        rect\w = *surface\w
        rect\h = *surface\h
        rect\x = 0
        rect\y = #WinH / 3
        xVel = 1
        yVel = -1
        
        *texture = SDL_CreateTextureFromSurface(*renderer, *surface)
        If (*texture)
          
          HasShown = #False
          event.SDL_Event
          While (Not SDLx_QuitRequested())
            While (SDL_PollEvent(@event))
              If (event\type = #SDL_EVENT_KEY_DOWN)
                Select (event\key\scancode)
                  Case #SDL_SCANCODE_ESCAPE
                    event\type = #SDL_EVENT_QUIT
                    SDL_PushEvent(@event)
                  Case #SDL_SCANCODE_W, #SDL_SCANCODE_Q
                    If (event\key\mod & #SDL_KMOD_CTRL)
                      event\type = #SDL_EVENT_QUIT
                      SDL_PushEvent(@event)
                    EndIf
                EndSelect
              EndIf
            Wend
            
            ; Move bitmap around window
            rect\x + xVel
            If (rect\x = 0) Or (rect\x = #WinW - rect\w)
              xVel * -1
            EndIf
            rect\y + yVel
            If (rect\y = 0) Or (rect\y = #WinH - rect\h)
              yVel * -1
            EndIf
            
            ; Fill white background
            SDL_SetRenderDrawColor(*renderer, 255, 255, 255, #SDL_ALPHA_OPAQUE)
            SDL_RenderClear(*renderer)
            SDL_RenderTexture(*renderer, *texture, #Null, @rect)
            If (Not HasShown)
              SDL_ShowWindow(*window)
              HasShown = #True
            EndIf
            SDL_RenderPresent(*renderer)
            
            Delay(10)
          Wend
          
          SDL_DestroyTexture(*texture)
        EndIf
        SDL_DestroySurface(*surface)
      Else
        Debug "Could not load bitmap: " + ImageFile
      EndIf
      
      SDL_DestroyRenderer(*renderer)
    EndIf
    
    SDL_DestroyWindow(*window)
  EndIf
  
  SDL_Quit()
EndIf

;-
