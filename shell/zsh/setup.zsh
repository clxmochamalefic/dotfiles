#!/usr/bin/env zsh

CURRENT_PATH=$(cd "$(dirname "$0")";pwd)

echo "source $CURRENT_PATH/.omzsh.zshrc" >> $HOME/.zshrc
