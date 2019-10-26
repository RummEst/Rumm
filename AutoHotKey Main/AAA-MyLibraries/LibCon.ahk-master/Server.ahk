#Include LibCon.ahk
SmartStartConsole() 

puts("Hello World!")
Loop, {
gets(Com)
exist0 := IsLabel(Label)
msgbox, %com%_%exist0%_%Label%

	goto, %Com%
;else
	puts(Command "%Com%" Does not exist)
}


Label:
msgbox, lol
return