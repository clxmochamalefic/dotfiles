#!/bin/bash

## 新しく作られたファイルのパーミッションがつねに 644 になるようにする。基本。
umask 022

## core ファイルを作らせないようにする。これも基本。
ulimit -c 0

# ctrl+s で出力がロックされてしまうのを防ぐ
stty stop undef

# よく使うエイリアスやら各コマンドのデフォルトのオプションを設定
alias ls='ls -CF'
alias ll='ls -al --show-control-chars --color=auto'
alias la='ls -CFal'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias sc='screen'
alias ps='ps --sort=start_time'

# プロンプトの表示をカスタマイズ
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export PS1='\[\033[01;32m\]\u@\H\[\033[01;34m\] \w \$\[\033[00m\] '

# もろもろ環境変数を設定
export PATH=$PATH:/sbin:/usr/sbin # パス
export PAGER='/usr/bin/lv -c' # man とかで使われる
export EDITOR='/usr/bin/vim' # visudo とかで使われる
export HISTSIZE=100000 # これだけコマンド履歴を残す
export LANG='ja_JP.UTF-8' # 以下 3 つ文字コード
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'

# OS別設定読み込み
if [ "$(uname)" == 'Darwin' ]; then
    source ~/.mac.bashrc
elif [ "$(expr substr "$(uname -s)" 1 5)" == 'Linux' ]; then
    source ~/.linux.bashrc
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

source ~/.git-completion.bash
