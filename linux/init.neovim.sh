#!/bin/bash

mkdir ~/appimg
mkdir ~/.config

# install neovim

if [ ! "$NO_NEOVIM" ] ; then
    cd ~/appimg
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage

    cd ~/bin
    ln -s ~/appimg/nvim.appimage nvim

    # setup neovim preference

    cd ~/.config
    ln -s "${DOTFILES_PATH}/nvim/" nvim
fi
