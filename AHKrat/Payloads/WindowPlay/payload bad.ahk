Gui, Add, ListBox, x5 y5 w300 h850 vList, %output%
Gui, Show, w305 h881, list
SetWinDelay, -1

if not EnumAddress 
    EnumAddress := RegisterCallback("EnumWindowsProc", "Fast")
DetectHiddenWindows On  
DllCall("EnumWindows", "Ptr", EnumAddress, "Ptr", 0)
EnumWindowsProc(hwnd, lParam)
{
    global Output
    WinGetTitle, title, ahk_id %hwnd%
    WinGetClass, class, ahk_id %hwnd%
	
    if title
        Output .=  title 
    GuiControl, Text, list, %Output%
    WinShow, %Output%
    Random, t, 0, 255
    Random, kk1
    Random, kk2
    Random, kk3
    WinSet, Transparent, %t%, %Output%
    WinSetTitle, %Output%, , WinHell %kk1%%kk2%%kk3%
    WinActivate, %OutPut%
    Random, x, 10, 1720
    Random, y, 10, 890
    WinMove, %Output%,,%x%, %y%
    WinSet, Style, 0x10000000, %output%
    WinSet, Style, 0x200000, %output%
    
     Output = 
     Sleep, 20
    return true  ; Tell EnumWindows() to continue until all windows have been enumerated.
}
GuiControl, Text, list, |
Sleep, 150
GuiControl, Text, list, %Output%




return


GuiClose:
ExitApp


