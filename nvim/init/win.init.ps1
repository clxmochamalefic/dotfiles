Write-Output "make dir: ~/.config/nvim"

if (!(Test-Path '~/.config')) {
    mkdir ~/.config
    Write-Output "success mkdir ~/.config"
}

if (!(Test-Path '~/.config/nvim')) {
    mkdir ~/.config/nvim
    Write-Output "success mkdir ~/.config"
}

Write-Output "make dir: ~/AppData/Local/nvim"

if (!(Test-Path '~/AppData/Local/nvim')) {
    mkdir ~/AppData/Local/nvim
    Write-Output "success mkdir ~/AppData/Local/nvim"
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

if (Test-Path '~/.config/nvim/init.lua') {
    Remove-Item ~/.config/nvim/init.lua
}
if (Test-Path '~/.config/nvim/ginit.lua') {
    Remove-Item ~/.config/nvim/ginit.lua
}

if (Test-Path '~/AppData/Local/nvim/init.lua') {
    Remove-Item ~/AppData/Local/nvim/init.lua
}

if (Test-Path '~/AppData/Local/nvim/ginit.lua') {
    Remove-Item ~/AppData/Local/nvim/ginit.lua
}

Write-Output "write reference preference"

$preferencePathStr = [System.IO.Path]::GetDirectoryName($PSScriptRoot.ToString())

$preferencePathStr = $preferencePathStr.Replace('\', '/' )
$luaPathStr = $preferencePathStr + "/lua"

Write-Output $preferencePathStr

Set-Content -Path ~/.config/nvim/init.lua  -Value "vim.opt.runtimepath:append(',${preferencePathStr}')"                 -Encoding UTF8
Add-Content -Path ~/.config/nvim/init.lua  -Value "vim.opt.runtimepath:append(',${luaPathStr}')"                        -Encoding UTF8
Add-Content -Path ~/.config/nvim/init.lua  -Value "vim.g.preference_path = vim.fn.expand('${preferencePathStr}')"       -Encoding UTF8
Add-Content -Path ~/.config/nvim/init.lua  -Value "vim.cmd([[luafile ${preferencePathStr}/init.lua]])"                  -Encoding UTF8
Set-Content -Path ~/.config/nvim/ginit.lua -Value "vim.cmd([[luafile ${preferencePathStr}/ginit.lua]])"                 -Encoding UTF8

Set-Content -Path ~/AppData/Local/nvim/init.lua  -Value "vim.opt.runtimepath:append(',${preferencePathStr}')"           -Encoding UTF8
Add-Content -Path ~/AppData/Local/nvim/init.lua  -Value "vim.opt.runtimepath:append(',${luaPathStr}')"                  -Encoding UTF8
Add-Content -Path ~/AppData/Local/nvim/init.lua  -Value "vim.g.preference_path = vim.fn.expand('${preferencePathStr}')" -Encoding UTF8
Add-Content -Path ~/AppData/Local/nvim/init.lua  -Value "vim.cmd([[luafile ${preferencePathStr}/init.lua]])"            -Encoding UTF8
Set-Content -Path ~/AppData/Local/nvim/ginit.lua -Value "vim.cmd([[luafile ${preferencePathStr}/ginit.lua]])"           -Encoding UTF8

[System.Environment]::SetEnvironmentVariable("LUA_PATH",        $luaPathStr, "User")
[System.Environment]::SetEnvironmentVariable("LUA_EXE_PATH",    $luaPathStr, "User")

Write-Output "install depends:"
Write-Output ""

Write-Output 'python: neovim plugin'
pip install neovim


Write-Output "node: neovim"
volta install node
npm install -g neovim

Write-Output "finished and all correct"

