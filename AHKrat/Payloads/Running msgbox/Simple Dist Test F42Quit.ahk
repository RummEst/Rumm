; Generated using SmartGUI Creator for SciTE   >>>> <<<< >>>> <<<< 1143 127 
#SingleInstance, force
Gui, -Border -Caption +AlwaysOnTop
CoordMode, Tooltip, Screen
CoordMode, Mouse, Screen


Blue:
Gui, Color, 00FFFF
Gui, Show, w8 h8, center
inloop:
Loop,  {
	WinGetPos, Ex, Ey,,,center
MouseGetPos, Mx, My,,,

xde := Mx - Ex
yde := My - Ey
xd := xde * xde
yd := yde * yde
d := yd + xd
Dis := sqrt(d)
tooltip, %Dis%  -  xd=%xd%    yd=%yd%   d=%d%, -2, 1

If (Dis < 80)
	goto, red



Gui, Color, 00FFFF


;~ WinMove, Error,,%x%, %y%
;tooltip, %ax%  %ay%, -20, 20
}
; 860 476

return
F4::exitapp
return

Red:
Gui, Color, FF0000
goto, inloop
return


















return
/*
If (Ex < 960) {
	aX = 1
} else {
aX = 0
}
If (Ey < 540) {
aY = 1
} else {
aY = 0
}

if (aY = 1) {

}