echo "begin /plugins/ddu.vim load"

" ddu.vim
call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'sources': [
      \     {'name': 'file_rec', 'params': {}},
      \     {'name': 'file'},
      \     {'name': 'buffer'},
      \     {'name': 'emoji'},
      \   ],
      \   'sourceOptions': {
      \     '_': {
      \       'matchers': ['matcher_substring'],
      \     },
      \     'dein_update': {
      \       'matchers': ['matcher_dein_update'],
      \     },
      \   },
      \   'filterParams': {
      \     'matcher_substring': {
      \       'highlightMatched': 'Search',
      \     },
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \     'action': {
      \       'defaultAction': 'do',
      \     },
      \     'word': {
      \       'defaultAction': 'append',
      \     },
      \     'dein_update': {
      \       'defaultAction': 'viewDiff',
      \     },
      \     'custom-list': {
      \       'defaultAction': 'callback',
      \     },
      \   },
      \   'actionOptions': {
      \     'echo': {
      \       'quit': v:false,
      \     },
      \     'echoDiff': {
      \       'quit': v:false,
      \     },
      \   },
      \ })


" ddu-ui --------------------

" ddu-ui-ff
if has('macunix')
  command "brew install desktop-file-utils"
endif

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
        \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
        \ <Cmd>close<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>close<CR>
endfunction


" ddu-ui-filer
call ddu#custom#patch_local('filer', #{
      \   ui: 'filer',
      \   sources: [
      \     #{
      \       name: 'file',
      \       params: #{},
      \     },
      \   ],
      \   sourceOptions: #{
      \     _: #{
      \       columns: ['icon_filename'],
      \     },
      \   },
      \   kindOptions: #{
      \     file: #{
      \       defaultAction: 'open',
      \     },
      \   },
      \   actionOptions: #{
      \     narrow: #{
      \       quit: v:false,
      \     },
      \   },
      \   uiParams: #{
      \     filer: #{
      \       search: expand('%:p'),
      \       sort: 'filename',
      \       span: 2,
      \       sortTreesFirst: v:true,
      \     },
      \     icon_filename: #{
      \       span: 2,
      \     },
      \   },
      \ })

autocmd TabEnter,CursorHold,FocusGained <buffer>
      \ call ddu#ui#filer#do_action('checkItems')

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
  "nnoremap <buffer><silent><expr> <CR>
  "  \ ddu#ui#filer#is_tree() ?
  "  \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
  "  \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open', 'params': {'command': 'choose'}})<CR>"
  "nnoremap <buffer><silent><expr> <CR>
  "  \ ddu#ui#filer#is_tree() ?
  "  \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
  "  \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open', 'params': {'command': 'split'}})<CR>"
  nnoremap <buffer><silent><expr> <CR>
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open'})<CR>"

  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>

  nnoremap <buffer><silent> <BS>
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>

  nnoremap <buffer><silent> c
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'copy'})<CR>

  nnoremap <buffer><silent> x
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'cut'})<CR>

  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'paste'})<CR>

  nnoremap <buffer><silent> d
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>

  nnoremap <buffer><silent> r
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'rename'})<CR>

  nnoremap <buffer><silent> R
        \ <Cmd>call ddu#ui#filer#do_action('checkItems')<CR>


  nnoremap <buffer><silent> m
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'move'})<CR>

  nnoremap <buffer><silent> b
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newFile'})<CR>

  nnoremap <buffer><silent> B
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newDirectory'})<CR>

  nnoremap <buffer><silent> yy
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'yank'})<CR>

  nnoremap <buffer><silent> h
        \ <Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>

  nnoremap <buffer><silent> l
        \ <Cmd>call ddu#ui#filer#do_action('expandItem')<CR>

  nnoremap <buffer><silent> <TAB>
        \ <Cmd>call ddu#ui#filer#do_action('expandItem', {'mode': 'toggle'})<CR>

endfunction

command! DduFiler     call ddu#start({ 'name': 'filer', 'uiParams': {} })
command! DduFilerHome call ddu#start({ 'name': 'filer', 'uiParams': { 'filer': { 'search': expand($HOME) } } })

nnoremap  ^  :<C-u>DduFiler<CR>
nnoremap  ~  :<C-u>DduFilerHome<CR>


" ddu-source --------------------

" ddu-source-buffer
call ddu#custom#patch_local('buffer', {
      \   'ui': 'ff',
      \   'sources': [
      \     {
      \       'name': 'buffer',
      \       'params': {},
      \     },
      \   ],
      \ })

nnoremap  \  :<C-u>call ddu#start({ 'name': 'buffer' })<CR>
command! DduBuffer call ddu#start({ 'name': 'buffer' })


" ddu-source-file_old
command! DduFileOld call ddu#start(#{ sources: [#{ name: 'file_old' }] })
nnoremap  \|  :<C-u>DduFileOld<CR>


" ddu-source-emoji
call ddu#custom#patch_local('emoji', {
      \   'sources': [
      \     {
      \       'name': 'emoji',
      \       'params': {},
      \     },
      \   ],
      \   'kindOptions': {
      \     'word': {
      \       'defaultAction': 'append',
      \     },
      \   },
      \ })

command! DduEmoji call ddu#start({ 'name': 'emoji' })

" Insert emoji mapping.
inoremap <C-x><C-e> <Cmd>call ddu#start({'sources': [{'name': 'emoji'}]})<CR>


" ddu-source-custom-list
let s:id = denops#callback#register(
      \   { s -> execute(printf('echom "%s"', s), '') },
      \   #{ once: v:true }
      \ )
call ddu#custom#patch_local('custom-list', {
      \   'sources': [#{
      \     name: 'custom-list',
      \     params: #{
      \       texts: ['hello', 'world'],
      \       callbackId: s:id,
      \     }
      \   }
      \ ]})

command! DduCmd call ddu#start(#{ name: 'custom_list' })

echo "begin /plugins/ddu.vim end"

