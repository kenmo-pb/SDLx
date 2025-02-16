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

Procedure PropertyCallback(*userdata, props.SDL_PropertiesID, *name)
  name.s = PeekS(*name, -1, #PB_UTF8)
  Debug "  " + name + " = " + SDLx_GetStringPropertyString(props, name, "(not set or not a string property)")
EndProcedure

If (SDL_Init(0))
  
  Debug "AppName = " + SDLx_GetAppMetadataPropertyString(#SDL_PROP_APP_METADATA_NAME_STRING)
  Debug "Version = " + SDLx_GetAppMetadataPropertyString(#SDL_PROP_APP_METADATA_VERSION_STRING)
  Debug "URL = " + SDLx_GetAppMetadataPropertyString(#SDL_PROP_APP_METADATA_URL_STRING)
  
  props.SDL_PropertiesID = SDL_GetGlobalProperties()
  If (props)
    SDL_SetStringProperty(props, "sdlx.prop.custom", "Hello World!")
    Debug ""
    Debug "Global Properties:"
    SDL_EnumerateProperties(props, @PropertyCallback(), #Null)
  EndIf
  
  SDL_Quit()
Else
  Debug "Failed to initialize!"
EndIf

;-
