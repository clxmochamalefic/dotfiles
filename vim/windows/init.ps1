if (!(Test-Path '~/.config')) {
    mkdir ~/.config
}

if (!(Test-Path '~/.config/nvim')) {
    mkdir ~/.config/nvim
}

if (Test-Path '~/.config/nvim/init.vim') {
    rm ~/.config/nvim/init.vim
}
if (Test-Path '~/.config/nvim/ginit.vim') {
    rm ~/.config/nvim/ginit.vim
}

cp $PSScriptRoot/init.vim ~/.config/nvim/init.vim
cp $PSScriptRoot/ginit.vim ~/.config/nvim/ginit.vim
