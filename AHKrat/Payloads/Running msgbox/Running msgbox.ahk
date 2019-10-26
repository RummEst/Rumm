; Generated using SmartGUI Creator for SciTE   >>>> <<<< >>>> <<<< 1143 127 
#SingleInstance, force
Allowed = 100
Gui, -Border -Caption +AlwaysOnTop
Gui, add, text, x14 y11 h8 w5,█
Gui, Show, w32 h32, center
CoordMode, Tooltip, Screen
CoordMode, Mouse, Screen
Gui 2: -Border -Caption +AlwaysOnTop
Gui 2:Add, Button, x5 y5 w20 h20 gB, b0
Gui 2:Add, Edit, x30 y5 w48 h20 vSetX, X
Gui 2:Add, Edit, x83 y5 w48 h20 vSety, Y
Gui 2:Add, Edit, x173 y5 w48 h20 vSetd, 100
Gui 2:Add, Button, x136 y5 w32 h20 gSet, Set
Gui 2:Show, y1000 x16 w256 h32, Gucci
Gui, Color, 00FFFF

inloop:
Loop,  {
	WinGetPos, ExB, EyB,,,center
MouseGetPos, Mx, My,,,
Ex := ExB + 16
Ey := EyB + 16

xde := Mx - Ex
yde := My - Ey
xd := xde * xde
yd := yde * yde
d := yd + xd
Dis := sqrt(d)
tooltip, %Dis%  -  xd=%xd%    yd=%yd%   d=%d%, -2, 1

If (Dis < Allowed)
	Goto, Red



Gui, Color, FFF000


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

B:
x := 960 - 32
y := 540 - 32
GuiControl, text, Setx, %x%
GuiControl, text, Sety, %y%
;WinMove, center,, 960, 540
return

Set:
gui 2: Submit, Nohide
WinMove, center,, %setx%,%sety%
Allowed := SetD
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