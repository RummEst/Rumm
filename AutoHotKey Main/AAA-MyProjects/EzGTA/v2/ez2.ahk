;start&stop var is SS
ini = %temp%\ez.ini
toggle  := 0
IfNotExist, %Temp%\ez.ini, {
    IniWrite, 0, %temp%\ez.ini, 1
}
on = %temp%\sp.png
off = %temp%\st.png

Gui, -MaximizeBox -MinimizeBox +ToolWindow
URLDownloadToFile, https://i.imgur.com/5ELRqRo.png, %temp%\sp.png
URLDownloadToFile, https://i.imgur.com/YJi3hzz.png, %temp%\ezGTA.png
URLDownloadToFile, https://i.imgur.com/xf9KKvo.png, %temp%\st.png
Gui, Add, Picture, x2 y-1 w170 h120 , %temp%\ezGTA.png
Gui, Color, WindowColor404040
Gui, Add, Picture, x2 y134 w176 h80 vSS gStart, %temp%\st.png
Gui, Add, Progress, x2 y115 w172 h30 cRed Background404040 vProg,
Gui, Font, Bold
Gui, Font, s16
Gui,1:Add,Text, cWhite x2  y115 w172  +0x200 +Center +BackgroundTrans vText22,        ;here empty

IniRead, State, %temp%\ez.ini, 1
if (State = 0){
    GuiControl,, SS, %off%
            GuiControl,, Prog, 0
        GuiControl,1:,Text22,Idle
}
else,
{
    GuiControl,, SS, %on%
            GuiControl,, Prog, 100
        GuiControl,1:,Text22,Active
}
;------------------------------GUI END----------------------------------------------------------------------------------------------




WinGet, gtaPID, PID, Grand Theft Auto V,, Google Chrome
Process, Exist, GTA5.exe
If (ErrorLevel = 1) ;-----------------CHANGE ME!!!!------------------------------------------------------------------------------------------------------00000
{
	msgbox, 16, Error, GTA is not running!
	ExitApp
}
else
{
	Gui, Show, x127 y87 h201 w176, EzGTA
    Sleep, 1000
    Return
}



Start:
    toggle  := !toggle

    if (toggle = 0){
        ;---OFF---
        IniWrite, 0, %ini%, 1
        GuiControl,, Prog, 0
        GuiControl,1:,Text22,Idle
        GuiControl,, SS, %off%
    }
    else{
        ;---ON---
        IniWrite, 1, %ini%, 1
        WinSetTitle, EzGTA
        GuiControl,, Prog, 100
        GuiControl,1:,Text22,Active
        GuiControl,, SS, %on%
    }
return


GuiClose:
ExitApp
