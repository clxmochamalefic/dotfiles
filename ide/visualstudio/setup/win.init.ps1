Write-Output "make preference: ~/_vsvimrc"

$filename = "_vsvimrc"
$path = $(Join-Path "~" $filename)


if (Test-Path $path)
{
  Remove-Item $path
}


$currentDirName = [System.IO.Path]::GetDirectoryName($PSScriptRoot.ToString())
#$preferenceDirPathStr = [System.IO.Directory]::GetParent($currentDirName).ToString()
$preferenceDirPathStr = $currentDirName

$preferenceDirPathStr = $preferenceDirPathStr.Replace('\', '/' )
$preferencePathStr = $(Join-Path $preferenceDirPathStr ".vimrc")

Write-Output "write reference to ${path}"
Write-Output "source path: ${preferencePathStr}"

$absolutePath = [System.IO.Path]::GetFullPath($preferencePathStr)
#Set-Content -Path $path  -Value "runtime! ${absolutePath}" -Encoding UTF8
Copy-Item -Path $absolutePath -Destination $path

Write-Output "finished and all correct"

