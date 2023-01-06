"---------------------------------------------------------------------------
" COLORSCHEME PREFERENCE

let s:colorscheme = 'onehalfdark'
let s:airline_theme = 'bubblegum'

" define colorscheme load function for lazyload
function! s:load_colorscheme() abort
  " background color
  set background=dark
  " using colorscheme
  execute "colorscheme " . s:colorscheme

  " using airline colorscheme
  let g:airline_theme = s:airline_theme
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

hi RegistersWindow  ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8

hi Pmenu            ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
hi PmenuSel         ctermbg=249 ctermfg=46 guibg=#610B5E guifg=#F2F2F2
hi PmenuSbar        ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8
hi PmenuThumb       ctermbg=249 ctermfg=46 guibg=#610B5E guifg=#F2F2F2

hi NormalFloat      ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8

hi TermCursor       ctermbg=249 ctermfg=46 guibg=#610B5E guifg=#F2F2F2
hi TermCursorNC     ctermbg=249 ctermfg=46 guibg=#2F0B3A guifg=#D8D8D8


" modify color by colorscheme
if s:colorscheme == 'onehalfdark'
  let g:terminal_color_0 = '#565F70'
  let g:terminal_color_8 = '#717C91'
endif


" vim-airline
set laststatus=2

let g:airline_experimental = 1
let g:airline_detect_spell=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#virtualenv#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'

