#!/bin/bash

CURRENT_PATH=$(cd "$(dirname "$0")";pwd)      # /nvim/.init/ 想定
PARENT_PATH=$(cd "$(dirname "$0")";cd ..;pwd)  # /nvim/ 想定

echo "make dir: $HOME/.config/nvim"

if ! [ -e $HOME/.config ] ; then
    mkdir $HOME/.config
    echo "success mkdir $HOME/.config"
fi

if ! [ -e $HOME/.config/nvim ] ; then
    mkdir $HOME/.config/nvim
    echo "success mkdir $HOME/.config"
fi

echo "remove nvim preference files what already exists"

if ! [ -e $HOME/.config/nvim/init.vim ] ; then
    rm $HOME/.config/nvim/init.vim
fi

if ! [ -e $HOME/.config/nvim/ginit.vim ] ; then
    rm $HOME/.config/nvim/ginit.vim
fi

echo "write reference preference"

LUA_PATH="${PARENT_PATH}/lua"

echo ""
echo "current path: ${CURRENT_PATH}"
echo "    lua path: ${LUA_PATH}"
echo ""

echo "vim.opt.runtimepath:append(',${PARENT_PATH}')"            >  $HOME/.config/nvim/init.lua
echo "vim.opt.runtimepath:append(',${LUA_PATH}')"               >> $HOME/.config/nvim/init.lua
echo "vim.g.preference_path = vim.fn.expand('${PARENT_PATH}')"  >> $HOME/.config/nvim/init.lua
echo "vim.cmd([[luafile ${PARENT_PATH}/init.lua]])"             >> $HOME/.config/nvim/init.lua
echo "vim.cmd([[luafile ${PARENT_PATH}/ginit.lua]])"            >> $HOME/.config/nvim/ginit.lua

echo "export LUA_PATH=$LUA_PATH" >> ~/.bashrc
echo "export LUA_EXE_PATH=$LUA_PATH" >> ~/.bashrc

echo "finished and all correct"

