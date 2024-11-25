<#
 # Get-GitRepositoryByIdentity
 # `git clone` with choice of any identity-file
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Get-ProfilePathMap()
{
  $profileDir = "${env:USERPROFILE}\.config"
  $profileFileName = ".gituserprofile"
  return @{
    profileDir = $profileDir
    profileFileName = $profileFileName
    profilePath = "${profileDir}\${profileFileName}"
  }
}

<#
 # Get-GitRepositoryByIdentity
 # `git clone` with choice of any identity-file
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Get-GitRepositoryByIdentity
{
  [CmdletBinding(SupportsShouldProcess=$True)]
  Param(
    $secretKeyPath,
    $url
  )
  begin
  {
    if (!$PSCmdlet.ShouldProcess($secretKeyPath) -or !$PSCmdlet.ShouldProcess($url))
    {
      Write-Output "### git clone with identity file alias ###"
      Write-Output "Usage: Get-GitRepositoryByIdentity -secretKeyPath <path> -url <git clone url>"
      Exit
    }
  }
  process
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

  end
  {

  }
}

<#
 # Add-GitProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
 #>

function Add-GitProfile
{
  [CmdletBinding(SupportsShouldProcess=$True)]
  Param($userProfileName, $name, $email)
  begin
  {
    if (!$PSCmdlet.ShouldProcess($userProfileName) -or !$PSCmdlet.ShouldProcess($name) -or !$PSCmdlet.ShouldProcess($email))
    {
      Write-Output "### add profile for git clone user profile ###"
      Write-Output "Usage: Add-GitProfile -userProfileName <user profile name> -name <git user name> -email <git user email>"
      Exit
    }
  }

  process
  {
    $profilePathMap = Get-ProfilePathMap
    $profilePath = $profilePathMap['profilePath']

    if (!(Test-Path $profilePathMap.profileDir))
    {
      New-Item -Path $profilePathMap.profileDir -ItemType Directory
    }
    if (!(Test-Path $profilePath))
    {
      New-Item -Path $profilePath -ItemType File
    }

    Import-Module PsIni
    $ini = Get-IniContent $profilePath
    $keys = $ini.psbase.Keys
    if (!($keys -contains 'userProfileName'))
    {
      Write-Error "userProfileName: ${userProfileName} is already exists"
      return
    }

    Set-IniContent -FilePath $profilePath -Sections $userProfileName -NameValuePairs @{
      'name' = $name
      ; 'email' = $email
    } | Out-IniFile $profilePath -Force
  }
  end
  {

  }
}

<#
 # Add-GitProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $secretKeyPath - path to the identity-file
 # @param [string] $url - git clone url
#>
function Show-GitProfile
{
  [CmdletBinding()]
  Param()
  begin
  {
  }
  process
  {
    $profilePathMap = Get-ProfilePathMap
    $profilePath = $profilePathMap['profilePath']
    $notfoundFileErrorMessage = "${profilePath} is not exists"

    if (!(Test-Path $profilePathMap.profileDir))
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
  end
  {
  }

}

<#
 # Add-GitProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $userProfileName - remove target userProfile-name (user profile name)
#>
function Remove-GitProfile
{
  [CmdletBinding(SupportsShouldProcess=$True)]
  Param ($userProfileName)
  begin
  {
    if (!$PSCmdlet.ShouldProcess($userProfileName))
    {
      Write-Output "### git user profile control:remove ###"
      Write-Output "Usage: Remove-GitProfile -userProfile <user profile name>"
      Exit
    }
  }

  process
  {
    $profilePathMap = Get-ProfilePathMap

    $profilePath = $profilePathMap['profilePath']
    $notfoundFileErrorMessage = "${profilePath} is not exists"
    $notfoundUserProfileErrorMessage = "userProfileName: ${userProfileName} is not exists"

    if (!(Test-Path $profilePathMap.profileDir))
    {
      Write-Error $notfoundFileErrorMessage
    }
    if (!(Test-Path profilePath))
    {
      Write-Error $notfoundFileErrorMessage
    }

    Import-Module PsIni
    $ini = Get-IniContent profilePath
    $keys = $ini.psbase.Keys

    if (!($keys -contains 'userProfileName'))
    {
      Write-Error $notfoundUserProfileErrorMessage
      return
    }

    Remove-IniEntry -FilePath $profilePath -Sections $userProfileName | Out-IniFile $profilePath -Force
  }

  end
  {
  }
}

<#
 # Set-GitLocalUserProfile
 # `git config --local user.(name|email)` with choice your profile
 #
 # @param [string] $userProfileName - user profile
#>
function Set-GitLocalUserProfile
{
  [CmdletBinding(SupportsShouldProcess=$True)]
  Param($userProfileName)
  begin
  {
    if (!$PSCmdlet.ShouldProcess($userProfileName))
    {
      Write-Output "### set user profile of git LOCAL repository from local user profile dictionary ###"
      Write-Output "Usage: Set-LocalUserProfile -userProfile <user profile name>"
      Exit
    }
  }
  process
  {
    $notfoundKeyErrorMessage = "user profile: ${userProfileName} is not exists"
    Import-Module PsIni

    $profilePathMap = Get-ProfilePathMap
    $profilePath = $profilePathMap['profilePath']

    $ini = Get-IniContent $profilePath
    $keys = $ini.psbase.Keys

    if (!($keys -contains $userProfileName))
    {
      Write-Error $notfoundKeyErrorMessage
      return
    }

    $value = $ini[$userProfileName]
    git config --local user.name $value['name']
    git config --local user.email $value['email']
  }

  end
  {
  }
}
