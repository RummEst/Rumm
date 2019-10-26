#SingleInstance, Force
HiddenWin = 0
ScanIndex = 0
INDEX = 0
;Gui, Add, ListBox, x5 y5 w80 h850 vList, %output%
;Gui, Add, ListBox, x90 y5 w80 h850 vList0, %output0%
Gui, add, checkbox, x5 y4 gCHK vHiddenWin, DetectHiddenWindows
Gui, add, checkbox, x140 y4 vLockedIndex , LockedIndex
;Gui, add, checkbox, x230 y4 vDebug1, Debug1
Gui, Add, ListBox, x5 y20 w650 h850 vList1 HWNDhLB gLab1 t8 t16, %output1%
Gui, Font, s10, Verdana 
Gui, add, text, x660 y5 w120 y14 vtxt1 , EVENTINFO=
Gui, add, text, x660 y5 w120 y28 vtxt2 , INDEX=%INDEX%
Gui, add, button, x660 y48 w80 h22 gRef vScan, Scan
Gui, add, button, x750 y48 w22 h22 gexit, X
Gui, add, button, x772 y48 w22 h22 gtool, -
Gui, add, button, x660 y72 w80 h22 vb0 gButton, b0
Gui, Font, s8  cFF0000, Verdana 
Gui, add, text, x660 y100 w160 h15 vd1 , DEBUG=HiddenWin=%HiddenWin%
Gui, add, text, x660 y115 w160 h15 vd2 , DEBUG=State=0xIDLE
Gui, add, text, x660 y130 w160 h15 vd3 , DEBUG=
Gui, Show, w825 h881, list

return

CHK:
Gui, Submit, NoHide
GuiControl, Text,d1,  DEBUG=HiddenWin=%HiddenWin%



Return
ref:
A:
GuiControl, Text,d2,  DEBUG=State=0xWORK
output = |
If (HiddenWin = 1) {
DetectHiddenWindows On  
} 
Else {
   DetectHiddenWindows Off 
}
if not EnumAddress 
    EnumAddress := RegisterCallback("EnumWindowsProc", "Fast")

DllCall("EnumWindows", "Ptr", EnumAddress, "Ptr", 0)
EnumWindowsProc(hwnd, lParam)
{
    
    global Output
    WinGetTitle, title, ahk_id %hwnd%
    WinGetClass, class, ahk_id %hwnd%
	Sleep, 5
    
    
    if (output !="") {
     LastOut := Output
     GuiControl, Text,d3,  DEBUG=%LastOut%
    }
    
    if title
    
     ;Output .=  hwnd "|"
     Output .=  title "|" 
     ;Output .=  class  "|"
     GuiControl, Text, list1, %Output% 
     Output = 
    return true  

}
GuiControl, Text,d2,  DEBUG=State=0xDONE
return
GuiControl, Text, list, |
return
x::
Gui, Submit, NoHide
tooltip, %list1%
return
return
/*
Ref:

Goto, A
GuiControl, Text, list1, %Output% 
Return
*/
GuiClose:
Exit:
ExitApp
return




Lab1:
GuiControl, Text, txt1, EVENTINFO=%A_EventInfo%
Return


Button:
    ScanIndex += 1
    GuiControl, Text,b0,sIndex=%ScanIndex%
Return
Tool:
Tooltip,
Return


