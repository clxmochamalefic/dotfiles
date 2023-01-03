execute "source " . g:my_initvim_path . "/plugins/lsp.lua"

let g:popup_preview_config = {
      \   'delay': 10,
      \   'maxWidth': 100,
      \   'winblend': 0,
      \ }

call popup_preview#enable()
call signature_help#enable()

