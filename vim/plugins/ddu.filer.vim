if g:is_enable_my_debug
  echo "begin /plugins/filer.ddu.vim load"
endif

" ddu-ui-filer
let s:current_filer = 0

let s:filers = ['filer_1', 'filer_2', 'filer_3', 'filer_4', ]
function! OpenDduFiler(window_id) abort
  let s:current_filer = a:window_id
  let l:name = s:filers[a:window_id]
  call ddu#start({ 'name': l:name })
endfunction
"
call ddu#custom#action('kind', 'file', 'open_filer1', { args -> OpenDduFiler(0) })
call ddu#custom#action('kind', 'file', 'open_filer2', { args -> OpenDduFiler(1) })
call ddu#custom#action('kind', 'file', 'open_filer3', { args -> OpenDduFiler(2) })
call ddu#custom#action('kind', 'file', 'open_filer4', { args -> OpenDduFiler(3) })

function! s:ddu_filer_my_settings() abort
  " basic actions
  nnoremap <buffer><silent> q     <Cmd>call ddu#ui#filer#do_action('quit')<CR>
  nnoremap <buffer><silent> z     <Cmd>call ddu#ui#filer#do_action('quit')<CR>
  nnoremap <buffer><silent> R     <Cmd>call ddu#ui#filer#do_action('refreshItems')<Bar>redraw<CR>
  nnoremap <buffer><silent> a     <Cmd>call ddu#ui#filer#do_action('chooseAction')<CR>
  nnoremap <buffer><silent> P     <Cmd>call ddu#ui#filer#do_action('preview')<CR>

  " change window
  nnoremap <buffer><silent> <F1>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer1', 'params': { 'id': 0 }, 'quit': v:true })<CR>
  nnoremap <buffer><silent> <F2>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer2', 'params': { 'id': 1 }, 'quit': v:true })<CR>
  nnoremap <buffer><silent> <F3>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer3', 'params': { 'id': 2 }, 'quit': v:true })<CR>
  nnoremap <buffer><silent> <F4>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer4', 'params': { 'id': 3 }, 'quit': v:true })<CR>


  " change directory (path)
  nnoremap <buffer><silent><expr> <CR>
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'filer_mychoosewin', 'quit': v:true })<CR>"

  nnoremap <buffer><silent><expr> h
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>" :
        \ "<Cmd>echoe 'cannot close this item'<CR>"

  nnoremap <buffer><silent><expr> l
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('expandItem')<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'vsplit' } })<CR>"

  nnoremap <buffer><silent><expr> L
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('expandItem')<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'split' } })<CR>"

  " change directory aliases
  nnoremap <buffer><silent> <F12> <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand(g:my_initvim_path)    } })<CR>
  nnoremap <buffer><silent> <F11> <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand($HOME . "/repos")     } })<CR>
  nnoremap <buffer><silent> <F10> <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand($HOME . "/Documents") } })<CR>
  nnoremap <buffer><silent> <F9>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand($HOME)                } })<CR>
  nnoremap <buffer><silent> ~     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand($HOME)                } })<CR>

  nnoremap <buffer><silent> <BS>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': '..' } })<CR>

  " ddu actions
  nnoremap <buffer><silent> C     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'cd' })<CR>

  nnoremap <buffer><silent> c     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'copy' })<CR>
  nnoremap <buffer><silent> x     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'cut' })<CR>
  nnoremap <buffer><silent> p     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'paste' })<CR>

  nnoremap <buffer><silent> m     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'move' })<CR>
  nnoremap <buffer><silent> b     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'newFile' })<CR>
  nnoremap <buffer><silent> B     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'newDirectory' })<CR>
  nnoremap <buffer><silent> yy    <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'yank' })<CR>
  nnoremap <buffer><silent> d     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'delete' })<CR>
  nnoremap <buffer><silent> r     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'rename' })<CR>
endfunction

let s:ddu_filer_sources = [
      \   #{
      \     name: 'file',
      \     params: #{},
      \   },
      \ ]
let s:ddu_filer_source_options = #{
      \     _: #{
      \       columns: ['icon_filename'],
      \     },
      \   }
let s:ddu_filer_kind_options = #{
      \   file: #{
      \     defaultAction: 'open',
      \   },
      \ }
let s:ddu_filer_action_options = #{
      \   narrow: #{
      \     quit: v:false,
      \   },
      \ }

let g:floating_ddu_ui_params_default = g:floating_ddu_ui_params
let g:floating_ddu_ui_params_default.border = "rounded"
let g:floating_ddu_ui_params_default.search = expand('%:p')
let g:floating_ddu_ui_params_default.sort = 'filename'
let g:floating_ddu_ui_params_default.sortTreesFirst = v:true
let g:floating_ddu_ui_params_default.splitDirection = "topleft"

let s:ddu_filer_ui_params = #{
      \   _: g:floating_ddu_ui_params_default,
      \   filer: g:floating_ddu_ui_params_default,
      \   icon_filename: #{
      \     span: 2,
      \     padding: 2,
      \     iconWidth: 2,
      \     useLinkIcon: "grayout",
      \     sort: 'filename',
      \     sortTreesFirst: v:true,
      \   }
      \ }

let s:ddu_filer_params = #{
      \   ui: 'filer',
      \   sources: s:ddu_filer_sources,
      \   sourceOptions: s:ddu_filer_source_options,
      \   kindOptions: s:ddu_filer_kind_options,
      \   actionOptions: s:ddu_filer_action_options,
      \   uiParams: s:ddu_filer_ui_params,
      \ }

call ddu#custom#patch_local('filer_1', #{
      \   ui: 'filer',
      \   name: 'filer_1',
      \   sources: s:ddu_filer_sources,
      \   sourceOptions: s:ddu_filer_source_options,
      \   kindOptions: s:ddu_filer_kind_options,
      \   actionOptions: s:ddu_filer_action_options,
      \   uiParams: s:ddu_filer_ui_params,
      \ })
call ddu#custom#patch_local('filer_2', #{
      \   ui: 'filer',
      \   name: 'filer_2',
      \   sources: s:ddu_filer_sources,
      \   sourceOptions: s:ddu_filer_source_options,
      \   kindOptions: s:ddu_filer_kind_options,
      \   actionOptions: s:ddu_filer_action_options,
      \   uiParams: s:ddu_filer_ui_params,
      \ })
call ddu#custom#patch_local('filer_3', #{
      \   ui: 'filer',
      \   name: 'filer_3',
      \   sources: s:ddu_filer_sources,
      \   sourceOptions: s:ddu_filer_source_options,
      \   kindOptions: s:ddu_filer_kind_options,
      \   actionOptions: s:ddu_filer_action_options,
      \   uiParams: s:ddu_filer_ui_params,
      \ })
call ddu#custom#patch_local('filer_4', #{
      \   ui: 'filer',
      \   name: 'filer_4',
      \   sources: s:ddu_filer_sources,
      \   sourceOptions: s:ddu_filer_source_options,
      \   kindOptions: s:ddu_filer_kind_options,
      \   actionOptions: s:ddu_filer_action_options,
      \   uiParams: s:ddu_filer_ui_params,
      \ })

let g:floating_ddu_ui_params_4preference = g:floating_ddu_ui_params_default
let g:floating_ddu_ui_params_4preference.search = expand(g:my_initvim_path)
"
call ddu#custom#action('kind', 'file', 'filer_mychoosewin', { args -> MyDduChooseWin(1, args) })

autocmd TabEnter,WinEnter,CursorHold,FocusGained * call ddu#ui#filer#do_action('checkItems')

autocmd FileType ddu-filer call s:ddu_filer_my_settings()

command! DduFiler call OpenDduFiler(s:current_filer)
nnoremap z       :<C-u>DduFiler<CR>


if g:is_enable_my_debug
  echo "begin /plugins/filer.ddu.vim end"
endif

