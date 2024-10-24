<#
 # Rename-ItemBulk
 #
 # @param [string] $Path - default: Get-Location
 # @param [string] $OldMatchPattern - matchpattern (mandantory)
 # @param [string] $ReplacedString - replaced string (mandantory)
 # @param [switch] $UseRegex - use regex for string matching
 # @param [switch] $File - target file only
 # @param [switch] $Directory - target dir only
#>
function Rename-ItemBulk(
    [string]$Path,
    [parameter(mandatory=$true)][string]$OldMatchPattern,
    [parameter(mandatory=$true)][string]$ReplacedString,
    [switch]$UseRegex,
    [switch]$File,
    [switch]$Directory
    )
{

  if ([string]::IsNullOrWhiteSpace($Path)) {
    $Path = Get-Location
  }

  $foreachClojure = {
    $replacedName = ''

      if ($UseRegex) {
        $regex = [System.Text.RegularExpressions.Regex]::new($OldMatchPattern)
          $replacedName = $regex.Replace($_.Name, $ReplacedString)
      } else {
        $replacedName = $_.Name.Replace($OldMatchPattern, $ReplacedString)
      }

    Rename-Item $_.Name $replacedName
  }

  $whereObjectClojure = { $true }
  if ($File -eq $true && $Directory -eq $false) {
    $whereObjectClojure = { -not $_.PSIsContainer }
  } elseif ($File -eq $false && $Directory -eq $true) {
    $whereObjectClojure = { $_.PSIsContainer }
  }

  Get-ChildItem | Where-Object $whereObjectClojure | ForEach-Object  $foreachClojure
}

<#
 # Set-EnvironmentFromPath
 # set envrionment variables from ini file
 #
 # @param [string] $path - path to the file
#>
function Set-EnvironmentFromPath($path)
{
  if ($path -eq $null -or $path -eq '') {
    Write-Output "Usage: Set-EnvironmentFromPath <path>"
    return
  }

  $PARAM=@{}
  Get-Content $path | %{$PARAM += ConvertFrom-StringData $_}

  foreach($key in $PARAM.Keys)
  {
    $value = $PARAM[$key]
    New-Item -Path "env:${key}" -Value $value
  }
}
