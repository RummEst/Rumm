#SingleInstance, Force

Gui, Add, ListBox, x5 y5 w260 h200 T30 gJoker vList, Number	Item | 1	Gold | 2 	Iron| 3	Dirt
Gui, Add, Text, x300 y5 w200 vTXT, 0

Gui, Show, w500 h300, test
return
Joker:
Gui, Submit, NoHide
GuiControl, Text, TXT, %list%
Return


GuiClose:
ExitApp