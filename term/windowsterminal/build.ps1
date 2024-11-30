$src_path = "${PSScriptRoot}\src"

function Get-Json($path)
{
  return Get-Content -Raw $path | ConvertFrom-Json
}

$base = Get-Json("${src_path}\base.json")
$action = Get-Json("${src_path}\actions.json")
$font = Get-Json("${src_path}\font.json")

$body = $base.PSObject.Copy()

$body.actions = $action

if (!(Test-Path $PSScriptRoot\dist))
{
  New-Item -ItemType Directory -Path $PSScriptRoot\dist
}

ConvertTo-Json $body | Out-File $PSScriptRoot\dist\settings.json
