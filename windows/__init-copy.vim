"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=C:\Users\cocoalix\.cache\dein\repos\github.com\Shougo\dein.vim

" Dein ---------------------------------------------------------------------------
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:initvim_path = fnamemodify(expand('<sfile>'), ':h')

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

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
