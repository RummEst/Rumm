Loop, {
	Tooltip, %Count%
	Sleep, 20
Count += 1
if (Count < 25) {
Sleep, 1
} else {
Count = 0
}


}








Return
x::
Count += 1
Tooltip, %Count%
Return