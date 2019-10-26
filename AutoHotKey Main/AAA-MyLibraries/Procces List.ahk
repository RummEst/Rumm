Gui, Add, ListBox, x5 y5 w895 h850 vList, %output%
Gui, add, button, x5 y857 w80 h22 gRef, Refresh
Gui, Show, w900 h881, list

A:
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
        Output .= "HWND: " . hwnd . "`tTitle: " . title . "`tClass: " . class . "|"
    return true  ; Tell EnumWindows() to continue until all windows have been enumerated.
}
GuiControl, Text, list, |
Sleep, 150
GuiControl, Text, list, %Output%




return
Ref:
Goto, A
Return

GuiClose:
ExitApp


