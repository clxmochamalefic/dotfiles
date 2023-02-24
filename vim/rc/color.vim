"---------------------------------------------------------------------------
" COLORSCHEME PREFERENCE

let s:colorscheme = 'onehalfdark'

" define colorscheme load function for lazyload
function! s:load_colorscheme() abort
  " background color
  set background=dark
  " using colorscheme
  execute "colorscheme " . s:colorscheme
endfunction

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

augroup ModifyColorForComp
  autocmd!
  hi! RegistersWindow ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8

  hi! Pmenu           ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
  hi! PmenuSel        ctermbg=249 ctermfg=46 guibg=#610B5E guifg=#F2F2F2
  hi! PmenuSbar       ctermbg=249 ctermfg=46 guibg=#FEB2FC guifg=#D8D8D8
  hi! PmenuThumb      ctermbg=249 ctermfg=46 guibg=#dc92ff guifg=#F2F2F2
augroup END

augroup ModifyColorForFloatWindow
  autocmd!
  hi! NormalFloat     ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
  hi! FloatBorder     ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
augroup END

augroup ModifyColorForTerm
  autocmd!
  hi! TermCursor      ctermbg=249 ctermfg=46 guibg=#610B5E guifg=#F2F2F2
  hi! TermCursorNC    ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
augroup END

augroup TransparentBG
  autocmd!
	autocmd Colorscheme * highlight Normal      ctermbg=none guibg=none
	autocmd Colorscheme * highlight NonText     ctermbg=none guibg=none
	autocmd Colorscheme * highlight LineNr      ctermbg=none guibg=none
	autocmd Colorscheme * highlight Folded      ctermbg=none guibg=none
	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none guibg=none
augroup END

" modify color by colorscheme
if s:colorscheme == 'onehalfdark'
  let g:terminal_color_0 = '#565F70'
  let g:terminal_color_8 = '#717C91'
endif

