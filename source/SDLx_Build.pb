; +------------+
; | SDLx_Build |
; +------------+
; | 2024-09-23 : Creation (PureBasic 6.12)
; | 2024-10-05 : Added statically linked lib function imports
; | 2025-02-19 : Added SDL function categories which can be selectively excluded by user
; | 2025-09-24 : Preliminary support for SDL3_net
; | 2026-03-10 : Support for SDL3_mixer

;-

#OutputFileEOL$ = #LF$

#PrototypeNamePrefix = "Proto_"

#IndentSpaces = 2

#MinSDLVersionToRebuild = 3
#MaxSDLVersionToRebuild = 3

Structure SDLFunctionStruct
  Name.s
  ReturnType.s
  ParamString.s
  Category.s
EndStructure

Global NewList SDLFunction.SDLFunctionStruct()


CompilerIf (#PB_Compiler_Version < 610)
  CompilerIf (Not Defined(time, #PB_Procedure))
    ImportC ""
      time(*seconds.INTEGER = #Null)
    EndImport
  CompilerEndIf
  
  Macro DateUTC()
    time()
  EndMacro
CompilerEndIf


If ExamineDirectory(0, #PB_Compiler_FilePath, "*.pbi")
  While NextDirectoryEntry(0)
    ProcessIt.i = #False
    Name.s = DirectoryEntryName(0)
    If (FindString(Name, "_Template"))
      If (Left(Name, 3) = "SDL")
        MajorVersion.i = Asc(Mid(Name, 4, 1)) - '0'
        If ((MajorVersion >= #MinSDLVersionToRebuild) And (MajorVersion <= #MaxSDLVersionToRebuild))
          OutputFileName.s = RemoveString(Name, "_Template")
          OutputFileFull.s = ".." + #PS$
          If (MajorVersion = 2)
            OutputFileFull + "SDL2" + #PS$
          EndIf
          OutputFileFull + OutputFileName
          OutputFileFull = #PB_Compiler_FilePath + OutputFileFull
          SDLName.s = GetFilePart(OutputFileName, #PB_FileSystem_NoExtension)
          TemplateFileName.s = Name
          ProcessIt = #True
        EndIf
      EndIf
    EndIf
    If (ProcessIt)
      ClearList(SDLFunction())
      DeleteLevel.i = 0
      
      If (FileSize(TemplateFileName) > 0)
        If (ReadFile(0, TemplateFileName))
          If (CreateFile(1, OutputFileFull))
            Debug "Generating '" + OutputFileName + "' from '" + TemplateFileName + "'..."
            ReadStringFormat(0)
            WriteStringFormat(1, #PB_UTF8)
            
            NumStructs.i = 0
            Indentation.s = ""
            PrevCategory.s = ""
            Category.s = ""
            While (Not Eof(0))
              Line.s = ReadString(0)
              LineOut.s = Line
              SkipLine.i = #False
              
              If (Left(Line, 2) = ";%")
                OrigCommand.s = Trim(StringField(Line, 2, "%"))
                Command.s = UCase(OrigCommand)
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
                    Debug "  Found " + Str(ListSize(SDLFunction())) + " SDL functions..."
                    Debug "  Found " + Str(NumStructs) + " SDL structures..."
                    PrevCategory = ""
                    LineOut = ""
                    ForEach SDLFunction()
                      If (SDLFunction()\Category <> PrevCategory)
                        If (PrevCategory)
                          LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                        EndIf
                        If (SDLFunction()\Category)
                          LineOut + Indentation + "CompilerIf (Not #SDLx_Exclude" + SDLFunction()\Category + ")" + #OutputFileEOL$
                        EndIf
                      EndIf
                      Select (SDLFunction()\Name)
                        Case "SDL_Init", "SDL_Quit", "NET_Init", "NET_Quit", "MIX_Init", "MIX_Quit"
                          ; special cases - handled elsewhere - do not declare prototypes here
                        Default
                          LineOut + "Global " + SDLFunction()\Name + "." + #PrototypeNamePrefix + SDLFunction()\Name + #OutputFileEOL$
                      EndSelect
                      PrevCategory = SDLFunction()\Category
                    Next
                    If (PrevCategory)
                      LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                    EndIf
                  
                  Case "STATIC_IMPORTS"
                    PrevCategory = ""
                    LineOut = ""
                    ForEach SDLFunction()
                      If (SDLFunction()\Category <> PrevCategory)
                        If (PrevCategory)
                          LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                        EndIf
                        If (SDLFunction()\Category)
                          LineOut + Indentation + "CompilerIf (Not #SDLx_Exclude" + SDLFunction()\Category + ")" + #OutputFileEOL$
                        EndIf
                      EndIf
                      LineOut + Indentation + SDLFunction()\Name
                      If (SDLFunction()\ReturnType)
                        LineOut + "." + SDLFunction()\ReturnType
                      EndIf
                      LineOut + "(" + SDLFunction()\ParamString + ")"
                      LineOut + #OutputFileEOL$
                      PrevCategory = SDLFunction()\Category
                    Next
                    If (PrevCategory)
                      LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                    EndIf
                  
                  Case "LOAD_DYNAMIC_FUNCTIONS"
                    PrevCategory = ""
                    LineOut = ""
                    ForEach SDLFunction()
                      If (SDLFunction()\Category <> PrevCategory)
                        If (PrevCategory)
                          LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                        EndIf
                        If (SDLFunction()\Category)
                          LineOut + Indentation + "CompilerIf (Not #SDLx_Exclude" + SDLFunction()\Category + ")" + #OutputFileEOL$
                        EndIf
                      EndIf
                      Select (SDLFunction()\Name)
                        Case "SDL_Init", "SDL_Quit", "NET_Init", "NET_Quit", "MIX_Init", "MIX_Quit"
                          ; special cases - handled elsewhere - do not declare prototypes here
                        Default
                          If (MajorVersion = 4) ; SDL3_net
                            LineOut + Indentation + "_SDLx_net_LoadFunction(" + SDLFunction()\Name + ")" + #OutputFileEOL$
                          ElseIf (#True)
                            LineOut + Indentation + "_SDLx_LoadFunction(" + SDLFunction()\Name + ")" + #OutputFileEOL$
                          Else
                            LineOut + Indentation + SDLFunction()\Name + " = GetFunction(__SDLxLib, " + #DQUOTE$ + SDLFunction()\Name + #DQUOTE$ + ")" + #OutputFileEOL$
                            If (#True)
                              LineOut + Indentation + "CompilerIf ((#SDLx_AssertAllFunctionLoads And #__SDLx_DebugErrors) Or #SDLx_RequireAllFunctionLoads)" + #OutputFileEOL$
                              LineOut + Indentation + Space(1*#IndentSpaces) + "If (" + SDLFunction()\Name + " = #Null)" + #OutputFileEOL$
                              LineOut + Indentation + Space(2*#IndentSpaces) + "__SDLx_Debug(" + #DQUOTE$ + "Failed to load SDL library function: '" + SDLFunction()\Name + "'" + #DQUOTE$ + ")" + #OutputFileEOL$
                              LineOut + Indentation + Space(2*#IndentSpaces) + "LoadFailed = #SDLx_RequireAllFunctionLoads" + #OutputFileEOL$
                              LineOut + Indentation + Space(1*#IndentSpaces) + "EndIf" + #OutputFileEOL$
                              LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                            EndIf
                          EndIf
                      EndSelect
                      PrevCategory = SDLFunction()\Category
                    Next
                    If (PrevCategory)
                      LineOut + Indentation + "CompilerEndIf" + #OutputFileEOL$
                    EndIf
                    LineOut + Indentation
                  
                  Default
                    SkipLine = #True ; discard line, eg. comments in Template file
                    If (Left(Command, 7) = "INDENT=")
                      Indentation = Space(#IndentSpaces * Val(Trim(StringField(Command, 2, "="))))
                    ElseIf (Left(Command, 9) = "CATEGORY=")
                      Category = Mid(OrigCommand, 10)
                    EndIf
                    
                EndSelect
                
              ElseIf (DeleteLevel > 0)
                SkipLine = #True
                
              Else
                
                If (Left(Line, 10) = "PrototypeC")
                  AddElement(SDLFunction())
                  SDLFunction()\Name = Trim(StringField(Mid(Line, 14), 1, "("))
                  SDLFunction()\ReturnType = Trim(Mid(Line, 12, 1))
                  SDLFunction()\ParamString = Trim(StringField(StringField(Line, 2, "("), 1, ")"))
                  SDLFunction()\Category = Category
                  If (Left(SDLFunction()\Name, Len(#PrototypeNamePrefix)) = #PrototypeNamePrefix)
                    ; OK, keep it
                    SDLFunction()\Name = Mid(SDLFunction()\Name, 1 + Len(#PrototypeNamePrefix))
                  Else
                    DeleteElement(SDLFunction())
                  EndIf
                ElseIf (Left(Trim(Line), 10) = "Structure ")
                  NumStructs + 1
                EndIf
                
              EndIf
              
              If (Not SkipLine)
                WriteString(1, LineOut + #OutputFileEOL$)
              EndIf
            Wend
            
            CloseFile(1)
            Debug "  Done"
          Else
            Debug "  Could not create file '" + OutputFileFull + "'"
          EndIf
          CloseFile(0)
        Else
          Debug "  Could not read file '" + TemplateFileName + "'"
        EndIf
      Else
        Debug "Skipping " + SDLName + " ('" + TemplateFileName + "' not found)"
      EndIf
      Debug ""
    EndIf
  
  Wend
  FinishDirectory(0)
EndIf

If (#True)
  Delay(3 * 1000)
  CloseDebugOutput()
EndIf

;-
