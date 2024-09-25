; +------------+
; | SDLx_Build |
; +------------+
; | 2024-09-23 : Creation (PureBasic 6.12)

;-

#OutputFileEOL$ = #LF$

#PrototypeNamePrefix = "Proto_"

#IndentSpaces = 2

Structure SDLFunctionStruct
  Name.s
  ReturnType.s
  ParamString.s
EndStructure

Global NewList SDLFunction.SDLFunctionStruct()





For MajorVersion = 2 To 3
  ClearList(SDLFunction())
  DeleteLevel.i = 0
  
  SDLName.s = "SDL" + Str(MajorVersion)
  TemplateFileName.s = SDLName + "_Template.pbi"
  OutputFileName.s = SDLName + ".pbi"
  OutputFileFull.s = ".." + #PS$ + OutputFileName
  
  If (FileSize(TemplateFileName) > 0)
    If (ReadFile(0, TemplateFileName))
      If (CreateFile(1, OutputFileFull))
        Debug "Generating '" + OutputFileName + "' from '" + TemplateFileName + "'..."
        ReadStringFormat(0)
        WriteStringFormat(1, #PB_UTF8)
        
        NumStructs.i = 0
        Indentation.s = ""
        While (Not Eof(0))
          Line.s = ReadString(0)
          LineOut.s = Line
          SkipLine.i = #False
          
          If (Left(Line, 2) = ";%")
            Command.s = UCase(Trim(StringField(Line, 2, "%")))
            Select (Command)
              
              Case "MODIFY_DISCLAIMER"
                LineOut = "; Warning: This file should not be directly modified!" + #OutputFileEOL$ + "; It was automatically generated from '" + TemplateFileName + "' by '" + #PB_Compiler_Filename + "'."
              
              Case "GEN_TIMESTAMP"
                LineOut = "; Generated " + FormatDate("%yyyy-%mm-%dd %hh:%ii:%ss UTC", DateUTC())
              
              Case "DELETESTART"
                DeleteLevel + 1
                SkipLine = #True
              Case "DELETEEND"
                DeleteLevel - 1
                SkipLine = #True
              
              Case "DECLARE_DYNAMIC_PROTOTYPES"
                Debug "Found " + Str(ListSize(SDLFunction())) + " SDL functions..."
                Debug "Found " + Str(NumStructs) + " SDL structures..."
                LineOut = ""
                ForEach SDLFunction()
                  Select (SDLFunction()\Name)
                    Case "SDL_Init", "SDL_Quit"
                      ; special cases - handled elsewhere - do not declare prototypes here
                    Default
                      LineOut + "Global " + SDLFunction()\Name + "." + #PrototypeNamePrefix + SDLFunction()\Name + #OutputFileEOL$
                  EndSelect
                Next
              
              Case "LOAD_DYNAMIC_FUNCTIONS"
                LineOut = ""
                ForEach SDLFunction()
                  Select (SDLFunction()\Name)
                    Case "SDL_Init", "SDL_Quit"
                      ; special cases - handled elsewhere - do not declare prototypes here
                    Default
                      LineOut + Indentation + SDLFunction()\Name + " = GetFunction(__SDLxLib, " + #DQUOTE$ + SDLFunction()\Name + #DQUOTE$ + ")" + #OutputFileEOL$
                      If (#True)
                        LineOut + Indentation + "CompilerIf (#SDLx_AssertAllFunctionLoads or #SDLx_RequireAllFunctionLoads)" + #OutputFileEOL$
                        LineOut + Indentation + Space(1*#IndentSpaces) + "If (" + SDLFunction()\Name + " = #Null)" + #OutputFileEOL$
                        LineOut + Indentation + Space(2*#IndentSpaces) + "__SDLx_Debug(" + #DQUOTE$ + "Failed to load SDL library function: '" + SDLFunction()\Name + "'" + #DQUOTE$ + ")" + #OutputFileEOL$
                        LineOut + Indentation + Space(2*#IndentSpaces) + "LoadFailed = #SDLx_RequireAllFunctionLoads" + #OutputFileEOL$
                        LineOut + Indentation + Space(1*#IndentSpaces) + "EndIf" + #OutputFileEOL$
                        LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                      EndIf
                  EndSelect
                Next
                LineOut + Indentation
              
              Default
                SkipLine = #True ; discard line, eg. comments in Template file
                If (Left(Command, 7) = "INDENT=")
                  Indentation = Space(#IndentSpaces * Val(Trim(StringField(Command, 2, "="))))
                EndIf
                
            EndSelect
            
          ElseIf (DeleteLevel > 0)
            SkipLine = #True
            
          Else
            
            If (Left(Line, 10) = "PrototypeC")
              AddElement(SDLFunction())
              SDLFunction()\Name = Trim(StringField(Mid(Line, 14 + Len(#PrototypeNamePrefix)), 1, "("))
              SDLFunction()\ReturnType = Trim(Mid(Line, 12, 1))
              SDLFunction()\ParamString = Trim(StringField(StringField(Line, 2, "("), 1, ")"))
            ElseIf (Left(Trim(Line), 10) = "Structure ")
              NumStructs + 1
            EndIf
            
          EndIf
          
          If (Not SkipLine)
            WriteString(1, LineOut + #OutputFileEOL$)
          EndIf
        Wend
        
        CloseFile(1)
        Debug "Done"
      Else
        Debug "Could not create file '" + OutputFileFull + "'"
      EndIf
      CloseFile(0)
    Else
      Debug "Could not read file '" + TemplateFileName + "'"
    EndIf
  Else
    Debug "Skipping " + SDLName + " ('" + TemplateFileName + "' not found)"
  EndIf
  Debug ""
  
Next
If (#True)
  Delay(3 * 1000)
  CloseDebugOutput()
EndIf

;-
