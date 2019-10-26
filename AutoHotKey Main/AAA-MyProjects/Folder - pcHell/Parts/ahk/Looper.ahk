
Loop, {
Random, y1, 75, 950
Random, x1, 75, 1850
Random, msg1
WinSetTitle, :), , %msg1%
WinMove, %msg1%, ,%x1%, %y1%
Random, y2, 75, 950
Random, x2, 75, 1850
Random, msg2
WinSetTitle, :(, , %msg2%
WinMove, %msg2%, ,%x2%, %y2%
Sleep, 100
}