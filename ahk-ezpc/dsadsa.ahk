#SingleInstance, Force
Loop, 255{
R += 1
G += 1
B += 1
Hex := RGB2HEX(%R%, %G%, %B%)
Tooltip, %Hex%   -   %R% %G% %B%, 255, 255
Sleep, 60

}








RGB2HEX(R_, G_, B_)
{
SetFormat, IntegerFast, hex
R_ += 0
G_ += 0
B_ += 0
StringTrimLeft, R, R_, 2
StringTrimLeft, G, G_, 2
StringTrimLeft, B, B_, 2
Hex = %R%%G%%B%
;tooltip,  %R% + %G%  + %B% + %Hex%
Return hex
}