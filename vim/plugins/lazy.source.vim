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

" 【Ctrl + o】 float windowでターミナルを表示
nnoremap <silent><C-o> :<C-u>execute 'Deol' '-cwd=' . fnamemodify(expand('%'), ':h') . ' -split=floating' . ' -winrow=' . g:float_window_row . ' -wincol=' . g:float_window_col . ' -winwidth=' . g:float_window_width . ' -winheight=' . g:float_window_height . ' -auto-cd=' .v:true<CR>

" 【ESC】 ターミナルモードから抜ける
tnoremap <ESC>   <C-\><C-n>

