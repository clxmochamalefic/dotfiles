imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' :    '<C-j>'
smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' :    '<C-j>'
imap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
smap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
imap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
smap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'

let g:vsnip_filetypes = {}

