# C / Home
Function GotoHome {Set-Location "C:\"}
Set-Alias -Name cd-c -Value GotoHome
# Dev
Function GotoDev {Set-Location "C:\Dev"}
Set-Alias -Name cd-dev -Value GotoDev
# C-Cpp
Function GotoCpp {Set-Location "C:\Dev\C-Cpp"}
Set-Alias -Name cd-cpp -Value GotoCpp
# Dotfiles
Function GotoDot {Set-Location "C:\Dev\dotfiles"}
Set-Alias -Name cd-dot -Value GotoDot

# Linux-like ls (from git)
del alias:ls -Force
Function ExecGitLs { & "C:\Program Files\Git\usr\bin\ls.exe" --color=auto -hF $args }
Set-Alias -Name ls -Value ExecGitLs

# Lazygit
Function RunLazygit { & "C:\CLI Programs\lazygit.exe" }
Set-Alias -Name lg -Value RunLazygit