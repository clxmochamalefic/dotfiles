$profilePath = "$Home\Documents\PowerShell\"
if ([System.IO.Directory]::Exists($profilePath) -eq $false) {
  New-Item -Path "$Home\Documents\PowerShell\" -ItemType Directory
}
Get-Content "${PSScriptRoot}\common_profile.ps1" > $Home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

.$profile
