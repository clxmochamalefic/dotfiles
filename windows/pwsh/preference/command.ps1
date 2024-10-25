function Set-EnvironmentFromPath($path)
{
  $CONF_FILE_PATH=$path #設定ファイルのパス
  $PARAM=@{}
  Get-Content $CONF_FILE_PATH | %{$PARAM += ConvertFrom-StringData $_}

  foreach($key in $PARAM.Keys)
  {
    $value = $PARAM[$key]
    $value = $value.Trim('"')
    if (Test-Path -Path "env:${key}") {
      Remove-Item -Path "env:${key}"
    }
    New-Item -Path "env:${key}" -Value $value
  }
}
