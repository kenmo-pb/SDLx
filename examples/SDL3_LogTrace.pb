; +------------------+
; | SDL3_LogTrace.pb |
; +------------------+
; | https://wiki.libsdl.org/SDL3/CategoryInit
; | https://wiki.libsdl.org/SDL3/CategoryLog

;-

;#SDLx_UseImport = #True
;#SDLx_DebugErrors = #True
#SDLx_IncludeHelperProcedures = #True
XIncludeFile "../SDL3.pbi"

Procedure PreInit()
  SDL_SetAppMetadata(#PB_Compiler_Filename, #Null$, #Null$)
  
  SDL_SetLogPriorities(#SDL_LOG_PRIORITY_TRACE)
  SDLx_LogToPBDebugger(#True)
EndProcedure

If (SDLx_InitWithPostLoadPreInitCallback(#SDL_INIT_VIDEO | #SDL_INIT_GAMEPAD | #SDL_INIT_AUDIO, @PreInit()))
  Delay(1*1000)
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
