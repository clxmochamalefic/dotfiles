function nq()
{
  nvim-qt ~ 
}
function ssho()
{
  ssh -o ServerAliveInterval=60 $args 
}
function which()
{
  Get-Command $args | Format-List 
}
function sh()
{
  pwsh $args 
}

# import completions
# git
Import-Module posh-git
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/paradox.omp.json | Invoke-Expression

# volta
Get-ChildItem "${PSScriptRoot}\Completions" | ForEach-Object { . $_ }

Import-Module PSReadline
Set-PSReadLineOption -EditMode Emacs


$OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')

[Environment]::SetEnvironmentVariable('Startup', "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup")

