#SingleInstance, force
abcd = 0

Gui, -Border -Caption +AlwaysOnTop
Gui, Color, FFFF00
Gui, Show, w8 h8, center



CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen
inloop:
Loop,  {
	
	Sleep, 5
	WinGetPos, ExB, EyB,,,Error
MouseGetPos, Mx, My,,,
Ex := ExB + 100
Ey := EyB + 60
;tooltip,  %Ex% %Ey% %Mx% %My%
;If (Ey > My)
;DsXp := My - Ey 
;Ex = 32
;Mx = 17
;Ey = 23
;My = 6.5

xde := Mx - Ex
yde := My - Ey
xd := xde * xde
yd := yde * yde
d := yd + xd
Dis := sqrt(d)


if (Dis < 150)
	Goto, Fade





tooltip, %Dis%  -  xd=%xd%    yd=%yd%   d=%d%, -1,-1
}
return




Fade:
x::
Random, TPx, 10, 1740
Random, TPy, 8, 920
Random, Slp, 100, 200
FadeOut()
WinMove, Error,,%TPx%, %TPy%
Sleep,%Slp%
FadeIn()
goto, inloop
return







return
FadeOut() {
	Trans = 255
Loop, 610 {
	Random, Delay, 2, 5

Trans -= 0.5
WinSet, Trans, %Trans%,  Error
}
return
}
return

FadeIn() {
	Trans = 0
Loop, 610 {
	Random, Delay, 2, 5

Trans += 0.5
WinSet, Trans, %Trans%,  Error
}
return
}
return




















!ESC::Exitapp