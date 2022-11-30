Param(
    [string]$Path,
    [parameter(mandatory=$true)][string]$OldMatchPattern,
    [parameter(mandatory=$true)][string]$ReplacedString,
    [switch]$UsePreg,
    [switch]$File,
    [switch]$Directory
)

if ([string]::IsNullOrWhiteSpace($Path)) {
    $Path = Get-Location
}

$foreachClojure = {
    $replacedName = ''

    if ($UsePreg) {
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

