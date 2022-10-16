echo "make dir: ~/.config/nvim"

if (!(Test-Path '~/.config')) {
    mkdir ~/.config
}

if (!(Test-Path '~/.config/nvim')) {
    mkdir ~/.config/nvim
}

echo "make dir: ~/AppData/Local/nvim"

if (!(Test-Path '~/AppData/Local/nvim')) {
    mkdir ~/.config
}

echo "remove nvim preference files what already exists"

if (Test-Path '~/.config/nvim/init.vim') {
    rm ~/.config/nvim/init.vim
}
if (Test-Path '~/.config/nvim/ginit.vim') {
    rm ~/.config/nvim/ginit.vim
}

if (Test-Path '~/AppData/Local/nvim/init.vim') {
    rm ~/AppData/Local/nvim/init.vim
}

if (Test-Path '~/AppData/Local/nvim/ginit.vim') {
    rm ~/AppData/Local/nvim/ginit.vim
}

echo "write reference preference"

$preferencePath = (Join-Path $PSScriptRoot .. | Resolve-Path)
$preferencePathStr = $preferencePath.ToString()

$preferencePathStr = $preferencePathStr.Replace($HOME, '$HOME')
$preferencePathStr = $preferencePathStr.Replace('\', '/' )

echo $preferencePathStr


Set-Content -Path ~/.config/nvim/init.vim  -Value "source ${preferencePathStr}/init.vim"  -Encoding UTF8
Set-Content -Path ~/.config/nvim/ginit.vim -Value "source ${preferencePathStr}/ginit.vim" -Encoding UTF8

Set-Content -Path ~/AppData/Local/nvim/init.vim  -Value "source ${preferencePathStr}/init.vim"  -Encoding UTF8
Set-Content -Path ~/AppData/Local/nvim/ginit.vim -Value "source ${preferencePathStr}/ginit.vim" -Encoding UTF8

echo "finished and all correct"

