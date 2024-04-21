# C / Home
Function GotoHome {Set-Location "C:\"}
Set-Alias -Name cd-c -Value GotoHome
# Dev
Function GotoDev {Set-Location "C:\Dev"}
Set-Alias -Name cd-dev -Value GotoDev
# Mana
Function GotoMana {Set-Location "C:\Dev\projects\c-cpp\libMana"}
Set-Alias -Name cd-mana -Value GotoMana
# Game
Function GotoGame {Set-Location "C:\Dev\projects\c-cpp\steam-game"}
Set-Alias -Name cd-game -Value GotoGame
# Nvim
Function GotoNvim {Set-Location "C:\Dev\dotfiles\.config\nvim"}
Set-Alias -Name cd-nvim -Value GotoNvim

# Linux-like ls (from git)
del alias:ls -Force
Function ExecGitLs { & "C:\Program Files\Git\usr\bin\ls.exe" --color=auto -hF $args }
Set-Alias -Name ls -Value ExecGitLs

# Run bash scripts
# Set-Alias sh "C:\Program Files\Git\bin\sh.exe"

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
