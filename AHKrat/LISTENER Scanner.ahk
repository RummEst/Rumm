#Include AHKsock.ahk
Layer = 1
Indx = 0
/*! 
Speak3.1 by: Rumm
_______________________________________________________________________________________________________________________________________________________________________________________________
_______________________________________________________________________________________________________________________________________________________________________________________________
_______________________________________________________________________________________________________________________________________________________________________________________________
_______________________________________________________________________________________________________________________________________________________________________________________________
_______________________________________________________________________________________________________________________________________________________________________________________________
_______________________________________________________________________________________________________________________________________________________________________________________________
*/


    Gui, Add, Text, x10 y3 w120 h12 vipp, 192.168.layer.x
Gui, Add, Text, x10 y18 w120 h17 vRe, ? - ??
Gui, Add, Button, x5 y35 w60 h20 gStart, Start
Gui, Add, Button, x70 y35 w60 h20 vLay gLayer, Layer (%Layer%)
Gui, Add, Text, x10 y60 w130 h17 vErr, %ErrorLeveL%
Gui, -Minimizebox -Maximizebox -AlwaysOnTop
Gui, Show, w132 h80, TCIP easy debug
return



Layer:
inputbox, layer
Guicontrol, text, Lay, Layer (%Layer%)
return


; 192.168.1.x

Start:
Loop, {

    Sleep, 2
    GuiControl, text, err, %ErrorLevel%
    Guicontrol, text, ipp, 192.168.%Layer%.%Count%
	;Tooltip, 192.168.%Layer%.%Count%
	Sleep, 2
Count += 1
if (Count < 256) {
Sleep, 2
sServer = 192.168.%Layer%.%Count%
AHKsock_Connect(sServer, 27015, "Recv")
} else {
Count = 0
}}


/*
Loop, {
Indx += 1
If (%Indx% < 255) {
    tooltip, %Indx%
;AHKsock_Connect(sServer, 27015, "Recv")
} 
else {
    msgbox, lol
Indx = 0
Return

}

}
*/

return

Recv(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bData = 0, iLength = 0) {
If (sEvent = "RECEIVED") {
        
        xc := % Bin2Hex(&bData, iLength)
        GuiControl,, re, %iLength% - %xc% 
      
    } else {
        Tooltip, 192
     AHKsock_Close(iSocket = -1, iTimeout = 200)
     return
    }
}

/*
Recv(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bData = 0, iLength = 0) {
    
    If (sEvent = "CONNECTED") {
        
        ;Check if the connection attempt was succesful
        If (iSocket = -1) {
            OutputDebug, % "Client - AHKsock_Connect() failed. Exiting..."
            ExitApp
        } Else OutputDebug, % "Client - AHKsock_Connect() successfully connected!"
        
    } Else If (sEvent = "DISCONNECTED") {
        
        OutputDebug, % "Client - The server closed the connection. Exiting..."
        ExitApp
        
    } Else If (sEvent = "RECEIVED") {
        
        ;We received data. Output it.
        OutputDebug, % "Client - We received " iLength " bytes."
        xc := % Bin2Hex(&bData, iLength)
        ToolTip,  %xc%
    }
}
*/


Bin2Hex(addr,len) {
    Static fun, ptr 
    If (fun = "") {
        If A_IsUnicode
            If (A_PtrSize = 8)
                h=4533c94c8bd14585c07e63458bd86690440fb60248ffc2418bc9410fb6c0c0e8043c090fb6c00f97c14180e00f66f7d96683e1076603c8410fb6c06683c1304180f8096641890a418bc90f97c166f7d94983c2046683e1076603c86683c13049ffcb6641894afe75a76645890ac366448909c3
            Else h=558B6C241085ED7E5F568B74240C578B7C24148A078AC8C0E90447BA090000003AD11BD2F7DA66F7DA0FB6C96683E2076603D16683C230668916240FB2093AD01BC9F7D966F7D96683E1070FB6D06603CA6683C13066894E0283C6044D75B433C05F6689065E5DC38B54240833C966890A5DC3
        Else h=558B6C241085ED7E45568B74240C578B7C24148A078AC8C0E9044780F9090F97C2F6DA80E20702D1240F80C2303C090F97C1F6D980E10702C880C1308816884E0183C6024D75CC5FC606005E5DC38B542408C602005DC3
        VarSetCapacity(fun, StrLen(h) // 2)
        Loop % StrLen(h) // 2
            NumPut("0x" . SubStr(h, 2 * A_Index - 1, 2), fun, A_Index - 1, "Char")
        ptr := A_PtrSize ? "Ptr" : "UInt"
        DllCall("VirtualProtect", ptr, &fun, ptr, VarSetCapacity(fun), "UInt", 0x40, "UInt*", 0)
    }
    VarSetCapacity(hex, A_IsUnicode ? 4 * len + 2 : 2 * len + 1)
    DllCall(&fun, ptr, &hex, ptr, addr, "UInt", len, "CDecl")
    VarSetCapacity(hex, -1) ; update StrLen
    Return hex
}

GuiClose:
ExitApp


