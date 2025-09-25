; +--------------+
; | SDL3_net.pbi |
; +--------------+
; | 2025-09-24 : Creation (PureBasic 6.21)

; Warning: This file should not be directly modified!
; It was automatically generated from 'SDL3_net_Template.pbi' by 'SDLx_Build.pb'.
;
; Generated 2025-09-25 22:41:15 UTC

; SDL_net Wiki:   https://wiki.libsdl.org/SDL3_net/FrontPage
; Complete API:   https://wiki.libsdl.org/SDL3_net/CategorySDLNet
; C Include:      https://github.com/libsdl-org/SDL_net/blob/main/include/SDL3_net/SDL_net.h


CompilerIf (Not Defined(__SDLx_net_Included, #PB_Constant))
#__SDLx_net_Included = #True

CompilerIf (#PB_Compiler_Version < 510)
  CompilerError #PB_Compiler_Filename + " requires PureBasic 5.10 or newer!"
CompilerEndIf

CompilerIf (#PB_Compiler_IsMainFile)
  EnableExplicit
CompilerEndIf

;-
;- SDL3 Include

CompilerIf (Not Defined(__SDLx_Included, #PB_Constant))
  XIncludeFile "SDL3.pbi"
CompilerEndIf


;-
;- Build Switches

CompilerIf (Not Defined(SDLx_net_DebugErrors, #PB_Constant))
  #SDLx_net_DebugErrors = #SDLx_DebugErrors
CompilerEndIf

CompilerIf (#PB_Compiler_Debugger)
  #__SDLx_net_DebugErrors = #SDLx_net_DebugErrors
CompilerElse
  #__SDLx_net_DebugErrors = #False
CompilerEndIf
CompilerIf (#__SDLx_net_DebugErrors)
  Macro __SDLx_net_Debug(_Message)
    Debug _Message
  EndMacro
CompilerElse
  Macro __SDLx_net_Debug(_Message)
    ;
  EndMacro
CompilerEndIf


;-
;- SDL3_net Library Files

#SDLx_net_LibName = "SDL3_net"

#SDLx_net_IncludeFilename = #PB_Compiler_Filename

CompilerSelect (#PB_Compiler_OS)
  CompilerCase #PB_OS_Windows
    CompilerIf (Not Defined(SDLx_net_OpenLibraryDefaultName, #PB_Constant))
      #SDLx_net_OpenLibraryDefaultName = "SDL3_net.dll"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_net_ImportLibraryName, #PB_Constant))
      #SDLx_net_ImportLibraryName = "SDL3_net.lib"
    CompilerEndIf
    
  CompilerCase #PB_OS_Linux
    CompilerIf (Not Defined(SDLx_net_OpenLibraryDefaultName, #PB_Constant))
      #SDLx_net_OpenLibraryDefaultName = "libSDL3_net.so"
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_net_ImportLibraryName, #PB_Constant))
      ;#SDLx_net_ImportLibraryName = ""
    CompilerEndIf
    
  CompilerCase #PB_OS_MacOS
    CompilerIf (Not Defined(SDLx_net_OpenLibraryDefaultName, #PB_Constant))
      ;#SDLx_net_OpenLibraryDefaultName = ""
    CompilerEndIf
    CompilerIf (Not Defined(SDLx_net_ImportLibraryName, #PB_Constant))
      #SDLx_net_ImportLibraryName = "Frameworks/SDL3_net.framework/SDL3_net"
    CompilerEndIf
CompilerEndSelect

CompilerIf (Not Defined(SDLx_net_UseImport, #PB_Constant))
  CompilerIf (Not Defined(SDLx_net_OpenLibraryDefaultName, #PB_Constant))
    #SDLx_net_UseImport = #True
  CompilerElse
    #SDLx_net_UseImport = #False
  CompilerEndIf
CompilerEndIf
#SDLx_net_UseOpenLibrary = Bool(Not #SDLx_net_UseImport)

CompilerIf (#SDLx_net_UseOpenLibrary And (Not Defined(SDLx_net_OpenLibraryDefaultName, #PB_Constant)))
  CompilerError "#SDLx_net_OpenLibraryDefaultName must be defined to open " + #SDLx_net_LibName + "!"
CompilerEndIf
CompilerIf (#SDLx_net_UseImport And (Not Defined(SDLx_net_ImportLibraryName, #PB_Constant)))
  CompilerError "#SDLx_net_ImportLibraryName must be defined to import " + #SDLx_net_LibName + "!"
CompilerEndIf

CompilerIf (Not Defined(SDLx_net_RequireAllFunctionLoads, #PB_Constant))
  #SDLx_net_RequireAllFunctionLoads = #SDLx_RequireAllFunctionLoads
CompilerEndIf
CompilerIf (Not Defined(SDLx_net_AssertAllFunctionLoads, #PB_Constant))
  #SDLx_net_AssertAllFunctionLoads = #SDLx_AssertAllFunctionLoads
CompilerEndIf

CompilerIf (Not Defined(SDLx_net_IncludeHelperProcedures, #PB_Constant))
  #SDLx_net_IncludeHelperProcedures = #True
CompilerEndIf


;-
;- Standard Types

UndefineMacro Uint8
Macro Uint8
  a
EndMacro
UndefineMacro Sint8
Macro Sint8
  b
EndMacro
UndefineMacro Uint16
Macro Uint16
  u
EndMacro
UndefineMacro Sint16
Macro Sint16
  w
EndMacro
UndefineMacro Uint32
Macro Uint32
  l
EndMacro
UndefineMacro Sint32
Macro Sint32
  l
EndMacro
UndefineMacro Uint64
Macro Uint64
  q
EndMacro
UndefineMacro Sint64
Macro Sint64
  q
EndMacro
UndefineMacro POINTER_TO_A_POINTER
Macro POINTER_TO_A_POINTER
  INTEGER
EndMacro

;-
;- SDL3_net Type Aliases

Macro NET_Status
  l ; enum
EndMacro



;-
;- SDL3_net Constants

;- - Querying SDL Version

#SDL_NET_MAJOR_VERSION = 3
#SDL_NET_MINOR_VERSION = 0
#SDL_NET_MICRO_VERSION = 0

Macro SDL_NET_VERSION()
  SDL_VERSIONNUM(#SDL_NET_MAJOR_VERSION, #SDL_NET_MINOR_VERSION, #SDL_NET_MICRO_VERSION)
EndMacro
Macro SDL_NET_VERSION_ATLEAST(X, Y, Z)
  (Bool(SDL_NET_VERSION() >= SDL_VERSIONNUM(X, Y, Z)))
EndMacro

Enumeration ; NET_Status
  #NET_FAILURE = -1
  #NET_WAITING = 0
  #NET_SUCCESS = 1
EndEnumeration



;-
;- SDL3_net Structures

Structure NET_Datagram Align #PB_Structure_AlignC
  *addr.NET_Address
  port.Uint16
  *buf
  buflen.l
EndStructure

Structure NET_Address Align #PB_Structure_AlignC
  ;
EndStructure

Structure NET_DatagramSocket Align #PB_Structure_AlignC
  ;
EndStructure

Structure NET_Server Align #PB_Structure_AlignC
  ;
EndStructure

Structure NET_StreamSocket Align #PB_Structure_AlignC
  ;
EndStructure





;-
;- SDL3_net Prototypes

PrototypeC.a Proto_NET_Init() ; returns bool
PrototypeC   Proto_NET_Quit()
PrototypeC.l Proto_NET_Version() ; returns int

PrototypeC.a Proto_NET_AcceptClient(*server.NET_Server, *client_stream.POINTER_TO_A_POINTER) ; returns bool
PrototypeC.l Proto_NET_CompareAddresses(*a.NET_Address, *b.NET_Address)
PrototypeC.i Proto_NET_CreateClient(*address.NET_Address, port.Uint16) ; returns NET_StreamSocket *
PrototypeC.i Proto_NET_CreateDatagramSocket(*addr.NET_Address, port.Uint16) ; return NET_DatagramSocket *
PrototypeC.i Proto_NET_CreateServer(*address.NET_Address, port.Uint16) ; returns NET_Server *
PrototypeC   Proto_NET_DestroyDatagram(*dgram.NET_Datagram)
PrototypeC   Proto_NET_DestroyDatagramSocket(*sock.NET_DatagramSocket)
PrototypeC   Proto_NET_DestroyServer(*server.NET_Server)
PrototypeC   Proto_NET_DestroyStreamSocket(*sock.NET_StreamSocket)
PrototypeC   Proto_NET_FreeLocalAddresses(*addresses.POINTER_TO_A_POINTER)
PrototypeC.l Proto_NET_GetAddressStatus(*address.NET_Address) ; returns NET_Status
PrototypeC.i Proto_NET_GetAddressString(*address.NET_Address) ; returns const char *
PrototypeC.l Proto_NET_GetConnectionStatus(*sock.NET_StreamSocket) ; returns NET_Status
PrototypeC.i Proto_NET_GetLocalAddresses(*num_addresses.LONG) ; returns NET_Address **
PrototypeC.i Proto_NET_GetStreamSocketAddress(*sock.NET_StreamSocket) ; returns NET_Address *
PrototypeC.l Proto_NET_GetStreamSocketPendingWrites(*sock.NET_StreamSocket) ; returns int
PrototypeC.l Proto_NET_ReadFromStreamSocket(*sock.NET_StreamSocket, *buf, buflen.l) ; returns int
PrototypeC.a Proto_NET_ReceiveDatagram(*sock.NET_DatagramSocket, *dgram.POINTER_TO_A_POINTER) ; returns bool
PrototypeC.i Proto_NET_RefAddress(*address.NET_Address) ; returns NET_Address *
PrototypeC.i Proto_NET_ResolveHostname(host.p-utf8) ; returns NET_Address *
PrototypeC.a Proto_NET_SendDatagram(*sock.NET_DatagramSocket, *address.NET_Address, port.Uint16, *buf, buflen.l) ; returns bool
PrototypeC   Proto_NET_SimulateAddressResolutionLoss(percent_loss.l)
PrototypeC   Proto_NET_SimulateDatagramPacketLoss(*sock.NET_DatagramSocket, percent_loss.l)
PrototypeC   Proto_NET_SimulateStreamPacketLoss(*sock.NET_StreamSocket, percent_loss.l)
PrototypeC   Proto_NET_UnrefAddress(*address.NET_Address)
PrototypeC.l Proto_NET_WaitUntilConnected(*sock.NET_StreamSocket, timeout.Sint32) ; returns NET_Status
PrototypeC.l Proto_NET_WaitUntilInputAvailable(*vsockets.POINTER_TO_A_POINTER, numsockets.l, timeout.Sint32) ; returns int
PrototypeC.l Proto_NET_WaitUntilResolved(*address.NET_Address, timeout.Sint32) ; returns NET_Status
PrototypeC.l Proto_NET_WaitUntilStreamSocketDrained(*sock.NET_StreamSocket, timeout.Sint32) ; returns int
PrototypeC.a Proto_NET_WriteToStreamSocket(*sock.NET_StreamSocket, *buf, buflen.l) ; returns bool




;-
;- OpenLibrary Variables

CompilerIf (#SDLx_net_UseOpenLibrary)

Global __SDLx_net_DynamicLibPath.s

Global __SDLx_net_Lib.i = #Null
Global __SDLx_NET_Init.Proto_NET_Init
Global __SDLx_NET_Quit.Proto_NET_Quit

Global NET_Version.Proto_NET_Version
Global NET_AcceptClient.Proto_NET_AcceptClient
Global NET_CompareAddresses.Proto_NET_CompareAddresses
Global NET_CreateClient.Proto_NET_CreateClient
Global NET_CreateDatagramSocket.Proto_NET_CreateDatagramSocket
Global NET_CreateServer.Proto_NET_CreateServer
Global NET_DestroyDatagram.Proto_NET_DestroyDatagram
Global NET_DestroyDatagramSocket.Proto_NET_DestroyDatagramSocket
Global NET_DestroyServer.Proto_NET_DestroyServer
Global NET_DestroyStreamSocket.Proto_NET_DestroyStreamSocket
Global NET_FreeLocalAddresses.Proto_NET_FreeLocalAddresses
Global NET_GetAddressStatus.Proto_NET_GetAddressStatus
Global NET_GetAddressString.Proto_NET_GetAddressString
Global NET_GetConnectionStatus.Proto_NET_GetConnectionStatus
Global NET_GetLocalAddresses.Proto_NET_GetLocalAddresses
Global NET_GetStreamSocketAddress.Proto_NET_GetStreamSocketAddress
Global NET_GetStreamSocketPendingWrites.Proto_NET_GetStreamSocketPendingWrites
Global NET_ReadFromStreamSocket.Proto_NET_ReadFromStreamSocket
Global NET_ReceiveDatagram.Proto_NET_ReceiveDatagram
Global NET_RefAddress.Proto_NET_RefAddress
Global NET_ResolveHostname.Proto_NET_ResolveHostname
Global NET_SendDatagram.Proto_NET_SendDatagram
Global NET_SimulateAddressResolutionLoss.Proto_NET_SimulateAddressResolutionLoss
Global NET_SimulateDatagramPacketLoss.Proto_NET_SimulateDatagramPacketLoss
Global NET_SimulateStreamPacketLoss.Proto_NET_SimulateStreamPacketLoss
Global NET_UnrefAddress.Proto_NET_UnrefAddress
Global NET_WaitUntilConnected.Proto_NET_WaitUntilConnected
Global NET_WaitUntilInputAvailable.Proto_NET_WaitUntilInputAvailable
Global NET_WaitUntilResolved.Proto_NET_WaitUntilResolved
Global NET_WaitUntilStreamSocketDrained.Proto_NET_WaitUntilStreamSocketDrained
Global NET_WriteToStreamSocket.Proto_NET_WriteToStreamSocket



Macro _SDLx_net_DQ
  "
EndMacro

Macro _SDLx_net_LoadFunction(_Name)
  _Name = GetFunction(__SDLx_net_Lib, _SDLx_net_DQ#_Name#_SDLx_net_DQ)
  CompilerIf ((#SDLx_net_AssertAllFunctionLoads And #__SDLx_net_DebugErrors) Or #SDLx_net_RequireAllFunctionLoads)
    If (_Name = #Null)
      __SDLx_net_Debug("Could not find SDL3_net library function: " + _SDLx_net_DQ#_Name#_SDLx_net_DQ)
      LoadFailed = #SDLx_net_RequireAllFunctionLoads
    EndIf
  CompilerEndIf
EndMacro

CompilerEndIf

;-
;- Function Imports

CompilerIf (#SDLx_net_UseImport)

ImportC #SDLx_net_ImportLibraryName
  
  NET_Init.a()
  NET_Quit()
  NET_Version.l()
  NET_AcceptClient.a(*server.NET_Server, *client_stream.POINTER_TO_A_POINTER)
  NET_CompareAddresses.l(*a.NET_Address, *b.NET_Address)
  NET_CreateClient.i(*address.NET_Address, port.Uint16)
  NET_CreateDatagramSocket.i(*addr.NET_Address, port.Uint16)
  NET_CreateServer.i(*address.NET_Address, port.Uint16)
  NET_DestroyDatagram(*dgram.NET_Datagram)
  NET_DestroyDatagramSocket(*sock.NET_DatagramSocket)
  NET_DestroyServer(*server.NET_Server)
  NET_DestroyStreamSocket(*sock.NET_StreamSocket)
  NET_FreeLocalAddresses(*addresses.POINTER_TO_A_POINTER)
  NET_GetAddressStatus.l(*address.NET_Address)
  NET_GetAddressString.i(*address.NET_Address)
  NET_GetConnectionStatus.l(*sock.NET_StreamSocket)
  NET_GetLocalAddresses.i(*num_addresses.LONG)
  NET_GetStreamSocketAddress.i(*sock.NET_StreamSocket)
  NET_GetStreamSocketPendingWrites.l(*sock.NET_StreamSocket)
  NET_ReadFromStreamSocket.l(*sock.NET_StreamSocket, *buf, buflen.l)
  NET_ReceiveDatagram.a(*sock.NET_DatagramSocket, *dgram.POINTER_TO_A_POINTER)
  NET_RefAddress.i(*address.NET_Address)
  NET_ResolveHostname.i(host.p-utf8)
  NET_SendDatagram.a(*sock.NET_DatagramSocket, *address.NET_Address, port.Uint16, *buf, buflen.l)
  NET_SimulateAddressResolutionLoss(percent_loss.l)
  NET_SimulateDatagramPacketLoss(*sock.NET_DatagramSocket, percent_loss.l)
  NET_SimulateStreamPacketLoss(*sock.NET_StreamSocket, percent_loss.l)
  NET_UnrefAddress(*address.NET_Address)
  NET_WaitUntilConnected.l(*sock.NET_StreamSocket, timeout.Sint32)
  NET_WaitUntilInputAvailable.l(*vsockets.POINTER_TO_A_POINTER, numsockets.l, timeout.Sint32)
  NET_WaitUntilResolved.l(*address.NET_Address, timeout.Sint32)
  NET_WaitUntilStreamSocketDrained.l(*sock.NET_StreamSocket, timeout.Sint32)
  NET_WriteToStreamSocket.a(*sock.NET_StreamSocket, *buf, buflen.l)

EndImport

CompilerEndIf



;-
;- PB Wrapper Procedures

CompilerIf (#SDLx_net_UseOpenLibrary)

Procedure NET_Quit()
  If (__SDLx_net_Lib)
    __SDLx_NET_Quit()
    CloseLibrary(__SDLx_net_Lib)
    __SDLx_net_Lib   = #Null
    __SDLx_NET_Init = #Null
    __SDLx_NET_Quit = #Null
  Else
    __SDLx_net_Debug("NET_Quit() called while not initialized")
  EndIf
EndProcedure

Procedure.a NET_Init()
  Protected Success.i = #False
  
  CompilerIf (#SDLx_UseOpenLibrary)
    If (__SDLxLib = #Null)
      __SDLx_net_Debug("SDL_Init() must be called before NET_Init()")
      ProcedureReturn (#False)
    EndIf
  CompilerEndIf
  
  If (__SDLx_net_Lib = #Null)
    If (__SDLx_net_DynamicLibPath = "")
      __SDLx_net_DynamicLibPath = #SDLx_net_OpenLibraryDefaultName
    EndIf
    __SDLx_net_Lib = OpenLibrary(#PB_Any, __SDLx_net_DynamicLibPath)
    If (Not __SDLx_net_Lib)
      __SDLx_net_Debug("Failed to open SDL3_net library '" + __SDLx_net_DynamicLibPath + "'")
    EndIf
  Else
    __SDLx_net_Debug("NET_Init() called while already initialized")
  EndIf
  
  If (__SDLx_net_Lib)
    If (#True)
      __SDLx_NET_Init = GetFunction(__SDLx_net_Lib, "NET_Init")
      If (__SDLx_NET_Init)
        __SDLx_NET_Quit = GetFunction(__SDLx_net_Lib, "NET_Quit")
        If (__SDLx_NET_Quit)
          Protected LoadFailed.i = #False
          
          _SDLx_net_LoadFunction(NET_Version)
          _SDLx_net_LoadFunction(NET_AcceptClient)
          _SDLx_net_LoadFunction(NET_CompareAddresses)
          _SDLx_net_LoadFunction(NET_CreateClient)
          _SDLx_net_LoadFunction(NET_CreateDatagramSocket)
          _SDLx_net_LoadFunction(NET_CreateServer)
          _SDLx_net_LoadFunction(NET_DestroyDatagram)
          _SDLx_net_LoadFunction(NET_DestroyDatagramSocket)
          _SDLx_net_LoadFunction(NET_DestroyServer)
          _SDLx_net_LoadFunction(NET_DestroyStreamSocket)
          _SDLx_net_LoadFunction(NET_FreeLocalAddresses)
          _SDLx_net_LoadFunction(NET_GetAddressStatus)
          _SDLx_net_LoadFunction(NET_GetAddressString)
          _SDLx_net_LoadFunction(NET_GetConnectionStatus)
          _SDLx_net_LoadFunction(NET_GetLocalAddresses)
          _SDLx_net_LoadFunction(NET_GetStreamSocketAddress)
          _SDLx_net_LoadFunction(NET_GetStreamSocketPendingWrites)
          _SDLx_net_LoadFunction(NET_ReadFromStreamSocket)
          _SDLx_net_LoadFunction(NET_ReceiveDatagram)
          _SDLx_net_LoadFunction(NET_RefAddress)
          _SDLx_net_LoadFunction(NET_ResolveHostname)
          _SDLx_net_LoadFunction(NET_SendDatagram)
          _SDLx_net_LoadFunction(NET_SimulateAddressResolutionLoss)
          _SDLx_net_LoadFunction(NET_SimulateDatagramPacketLoss)
          _SDLx_net_LoadFunction(NET_SimulateStreamPacketLoss)
          _SDLx_net_LoadFunction(NET_UnrefAddress)
          _SDLx_net_LoadFunction(NET_WaitUntilConnected)
          _SDLx_net_LoadFunction(NET_WaitUntilInputAvailable)
          _SDLx_net_LoadFunction(NET_WaitUntilResolved)
          _SDLx_net_LoadFunction(NET_WaitUntilStreamSocketDrained)
          _SDLx_net_LoadFunction(NET_WriteToStreamSocket)
          
          
          If (Not LoadFailed)
            If (#True)
              Success = __SDLx_NET_Init()
              CompilerIf (#True)
                If (Success)
                  Protected LinkedVer.i = NET_Version()
                  If (#True);(SDL_VERSIONNUM_MAJOR(LinkedVer) = #SDL_NET_MAJOR_VERSION)
                    If (#True);(SDL_VERSIONNUM_MINOR(LinkedVer) < #SDL_MINOR_VERSION - 1)
                      ;Protected Message.s = "Warning: Dynamically linked SDL ("
                      ;Message + Str(SDL_VERSIONNUM_MAJOR(LinkedVer)) + "." + Str(SDL_VERSIONNUM_MINOR(LinkedVer)) + "." + Str(SDL_VERSIONNUM_MICRO(LinkedVer))
                      ;Message + ") is older than SDLx compiled version ("
                      ;Message + Str(#SDL_MAJOR_VERSION) + "." + Str(#SDL_MINOR_VERSION) + "." + Str(#SDL_MICRO_VERSION) + ")"
                      ;__SDLx_Debug(Message)
                    EndIf
                  Else
                    __SDLx_net_Debug("Dynamically linked SDL3_net version (" + Str(SDL_VERSIONNUM_MAJOR(LinkedVer)) + ") does not match compiled SDLx version (" + Str(#SDL_MAJOR_VERSION) + ")!")
                    NET_Quit()
                    Success = #False
                  EndIf
                EndIf
              CompilerEndIf
            EndIf
          EndIf
        Else
          __SDLx_net_Debug("Failed to load SDL library function: '" + "NET_Quit" + "'")
        EndIf
      Else
        __SDLx_net_Debug("Failed to load SDL library function: '" + "NET_Init" + "'")
      EndIf
    EndIf
  EndIf
  
  ProcedureReturn (Success)
EndProcedure

CompilerEndIf

;-
;- Helper Procedures

CompilerIf (#SDLx_net_IncludeHelperProcedures)

CompilerEndIf







;-
;- Template / Main File Warning

CompilerIf (#PB_Compiler_IsMainFile)
  MessageRequester(#PB_Compiler_Filename, "This IncludeFile is not intended to be run by itself." + #LF$ + #LF$ + "See the 'examples' subfolder, or include this in your own project!", #PB_MessageRequester_Warning)
CompilerEndIf

CompilerEndIf
;-
