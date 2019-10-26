#SingleInstance Off
Random, msg, 1, 2
Random, ran

If (msg = 1)
	msgbox, 16, %ran%%ran%, Your PC will now pay for its sins!
	SoundBeep, 12000, 25
	exitapp
else if (msg = 2)
	msgbox, 16, %ran%%ran%, Welcome to PC Hell!
	SoundBeep, 6000, 25
	exitapp


