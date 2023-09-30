#!/usr/bin/env pwsh

# copy pwsh preference
$profilePath = "$Home\Documents\PowerShell\"
if ([System.IO.Directory]::Exists($profilePath) -eq $false) {
  New-Item -Path $profilePath -ItemType Directory
}
Get-Content "${PSScriptRoot}\preferences\common_profile.ps1" > "${profilePath}Microsoft.PowerShell_profile.ps1"

# ~/.wslconfig
$wslconfigPath = "$Home\.wslconfig"
if ([System.IO.Directory]::Exists($wslconfigPath) -eq $false) {
  New-Item -Path $profilePath -ItemType Directory
}
Get-Content "${PSScriptRoot}\preferences\common_profile.ps1" > "${profilePath}Microsoft.PowerShell_profile.ps1"

# install posh-git (show git branch on prompt)
Install-Module posh-git

# reload profile
. $PROFILE
