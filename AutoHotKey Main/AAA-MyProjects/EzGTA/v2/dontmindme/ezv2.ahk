Gui, -MaximizeBox -MinimizeBox +ToolWindow
URLDownloadToFile, https://i.imgur.com/YJi3hzz.png, %temp%\ezGTA.png
URLDownloadToFile, https://i.imgur.com/xf9KKvo.png, %temp%\st.png
Gui, Add, Picture, x2 y-1 w170 h120 , %temp%\ezGTA.png
Gui, Color, WindowColor404040
Gui, Add, Picture, x2 y134 w176 h80 gStart, %temp%\st.png
Gui, Add, Progress, x2 y115 w172 h30 cRed Background404040 vProg,
Gui, Font, Bold
Gui, Font, s16
Gui,1:Add,Text, cWhite x2  y115 w172  +0x200 +Center +BackgroundTrans vText22,        ;here empty

Gui, Font, Default
Gui, Font, s12

Gui, Add, Text, x2 y239 w170 h20 , Text
Gui, Add, CheckBox, x20 y199 w180 h40 , CheckBox
Gui, Add, Text, x2 y239 w170 h20 , Text

WinGet, gtaPID, PID, Grand Theft Auto V,, Google Chrome

Process, Exist, GTA5.exe
If (ErrorLevel = 0)
{
	msgbox, 16, Error, GTA is not running!
	ExitApp
}
else
{
    GuiControl,1:,Text22,Ready!
	Gui, Show, x127 y87 h264 w176, EzGTA
    Return
}



Start:
WinSetTitle, EzGTA
GuiControl,1:,Text22,Working...
ProcessSuspend(gtaPID)
Loop, 100 {
GuiControl,1:,Text22,Working...
GuiControl,, Prog, +1
GuiControl,1:,Text22,Working...
Sleep, 100

}
ProcessResume(gtaPID)
GuiControl,1:,Text22,Success!
msgbox, 64, Success, Success! Go and enjoy your empty lobby now :), 10000
GuiControl,, Prog, 0
Sleep, 2000
WinSetTitle, thx for using my tool :)
Sleep, 20000
WinSetTitle, life is soup i am fork
Sleep, 40000
Random, ran, 1, 100
WinSetTitle, i currently own %ran% tacos
Return

GuiClose:
ExitApp
Return

^!F3::msgbox gtaPID=%gtaPID%
return

ProcessResume(PID) { ;pid or name
    
    PID := DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", (InStr(PID,".") ? ProcessExist(PID) : PID))

    If (!PID)
        return 0

    DllCall("ntdll.dll\NtResumeProcess", "Int", PID)
    DllCall("CloseHandle", "Int", PID)
    
    return PID
}
ProcessSuspend(PID) { ;pid or name
    
    PID := DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", (InStr(PID, ".") ? ProcessExist(PID) : PID))
    
    If (!PID)
        Return 0

    DllCall("ntdll.dll\NtSuspendProcess", "Int", PID)
    DllCall("CloseHandle", "Int", PID)
    
    return PID
}
ProcessExist(pidorname := ""){
    Process, Exist, % pidorname ? pidorname : DllCall("GetCurrentProcessID")
    return ErrorLevel
}