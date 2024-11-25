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
function Rename-ItemBulk
{
  [CmdletBinding()]
  Param(
      [string]$Path,
      [parameter(mandatory=$true)][string]$OldMatchPattern,
      [parameter(mandatory=$true)][string]$ReplacedString,
      [switch]$UseRegex,
      [switch]$File,
      [switch]$Directory
  )

  begin
  {
    if ([string]::IsNullOrWhiteSpace($Path)) {
      $Path = Get-Location
    }
  }

  process
  {
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

  end
  {

  }
}

