Write-Output "make dir: ~/.config/nvim"

if (!(Test-Path '~/.config')) {
    mkdir ~/.config
}

if (!(Test-Path '~/.config/nvim')) {
    mkdir ~/.config/nvim
}

Write-Output "make dir: ~/AppData/Local/nvim"

if (!(Test-Path '~/AppData/Local/nvim')) {
    mkdir ~/.config
}

Write-Output "remove nvim preference files what already exists"

if (Test-Path '~/.config/nvim/init.vim') {
    Remove-Item ~/.config/nvim/init.vim
}
if (Test-Path '~/.config/nvim/ginit.vim') {
    Remove-Item ~/.config/nvim/ginit.vim
}

if (Test-Path '~/AppData/Local/nvim/init.vim') {
    Remove-Item ~/AppData/Local/nvim/init.vim
}

if (Test-Path '~/AppData/Local/nvim/ginit.vim') {
    Remove-Item ~/AppData/Local/nvim/ginit.vim
}

Write-Output "write reference preference"

$preferencePathStr = $PSScriptRoot.ToString()

$preferencePathStr = $preferencePathStr.Replace($HOME, '$HOME')
$preferencePathStr = $preferencePathStr.Replace('\', '/' )

Write-Output $preferencePathStr


Set-Content -Path ~/.config/nvim/init.vim  -Value "set runtimepath+=${preferencePathStr}"  -Encoding UTF8
Add-Content -Path ~/.config/nvim/init.vim  -Value "let g:preference_path = expand('${preferencePathStr}')"  -Encoding UTF8
Add-Content -Path ~/.config/nvim/init.vim  -Value "source ${preferencePathStr}/init.vim"  -Encoding UTF8
Set-Content -Path ~/.config/nvim/ginit.vim -Value "source ${preferencePathStr}/ginit.vim" -Encoding UTF8

Set-Content -Path ~/AppData/Local/nvim/init.vim  -Value "set runtimepath+=${preferencePathStr}"  -Encoding UTF8
Add-Content -Path ~/AppData/Local/nvim/init.vim  -Value "let g:preference_path = expand('${preferencePathStr}')"  -Encoding UTF8
Add-Content -Path ~/AppData/Local/nvim/init.vim  -Value "source ${preferencePathStr}/init.vim"  -Encoding UTF8
Set-Content -Path ~/AppData/Local/nvim/ginit.vim -Value "source ${preferencePathStr}/ginit.vim" -Encoding UTF8

Write-Output "finished and all correct"
