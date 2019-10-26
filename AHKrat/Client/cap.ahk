
TakeScreenshot(FileName)
; beaucoup thanks to tic (Tariq Porter) for his GDI+ Library
; https://autohotkey.com/boards/viewtopic.php?t=6517
; https://github.com/tariqporter/Gdip/raw/master/Gdip.ahk
{
  pToken:=Gdip_Startup()
  If (pToken=0)
  {
    MsgBox,4112,Fatal Error,Unable to start GDIP
    ExitApp
  }
  pBitmap:=Gdip_BitmapFromScreen()
  If (pBitmap<=0)
  {
    MsgBox,4112,Fatal Error,pBitmap=%pBitmap% trying to get bitmap from the screen
    ExitApp
  }
  Gdip_SaveBitmapToFile(pBitmap,FileName)
  If (ErrorLevel<>0)
  {
    MsgBox,4112,Fatal Error,ErrorLevel=%ErrorLevel% trying to save bitmap to`n%FileName%
    ExitApp
  }
  Return
}
; change the line below to wherever you have the downloaded GDIP source code
#Include Gdip.ahk