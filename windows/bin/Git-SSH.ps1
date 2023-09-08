param (
  [string]$Identifier,
  [switch]$Push,
  [switch]$Pull,
  [switch]$Fetch,
  [string]$Arg,
  [string]$Remote,
  [string]$Branch
  <#
    .SYNOPSIS
    git -c core.sshCommand="ssh -i <private_identity_file> -F /dev/null" <push|pull|fetch> 

    .DESCRIPTION
    git push/pull/fetch with arbitarary private_identity_file

    .PARAMETER Identifier
    [string]: 

    .PARAMETER Push
    [switch]: git push

    .PARAMETER Pull
    [switch]: git pull

    .PARAMETER git fetch
    [switch]: 

    .PARAMETER Extension
    Specifies the extension. "Txt" is the default.

    .INPUTS
    None. You cannot pipe objects to Add-Extension.

    .OUTPUTS
    System.String. Add-Extension returns a string with the extension or file name.

    .EXAMPLE
    PS> extension -name "File"
    File.txt

    .EXAMPLE
    PS> extension -name "File" -extension "doc"
    File.doc

    .EXAMPLE
    PS> extension "File" "doc"
    File.doc

    .LINK
    Online version: http://www.fabrikam.com/extension.html

    .LINK
    Set-Item
  #>
)
