Gui, Add, Button, x2 y129 w40 h30 gBut, x1
Gui, Add, Button, x42 y129 w40 h30 , x2
Gui, Add, Button, x82 y129 w40 h30 , x3
Gui, Add, Button, x122 y129 w50 h30 , x4
Gui, Add, Text, x2 y-1 w600 h20 vRED, COLOR
Gui, Font, S14
Gui, Add, Text, x2 y19 w440 h25 cFF0F0F vhx , vhx
Gui, Add, Text, x2 y50 w440 h25 c0FFF0F vrgb , rgb
; Generated using SmartGUI Creator for SciTE
Gui, Color, WindowColor000000,
Gui, Show, w684 h171, Untitled GUI


return
R = 127
GuiClose:
ExitApp
return
But:
R += 1
Loop, {
	If (R < 254)
		R += 1
	If (G < 254)
		G += 1
	If (B < 254)
		B += 1





	If (R > 127)
		G += 1
	If (G > 127)
		B += 1
	If (B > 127)
		R += 1
	If (R = 254)
		R = 0
	If (G = 254)
		G  = 0
	If (B = 254)
		B = 0


    GuiControl,, rgb, %r% %g% %b%
Hex := RGB2HEX(R, G, B)

 GuiControl, +c%Hex%, Red
 GuiControl,, Red, RummRummRGB
  GuiControl,, HX, %hex%
}
Goto, But
















RGB2HEX(R_, G_, B_)
{
SetFormat, IntegerFast, HEX
R_ += 0
G_ += 0
B_ += 0
StringTrimLeft, R, R_, 2
StringTrimLeft, G, G_, 2
StringTrimLeft, B, B_, 2
Hex = %R%%G%%B%
;tooltip,  %R% + %G%  + %B% + %Hex%
;Listvars
SetFormat, IntegerFast, D
Return hex
}