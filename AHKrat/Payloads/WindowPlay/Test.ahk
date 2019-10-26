msgbox, hi
Loop, {
Random, label, 1, 21
Goto, A%label%
msgbox, %code%
}




F2::
return
F3::
WinGetActiveTitle, Title
WinSet, Style, 	code = %code%, %Title%


return
A1:
code = 0x40000000
return
A2:
code = 0x10000000
return
A3:
code = 0x200000
return
A4:
code = 0x40000
return
A5:
code = 0x10000
return
A6:
code = 0x80000
return
A7:
code = 0x40000
return
A8:
code = 0x80880000
return
A9:
code = 0xCF0000
return
A10:
code = 0x20000
return
A12:
code = 0x20000000
return
A13:
code = 0x10000
return
A14:
code = 0x1000000
return
A15:
code = 0x100000
return
A16:
code = 0x20000
return
A17:
code = 0x400000
return
A18:
code = 0x8000000
return
A19:
code = 0xC00000	
return
A20:
code = 0x80000000
return
A21:
code = 0x800000
return



/*
Loop, 255 {
t -= 1
Sleep, 1
WinSet, Transparent, %t%, %title%
}
Loop, 255 {
t += 1
Sleep, 1
WinSet, Transparent, %t%, %title%
}
goto, a
*/

F5::exitapp