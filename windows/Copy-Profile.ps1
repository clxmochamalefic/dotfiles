$profilePath = "$Home\Documents\PowerShell\"
if ([System.IO.Directory]::Exists($profilePath) -eq $false) {
  New-Item -Path $profilePath -ItemType Directory
}
Get-Content "${PSScriptRoot}\common_profile.ps1" > "${profilePath}Microsoft.PowerShell_profile.ps1"

. $PROFILE
