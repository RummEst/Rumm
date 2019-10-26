Egg = 10
xturn := ""
xshow := ""
baseDir = %Appdata%\AHK
baseIni = %Appdata%\AHK\ezpc.ini
FirstBoot = %Appdata%\AHK\boot
DefaultRun = notepad.exe
If !FileExist(FirstBoot) {
	IniWrite, 0, %BaseIni%, ToggleCheck, UseBigWords
	IniWrite, 0, %BaseIni%, ToggleCheck, UseSound
	IniWrite, 0, %BaseIni%, ToggleCheck, ToggleEzVolume
	IniWrite, 1, %BaseIni%, ToggleCheck, ToggleBakHide          ;1-defaultRun 2-Name 3-Enabled?
	IniWrite, %DefaultRun%, %BaseIni%, Shortcut1, Run
		IniWrite, Shortcut1, %BaseIni%, Shortcut1, Name
			IniWrite, True, %BaseIni%, Shortcut1, Enabled
	IniWrite, %DefaultRun%, %BaseIni%, Shortcut2, Run
		IniWrite, Shortcut2, %BaseIni%, Shortcut2, Name
			IniWrite, True, %BaseIni%, Shortcut2, Enabled
	IniWrite, %DefaultRun%, %BaseIni%, Shortcut3, Run
		IniWrite, Shortcut3, %BaseIni%, Shortcut3, Name
			IniWrite, True, %BaseIni%, Shortcut3, Enabled
	IniWrite, %DefaultRun%, %BaseIni%, Shortcut4, Run
		IniWrite, Shortcut4, %BaseIni%, Shortcut4, Name
			IniWrite, True, %BaseIni%, Shortcut4, Enabled
	IniWrite, %DefaultRun%, %BaseIni%, Shortcut5, Run
		IniWrite, Shortcut5, %BaseIni%, Shortcut5, Name
			IniWrite, True, %BaseIni%, Shortcut5, Enabled
;	IniWrite, ShortcutA, %BaseIni%, Shortcuts, A
;	IniWrite, ShortcutB, %BaseIni%, Shortcuts, B
;	IniWrite, ShortcutC, %BaseIni%, Shortcuts, C
ToolTip, debug_Firstboot
Sleep, 1000
FileAppend,,%FirstBoot%
Tooltip,
}

IniRead, 1Run, %BaseIni%, Shortcut1,Run
	IniRead, 1Name, %BaseIni%, Shortcut1,Name
		IniRead, 1Enabled, %BaseIni%, Shortcut1,Enabled
		
IniRead, 2Run, %BaseIni%, Shortcut2,Run
	IniRead, 2Name, %BaseIni%, Shortcut2,Name
		IniRead, 2Enabled, %BaseIni%, Shortcut2,Enabled
		
IniRead, 3Run, %BaseIni%, Shortcut3,Run
	IniRead, 3Name, %BaseIni%, Shortcut3,Name
		IniRead, 3Enabled, %BaseIni%, Shortcut3,Enabled
		
IniRead, 4Run, %BaseIni%, Shortcut4,Run
	IniRead, 4Name, %BaseIni%, Shortcut4,Name
		IniRead, 4Enabled, %BaseIni%, Shortcut4,Enabled
		
IniRead, 5Run, %BaseIni%, Shortcut5,Run
	IniRead, 5Name, %BaseIni%, Shortcut5,Name
		IniRead, 5Enabled, %BaseIni%, Shortcut5,Enabled


IniRead, BigW, %BaseIni%, ToggleCheck, UseBigWords, 0
IniRead, Sounds, %BaseIni%, ToggleCheck, UseSound, 0


If !FileExist(BaseDir) 
FileCreateDir, %Appdata%\AHK
IniRead, ToggleEzVolume, %BaseIni%, ToggleCheck,  ToggleEzVolume, 0
IniRead, ToggleBakHide, %BaseIni%, ToggleCheck, ToggleBakHide, 1
tooltip, base initation succes %ToggleEzVolume% %ToggleBakHide%



baseStart:
startboot = boot
SoundLow = 0 ;650
SoundHigh = 0 ;850
Enable = 1
#Persistent
#SingleInstance, Force
a = 0
b = 0
c = 0
previous_ID := 0
Menu, tray, NoStandard
Menu, Tray, add, Disable
Menu, Tray, add, Debug, Debug
Menu, Tray, add, Settings, Sets
Menu, Tray, add,
Menu, Tray, add, Exit

If (BigW = 1) {
xturn := "Turn "
xshow := "Show "
}

Goto, FirstMenuGen
return
Debug:
;msgbox, 1 ----------------DEBUG HERE
ListVars
return

iniCreate:
	msgbox, lol
	;IniWrite, 0, %BaseIni%, ToggleCheck, ToggleEzVolume
	;IniWrite, 1, %BaseIni%, ToggleCheck, ToggleBakHide
return


return
exit:
exitapp
return

Enable:
Disable:
if (Enable = 1) {
	Menu, Tray, rename, Disable, Enable
	Enable = 0
	
	;DISABLED
	
} else {
	Menu, Tray, rename, Enable, Disable
	Enable = 1
	
	;ENABLED (DEFAULT)
	
}
/* Toggle Script

if (A = 1) {
	A = 0
	
} else {
	A = 1
	
}


Menu, Me, Add, 3
Menu, Me, Add, 4
Menu, Me, Add, 5
Menu, Me, Add, 6
Menu, Me, Add, 7
Menu, Me, Add, 8

1. INFO 2.CLICKS & TOGGLES 3.SPECIAL
*/
; ACTUAL START    --menu me---------DEFAULT MENU--------------------------------------- SCRIPT:
return
return
return
!F9::
exitapp
;%GetLocalIPByAdaptor("Ethernet")%:
return
!F8::
ListVars
return
return








;-------------------------------------MENU-GENERATION---[DEFAULT]
FirstMenuGen:
; last active window title --
DateC = %A_DD%/%A_MM%/%A_YYYY%
ipC =  % GetLocalIPByAdaptor("Ethernet")
Menu, Me, Add, Search Clipboard, SClip
Menu, Me, Add, Search Google, SGoogle

Menu, MeS, Add,%1Name%, S1
Menu, MeS, Add,%2Name%, S2
Menu, MeS, Add,%3Name%, S3
Menu, MeS, Add,%4Name%, S4
Menu, MeS, Add,%5Name%, S5
Menu, Me, add, Shortcuts, :MeS




Menu, Me, Add
Menu, Me, Add, Local IP: %IPC% , IP   ;IP
Menu, Me, Add, Date: %DateC%, DATE 
;Menu, Me, Add, LastWIP, LastWinA  --Be brought 2 coder page
;Addon Toggles (2) TGbak TGezvol
Menu, MeT, Add, Toggle BakHide, TGbak
Menu, MeT, Add, Toggle ezVolume, TGezvol
Menu, Me, Add
Menu, Me, Add, Toggles, :MeT
Menu, Me, Add
Menu, Me, Add, `%AppData`%, RunAD
Menu, MeSub, Add, Temp, RunTmp
Menu, MeSub, Add, Program Files, RunPrF
Menu, MeSub, Add, Windows Dir, RunWinDir
Menu, MeSub, Add, Startup (Global), RunStpG
Menu, MeSub, Add, Startup (User), RunStpU
Menu, MeSub, Add, My Documents, RunDoc
Menu, Me, Add, Navigate, :MeSub

Menu, MeUtil, Add, Task Manager, UTask
Menu, MeUtil, Add, Notepad, UNote
Menu, MeUtil, Add, CommandPrompt, UCmd
Menu, MeUtil, Add, PowerShell, UShell
Menu, MeUtil, Add, Calculator, UCalc

Menu, Me, add, Utilities, :MeUtil

Menu, MePower, Add, Sleep,  PSleep
Menu, MePower, Add, Logout, PLog
Menu, MePower, Add, Shutdown, PShut
Menu, MePower, Add, Re%Startboot%, PRes

Menu, Me, Add, Power, :MePower
Menu, Me, Add, %xturn%Monitor Off, MonOff
Menu, Me, Add, %xShow%Desktop, ShowDesk
;--

If (ToggleBakHide = 1)
Menu, MeT, Check, Toggle BakHide

If (ToggleEzVolume = 1)
Menu, MeT, Check, Toggle ezVolume





Sleep, 150
tooltip,
Sdis:
return
Sets:
F2::
Gui, Add, GroupBox, x5 y2 w250 h130 , Toggles
Gui, Add, GroupBox, x5 y138 w250 h170 , Shortcut Settings 
;Gui, Add, Text,  x5 y138 w150 h15, Shortcut Settings 
Gui, Add, ListBox, x15 y153 w120 h130 T10 gList vList, 1	%1Name%|2	%2Name%|3	%3Name%|4	%4Name%|5	%5Name% ;|%Shortcut_A%|%Shortcut_B%|%Shortcut_C% ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, CheckBox, x140 y220 w100 h20 gSdis +Disabled, Disable
Gui, add, button, x140 y180 w100 h20 gNewname, Rename ;;;;
Gui, add, button, x140 y200 w100 h20 gNewDest, Set Destination ;;;;
Gui, add, edit, y278 x15 w230 h20 vRunD, ...
Gui, Font, s12 Verdana
gui, add, text, x140 y160 w100 h20 +center vTxt, Shortcut
Gui, font, s8 Bebas
gui, add, text, y257 x140 w100 h20 +center vState, Idle
;Gui, add, button, x80 y290 h25 w100 gMenuRef ,Refresh Menu 
Gui, font
Gui, Add, CheckBox, x15 y20 w160 h20 , BakHide Enabled By Default
Gui, Add, CheckBox, x15 y40 w160 h20 , EzVolume Enabled By Default
Gui, Add, CheckBox, x15 y60 w110 h20 +disabled , Enable Sounds
Gui, Add, CheckBox, x15 y80 w110 h20 vBigW gBigWW, Use Big Words*
Gui, Add, Button, x230 y13 w20 h20 , >> ;;;;
Gui, Add, Button, x14 y100 w80 h25 gVcon, View Config ;;;;;_____________dd
Gui, font, s8 Verdana
Gui, add, text, x100 y110 w150 h20, *Needs restart to take effect
gui, font
Gui, font, s10
Gui, Add, Text, x5 y345 w250 h20 +cFF0F0F vEgg gEgg +Center, EZPC v1.2.0 Made by Janar Rumm
gui, font

Gui, -Maximizebox -Minimizebox 
Gui, Show, x756 y256 h360 w260, EZPC v1.2.0 - Settings
return

return
vcon:
run, %Baseini%
return

List:
rundd := ""
gui, submit, nohide
sArray := StrSplit(list, A_TAB)
guicontrol, text, txt, % sArray[2]     ; sArray[1] "-"
Dst := sArray[1]
iniread, rundd, %baseini%, Shortcut%Dst%, Run
GuiControl, text, RunD, %rundd%

return

Newname:
If (list = "") {
	msgbox, 16, Error,Please select a shortcut!
	return
} else {
gui, submit, nohide
sArray := StrSplit(list, A_TAB)
Name := sArray[2]
Nr := sArray[1]
Inputbox,  New_Name,Rename, Enter new name for "%Name%", ,240,124,
if ErrorLevel
	return
%nr%Name := New_Name
IniWrite, %New_Name%, %BaseIni%, Shortcut%nr%, Name
guicontrol, text, List, |
guicontrol, text, List, 1	%1Name%|2	%2Name%|3	%3Name%|4	%4Name%|5	%5Name%
goto, MesMenuReset
return
}
return
NewDest:
guicontrol, text, state, Writing...
If (list = "") {
	msgbox, 16, Error,Please select a shortcut!
	return
}
gui, submit, nohide
dbug = %runD%
sArray := StrSplit(list, A_TAB)
Name := sArray[2]
Nr := sArray[1]
IniWrite, %runD%, %baseini%, Shortcut%nr%, Run
guicontrol, text, state, Destination Set
Sleep, 300
guicontrol, text, state, Idle
IniRead, 1Run, %BaseIni%, Shortcut1,Run
IniRead, 2Run, %BaseIni%, Shortcut2,Run
IniRead, 3Run, %BaseIni%, Shortcut3,Run
IniRead, 4Run, %BaseIni%, Shortcut4,Run
IniRead, 5Run, %BaseIni%, Shortcut5,Run
return

BigWW:
gui,submit,nohide
if (BigW = 1) {
IniWrite, 1, %baseini%, ToggleCheck, UseBigWords
}
else {
IniWrite, 0, %baseini%, ToggleCheck, UseBigWords
}
return
return


return
S1:

run, %1Run%
return
S2:

run, %2Run%
return
S3:

run, %3Run%
return
S4:

run, %4Run%
return
S5:

run, %5Run%
return
return
GuiClose:
Gui, Destroy
return
;Menu, Me, Add,
;--------------------------------------MENU END
;---------------------------------CONSTANT LOOP
Loop, {
Sleep, 100
Random, DeB, 0, 9
Tooltip, %deb%, 00, 00
;WinGet, current_ID, ID, A
;WinWaitNotActive, ahk_id %current_ID%
;previous_ID := current_ID
}

XButton1:: ;MENU OPEN
MouseGetPos, mouseX, mouseY
Menu, Me, Show, %mouseX%, %MouseY%
return


return ;-----------------------------cmd_ip
ip:
SoundBeep, %SoundLow%, 25
run, %comspec% /c title EZPC & @echo off & color c & cls & ipconfig & echo %A_IPAddress1% - %A_IPAddress2% - %A_IPAddress3% - %A_IPAddress4% & echo EZPC - :)& ping www.google.com & pause,,,cmdip_pid
Sleep, 200
WinGetTitle, cmdip_title, ahk_pid %cmdip_pid%
;msgbox, %cmdip_pid%%cmdip_title%
WinSet, Transparent, 235, %cmdip_title%
RETURN
Date:  ;------------------------------date
clipboard := DateC
Tooltip, Date copied to clipboard...
Sleep, 600
tooltip,
SoundBeep, %SoundHigh%, 25
return
;-----------------------------end
;---------------------------------------------TOGGLES
; 13-bak off 14-bak on 15-ez off 16-ez on
;  ToggleEzVolume
;  ToggleBakHide
;  TGbak:
;  TGezvol:

return 

TGbak:
if (ToggleBakHide = 1) {
	ToggleBakHide = 0 ; SET OFF
	;IniWrite, 0, %BaseIni%, ToggleCheck, ToggleBakHide
	Send, {F13}
	Menu, Me, UnCheck, Toggle BakHide
} else {
	ToggleBakHide = 1 ; SET ON
	;IniWrite, 1, %BaseIni%, ToggleCheck, ToggleBakHide
	Send, {F14}
	Menu, Me, Check, Toggle BakHide
}

return
TGezvol:
if (ToggleEzVolume = 1) {
	ToggleEzVolume = 0 ; SET OFF
	;IniWrite, 0, %BaseIni%, ToggleCheck, ToggleEzVolumeF13
	Send, {F15}
	Menu, Me, UnCheck, Toggle ezVolume
} else {
	ToggleEzVolume = 1 ; SET ON
	;IniWrite, 1, %BaseIni%, ToggleCheck, ToggleEzVolume
	Send, {F16}
	Menu, Me, Check, Toggle ezVolume
}
return


Egg:
If (Egg < 95) {
Egg += 5
Gui, Font, cFF00%egg% s10
GuiControl, Font, egg
Gui, Font,
WinSetTitle,EZPC v1.2.0 - Best Cat :),, EZPC v1.2.0 - Settings,
return
}
WinSetTitle, EZPC v1.2.0 - Settings,,EZPC v1.2.0 - Best Cat :),
pic := WebPic(WB1, "https://i.imgur.com/PJh1hLR.jpg", "w512 h512, cFF0000")
SplashImage, C:\Users\User\Desktop\Share\image.jpg,b,,,SplashCat
FadeIn()
SoundPlay, *16
Sleep, 600
FadeOut()
SplashImage, off
Egg = 10
Gui, Font, cFF0000 s10
GuiControl, Font, egg
Gui, Font,
return



;------------------------------RUNNERS
return
RunTmp:
run, %temp%
return
RunAD:
run, %appdata%
return
RunPrF:
run, %A_ProgramFiles%
return
RunWinDir:
run, %A_WinDir%
return
RunStpG:
run, %A_StartupCommon%
return
RunDoc:
run, %A_MyDocuments%
return
RunStpU:
run %A_Startup%
return

SClip:
Clip = %Clipboard%
Query := StrReplace(Clip, A_Space, "+")
run, www.google.com/search?q=%Query%
Return
SGoogle:
Inputbox, SEARCH, Google Search, , ,220, 102,,,
Query := StrReplace(SEARCH, A_Space, "+")
run, www.google.com/search?q=%Query%
return
;   https://www.google.com/search?q=hey+hey
;-------------------RUNNERS-END

PSleep:
Tooltip, Sending to sleep
Sleep, 400
Tooltip,
DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
Return


PLog:
Tooltip, Logging out
Sleep, 400
Tooltip,
Shutdown, 0
return




PShut:
Msgbox, 4, Shutdown, Are you sure you want to Shutdown the PC ?
IfMsgBox Yes
	Shutdown, 1
else
	return
return
PRes:
Msgbox, 4, Restart, Are you sure you want to Re%startboot% the PC ?
IfMsgBox Yes
	Shutdown, 2
else
	return
return

MonOff:
SendMessage, 0x112, 0xF170, 2,, Program Manager
Return

ShowDesk:
Send #d
return



UTask:
run, Taskmgr.exe
return
UNote:
run, Notepad, %A_Desktop%
return
UShell:
Run, %A_WinDir%\System32\WindowsPowerShell\v1.0\powershell.exe, %A_WinDir%\System32
return
UCalc:
Run, Calc.exe
return
UCmd:
Run, cmd.exe,%A_WinDir%\System32,, ucmd_pid
Sleep, 220
WinGetTitle, ucmd_title, ahk_pid %ucmd_pid%
;msgbox, %cmdip_pid%%cmdip_title%
WinSet, Transparent, 225, %ucmd_title%
RETURN
return
Return
MesMenuReset:
Menu, Mes, DeleteAll
Sleep, 10
Menu, MeS, Add,%1Name%, S1
Menu, MeS, Add,%2Name%, S2
Menu, MeS, Add,%3Name%, S3
Menu, MeS, Add,%4Name%, S4
Menu, MeS, Add,%5Name%, S5
Return
Return


















































































msgbox, 0, Error, End Of Line :) Looks like you missed a "return" !
return
GetLocalIPByAdaptor(adaptorName) {
    objWMIService := ComObjGet("winmgmts:{impersonationLevel = impersonate}!\\.\root\cimv2")
    colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionID = '" adaptorName "'")._NewEnum, colItems[objItem]
    colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE InterfaceIndex = '" objItem.InterfaceIndex "'")._NewEnum, colItems[objItem]
    Return objItem.IPAddress[0]
}

GetLocalIPs() {
    adaptors := Object()
    ips := Object()
    objWMIService := ComObjGet("winmgmts:{impersonationLevel = impersonate}!\\.\root\cimv2")
    colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapter")._NewEnum, colItems[objItem]
    While (colItems[objItem])
        adaptors.Insert(objItem.InterfaceIndex,objItem.NetConnectionID)
    For index, name in adaptors {
        colItems := objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE InterfaceIndex = '" index "'")._NewEnum, colItems[objItem]
        If (name && objItem.IPAddress[0])
            ips.Insert(name,objItem.IPAddress[0])
    }
    Return ips
}

WebPic(WB, Website, Options := "") {
	RegExMatch(Options, "i)w\K\d+", W), (W = "") ? W := 50 :
	RegExMatch(Options, "i)h\K\d+", H), (H = "") ? H := 50 :
	RegExMatch(Options, "i)c\K\d+", C), (C = "") ? C := "EEEEEE" :
	WB.Silent := True
	HTML_Page :=
	(RTRIM
	"<!DOCTYPE html>
		<html>
			<head>
				<style>
					body {
						background-color: #" C ";
					}
					img {
						top: 0px;
						left: 0px;
					}
				</style>
			</head>
			<body>
				<img src=""" Website """ alt=""Picture"" style=""width:" W "px;height:" H "px;"" />
			</body>
		</html>"
	)
	While (WB.Busy)
		Sleep 10
	WB.Navigate("about:" HTML_Page)
	Return HTML_Page
}

FadeOut() {
	Trans = 255
Loop, 610 {
	Random, Delay, 2, 5

Trans -= 0.5
WinSet, Trans, %Trans%,  SplashCat
}
return
}
return

FadeIn() {
	Trans = 0
Loop, 610 {
	Random, Delay, 2, 5

Trans += 0.5
WinSet, Trans, %Trans%,  SplashCat
}
return
}
return
