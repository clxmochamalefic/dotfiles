if g:is_enable_my_debug
  echo "begin /plugins/ddu.vim load"
endif

let s:ddu_float_window_col            = g:float_window_col
let s:ddu_float_window_row            = g:float_window_row
let s:ddu_float_window_width          = g:float_window_width
let s:ddu_float_window_height         = g:float_window_height
let s:ddu_float_window_preview_width  = 120
let s:ddu_float_window_preview_col    = 0
let s:ddu_float_window_preview_height = s:ddu_float_window_height

let s:floating_ddu_ui_params = #{
      \   span: 2,
      \
      \   split: 'floating',
      \   floatingBorder: 'rounded',
      \   filterFloatingPosition: 'bottom',
      \   filterSplitDirection: 'floating',
      \   winRow: s:ddu_float_window_row,
      \   winCol: s:ddu_float_window_col,
      \   winWidth: s:ddu_float_window_width,
      \   winHeight: s:ddu_float_window_height,
      \
      \   previewFloating: v:true,
      \   previewVertical: v:true,
      \   previewFloatingBorder: 'rounded',
      \   previewFloatingZindex: 10000,
      \   previewCol: s:ddu_float_window_preview_col,
      \   previewWidth: s:ddu_float_window_preview_width,
      \   previewHeight: s:ddu_float_window_preview_height,
      \ }

" ddu.vim ------------------------------
call ddu#custom#patch_global(#{
      \   ui: 'ff',
      \   sources: [
      \     #{ name: 'file_rec', params: #{} },
      \     #{ name: 'file' },
      \     #{ name: 'buffer' },
      \     #{ name: 'emoji' },
      \   ],
      \   sourceOptions: #{
      \     _: #{
      \       columns: ['icon_filename'],
      \       matchers: ['matcher_substring'],
      \     },
      \     dein_update: #{
      \       matchers: ['matcher_dein_update'],
      \     },
      \   },
      \   filterParams: #{
      \     matcher_substring: #{
      \       highlightMatched: 'Search',
      \     },
      \   },
      \   kindOptions: #{
      \     file: #{
      \       defaultAction: 'open',
      \     },
      \     file_old: #{
      \       defaultAction: 'open',
      \     },
      \     file_rec: #{
      \       defaultAction: 'open',
      \     },
      \     action: #{
      \       defaultAction: 'do',
      \     },
      \     word: #{
      \       defaultAction: 'append',
      \     },
      \     dein_update: #{
      \       defaultAction: 'viewDiff',
      \     },
      \     custom-list: #{
      \       defaultAction: 'callback',
      \     },
      \   },
      \   uiParams: #{
      \     _: s:floating_ddu_ui_params,
      \   },
      \   actionOptions: #{
      \     echo: #{
      \       quit: v:false,
      \     },
      \     echoDiff: #{
      \       quit: v:false,
      \     },
      \   },
      \ })


" ddu-ui --------------------

" ddu-ui-ff
if has('macunix')
  command "brew install desktop-file-utils"
endif

function! s:win_all()
  return range(1, winnr('$'))
endfunction

function! MyDduChooseWin(src, args)

  try
    let l:path = a:args.items[0].action.path
    call choosewin#start(s:win_all(), {'auto_choose': v:true, 'hook_enable': v:false})
    execute 'edit ' . l:path
  catch /.*/
    if a:src == 0
      "call ddu#ui#ff#do_action('itemAction')
      call ddu#ui#ff#do_action('itemAction', args)
    else
      "call ddu#ui#filer#do_action('itemAction')
      call ddu#ui#filer#do_action('itemAction', args)
    endif
  endtry

endfunction

call ddu#custom#action('kind', 'file', 'ff_mychoosewin', { args -> MyDduChooseWin(0, args) })


autocmd FileType ddu-ff               call s:ddu_ff_my_settings()
function! s:ddu_ff_my_settings() abort
  nnoremap <buffer><silent> <CR>    <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'ff_mychoosewin', 'quit': v:true })<CR>
  nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i       <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> P       <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  nnoremap <buffer><silent> q       <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent><expr> l <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'vsplit'}, 'quit': v:true })<CR>
  nnoremap <buffer><silent><expr> L <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'split'},  'quit': v:true })<CR>
  nnoremap <buffer><silent> d       <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'delete' })<CR>
endfunction

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
  nnoremap <buffer><silent> R     <Cmd>call ddu#ui#filer#do_action('refreshItems')<Bar>redraw<CR>
  nnoremap <buffer><silent> a     <Cmd>call ddu#ui#filer#do_action('chooseAction')<CR>
  nnoremap <buffer><silent> P     <Cmd>call ddu#ui#filer#do_action('preview')<CR>

  nnoremap <buffer><silent> <F1>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer1', 'params': { 'id': 0 }, 'quit': v:true })<CR>
  nnoremap <buffer><silent> <F2>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer2', 'params': { 'id': 1 }, 'quit': v:true })<CR>
  nnoremap <buffer><silent> <F3>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer3', 'params': { 'id': 2 }, 'quit': v:true })<CR>
  nnoremap <buffer><silent> <F4>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_filer4', 'params': { 'id': 3 }, 'quit': v:true })<CR>
  "nnoremap <buffer><silent> <F1>  <Cmd>call OpenDduFiler(0)<CR>
  "nnoremap <buffer><silent> <F2>  <Cmd>call OpenDduFiler(1)<CR>
  "nnoremap <buffer><silent> <F3>  <Cmd>call OpenDduFiler(2)<CR>
  "nnoremap <buffer><silent> <F4>  <Cmd>call OpenDduFiler(3)<CR>


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
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open', params: { 'command': 'vsplit' } })<CR>"

  nnoremap <buffer><silent><expr> L
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('expandItem')<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open', params: { 'command': 'split' } })<CR>"

  " change directory aliases
  nnoremap <buffer><silent> ~     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand($HOME) } })<CR>
  nnoremap <buffer><silent> ^     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand(g:my_initvim_path) } })<CR>
  nnoremap <buffer><silent> =     <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': expand($HOME . "/repos") } })<CR>
  nnoremap <buffer><silent> <BS>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': { 'path': '..' } })<CR>
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

let s:floating_ddu_ui_params_default = s:floating_ddu_ui_params
let s:floating_ddu_ui_params_default.border = "rounded"
let s:floating_ddu_ui_params_default.search = expand('%:p')
let s:floating_ddu_ui_params_default.sort = 'filename'
let s:floating_ddu_ui_params_default.sortTreesFirst = v:true
let s:floating_ddu_ui_params_default.splitDirection = "topleft"

let s:ddu_filer_ui_params = #{
      \   _: s:floating_ddu_ui_params_default,
      \   filer: s:floating_ddu_ui_params_default,
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

let s:floating_ddu_ui_params_4preference = s:floating_ddu_ui_params_default
let s:floating_ddu_ui_params_4preference.search = expand(g:my_initvim_path)
"
call ddu#custom#action('kind', 'file', 'filer_mychoosewin', { args -> MyDduChooseWin(1, args) })

autocmd TabEnter,WinEnter,CursorHold,FocusGained * call ddu#ui#filer#do_action('checkItems')

autocmd FileType ddu-filer call s:ddu_filer_my_settings()

command! DduFiler call OpenDduFiler(s:current_filer)
nnoremap ^       :<C-u>DduFiler<CR>


" ddu-source --------------------

" ddu-source-buffer
call ddu#custom#patch_local('buffer', #{
      \   ui: 'ff',
      \   sources: [
      \     #{
      \       name: 'buffer',
      \       params: #{ path: $HOME },
      \     },
      \   ],
      \   kindOptions: #{
      \     buffer: #{
      \       defaultAction: 'open',
      \     },
      \   },
      \   uiParams: #{
      \     buffer: s:floating_ddu_ui_params,
      \   }
      \ })

command! DduBuffer call ddu#start({ 'name': 'buffer' })
nnoremap  \  :<C-u>DduBuffer<CR>


" ddu-source-file_old
call ddu#custom#patch_local('file_old', #{
      \   ui: 'ff',
      \   sources: [
      \     #{
      \       name: 'file_old',
      \       params: #{},
      \     },
      \   ],
      \   kindOptions: #{
      \     file_old: #{
      \       defaultAction: 'open',
      \     },
      \   },
      \   uiParams: #{
      \     file_old: s:floating_ddu_ui_params,
      \   }
      \ })

command! DduFileOld call ddu#start(#{ name: 'file_old' })
"nnoremap  \|  :<C-u>DduFileOld<CR>


" ddu-source-emoji
call ddu#custom#patch_local('emoji', #{
      \   sources: [
      \     #{
      \       name: 'emoji',
      \       params: {},
      \     },
      \   ],
      \   kindOptions: #{
      \     emoji: {
      \       'defaultAction': 'append',
      \     },
      \     word: {
      \       'defaultAction': 'append',
      \     },
      \   },
      \   uiParams: #{
      \     emoji: s:floating_ddu_ui_params,
      \   }
      \ })

command! DduEmoji call ddu#start({ 'name': 'emoji' })

" Insert emoji mapping.
inoremap <C-x><C-e> <Cmd>call ddu#start({'sources': [{'name': 'emoji'}]})<CR>


" ddu-source-mrw
let mrw_source = #{
      \   name: 'mr',
      \   params: #{ kind: 'mrw' },
      \ }
call ddu#custom#patch_local('mrw', #{
      \   ui: 'ff',
      \   sources: [
      \     mrw_source,
      \   ],
      \   kindOptions: #{
      \     mrw: #{
      \       defaultAction: 'open',
      \     },
      \   },
      \ })

command! DduMrw call ddu#start({ 'name': 'mrw' })

" Insert emoji mapping.
nnoremap  \|  :<C-u>DduMrw<CR>

let mrw_source = #{
      \   name: 'mr',
      \   params: #{ kind: 'mrw', current: v:true },
      \ }
call ddu#custom#patch_local('mrw_current', #{
      \   ui: 'ff',
      \   sources: [
      \     mrw_source,
      \   ],
      \   kindOptions: #{
      \     mrw: #{
      \       defaultAction: 'open',
      \     },
      \   },
      \ })

command! DduMrwCurrent call ddu#start({ 'name': 'mrw_current' })

" Insert emoji mapping.
nnoremap  ~  :<C-u>DduMrwCurrent<CR>


" windows-clipboard-history

if has('win32')
  call ddu#custom#patch_local('clip-history', #{
        \   ui: 'ff',
        \   sources: [
        \     #{
        \       name: 'windows-clipboard-history',
        \       params: #{ prefix: 'Clip:' },
        \     }
        \   ],
        \   kindOptions: #{
        \     mrw: #{
        \       defaultAction: 'open',
        \     },
        \   },
        \})

  command! DduClip call ddu#start({ 'name': 'clip-history' })

  " Insert emoji mapping.
  nnoremap  .  :<C-u>DduClip<CR>
endif

let s:current_filer = 0

let s:filers = ['filer_1', 'filer_2', 'filer_3', 'filer_4', ]
function! OpenDduFiler(window_id) abort
  let s:current_filer = a:window_id
  let l:name = s:filers[a:window_id]
  call ddu#start({ 'name': l:name })
endfunction

" tpope/vim-dadbod

if g:is_enable_my_debug
  echo "begin /plugins/ddu.vim end"
endif

