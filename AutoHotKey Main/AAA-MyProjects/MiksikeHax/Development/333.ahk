#NoTrayIcon
!F1:: msgbox 0, MiksikeHax - Made By Wuff,F4 - Terminate App & Self Destruct`nF3 - Clear Tooltip`nF2 - Do The Magic :)`nAlt + F1 - Bring Up Help`n `nMiksikeHax V1.1 Updated on: 12/13/2018`nMade By: Wuff (Winni Puhh) or (rum)
RButton:: ToolTip ; Off2
F3:: ToolTip ; Off
F4::exitapp
return
;-------------------------------------------------------------------------------
F2:: ; hotkey
^RButton:: ;  2nd hotkey
;-------------------------------------------------------------------------------
    Term := get_Highlight()             ; get the text MADE?BY?WUFF
    
    ;StringReplace, Tnew, Tnew, %A_Space%, +, All
    ;Tnew := StrReplace(Tnew, A_Space, &, All)
    Tnew := StrReplace(Term, "x", "*")  ; replace multiplication
    Tnew := StrReplace(Tnew, ":", "/")  ; replace division
    Tnew := StrReplace(Tnew, ",", ".")  ; replace decimal delimiter
    ;Tnew := StrReplace(Tnew, " ", "=")  ; remove equals

    
    ToolTip, % Term " = " Eval(Tnew)

Return



;-------------------------------------------------------------------------------
get_Highlight() { ; get highlighted text
;-------------------------------------------------------------------------------
    _AutoTrim := A_AutoTrim             ; remember current setting
    AutoTrim, Off                       ; keep leading/trailing white spaces
    ClipStore := ClipboardAll           ; remember current content

    Send, ^c                            ; copy highlighted text
    ClipWait, 1                         ; wait for change
    Result := Clipboard                 ; store highlighted text

    Clipboard := ClipStore              ; restore previous content
    AutoTrim, %_AutoTrim%               ; restore previous setting
    Return, Result
}



;-------------------------------------------------------------------------------
Eval(Exp) { ; use Javascript/COM, by TLM and tidbit
;-------------------------------------------------------------------------------
    static Constants := "E|LN2|LN10|LOG2E|LOG10E|PI|SQRT1_2|SQRT2"
    static Functions := "abs|acos|asin|atan|atan2|ceil|cos|exp|floor"
                     .  "|log|max|min|pow|random|round|sin|sqrt|tan"

    Transform, Exp, Deref, %Exp% ; support variables

    Exp := Format("{:L}", Exp) ; everything lowercase
    Exp := RegExReplace(Exp, "i)(" Constants ")", "$U1") ; constants uppercase
    Exp := RegExReplace(Exp, "i)(" Constants "|" Functions ")", "Math.$1")
    Exp := StrReplace(Exp, "Math.ceil", "Math.ceil")
    Exp := StrReplace(Exp, "Math.exp", "Math.exp")

    Obj := ComObjCreate("HTMLfile")
    Obj.Write("<body><script>document.body.innerText=eval('" Exp "');</script>")
    Return, InStr(Result := Obj.body.innerText, "body") ? "ERROR" : Result
}