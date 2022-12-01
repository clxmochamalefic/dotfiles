scriptencoding utf-8

"---------------------------------------------------------------------------
" default shell
set shell=pwsh
set shellcmdflag=-c
set shellquote="

" terminal
cnoremap :tp terminal
cnoremap ;tp terminal
cnoremap :tw call termopen("powershell wsl")
cnoremap ;tw call termopen("powershell wsl")

"---------------------------------------------------------------------------
" font
" Windows用
" Migu 2M こそ至高フォント。
"
" https://osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-2m-20150712.zip/
set guifont=Migu\ 2M\ for\ Powerline:h12
"set guifont=MS_Mincho:h12:cSHIFTJIS
" 行間隔の設定
set linespace=1
" 一部のUCS文字の幅を自動計測して決める
if has('kaoriya')
  set ambiwidth=auto
endif

"---------------------------------------------------------------------------
" PATH

" python3 execution path
let g:python3_host_prog = system('gcm python | Select-Object Source')
