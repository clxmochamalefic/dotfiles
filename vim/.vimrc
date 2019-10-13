"---------------------------------------------------------------------------
" vimrc rule
" :set ff=unix
" :set fenc=utf8

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

"---------------------------------------------------------------------------
" UndoFiles
if has('win32')
    set undodir=$HOME/apps/vim/undofiles
    set backupdir=$HOME/apps/vim/backupfiles
elseif has('unix')
    set undodir=$HOME/tmp/undofiles
    set backupdir=$HOME/tmp/backupfiles
elseif has('mac')
    set undodir=$HOME/tmp/undofiles
    set backupdir=$HOME/tmp/backupfiles
endif


"---------------------------------------------------------------------------
" Input

"+++++++++++++++
" tab
set tabstop=4
set smartindent
set shiftwidth=4
set expandtab

"+++++++++++++++
" tab
set backspace=indent,eol,start

"---------------------------------------------------------------------------
" mouse
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る/nomousefocus:切り替えない)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a

"---------------------------------------------------------------------------
" Use Default Shell
if has('win32')
  set shell=PowerShell
elseif has('mac')
"  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
endif

"---------------------------------------------------------------------------
" Display

"+++++++++++++++
" color and decoration
set showcmd         "
set laststatus=2    "
set number          " 行番号
set showmatch       " 括弧入力時対応括弧表示
set incsearch       " インクリメンタルサーチ
set hlsearch        " 検索結果の文字列をハイライト
set list            " タブ/改行を表示
set listchars=tab:>\ ,trail:~,eol:$,extends:>,precedes:<,nbsp:%
syntax on

" 行番号色変更
autocmd ColorScheme * hi LineNr ctermbg=46 ctermfg=0
autocmd ColorScheme * hi CursorLineNr ctermbg=239 ctermfg=46
set cursorline

"+++++++++++++++
" font:
if has('win32')
  " Windows用
  " Migu 2M こそ至高フォント。
  " https://osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-2m-20150712.zip/
  set guifont=Migu_2M:h8:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka－等幅:h14
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
set wildmenu                " コマンドライン補完設定
set wildmode=list:full,full
set hidden                  " 編集中ファイルがあっても別画面に切り替え可能に
set noequalalways

"---------------------------------------------------------------------------
" Mapping
nnoremap ; :

" tag jump
nnoremap <C-J> <C-]>

" must install: Shougo/Unite.vim
cnoremap :ub Unite buffer
cnoremap ;ub Unite buffer

" must install: Shougo/vimfiler.vim
cnoremap :vf VimFiler
cnoremap ;vf VimFiler
cnoremap :vfe VimFilerExplorer
cnoremap ;vfe VimFilerExplorer

" today date and time
nmap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR>
nmap <F7> <ESC>i<C-R>=strftime("%H:%M")<CR><CR>

"---------------------------------------------------------------------------
" FileType Preference
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"---------------------------------------------------------------------------
" tags

"---------------------------------------------------------------------------
" dein.vim
filetype off

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))

    " dein & NeoComplete
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neocomplete.git')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')

    " Vim Basic
call dein#add('itchyny/lightline.vim')
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-fontzoom')

    " Unite.vim
call dein#add('Shougo/denite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/neomru.vim')

    " search module
call dein#add('actionshrimp/vim-xpath')

    " syntax highlight
call dein#add('PProvost/vim-ps1')
call dein#add('gregsexton/MatchTag')
call dein#add('leafgarland/typescript-vim')
call dein#add('Quramy/tsuquyomi')
call dein#add('elzr/vim-json')

    " colorschemes
call dein#add('jonathanfilip/vim-lucius')

call dein#end()

" ----------------------------------------
" Config of NeoComplete
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


"--------------------------------------------------
" itchyny/lightline.vim
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"--------------------------------------------------
" vimfiler
let g:vimfiler_as_default_explorer = 1      " replace default vim file explorer
let g:vimfiler_safe_mode_by_default = 0     " vim startup with safemode disabled on vimfiler


"--------------------------------------------------
" MSYS PATH
"let $PATH = $PATH . 'C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\usr\bin;'
filetyp on


"--------------------------------------------------
" jq
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

"--------------------------------------------------
" Separated configs
runtime! .uniterc

"+++++++++++++++
" colorscheme:
colorscheme lucius
LuciusDark
if has('unix')
  set t_Co=256
endif
