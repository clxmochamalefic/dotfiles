# import completions
#   git
Import-Module posh-git
$pwshconfPath = [System.Environment]::GetEnvironmentVariable('PWSHCONF', 'USER')
oh-my-posh init pwsh --config "$env:PWSHCONF\mytheme.omp.yaml" | Invoke-Expression

#   TODO: これ本当に必要かチェック
#   volta completions
$profilePath = "${HOME}\Documents\PowerShell"
Get-ChildItem "${profilePath}\Completions" | ForEach-Object { . $_ }

#   commandline use feel modifing to the bash
Import-Module PSReadline
Set-PSReadLineOption -EditMode Emacs
# Remove-PSReadLineKeyHandler -Chord Ctrl+J Ctrl+H Ctrl+G
Remove-PSReadLineKeyHandler -Chord Ctrl+j 
Remove-PSReadLineKeyHandler -Chord Ctrl+h
Remove-PSReadLineKeyHandler -Chord Ctrl+g

$OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')

# load other preferences
#   command aliases
$myCommandAliases = "${pwshconfPath}\command_aliases.ps1"

. $myCommandAliases

$myCommand = "${pwshconfPath}\command.ps1"
. $myCommand
