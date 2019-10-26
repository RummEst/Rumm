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
    WinHide, %Output%
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


