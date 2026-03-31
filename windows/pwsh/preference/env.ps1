$currentDir = $PSScriptRoot

$env:PWSH_PREFERENCE_PATH=$currentDir
$dotfilePath        = $(Join-Path $currentDir '..' '..' '..')
$env:DOTFILE_PATH       = $(Resolve-Path $dotfilePath)

$yaziConfigHomePath     = $(Join-Path $env:DOTFILE_PATH 'common' 'yazi')
$env:YAZI_CONFIG_HOME   = $(Resolve-Path $yaziConfigHomePath)
