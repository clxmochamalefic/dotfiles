let mapleader = ","

if &compatible
    set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END


scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

"---------------------------------------------------------------------------
"" UndoFiles
let s:home_tmp_dir = expand($HOME . '/tmp')

" ~/tmp 以降のディレクトリがない場合は新規作成
if !isdirectory(s:home_tmp_dir)
    execute '!mkdir ' . s:home_tmp_dir
    execute '!mkdir ' . expand(s:home_tmp_dir . '/undofiles')
    execute '!mkdir ' . expand(s:home_tmp_dir . '/backupfiles')
endif

exe 'set undodir='   . expand(s:home_tmp_dir . '/undofiles')
exe 'set backupdir=' . expand(s:home_tmp_dir . '/backupfiles')

" Windows でもパスの区切り文字を / にする
set shellslash

"---------------------------------------------------------------------------
"" Input

"+++++++++++++++
"" tab
set tabstop=4
set smartindent
set shiftwidth=4
set expandtab

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.js   setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.jsx  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.ts   setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.tsx  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.sass setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scss setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"+++++++++++++++
"" tab
set backspace=indent,eol,start

set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

"---------------------------------------------------------------------------
"" mouse
"
"" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない
" (mousefocus:切替る/nomousefocus:切り替えない)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a

"---------------------------------------------------------------------------
" Use Default Shell
if has('win32')
"  set shell=PowerShell
  set shell=bash
  set shellcmdflag=-c
  set shellquote="
endif

"+++++++++++++++
" python設定
if has('win32')
    " install from msi
    "let g:python3_host_prog = 'C:/Python39/python.exe'
    " install from winget
    let g:python3_host_prog = 'C:/Users/cocoalix/AppData/Local/Programs/Python/Python310/python.exe'
elseif has('mac')
  let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
  let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'
endif

set number

"+++++++++++++++
" 行番号色変更
autocmd ColorScheme * hi LineNr ctermbg=46 ctermfg=0
autocmd ColorScheme * hi CursorLineNr ctermbg=239 ctermfg=46
set cursorline

"+++++++++++++++
" font:
if has('win32')
    " Windows用
    " Migu 2M こそ至高フォント。
    "
    " https://osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-2m-20150712.zip/
    set guifont=Migu\ 2M:h12
    "set guifont=MS_Mincho:h12:cSHIFTJIS
    " 行間隔の設定
    set linespace=1
    " 一部のUCS文字の幅を自動計測して決める
    if has('kaoriya')
        set ambiwidth=auto
    endif
elseif has('mac')
    set guifont=Migu\ 2M:h12
elseif has('xfontset')
    " UNIX用 (xfontsetを使用)
    set guifontset=a14,r14,k14
endif

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
    " IME ON時のカーソルの色を設定(設定例:紫)
    highlight CursorIM guibg=Purple guifg=NONE
    " 挿入モード・検索モードでのデフォルトのIME状態設定
    set iminsert=0 imsearch=0
    if has('xim') && has('GUI_GTK')
        " XIMの入力開始キーを設定:
        " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
        "set imactivatekey=s-space
    endif
    " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
    "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"---------------------------------------------------------------------------
" Window
set wildmenu
" コマンドライン補完設定
set wildmode=list:full,full
set hidden
" 編集中ファイルがあっても別画面に切り替え可能に
set noequalalways

"---------------------------------------------------------------------------
" Mapping
nnoremap ; :

" tag jump
nnoremap <C-J> <C-]>

" today date and time
nmap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR>
nmap <F7> <ESC>i<C-R>=strftime("%H:%M")<CR><CR>

" use colorschema
set termguicolors

" use clipboard ------------------------------------------------------------------
set nopaste
noremap! <S-Insert> <C-R>+
set clipboard=unnamed

" Dein ---------------------------------------------------------------------------
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:initvim_path = fnamemodify(expand('<sfile>'), ':h')

" なければgit clone
if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath+=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " 管理するプラグインを記述したファイル
    let s:toml = s:initvim_path . '/dein.toml'
    let s:lazy_toml = s:initvim_path . '/dein_lazy.toml'
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif
" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。

" その他インストールしていないものはこちらに入れる
if dein#check_install()
    call dein#install()
endif

" ctags
set tags=./tags;$HOME

filetype plugin indent on
syntax enable


call map(dein#check_clean(), "delete(v:val, 'rf')")

" XML / HTML の閉じタグ自動入力
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" 閉じかっこの自動入力
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
