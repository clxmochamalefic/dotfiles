call pum#set_option('max_width', 100)
call pum#set_option('use_complete', v:true)
call pum#set_option('border', 'rounded')

set pumblend=20

augroup transparent-windows
  autocmd!
  autocmd FileType * set winblend=20  " こちらも 5 〜 30 で試してみてください。
augroup END

" invoke with '-'
nmap  -  <Plug>(choosewin)

