$profileDir = "${env:USERPROFILE}\.config"
$profileFileName = ".gituserprofile"
$profilePath = "${profileDir}\${profileFileName}"

<#
 # Get-GitRepositoryByIdentity
 # `git clone` with choice of any identity-file
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Get-GitRepositoryByIdentity([mandantory]$secretKeyPath, [mandantory]$url)
{
  $cloneCommand = "git -c core.sshCommand='ssh -i ${secretKeyPath} -F /dev/null' clone ${url}"
  $localConfigCommand = "git config --local core.sshCommand 'ssh -i ${secretKeyPath} -F /dev/null'"

  # clone
  Write-Output "execute: $cloneCommand"
  Invoke-Expression $cloneCommand

  # config --local
  Write-Output "execute: $localConfigCommand"
  Invoke-Expression $localConfigCommand
}

<#
 # Add-GitProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Add-GitProfile([mandantory]$key, [mandantory]$name, [mandantory]$email)
{
  if (!(Test-Path $profileDir))
  {
    New-Item -Path $profileDir -ItemType Directory
  }
  if (!(Test-Path $profilePath))
  {
    New-Item -Path $profilePath -ItemType File
  }

  Import-Module PsIni
  $ini = Get-IniContent $profilePath
  if ($ini.ContainsKey($key))
  {
    Write-Error "key: ${key} is already exists"
    return
  }

  Set-IniContent -FilePath $profilePath -Sections $key -NameValuePairs @{
    'name' = $name
    ; 'email' = $email
  } | Out-IniFile $profilePath -Force
}

<#
 # Add-GitProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Show-GitProfile()
{
  $notfoundFileErrorMessage = "${profilePath} is not exists"

  if (!(Test-Path $profileDir))
  {
    Write-Error $notfoundFileErrorMessage
  }
  if (!(Test-Path $profilePath))
  {
    Write-Error $notfoundFileErrorMessage
  }

  Import-Module PsIni
  $ini = Get-IniContent $profilePath

  Write-Output $ini
}

<#
 # Add-GitProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Remove-GitProfile([mandantory]$key)
{
  $notfoundFileErrorMessage = "${profilePath} is not exists"
  $notfoundKeyErrorMessage = "key: ${key} is not exists"

  if (!(Test-Path $profileDir))
  {
    Write-Error $notfoundFileErrorMessage
  }
  if (!(Test-Path $profilePath))
  {
    Write-Error $notfoundFileErrorMessage
  }

  Import-Module PsIni
  $ini = Get-IniContent $profilePath

  if (!($ini.ContainsKey($key)))
  {
    Write-Error $notfoundKeyErrorMessage
    return
  }

  Remove-IniEntry -FilePath $profilePath -Sections $key | Out-IniFile $profilePath -Force
}

<#
 # Set-LocalUserProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Set-LocalUserProfile([mandantory]$key)
{
  Import-Module PsIni
  $ini = Get-IniContent $profilePath

  if (!($ini.ContainsKey($key)))
  {
    Write-Error $notfoundKeyErrorMessage
    return
  }

  $value = $ini[$key]
  git config --local user.name $value['name']
  git config --local user.email $value['email']
}
