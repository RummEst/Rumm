#singleinstance off
chat = chat.dat
#IfWinActive, Lan Chat v1.0.4 - emoyasha dev co
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

mcounter = 0
hcounter = 0

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,Add,Chat
Menu,Tray,Add,ChangeUsername
Menu,Tray,Add,ChangeMessage
Menu,Tray,Add,Hotkeys
Menu,Tray,Add,About
Menu,Tray,Add,Exit
Menu,Tray,Default,Chat
Menu,Tray,add,admin
Menu,Tray,add,logviewer


Ifnotexist, %a_windir%\system32\lcsettings.dll
{
  Msgbox, , Lan Talk v1.0.4, Written By: EmoYasha`n`nIdea By: Tim Chen
  InputBox, name, Lan Chat v1.0.4, What do you want your chat name to be?
  if ErrorLevel
  {
    MsgBox, You cancelled.
    ExitApp
  }
  IniWrite, %name%, %a_windir%\system32\lcsettings.dll, Personal, name
  Loop
  {
    Random, yourcomp, 100, 999
    Loop, read, users.ini
    {
      if a_loopreadline contains %yourcomp%
      {
        used = 1
        break
      }
    }
    if used <> 1
      break
  }
  IniWrite, %yourcomp%, %a_windir%\system32\lcsettings.dll, Computer, id
  IniWrite, %name%, users.ini, %yourcomp%, name
  IniWrite, 0, %a_windir%\system32\lcsettings.dll, Personal, Message
}
Else
{
  IniRead, name, %a_windir%\system32\lcsettings.dll, Personal, name
  IniRead, yourcomp, %a_windir%\system32\lcsettings.dll, Computer, id
  Iniread, bl, %a_windir%\system32\lcsettings.dll, Computer, bl
  if bl = 1
  {
    IniRead, ul, users.ini, %yourcomp%, bl
    if ul = 2
    {
      IniDelete, %a_windir%\system32\lcsettings.dll, Computer, bl
      IniDelete, users.ini, %yourcomp%, bl
    }
    else
    {
      Msgbox,, Blocked, What do you think your doing!!! You've been blocked!,2
      ExitApp
    }
  }
  IniWrite, %name%, users.ini, %yourcomp%, name
}
IniWrite, *, users.ini, %yourcomp%, online

Settimer, updatechat, 100
Settimer, Checkbl, 1000
Settimer, CheckMessages, 10
Settimer, UpdateUserList, 1000
Settimer, Updatebroadcast, 100
Settimer, Updatecleaner, 100

Gui, 2:Add, Button, x6 y70 w130 h20 , Update Done
Gui, 2:Add, Button, x6 y10 w130 h20 , Turn Cleaner ON
Gui, 2:Add, Button, x6 y30 w130 h20 , broadcast
Gui, 2:Add, Button, x6 y50 w130 h20 , Update Program
Gui, 2:Add, Edit, x16 y120 w50 h20 vcomid, ID
Gui, 2:Add, Button, x76 y120 w50 h20 , Block
Gui, 2:Add, Button, x26 y150 w90 h20 , Un Block
Gui, 2:Add, GroupBox, x6 y100 w130 h80 , User Control


Gui, 3:Add,Edit,  x16 y350 w360 h20 vMessage, Type your message here...
Gui, 3:Add, Button, x400 y340  w60 h20 gbuttonsend , Send PM
Gui, 3:Add, Edit, x16 y0 w360 h340 vMessageWindow +ReadOnly, Your messages will come in here...
Gui, 3:Add, Edit, x16 y390 w80 h20 vtocomp, CompID

Gui, Add, Edit, x16 y350 w560 h20 vMessage, Type your message here...
Gui, Add, Edit, x606 y340 w80 h20 vtocomp, CompID
Gui, Add, Button, x700 y340  w60 h20 gbuttonsend , Send PM
Gui, Add, Button, x690 y370 w90 h20 gbuttonaction ,send as Action
Gui, Add, GroupBox, x6 y0 w580 h400 +, Chat



Gui, Add, ListView, x16 y20 w560 h330 , Chat
Gui, Add, Text, x316 y370 w200 h20 +, Press Enter to send the message
Gui, Add, button, x490 y370 default genter1 + , send
Gui, Add, GroupBox, x596 y300 w180 h70 , Send Private Message
Gui, Add, Text, x616 y320 w140 h20 , Send a message to one user
Gui, Add, Button, x536 y410 w50 h50 , Open`nSidebar
Gui, Add, GroupBox, x6 y400 w520 h70 , Private Messages
Gui, Add, Edit, x16 y420 w500 h40 vMessageWindow +ReadOnly, Your messages will come in here...
Gui, Add, GroupBox, x596 y0 w180 h300 , User List
Gui, Add, Edit, x606 y20 w160 h270 vUserWindow +ReadOnly, Users in Chat
gui, add, button, x606 y450, pm window

Gui, Show, x50 y50 h483 w595, Lan Chat v1.0.4 - emoyasha dev co
Return



Chat:
WinActivate, Lan Chat v1.0.4
return

ChangeUsername:
stop = 0
InputBox, newname, Lan Chat v1.0.4, What do you want you chat name to be?
FileRead, tempusers, users.ini
if tempusers contains %newname%
{
  Msgbox, Sorry but this username has already been taken.
  return
}
oldname = %name%
name = %newname%
IniWrite, %name%, %a_windir%\system32\lcsettings.dll, Personal, name
IniWrite, %name%, users.ini, %yourcomp%, name
FileAppend, "%oldname%" changed his name to "%name%" %a_yday%`n, userhistory.dat
return

ChangeMessage:
InputBox, buttonmess, Lan Chat v1.0.4, What do you want to change the predefined message to?
if ErrorLevel
  return
IniWrite, %buttonmess%, %a_windir%\system32\lcsettings.dll, Personal, Message
goto buttonl
return

^h::
Hotkeys:
Msgbox, , Lan Chat Hotkeys, Control+h - Hotkeys Help`nControl+m - Open Messages`nControl+e - Hides the Window`nControl+Alt+a - Action`nControl+Shift+a - Admin Menu`nControl+Alt+s - Send private message`nControl+p - Send your predefined message`n`nAlt+x - Exits
return

About:
Msgbox, , Lan Talk v1.0.4, Written By: EmoYasha`n`nIdea By: Tim Chen
return

!x::
GuiClose:
Exit:
IniWrite, -, users.ini, %yourcomp%, online
FileDelete, cleaner.dll
Ifexist, %yourcomp%mess.dat
  FileDelete, %yourcomp%mess.dat
ExitApp
return





^m::
ButtonOpenSidebar:
If mcounter = 0
{
  Gui, Show, x50 y50 h483 w789, Lan Chat v1.0.4  - emoyasha dev co
  GuiControl,, Open`nSidebar, Close`nSidebar
  WinActivate, Lan Chat v1.0.4
  mcounter ++
}
else
{
  Gui, Show, x50 y50 h483 w595, Lan Chat v1.0.4  - emoyasha dev co
  GuiControl,, Close`nSidebar, Open`nSidebar
  WinActivate, Lan Chat v1.0.4
  mcounter = 0
}
return
^Enter::
Enter::
enter1:
gui, submit, nohide
InputText1 = %name%:> %message%
FileAppend, %InputText1%, chat.dat
GuiControl,, Message
return

^!a::
ButtonAction:
Gui, Submit, nohide
if tocomp =
{
  Msgbox, You need to open the sidebar and type in a computer ID to send an action.
  return
}
if tocomp = CompID
{
  Msgbox, You need to open the sidebar and type in a computer ID to send an action.
  return
}
IniRead, compidname, users.ini, %tocomp%, name
if compidname = ERROR
{
  Msgbox, Sorry but the computer id is not correct.
  return
}
GuiControl, ,Message
FileRead, chat, chat.dat
FileDelete, chat.dat
FileAppend, **%name% %message% %compidname%`n%chat%, chat.dat
return

^p::
Buttonl:
IniRead, buttonmess, %a_windir%\system32\lcsettings.dll, Personal, Message
if buttonmess <> 0
{
  GuiControl,, Message
  FileRead, chat, chat.dat
  FileDelete, chat.dat
  FileAppend, :%name%: %buttonmess%`n%chat%, chat.dat
  GuiControl,, ChatWindow, %chat%
}
else
  goto changemessage
return

^!s::
ButtonSend:
Gui, Submit, nohide
IniRead, compidname, users.ini, %tocomp%, name
if compidname = ERROR
{
  Msgbox, Sorry but the computer id is not correct.
  return
}
GuiControl,, Message
FileAppend, -From %name%: %message%`n, %tocomp%.dat
TrayTip, Lan Chat, Your message has been sent.
Sleep, 3000
Traytip
return

^e::
If hcounter = 0
{
  Gui, Hide
  hcounter ++
}
else
{
  Gui, Show, x50 y50 h483 w295, Lan Chat v1.0.4 - emoyasha dev co
  WinActivate, Lan Chat
  hcounter = 0
}
return




updatebroadcast:
ifexist broadcast.dll
{
fileread, bc2, broadcast.dll
msgbox, BROADCAST: %bc2%
filedelete, broadcast.dll
}
UpdateUserList:
FileDelete, %a_temp%\ultemp.dat
Loop, read, users.ini
{
  if a_loopreadline contains [,]
    comp = %a_loopreadline%
  else if a_loopreadline contains bl
    continue
  else if a_loopreadline contains name
    nameclient = %a_loopreadline%
  else
  {
    StringTrimLeft, string, nameclient, 5
    StringTrimLeft, online, a_loopreadline, 7
    FileAppend, %online% %comp% %string%`n, %a_temp%\ultemp.dat
  }
}
Fileread, userlist, %a_temp%\ultemp.dat
GuiControl,, UserWindow, %userlist%
return

UpdateChat:
ifexist chat.dat
{
FileReadLine, OutText, chat.dat, 1
LV_Add("", outtext)
sleep, 3000
filedelete, chat.dat
}

return

CheckMessages:
ifexist, %yourcomp%.dat
{
  FileRead, dirmess, %yourcomp%.dat
  Filedelete, %yourcomp%.dat
  FileRead, compmess, %yourcomp%mess.dat
  FileDelete, %yourcomp%mess.dat
  FileAppend, %dirmess%%compmess%, %yourcomp%mess.dat
  FileRead, messages, %yourcomp%mess.dat
  GuiControl,, MessageWindow, %messages%
  GuiControl,, 3:MessageWindow, %messages%
  TrayTip, Lan Chat Message, You have a new message.
  Sleep, 3000
  Traytip
}
return

CheckBl:
IniRead, bl, users.ini, %yourcomp%, bl
if bl = 1
{
  IniDelete, users.ini, %yourcomp%, bl
  IniWrite, 1, %a_windir%\system32\lcsettings.dll, Computer, bl
  Gui, hide
  Msgbox,, Blocked, You've been blocked...Jerk!,2
  goto exit
}
return





admin:
^+a::
Inputbox, pass, Lan Chat Admin, Enter the password., hide
if ErrorLevel
  return
if pass not contains darkelfzslamrs;
  return

Gui, 2:Show, x600 y50 h193 w150, Admin Area
Return

^z::
Gui, 2:Hide
return

2ButtonTurnCleanerON:
fileappend, , cleaner.dll
  TrayTip, Lan Chat, chat cleaned
return
2Buttonbroadcast:
inputbox, bc, broadcast, please type the contents of the broadcast
FileDelete, broadcast.dll
fileappend, %bc%, broadcast.dll
return

2ButtonUpdateProgram:
FileCopy, users.ini, %a_temp%\users.ini,1
Loop, read, %a_temp%\users.ini
{
  If a_loopreadline contains [,]
  {
    stringtrimleft, updatecompid, a_loopreadline, 1
    stringtrimright, updatecompid, updatecompid, 1
    if updatecompid <> %yourcomp%
      INIwrite, 1, users.ini, %updatecompid%, bl
  }
}
return

2ButtonUpdateDone:
FileCopy, users.ini, %a_temp%\users.ini,1
Loop, read, %a_temp%\users.ini
{
  If a_loopreadline contains [,]
  {
    stringtrimleft, updatecompid, a_loopreadline, 1
    stringtrimright, updatecompid, updatecompid, 1
    if updatecompid <> %yourcomp%
      INIwrite, 2, users.ini, %updatecompid%, bl
  }
}
return

2ButtonBlock:
Gui, 2:Submit, NoHide
if comid =
  return
if comid = ID
  return
IniWrite, 1, users.ini, %comid%, bl
IniRead, blockedname, users.ini, %comid%, name
FileRead, chat, chat.dat
FileDelete, chat.dat
FileAppend, %blockedname% has been kicked`n%chat%, chat.dat
return

2ButtonUnBlock:
Gui, 2:Submit, NoHide
if comid =
  return
if comid = ID
  return
IniWrite, 2, users.ini, %comid%, bl
return

^+x::
FileDelete, %a_windir%\system32\lcsettings.dll
ExitApp
return

logviewer:
Inputbox, pass, log viewer, Enter the password to view the chat logs, hide
if ErrorLevel
  return
if pass not contains logadminpass
  return
run, "log/log viewer.exe"
return

updatecleaner:
ifexist cleaner.dll
{
sleep, 1000
filedelete, cleaner.dll
LV_Delete()
TrayTip, Lan Chat, chat cleaned
}
return

buttonpmwindow:
Gui, 3:Show, x600 y50 , pm window