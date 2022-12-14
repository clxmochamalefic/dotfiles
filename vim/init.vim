"---------------------------------------------------------------------------
"" initialize

" this init.vim is using utf-8
scriptencoding utf-8

" disable `vi` compatible
if &compatible
    set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" define default file encoding and fileformat
set encoding=utf-8
set fileencoding=utf-8
set ff=dos

" get preference file path
let s:initvim_path = fnamemodify(expand('<sfile>'), ':h')

"---------------------------------------------------------------------------
"" UndoFiles
let s:home_tmp_dir = expand($HOME . '/.cache/vim_tmp')

" ~/tmp 以降のディレクトリがない場合は新規作成
if !isdirectory(s:home_tmp_dir)
    execute '!mkdir -p ' . s:home_tmp_dir
    execute '!mkdir ' . expand(s:home_tmp_dir . '/undofiles')
    execute '!mkdir ' . expand(s:home_tmp_dir . '/backupfiles')
endif

exe 'set undodir='   . expand(s:home_tmp_dir . '/undofiles')
exe 'set backupdir=' . expand(s:home_tmp_dir . '/backupfiles')


"---------------------------------------------------------------------------
"" display

" define colorscheme load function for lazyload
if !exists('*s:isEndSemicolon')
  let &stl.='%{s:isEndSemicolon}'
  function! s:load_colorscheme() abort
    " background color
    set background=dark
    " using colorscheme
    colorscheme onehalfdark
    " using airline colorscheme
    let g:airline_theme = 'onehalfdark'
  endfunction
endif

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

" modify line number col color
autocmd ColorScheme * hi LineNr ctermbg=46 ctermfg=0
autocmd ColorScheme * hi CursorLineNr ctermbg=239 ctermfg=46
set cursorline


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

" define tabstop by filetype
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
inoremap {<Enter> {}<Left><CR><BS><ESC><S-o>
inoremap [<Enter> []<Left><CR><BS><ESC><S-o>
inoremap (<Enter> ()<Left><CR><BS><ESC><S-o>


"---------------------------------------------------------------------------
" input (key_mapping)
nnoremap ; :

" tag jump
nnoremap <C-J> <C-]>

" terminal alias
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>

" today date and time
nmap <C-;> <ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR>
nmap <F7> <ESC>i<C-R>=strftime("%H:%M")<CR><CR>

" auto insert semicolon to after last character in current line
if !exists('*s:isEndSemicolon')
  let &stl.='%{s:isEndSemicolon}'
  function! s:isEndSemicolon() abort
    return getline(".")[col("$")-2] != ';'
  endfunction
endif

inoremap <expr>;; s:isEndSemicolon() ?  "<C-O>$;<CR>"  :  "<C-O>$<CR>"

" Help画面でのqだけでのヘルプ終了
augroup QuitHelp
  autocmd!
  autocmd FileType help nnoremap q :quit<CR>
augroup END

" preference file open mapping
let s:ginitvim_filepath = s:initvim_path . '/ginit.vim'
let s:initvim_filepath  = s:initvim_path . '/init.vim'

" plugin preference file open mapping
let s:basic_plugin_filepath     = s:initvim_path . '/dein.toml'
let s:theme_plugin_filepath     = s:initvim_path . '/themes.toml'
let s:lazy_load_plugin_filepath = s:initvim_path . '/dein.lazy.toml'

" plugin list
let s:dein_plugins = [s:basic_plugin_filepath, s:theme_plugin_filepath, s:lazy_load_plugin_filepath]

" init.vim open
command! Preferences execute 'e ' . s:initvim_filepath
command! Pref Preferences
command! Pr Preferences

" ginit.vim open
command! PreferencesGui execute 'e ' . s:ginitvim_filepath
command! PrefGui Preferences
command! Pg PreferencesGui

" dein.toml open
command! Plugins execute 'e ' . s:basic_plugin_filepath
command! Plu Plugins

" dein_lazy.toml open
command! PluginsLazy execute 'e ' . s:lazy_load_plugin_filepath
command! Pll PluginsLazy

" themes.toml open
command! PluginsTheme execute 'e ' . s:theme_plugin_filepath
command! Pt PluginsTheme

" init.vim reload
if !exists('*reload_functions')
  let &stl.='%{reload_functions}'
  function! s:reload_preference() abort
    if has("gui_running")
      execute 'source ' . s:ginitvim_filepath
    endif
    execute 'call dein#call_hook("add")'
  endfunction
  function! s:reload_all() abort
    call s:reload_preference()
    call s:reload_plugin_hard(s:dein_plugins)
  endfunction
endif

command! ReloadPreference execute s:reload_preference()
command! Rer ReloadPreference
command! ReloadAll execute s:reload_all()
command! Rea ReloadAll


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
"

"---------------------------------------------------------------------------
" terminal
if has('win32')
  set shell=pwsh
  set shellcmdflag=-c
  set shellquote="

  " terminal
  cnoremap :tp terminal
  cnoremap ;tp terminal
  cnoremap :tw call termopen("powershell wsl")
  cnoremap ;tw call termopen("powershell wsl")
endif

augroup Terminal
  autocmd!
  autocmd TermOpen * startinsert
  "autocmd!
  "autocmd VimEnter * ++nested split term://sh
augroup END


"---------------------------------------------------------------------------
" path

" python path
if has('win32')
  " install from msi
  "let g:python3_host_prog = 'C:/Python39/python.exe'
  " install from winget
  let g:python3_host_prog = $HOME.'/AppData/Local/Programs/Python/Python310/python.exe'
elseif has('mac')
  let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
  let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'
endif

" ctags path
set tags=./tags;$HOME

"---------------------------------------------------------------------------
" plugin installation
" using dein.vim

" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" add dein repo dir path to runtimepath
execute 'set runtimepath+=' . s:dein_repo_dir

" load plugins
if !exists('*reload_plugin_functions')
  let &stl.='%{reload_plugin_functions}'
  function! s:reload_plugin(tomls) abort
    if dein#load_state(s:dein_dir)
      call dein#begin(s:dein_dir)

      for toml in a:tomls
        let l:is_lazy = stridx(toml, '.lazy.toml') > -1 ? 1 : 0
        call dein#load_toml(toml, {'lazy': l:is_lazy})
      endfor

      call dein#end()
      call dein#save_state()
    endif

    " その他インストールしていないものはこちらに入れる
    if dein#check_install()
      call dein#install()
    endif

    " remove plugin on toml undefined 
    call map(dein#check_clean(), "delete(v:val, 'rf')")
  endfunction

  function! s:reload_plugin_hard(tomls) abort
    call dein#clear_state()
    call s:reload_plugin(a:tomls)
  endfunction
endif

command! ReloadPluginHard execute s:reload_plugin_hard(s:dein_plugins)
command! Rel ReloadPluginHard

" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。
call s:reload_plugin(s:dein_plugins)

" load colorscheme (after loaded plugins)
call s:load_colorscheme()

" show dein.vim install and update progress
command! DeinProgress echo dein#get_progress()
command! Dp DeinProgress


" init.vim is load finished
filetype plugin indent on
syntax enable

