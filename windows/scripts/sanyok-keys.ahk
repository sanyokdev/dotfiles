#SingleInstance, Force

; --- Close active window
#IfWinNotActive,Program Manager
#q::
    Keywait,q
    WinGetTitle,curTitle,A
    if (curTitle != "Program Manager")
        Send !{F4}
return

; --- Minimize active window
#IfWinNotActive,Program Manager
#+f::
    Keywait,f
    WinGetTitle,curTitle,A
    if (curTitle != "Program Manager")
        WinMinimize, A
return

; --- Toggle minimize/maximize for active window
#f::
    WinGet,curState,MinMax,A
    if (curState = 1)
        WinRestore, A ; Restore the window
    else
        WinMaximize, A ; Otherwise, maximize the window
return

; --- Open windows terminal
#Enter::
    Run, "C:\Program Files\WezTerm\wezterm-gui.exe" start --cwd "C:\Dev"

    WinWait, ahk_exe wezterm-gui.exe, , 5 ; Wait for 5 seconds for the window to appear
    if !ErrorLevel
    {
        WinActivate ; Activate the window
    }
return