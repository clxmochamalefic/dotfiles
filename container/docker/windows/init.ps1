#!/usr/bin/env pwsh

Param(
  [Boolean]$OnlyCreateService = $false
)

Write-Output "install docker-cli and docker-compose"
if ($OnlyCreateService)
{
  Write-Output "skip installation"
} else
{
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
  Enable-WindowsOptionalFeature -Online -FeatureName Containers -All

  winget install Docker.DockerCLI Docker.DockerCompose --silent
}

Write-Output "create docker service (Docker)"

$dist_path = "${env:ProgramFiles}\docker\daemon.json"

Copy-Item -Path "${PSScriptRoot}\daemon.json" -Destination $dist_poath -Force

$docker_path = (Get-Command dockerd | Select-Object -ExpandProperty Source)
New-Service -Name Docker -BinaryPathName $docker_path --run-service --config-file $dist_path -DisplayName "Docker Engine" -StartupType "Automatic"

Start-Service Docker
