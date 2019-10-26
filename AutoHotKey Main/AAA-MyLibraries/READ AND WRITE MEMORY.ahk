WriteMemory(WVALUE,MADDRESS,PROGRAM)
ReadMemory(MADDRESS,PROGRAM)



{
winget, pid, PID, %PROGRAM%

VarSetCapacity(MVALUE,4,0)
ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)

Loop 4
result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

return, result  
}
{
winget, pid, PID, %PROGRAM%

ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "Uint*", WVALUE, "Uint", 4, "Uint *", 0)

DllCall("CloseHandle", "int", ProcessHandle)
return
}