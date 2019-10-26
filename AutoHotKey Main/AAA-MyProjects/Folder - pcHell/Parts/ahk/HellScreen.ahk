URLDownloadToFile, https://i.imgur.com/yj867NQ.jpg, %Temp%\pc_screen.jpg
Gui, Add, Picture, x0 y65, %Temp%\pc_screen.jpg
Gui, -Caption 
TempVar := A_ScreenHeight +100
Gui,Show, h%TempVar% w%A_ScreenWidth% 
Sleep, 5000