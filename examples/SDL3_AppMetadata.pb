; +---------------------+
; | SDL3_AppMetadata.pb |
; +---------------------+
; | https://wiki.libsdl.org/SDL3/CategoryInit

;-

;#SDLx_UseImport = #True
#SDLx_DebugErrors = #True
XIncludeFile "../SDL3.pbi"

Procedure.i PreInit()
  SDL_SetAppMetadata(GetFilePart(#PB_Compiler_Filename, #PB_FileSystem_NoExtension), SDLx_CompiledVersionString(), "com.sdlx.appmetadata")
  SDL_SetAppMetadataProperty(#SDL_PROP_APP_METADATA_URL_STRING, "https://www.purebasic.com")
EndProcedure

SDLx_SetPostLoadPreInitCallback(@PreInit())

If (SDL_Init(0))
  
  Debug "AppName = " + SDLx_GetAppMetadataPropertyString(#SDL_PROP_APP_METADATA_NAME_STRING)
  Debug "Version = " + SDLx_GetAppMetadataPropertyString(#SDL_PROP_APP_METADATA_VERSION_STRING)
  Debug "URL = " + SDLx_GetAppMetadataPropertyString(#SDL_PROP_APP_METADATA_URL_STRING)
  
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
