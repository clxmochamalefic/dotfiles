#!/bin/bash
PARENT_DIR=$(cd $(dirname $0); cd ..;pwd)

if [$# -lt 2]; then
    echo "plz call init.sh of parent directory"
    exit 1
fi

# clone neobundle
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

mkdir -p ~/.vim/colors

# clone and apply my .vimrc
cp $SCRIPT_DIR/.*vimrc ~/
