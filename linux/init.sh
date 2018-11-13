#!/bin/bash
# make repositories dirctory

PARENT_DIR=$(cd $(dirname $0); cd ..;pwd)

if [$# -lt 1]; then
    echo "Usage init.sh -$repositoriesDirectory"
    exit 1
fi

# get password sudo
echo "sudo password? : "
read pw

# 4 ubuntu japanese remix
LANG=C xdg-user-dirs-gtk-update

# install vim
$pw | sudo apt-get install vim -y

# clone neobundle
# TODO: Replace Dein.vim
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# clone and apply my .vimrc
cp ../vimrc/.vimrc $PARENT_DIR/vim/.vimrc

# echo warning!!
echo "edit UndoFile setting from ~/.vimrc"
