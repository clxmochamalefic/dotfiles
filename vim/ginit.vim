call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

# Migu 2M
# https://osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-2m-20150712.zip/
#
# Cica
# https://github.com/miiton/Cica
let s:fav_font_map = {
\   "Migu2M": "Migu\ 2M",
\   "Migu2MPL": "Migu\ 2M\ for\ Powerline",
\   "Cica": "Cica",
\ }

let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
#  execute "set guifont=" . s:fav_font_map["Cica"] . ":h" . s:fontsize
  execute "set guifont=Cica:h" . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

call AdjustFontSize(0)
