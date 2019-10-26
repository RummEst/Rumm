
#SingleInstance, force
Gui, Add, GroupBox, x5 y2 w250 h130 , Toggles
Gui, Add, Text,  x5 y138 w150 h15, Shortcut Settings, 
Gui, Add, ListBox, x5 y153 w120 h130 , %Shortcut1%|%Shortcut2%|%Shortcut3%|%Shortcut4%|%Shortcut5% ;|%Shortcut_A%|%Shortcut_B%|%Shortcut_C%
Gui, Add, CheckBox, x15 y20 w160 h20 , BakHide Enabled By Default
Gui, Add, CheckBox, x15 y40 w160 h20 , EzVolume Enabled By Default
Gui, Add, CheckBox, x15 y60 w110 h20 , Enable Sounds
Gui, Add, CheckBox, x15 y80 w110 h20 , Use Big Words
Gui, Add, Button, x230 y13 w20 h20 , >>
Gui, Add, Button, x14 y100 w80 h25 , View Config
Gui, Add, Text, x5 y345 w250 h20 +Center, credits
; Generated using SmartGUI Creator 4.0
Gui, Show, x756 y256 h360 w260, Settings
Return

GuiClose:
ExitApp


