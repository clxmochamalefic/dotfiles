#!/bin/bash

# arg check
PARENT_DIR=$(cd $(dirname $0); cd ..;pwd)

if [$# -lt 1]; then
    echo "Usage init.sh <repositoriesDirectory>"
    exit 1
fi

# vim setup
mkdir -p ~/apps/vim/backupfiles
mkdir -p ~/apps/vim/undofiles

rm ~/apps/vim/vimrc
rm ~/apps/vim/gvimrc

cp ${PARENT_DIR}/vim/.*vimrc ~/apps/vim/
cp ${PARENT_DIR}/vim/.*vimrc ~/

# make repositories dirctory

# clone neobundle
# TODO: Replace Dein.vim
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# NeoBundleInstall from cli
# thx for https://thinca.hatenablog.com/entry/20120830/1346264830
# TODO: NEED TEST!!
vim -N -u NONE -i NONE -V1 -e -s --cmd NeoBundleInstall! --cmd qall!

# cp vim-lucius
cp -r ~/.vim/bundle/vim-lucius/ ~/.vim/
cp -r ~/.vim/bundle/vim-lucius/ ~/apps/vim/vim81/colors/
