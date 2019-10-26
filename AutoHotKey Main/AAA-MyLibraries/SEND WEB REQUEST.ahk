






WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WebRequest.Open("POST", "https://discordapp.com/api/webhooks/607851235965665280/kPeScunJWsMipUrI86fRwfqpgXSccDKo8Uy6P9-mt5ivaOXr8jRAE_fn08ADMfMDzRQe")
WebRequest.SetRequestHeader("Content-Type","application/x-www-form-urlencoded")

WebRequest.Send("content=Content&username=Username")