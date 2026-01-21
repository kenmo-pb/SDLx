;%==========================================================================================%
;% Note: This is the TEMPLATE FILE which is used to generate the complete 'SDL3_Module.pbi' %
;%==========================================================================================%
; +-----------------+
; | SDL3_Module.pbi |
; +-----------------+
; | 2026-01-21 : Creation (PureBasic 6.30)

;% MODIFY_DISCLAIMER
;
;% GEN_TIMESTAMP

; SDL3 Wiki:       https://wiki.libsdl.org/SDL3
; API by Category: https://wiki.libsdl.org/SDL3/APIByCategory
; All Functions:   https://wiki.libsdl.org/SDL3/CategoryAPIFunction
; Complete API:    https://wiki.libsdl.org/SDL3/CategoryAPI
;
; SDL2 --> SDL3 Migration Guide: https://github.com/libsdl-org/SDL/blob/main/docs/README-migration.md

CompilerIf (#PB_Compiler_Version < 510)
  CompilerError #PB_Compiler_Filename + " requires PureBasic 5.10 or newer!"
CompilerEndIf

CompilerIf (#PB_Compiler_IsMainFile)
  EnableExplicit
CompilerEndIf


;-
;- Build Switches

;- - Excluded SDL Categories


;-
;- SDL3 Library Files


;-
;- Standard Types

;-
;- SDL3 Type Aliases


;-
;- SDL3 Constants




;-
;- SDL3 Structures





;-
;- SDL3 Prototypes


;-
;- OpenLibrary Variables

;-
;- Function Imports






;-
;- Inline C Extensions


;-
;- PB Wrapper Procedures


;-
;- Helper Structures


;-
;- Helper Procedures






;-
;- Template / Main File Warning

;% DELETESTART
MessageRequester(#PB_Compiler_Filename, "This template file is not intended to be used as-is." + #LF$ + #LF$ + "Please run 'SDLx_Build.pb' to generate the full IncludeFile.", #PB_MessageRequester_Warning)
End
;% DELETEEND
CompilerIf (#PB_Compiler_IsMainFile)
  MessageRequester(#PB_Compiler_Filename, "This IncludeFile is not intended to be run by itself." + #LF$ + #LF$ + "See the 'examples' subfolder, or include this in your own project!", #PB_MessageRequester_Warning)
CompilerEndIf

;-
