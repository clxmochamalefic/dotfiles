$srcPath = "${PSScriptRoot}/command/src"

$list = Get-ChildItem $srcPath -Recurse -File -Filter "*.ps1"

foreach ($l in $list)
{
  $n = $l.Name
  . "${srcPath}/${n}"
}

