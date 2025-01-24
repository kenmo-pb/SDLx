; +----------------+
; | SDL3_Camera.pb |
; +----------------+

;-

;#SDLx_StaticLink = #True
;#SDLx_DebugErrors = #True
XIncludeFile "../../SDL3.pbi"

#WinH = 600

If (SDL_Init(#SDL_INIT_VIDEO | #SDL_INIT_CAMERA))
  
  *window.SDL_Window     = #Null
  *renderer.SDL_Renderer = #Null
  *camera.SDL_Camera     = #Null
  *texture.SDL_Texture   = #Null
  
  devcount.l
  *devices = SDL_GetCameras(@devcount)
  
  If ((*devices = #Null) Or (devcount = 0))
    Debug "No camera device could be found!"
    SDL_free(*devices)
    End
  EndIf
  
  firstID.l = PeekL(*devices)
  SDL_free(*devices)
  *camera = SDL_OpenCamera(firstID, #Null)
  If (Not *camera)
    Debug "Could not open camera!"
    End
  EndIf
  
  event.SDL_Event
  dstrect.SDL_FRect
  
  StartTime.i = ElapsedMilliseconds()
  
  While (Not SDLx_QuitRequested())
    
    While (SDL_PollEvent(@event))
      If (event\type = #SDL_EVENT_KEY_DOWN)
        ; [Escape] or [Ctrl+Q] or [Ctrl+W] to quit
        Select (event\key\scancode)
          Case #SDL_SCANCODE_ESCAPE
            event\type = #SDL_EVENT_QUIT
            SDL_PushEvent(@event)
          Case #SDL_SCANCODE_Q, #SDL_SCANCODE_W
            If (*window)
              If (event\key\mod & #SDL_KMOD_CTRL)
                event\type = #SDL_EVENT_QUIT
                SDL_PushEvent(@event)
              EndIf
            EndIf
        EndSelect
      EndIf
    Wend
    
    *frame.SDL_Surface = SDL_AcquireCameraFrame(*camera, #Null)
    If (*frame And (*frame\w > 0) And (*frame\h > 0))
      If (Not *texture)
        *window = SDL_CreateWindow(#PB_Compiler_Filename, #WinH * *frame\w / *frame\h, #WinH, 0)
        If (*window)
          *renderer = SDL_CreateRenderer(*window, #Null)
          If (*renderer)
            *texture = SDL_CreateTexture(*renderer, *frame\format, #SDL_TEXTUREACCESS_STREAMING, *frame\w, *frame\h)
            dstrect\w = *frame\w
            dstrect\h = *frame\h
            SDL_SetRenderLogicalPresentation(*renderer, *frame\w, *frame\h, #SDL_LOGICAL_PRESENTATION_STRETCH)
          EndIf
        EndIf
      EndIf
      If (*texture)
        SDL_UpdateTexture(*texture, #Null, *frame\pixels, *frame\pitch)
      EndIf
      SDL_ReleaseCameraFrame(*camera, *frame)
    EndIf
    
    SDL_SetRenderDrawColor(*renderer, $99, $99, $99, #SDL_ALPHA_OPAQUE)
    SDL_RenderClear(*renderer)
    If (*texture)
      ;SDL_RenderTexture(*renderer, *texture, #Null, @dstrect) ; draw texture exactly as-received
      SDL_RenderTextureRotated(*renderer, *texture, #Null, @dstrect, 0.0, #Null, #SDL_FLIP_HORIZONTAL) ; draw horizontally mirrored, more intuitive for a webcam
    EndIf
    SDL_RenderPresent(*renderer)
    
    If ((Not *texture) And (ElapsedMilliseconds() - StartTime > 5*1000))
      ; time out if no camera frames received
      Debug "No camera frames received!"
      Break
    EndIf
    
    Delay(20)
  Wend
  
  SDL_DestroyTexture(*texture)
  SDL_DestroyRenderer(*renderer)
  SDL_DestroyWindow(*window)
  SDL_CloseCamera(*camera)
  
  SDL_Quit()
EndIf

;-
