"---------------------------------------------------------------------------
" COLORSCHEME PREFERENCE

let s:colorscheme = 'onehalfdark'
let s:airline_theme = 'bubblegum'

" define colorscheme load function for lazyload
if !exists('*s:isEndSemicolon')
  let &stl.='%{s:isEndSemicolon}'
  function! s:load_colorscheme() abort
    " background color
    set background=dark
    " using colorscheme
    execute "colorscheme " . s:colorscheme

    " using airline colorscheme
    let g:airline_theme = s:colorscheme
  endfunction
endif

" modify line number col color
augroup MyColorSchemeOnePointModify
  autocmd!

"  autocmd ColorScheme *pwsh*  hi
  autocmd ColorScheme *       hi LineNr       ctermbg=46  ctermfg=0
  autocmd ColorScheme *       hi CursorLineNr ctermbg=239 ctermfg=46
augroup END

" highlight cursor line
set cursorline

" load colorscheme (after loaded plugins)
call s:load_colorscheme()
