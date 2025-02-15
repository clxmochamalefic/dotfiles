#!/usr/bin/env pwsh

# TODO: DRYRUNに対応させたい

# 変数定義 (警告文書に出すために一度ここに全部定義しておく)
#   現在時刻 (yyyyMMddHHmmss)
$now = Get-Date -Format "yyyyMMddHHmmss"
#   pwshのプロファイルのディレクトリパス
$profilePath = "$Home\Documents\PowerShell"
#   スタートアップのディレクトリパス
$startupPath = "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
#   reposのパス
$repositoryPath = "${HOME}\repos"
#   dotfilesのディレクトリパス
$dotfilesPath = "${repositoryPath}\dotfiles"
if ([System.IO.Directory]::Exists($dotfilesPath) -eq $false)
{
  # 上述のパスに存在しない場合は普段使っているほかのやつを使う
  $dotfilesPath = "${repositoryPath}\cocoalix\dotfiles"
}

$windowsPreferencePath = "${dotfilesPath}\windows"

#  pwshの設定のディレクトリパス
$pwshPreferencePath = "${windowsPreferencePath}\pwsh\preference"
#   pwshのプロファイルのファイルパス
$pwshDefaultProfileFilePath = $Profile
#   wslの設定のファイルパス
$wslconfigPath = "$Home\.wslconfig"
#   wslの設定のバックアップファイルパス
$wslconfigOldPath = "$Home\.wslconfig.${now}.old"
#   wsl g の設定のファイルパス
$wslgconfigPath = "$Home\.wslgconfig"
#   wsl g の設定のバックアップファイルパス
$wslgconfigOldPath = "$Home\.wslgconfig.${now}.old"


$currentEnvStartup = [Environment]::GetEnvironmentVariable('Startup', 'USER')
$currentEnvDotfiles = [Environment]::GetEnvironmentVariable('DOTFILES', 'USER')
$currentEnvPwshconf = [Environment]::GetEnvironmentVariable('PWSHCONF', 'USER')

Write-Output ""
Write-Output "### initialize windows environment preference ###"
Write-Output ""

Write-Output "----------"
Write-Output ""
Write-Output "                            CAUTION / 警告"
Write-Output "                         --------------------"
Write-Output "                  THIS SCRIPT HAS ANY BROKABLE ACTION"
Write-Output "                  このスクリプトは破壊的変更を含みます"
Write-Output ""
Write-Output "  1. your current ALL profile is move to backup, but current is overwrite"
Write-Output "     現在の全てのプロファイルはバックアップされますが"
Write-Output "     その後現在のファイルはすべて上書きされます"
Write-Output "     1. pwsh default profile"
Write-Output "     2. wslconfigs (~/.wslconfig, ~/.wslgconfig)"
Write-Output ""
Write-Output "  2. your current below ENV-VARs are overwrite, there is not backup"
Write-Output "     下記のいくつかの環境変数の内容が上書きされます"
Write-Output "     それらはバックアップされません"
Write-Output "     1. Startup"
Write-Output "        before: ${currentEnvStartup}"
Write-Output "         after: ${startupPath}"
Write-Output "     2. DOTFILES"
Write-Output "        before: ${currentEnvDotfiles}"
Write-Output "         after: ${dotfilesPath}"
Write-Output "     3. PWSHCONF"
Write-Output "        before: ${currentEnvPwshconf}"
Write-Output "         after: ${pwshPreferencePath}"
Write-Output ""
Write-Output "----------"

$key = Read-Host "COULD YOU CONTINUE? [y/N]"
if ($key -ne "y")
{
  Write-Output "  ABORTED"
  exit
}

Write-Output ""
Write-Output "I will start the following actions."

Write-Output ""
Write-Output 'COPY profiles'

# copy pwsh preference
Write-Output ""
Write-Output '  MAKE LINK pwsh profile'
if ([System.IO.Directory]::Exists($profilePath) -eq $false)
{
  Write-Output '    MAKE profile path'
  New-Item -Path $profilePath -ItemType Directory
}
#Get-Content "${PSScriptRoot}\preference\common_profile.ps1" > "${profilePath}Microsoft.PowerShell_profile.ps1"

# pwshのデフォルトプロファイルがすでに存在する場合はバックアップを作成する
if ([System.IO.Directory]::Exists($pwshDefaultProfileFilePath) -eq $true)
{
  Write-Output "    CREATE backup"
  Write-Output "      RENAME Microsoft.PowerShell_profile.ps1 => Microsoft.PowerShell_profile.ps1.${now}.old"
  Copy-Item $pwshDefaultProfileFilePath "${pwshDefaultProfileFilePath}.${now}.old"
}
if ([System.IO.Directory]::Exists($pwshPreferencePath) -eq $true)
{
  Write-Output "    WRITE preference to: ${pwshPreferencePath}"
  # このリポジトリに存在するcommon_profile.ps1を参照する記述に置き換える
  Write-Output ". ${pwshPreferencePath}\common_profile.ps1" > "${pwshDefaultProfileFilePath}"
} else
{
  Write-Output "    preference path not found: ${pwshPreferencePath}"
}

# ~/.wslconfig
Write-Output ""
Write-Output '  COPY .wslconfig'

Write-Output "    RENAME .wslconfig => .wslconfig.${now}.old"
if ([System.IO.Directory]::Exists($wslconfigPath) -eq $true)
{
  Write-Output '    RENAME current old config to .old'
  Copy-Item $wslconfigPath $wslconfigOldPath
}
Get-Content "${windowsPreferencePath}\.wslconfig" > $wslconfigPath

Write-Output "    RENAME .wslgconfig => .wslgconfig.${now}.old"
if ([System.IO.Directory]::Exists($wslgconfigPath) -eq $true)
{
  Write-Output '    RENAME current old config to .old'
  Copy-Item $wslgconfigPath $wslgconfigOldPath
}
Get-Content "${windowsPreferencePath}\.wslgconfig" > $wslgconfigPath

# add environment variable
Write-Output ""
Write-Output 'ADD environment variable'
# start-up
[Environment]::SetEnvironmentVariable('Startup', $startupPath, 'USER')
[Environment]::SetEnvironmentVariable('DOTFILES', $dotfilesPath, 'USER')
[Environment]::SetEnvironmentVariable('PWSHCONF', $pwshPreferencePath, 'USER')

# install posh-git (show git branch on prompt)
Write-Output ""
Write-Output 'INSTALL module'

Write-Output '  posh-git'
Install-Module posh-git

Write-Output '  PsIni'
Install-Module PsIni

# reload profile
Write-Output ""
Write-Output 'RELOAD profile'
. $PROFILE


Write-Output ""
Write-Output '### SCRIPT FINISHED ###'
