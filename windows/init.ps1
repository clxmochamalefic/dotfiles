#!/usr/bin/env pwsh

Write-Output ""
Write-Output "initialize winget plugins"

Write-Output ""
Write-Output 'copy profile'

# copy pwsh preference
Write-Output ""
Write-Output 'pwsh profile'
$profilePath = "$Home\Documents\PowerShell\"
if ([System.IO.Directory]::Exists($profilePath) -eq $false) {
  Write-Output '    make profile path'
  New-Item -Path $profilePath -ItemType Directory
}
Get-Content "${PSScriptRoot}\preferences\common_profile.ps1" > "${profilePath}Microsoft.PowerShell_profile.ps1"

# ~/.wslconfig
Write-Output ""
Write-Output '.wslconfig'
$wslconfigPath = "$Home\.wslconfig"
if ([System.IO.Directory]::Exists($wslconfigPath) -eq $true) {
  Write-Output '    rename current old config to .old'
  Move-Item $wslconfigPath "$wslconfigPath.old"
}
Get-Content "${PSScriptRoot}\preferences\.wslconfig" > $wslconfigPath

# install posh-git (show git branch on prompt)
Write-Output ""
Write-Output 'install module'
Write-Output 'posh-git'
Install-Module posh-git

# reload profile
Write-Output ""
Write-Output 'reload profile'
. $PROFILE

Write-Output ""
Write-Output 'script finished'
