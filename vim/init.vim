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

" debug mode
let g:is_enable_my_debug = v:true

" get preference file path
"let g:my_initvim_path = expand('%:p:h')
let g:my_initvim_path = expand(g:preference_path)

function! DebugEcho(mes) abort
  if g:is_enable_my_debug
    echo 'begin ' . a:mes . ' load'
  endif
endfunction


call DebugEcho('begin ' . g:my_initvim_path . ' load')

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


call DebugEcho('load rc')

runtime /rc/base.vim
runtime /rc/dein.vim
runtime /rc/filetype.vim
runtime /rc/mapping.vim
runtime /rc/color.vim
runtime /rc/command.vim

call DebugEcho('end ' . g:my_initvim_path . ' load')


" init.vim is load finished
filetype plugin indent on
syntax enable

