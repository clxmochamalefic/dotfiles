export PATH=$PATH:/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/

# .bashrcのls aliasはGNU-lsのものなので、BSD-lsのものに貼り直す
alias ls='ls -CFG'
alias ll='ls -alG'
alias la='ls -CFalG'

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -U compinit
compinit -u

autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

 
# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完リストの表示間隔を狭くする
setopt list_packed
 
# コマンドの打ち間違いを指摘してくれる
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "


eval $(thefuck --alias)
