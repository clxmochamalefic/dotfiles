<#
 # Set-EnvironmentFromIniFile
 # set envrionment variables from ini file
 #
 # @param [string] $path - path to the file
#>
function Set-EnvironmentFromIniFile
{
    [CmdletBinding()]
    Param ($path)
    begin
    {
      if ($path -eq $null -or $path -eq '') {
        Write-Output "Usage: Set-EnvironmentFromPath <path>"
        Exit -1;
      }

    }
    process
    {
      $PARAM=@{}
      Get-Content $path | %{$PARAM += ConvertFrom-StringData $_}

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
    end
    {

    }
}

