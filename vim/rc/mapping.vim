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
function! s:isEndSemicolon() abort
  return getline(".")[col("$")-2] != ';'
endfunction

inoremap <expr>;; s:isEndSemicolon() ?  "<C-O>$;<CR>"  :  "<C-O>$<CR>"


" XML / HTML の閉じタグ自動入力
augroup MyXML
  autocmd!
  autocmd FileType xml        inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType html       inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType phtml      inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType blade.php  inoremap <buffer> </ </<C-x><C-o>
augroup END

" Help画面でのqだけでのヘルプ終了
augroup QuitHelp
  autocmd!
  autocmd FileType help nnoremap q :quit<CR>
augroup END

" 閉じかっこの自動入力
"inoremap {<Enter> {}<Left><CR><BS><ESC><S-o>
"inoremap [<Enter> []<Left><CR><BS><ESC><S-o>
"inoremap (<Enter> ()<Left><CR><BS><ESC><S-o>

