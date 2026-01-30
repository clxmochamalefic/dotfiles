$location = Get-AppxPackage | where { $_.Name -eq "Microsoft.WindowsTerminal" } | Select -ExpandProperty InstallLocation
$env_name = "WINTERM_PATH"
$env_type = "User"

# 新しい環境変数を設定する
echo "update ${env_type} ENV: Name:${env_name} / Val:" + $location
[System.Environment]::SetEnvironmentVariable($env_name, $location, $env_type)
