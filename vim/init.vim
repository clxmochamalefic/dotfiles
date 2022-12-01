scriptencoding utf-8

let mapleader = ","

if &compatible
    set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" encoding preference 
set encoding=utf-8
set fileencoding=utf-8

" variable
let s:initvim_path = fnamemodify(expand('<sfile>'), ':h')

"---------------------------------------------------------------------------
"" UndoFiles
let s:home_tmp_dir = expand($HOME . '/.cache/nvim')

" ~/tmp 以降のディレクトリがない場合は新規作成
if !isdirectory(s:home_tmp_dir)
    execute '!mkdir -p ' . s:home_tmp_dir
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

  autocmd BufNewFile,BufRead *.html       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.phtml      setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.js         setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.jsx        setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.ts         setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.tsx        setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.css        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.sass       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.scss       setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.prisma     setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.vim        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yaml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.toml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.tml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.lua        setlocal tabstop=2 softtabstop=2 shiftwidth=2

  "autocmd BufNewFile,BufRead *.blade.php  setlocal syntax=html
  "autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=html
  "autocmd BufNewFile,BufRead *.blade.php  setlocal tabstop=2 softtabstop=2 shiftwidth=2
  "autocmd BufNewFile,BufRead *.blade      setlocal tabstop=2 softtabstop=2 shiftwidth=2

  autocmd BufNewFile,BufRead *.blade.php  setlocal filetype=blade
  autocmd FileType blade                  setlocal tabstop=2 softtabstop=2 shiftwidth=2

augroup END

" XML / HTML の閉じタグ自動入力
augroup MyXML
  autocmd!
  autocmd FileType xml        inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType html       inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType phtml      inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType blade.php  inoremap <buffer> </ </<C-x><C-o>
augroup END

" 閉じかっこの自動入力
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

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
" Mapping
nnoremap ; :

" tag jump
nnoremap <C-J> <C-]>

" terminal alias
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>

" today date and time
nmap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR>
nmap <F7> <ESC>i<C-R>=strftime("%H:%M")<CR><CR>

augroup Terminal
  autocmd!
  autocmd TermOpen * startinsert
  "autocmd!
  "autocmd VimEnter * ++nested split term://sh
augroup END

" use clipboard ------------------------------------------------------------------
set nopaste
noremap! <S-Insert> <C-R>+
set clipboard=unnamed

" Dein ---------------------------------------------------------------------------

let g:dein#install_progress_type = 'floating'

if !exists('*LoadPlugins')
  let &stl.='%{LoadPlugins}'

  ""
  " プラグイン設定をロードする
  "
  " @param string a:dein_dir deinのインストールパス
  " @param string a:initvim_path init.vimのパス
  ""
  function! LoadPlugins(dein_dir, initvim_path)
    call dein#clear_state()
    call dein#begin(a:dein_dir)

    " 管理するプラグインを記述したファイルを全て読み込む
    " プラグインの追加・削除やtomlファイルの設定を変更した後は
    " 適宜 call dein#update や call dein#clear_state を呼んでください。
    " そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。
    let l:filelist =  expand(a:initvim_path . "/plugins/*.toml")
    let l:splitted = split(l:filelist, "\n")
    for l:file in l:splitted
      " .lazy.toml の場合は lazy load にする
      let l:is_lazy = stridx(l:file, '.lazy.toml') > -1
      call dein#load_toml(expand(l:file), {'lazy': l:is_lazy})
    endfor

    call dein#end()
    call dein#save_state()
  endfunction
endif

" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:plugin_preferences_dir = s:initvim_path . '/plugins'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath+=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    execute LoadPlugins(s:dein_dir, s:initvim_path)
endif

" その他インストールしていないものはこちらに入れる
if dein#check_install()
    call dein#install()
endif

"---------------------------------------------------------------------------
"" Display

"+++++++++++++++
" use colorschema
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors
set background=dark
colorscheme onehalfdark
let g:airline_theme = 'onehalfdark'

"+++++++++++++++
" linenumber

" show
set number

"+++++++++++++++
" linenumber

" modify color for linenumber
augroup LineNumberColor
  autocmd!
  autocmd ColorScheme * hi LineNr ctermbg=46 ctermfg=0
  autocmd ColorScheme * hi CursorLineNr ctermbg=239 ctermfg=46
augroup END

"+++++++++++++++
" floating window

" floating window color
hi MyDarkColorTheme guibg=232 guifg=7 ctermbg=232 ctermfg=7
set winhighlight=Normal:MyDarkColorTheme

" modify color for current cursor line linenumber
set cursorline

"+++++++++++++++
" Window
set wildmenu
" コマンドライン補完設定
set wildmode=list:full,full
set hidden
" 編集中ファイルがあっても別画面に切り替え可能に
set noequalalways

"---------------------------------------------------------------------------
" general

" ctags
set tags=./tags;$HOME

filetype plugin indent on
syntax enable

call map(dein#check_clean(), "delete(v:val, 'rf')")

let s:initvim_fp = s:initvim_path . '/init.vim'
let s:deintoml_fp = s:initvim_path . '/plugins/dein.toml'
let s:deinlazytoml_fp = s:initvim_path . '/plugins/dein.lazy.toml'

" init.vim 自動オープン
command! Preferences execute 'e ' . s:initvim_path . '/init.vim'
command! Pref Preferences
command! Pr Preferences

" dein.toml 自動オープン
command! Plugins execute 'e ' . s:deintoml_fp
command! Pl Plugins

" dein_lazy.toml 自動オープン
command! Lplugins execute 'e ' . s:deinlazytoml_fp
command! Lp Lplugins

if !exists('*ReloadAll')
  let &stl.='%{ReloadAll}'

  function! ReloadAll()
    execute 'source ' . s:initvim_fp
    execute LoadPlugins(s:dein_dir, s:initvim_path)
  endfunction
endif

" init.vim 再読み込み
command! Reload execute ReloadAll()

"---------------------------------------------------------------------------
" env preferences
if has('win32')
    execute 'source ' . s:initvim_path . '/env/win.vim'
elseif has('mac')
    execute 'source ' . s:initvim_path . '/env/unix.vim'
elseif has('macunix')
    execute 'source ' . s:initvim_path . '/env/unix.vim'
elseif has('xfontset')
    execute 'source ' . s:initvim_path . '/env/linux.vim'
else
    execute 'source ' . s:initvim_path . '/env/linux.vim'
endif
