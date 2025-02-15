Write-Output "make dir: ~/.config/nvim"

$startupPath = "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\boot_denops.vbs"

Set-Content -Path $startupPath  -Value 'Set ws = CreateObject("Wscript.Shell")' -Encoding UTF8
Add-Content -Path $startupPath  -Value "ws.run ""cmd /c $HOME\.config\nvim\boot_denops.bat"", vbhide" -Encoding UTF8

Write-Output "finished and all correct"

