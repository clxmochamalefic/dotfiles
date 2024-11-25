# README - command

# how to create a command ?

https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.4

```powershell
function Test-ScriptCmdlet
{
[CmdletBinding(SupportsShouldProcess=$True)]
    Param ($Parameter1)
    begin{}
    process{}
    end{}
}
```

# how to create module ?

https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/new-modulemanifest?view=powershell-7.4#3

```powershell
$moduleSettings = @{
  RequiredModules = ("BitsTransfer", @{
    ModuleName="PSScheduledJob"
    ModuleVersion="1.0.0.0";
    GUID="50cdb55f-5ab7-489f-9e94-4ec21ff51e59"
  })
  Path = 'C:\ps-test\ManifestTest.psd1'
}
New-ModuleManifest @moduleSettings
```

