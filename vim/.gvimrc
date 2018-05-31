"---------------------------------------------------------------------------
" vimrc rule
" :set ff=unix
" :set fenc=utf8

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

"---------------------------------------------------------------------------
" Display

"+++++++++++++++
" display
set transparency=5                      " GVim ウィンドウ透過
autocmd GUIEnter * set transparency=240 " Kaoriya GVim ウィンドウ透過
set guioptions-=m                       " GVimメニューバー非表示
set guioptions-=T                       " GVimツールバー非表示
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
