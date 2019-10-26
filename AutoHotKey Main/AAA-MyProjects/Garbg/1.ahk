FileDelete, leak.txt
#MaxMem 4096
Gui, Show, w110 h50, test
loops = 0
;FileDelete, garbg.txt
leak = 1000
Loop, 20{
Random, x
Random, x1
Random, x2
Random, x3
Random, x4
leak = %leak%%x%%x1%%x2%%x3%%x4%
;FileRead, read, garbg.txt
Tooltip, %A_Index%, 
loops = %A_Index%
Sleep, 1
}
FileAppend, %loops%_%leak%, leak.txt
Return


GuiClose:
Exitapp