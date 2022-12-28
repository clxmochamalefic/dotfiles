"---------------------------------------------------------------------------
" BASE PREFERENCES
"---------------------------------------------------------------------------

" define default file encoding and fileformat
set encoding=utf-8
set fileencoding=utf-8
set ff=dos


"---------------------------------------------------------------------------
" PATH

" UndoFiles
let s:home_tmp_dir = expand($HOME . '/.cache/vim_tmp')

" ~/tmp 以降のディレクトリがない場合は新規作成
if !isdirectory(s:home_tmp_dir)
    execute '!mkdir -p ' . s:home_tmp_dir
    execute '!mkdir ' . expand(s:home_tmp_dir . '/undofiles')
    execute '!mkdir ' . expand(s:home_tmp_dir . '/backupfiles')
endif

exe 'set undodir='   . expand(s:home_tmp_dir . '/undofiles')
exe 'set backupdir=' . expand(s:home_tmp_dir . '/backupfiles')

" ctags path
set tags=./tags;$HOME


"---------------------------------------------------------------------------
" Window
set wildmenu
" コマンドライン補完設定
set wildmode=list:full,full
set hidden
" 編集中ファイルがあっても別画面に切り替え可能に
set noequalalways


"---------------------------------------------------------------------------
"" sound

" enable mute
set t_vb=
set visualbell
set noerrorbells


"---------------------------------------------------------------------------
"" I/O

" use clipboard
set nopaste
noremap! <S-Insert> <C-R>+
set clipboard=unnamed


"---------------------------------------------------------------------------
"" input (key)

"+++++++++++++++
" define mapleader character
" (`mapleader` is preference of combination prefix character
let mapleader = ","

"+++++++++++++++
" tab and tabstop

" disable use tabcharacter and define tabstop
set tabstop=4
set smartindent
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

"---------------------------------------------------------------------------
" Display

" use gui color preference on terminal
set termguicolors

" show whitespace characters
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" Windows でもパスの区切り文字を / にする
set shellslash

"+++++++++++++++
"" display - line number

" display line number
set number
"---------------------------------------------------------------------------
" input (IME)

" 日本語入力に関する設定:
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
"" input (mouse)
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
" terminal
if has('win32')
  set shell=pwsh
  set shellcmdflag=-c
  set shellquote="
endif

augroup Terminal
  autocmd!
  autocmd TermOpen * startinsert
  "autocmd!
  "autocmd VimEnter * ++nested split term://sh
augroup END
