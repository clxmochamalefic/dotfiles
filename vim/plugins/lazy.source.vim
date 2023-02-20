" deol.nvim ------------------------------
let g:deol#floating_border = "rounded"
let g:deol#enable_ddc_completion = v:true

let g:deol#custom_map = {
      \   'edit': 'e',
      \   'start_insert': 'i',
      \   'start_insert_first': 'I',
      \   'start_append': 'a',
      \   'start_append_last': 'A',
      \   'execute_line': '<CR>',
      \   'previous_prompt': '<C-p>',
      \   'next_prompt': '<C-n>',
      \   'paste_prompt': '<C-y>',
      \   'bg': '<C-z>',
      \   'quit': 'q',
      \ }

"autocmd FileType ddu-filer call s:deol_my_settings()

"let s:current_filer = 0

"function! s:get_file_type() abort
"  let l:filetype = execute ("set filetype")
"endfunction
"
"function! s:deol_my_settings() abort
"  nnoremap <buffer><silent> <F1>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer1', 'params': { 'id': 0 }, 'quit': v:true })<CR>
"  nnoremap <buffer><silent> <F2>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer2', 'params': { 'id': 1 }, 'quit': v:true })<CR>
"  nnoremap <buffer><silent> <F3>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer3', 'params': { 'id': 2 }, 'quit': v:true })<CR>
"  nnoremap <buffer><silent> <F4>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer4', 'params': { 'id': 3 }, 'quit': v:true })<CR>
"endfunction

" 【Ctrl + o】 float windowでターミナルを表示
nnoremap <silent><C-o> :<C-u>execute 'Deol' '-cwd=' . fnamemodify(expand('%'), ':h') . ' -split=floating' . ' -winrow=' . g:float_window_row . ' -wincol=' . g:float_window_col . ' -winwidth=' . g:float_window_width . ' -winheight=' . g:float_window_height . ' -auto-cd=' .v:true<CR>

" 【ESC】 ターミナルモードから抜ける
tnoremap <ESC>   <C-\><C-n>

