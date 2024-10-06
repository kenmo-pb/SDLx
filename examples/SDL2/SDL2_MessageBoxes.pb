; +----------------------+
; | SDL2_MessageBoxes.pb |
; +----------------------+

;-

;#SDLx_StaticLink = #True
;#SDLx_DebugErrors = #True
XIncludeFile "../../SDL2.pbi"

If (SDL_Init(0) = #SDLx_INIT_SUCCESS)
  
  ; Simple Message Boxes
  
  SDL_ShowSimpleMessageBox(0,                           #PB_Compiler_Filename, "The most simple Message Box", #Null)
  SDL_ShowSimpleMessageBox(#SDL_MESSAGEBOX_INFORMATION, #PB_Compiler_Filename, "Simple Information Message Box", #Null)
  SDL_ShowSimpleMessageBox(#SDL_MESSAGEBOX_WARNING,     #PB_Compiler_Filename, "Simple Warning Message Box", #Null)
  SDL_ShowSimpleMessageBox(#SDL_MESSAGEBOX_ERROR,       #PB_Compiler_Filename, "Simple Error Message Box", #Null)
  
  
  
  ; More complex Message Box...
  *title   = UTF8(#PB_Compiler_Filename)
  *message = UTF8("This is a more complex Message Box!")
  
  ; Define three buttons...
  Global Dim button.SDL_MessageBoxButtonData(3-1)
  With button(0)
    \flags = #SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT
    \buttonid = 1
    \text = UTF8("OK (1)")
  EndWith
  With button(1)
    \flags = 0
    \buttonid = 2
    \text = UTF8("Remove (2)")
  EndWith
  With button(2)
    \flags = #SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT
    \buttonid = 3
    \text = UTF8("Cancel (3)")
  EndWith
  
  ; Define custom colors...
  Global Dim colors.SDL_MessageBoxColor(#SDL_MESSAGEBOX_COLOR_MAX - 1)
  With colors(#SDL_MESSAGEBOX_COLOR_BACKGROUND)
    \r = 64
    \g = 64
    \b = 255
  EndWith
  With colors(#SDL_MESSAGEBOX_COLOR_TEXT)
    \r = 255
    \g = 255
    \b = 64
  EndWith
  With colors(#SDL_MESSAGEBOX_COLOR_BUTTON_BORDER)
    \r = 0
    \g = 0
    \b = 64
  EndWith
  With colors(#SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND)
    \r = 64
    \g = 64
    \b = 64
  EndWith
  With colors(#SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED)
    \r = 64
    \g = 255
    \b = 64
  EndWith
  
  ; Populate struct...
  messageboxdata.SDL_MessageBoxData
  With messageboxdata
    \flags = #SDL_MESSAGEBOX_INFORMATION
    \window = #Null
    \title = *title
    \message = *message
    \numbuttons = ArraySize(button()) + 1 ; +1 because PB ArraySize() reports "2" for 3 elements (max index is 2)
    \buttons = @button(0)
    \colorScheme = @colors(0)
  EndWith
  
  ; Finally, display the MessageBox and get buttonid result!
  result.SDLx_Int
  SDL_ShowMessageBox(@messageboxdata, @result)
  Debug "SDL_ShowMessageBox() Result: " + Str(Result)
  
  SDL_Quit()
EndIf

;-
