if g:is_enable_my_debug
  echo "begin /plugins/ff.ddu.vim load"
endif

call ddu#custom#action('kind', 'file', 'ff_mychoosewin', { args -> MyDduChooseWin(0, args) })

let s:current_ff_name = 'buffer'

command! DduFF  call ddu#start({ 'name': s:current_ff_name })
nnoremap Z      :<C-u>DduFF<CR>


function! OpenDduFF(name) abort
  "if a:isRequireWin && !has('win32')
  "  return
  "endif

  echom a:name
  "let s:current_ff_name = a:name
  call ddu#start({ 'name': a:name })
endfunction

call ddu#custom#action('kind', 'file', 'ff_open_buffer',       { args -> OpenDduFF('buffer') })
call ddu#custom#action('kind', 'file', 'ff_open_mrw',          { args -> OpenDduFF('mrw') })
call ddu#custom#action('kind', 'file', 'ff_open_mrw_current',  { args -> OpenDduFF('mrw_current') })
call ddu#custom#action('kind', 'file', 'ff_open_emoji',        { args -> OpenDduFF('emoji') })
call ddu#custom#action('kind', 'file', 'ff_open_clip_history', { args -> OpenDduFF('clip_history') })

"call ddu#custom#action('kind', 'buffer', 'ff_open_buffer',       { args -> OpenDduFF('buffer',        v:false) })
"call ddu#custom#action('kind', 'buffer', 'ff_open_mrw',          { args -> OpenDduFF('mrw',           v:false) })
"call ddu#custom#action('kind', 'buffer', 'ff_open_mrw_current',  { args -> OpenDduFF('mrw_current',   v:false) })
"call ddu#custom#action('kind', 'buffer', 'ff_open_emoji',        { args -> OpenDduFF('emoji',         v:false) })
"call ddu#custom#action('kind', 'buffer', 'ff_open_clip_history', { args -> OpenDduFF('clip_history',  v:true) })

"call ddu#custom#action('kind', 'mrw', 'ff_open_buffer',       { args -> OpenDduFF('buffer',        v:false) })
"call ddu#custom#action('kind', 'mrw', 'ff_open_mrw',          { args -> OpenDduFF('mrw',           v:false) })
"call ddu#custom#action('kind', 'mrw', 'ff_open_mrw_current',  { args -> OpenDduFF('mrw_current',   v:false) })
"call ddu#custom#action('kind', 'mrw', 'ff_open_emoji',        { args -> OpenDduFF('emoji',         v:false) })
"call ddu#custom#action('kind', 'mrw', 'ff_open_clip_history', { args -> OpenDduFF('clip_history',  v:true) })
"
call ddu#custom#action('kind', 'word', 'ff_open_buffer',       { args -> OpenDduFF('buffer',        v:false) })
call ddu#custom#action('kind', 'word', 'ff_open_mrw',          { args -> OpenDduFF('mrw',           v:false) })
call ddu#custom#action('kind', 'word', 'ff_open_mrw_current',  { args -> OpenDduFF('mrw_current',   v:false) })
call ddu#custom#action('kind', 'word', 'ff_open_emoji',        { args -> OpenDduFF('emoji',         v:false) })
call ddu#custom#action('kind', 'word', 'ff_open_clip_history', { args -> OpenDduFF('clip_history',  v:true) })

if has('win32')
  call ddu#custom#action('kind', 'windows-clipboard-history', 'ff_open_buffer',       { args -> OpenDduFF('buffer',        v:false) })
  call ddu#custom#action('kind', 'windows-clipboard-history', 'ff_open_mrw',          { args -> OpenDduFF('mrw',           v:false) })
  call ddu#custom#action('kind', 'windows-clipboard-history', 'ff_open_mrw_current',  { args -> OpenDduFF('mrw_current',   v:false) })
  call ddu#custom#action('kind', 'windows-clipboard-history', 'ff_open_emoji',        { args -> OpenDduFF('emoji',         v:false) })
  call ddu#custom#action('kind', 'windows-clipboard-history', 'ff_open_clip_history', { args -> OpenDduFF('clip_history',  v:true) })
endif

autocmd FileType ddu-ff               call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-buffer        call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-mrw           call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-mrw_current   call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-emoji         call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-clip_history  call s:ddu_ff_my_settings()
function! s:ddu_ff_my_settings() abort
  nnoremap <buffer><silent> z     <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'ff_open_buffer',       'quit': v:true })<CR>
  nnoremap <buffer><silent> x     <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'ff_open_mrw',          'quit': v:true })<CR>
  nnoremap <buffer><silent> c     <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'ff_open_mrw_current',  'quit': v:true })<CR>
  nnoremap <buffer><silent> v     <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'ff_open_emoji',        'quit': v:true })<CR>
  if has('win32')
    nnoremap <buffer><silent> b   <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'ff_open_clip_history', 'quit': v:true })<CR>
  endif
  "nnoremap <buffer><silent>   <F12> <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_buffer',       'quit': v:true })<CR>
  "nnoremap <buffer><silent>   <F11> <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw',          'quit': v:true })<CR>
  "nnoremap <buffer><silent>   <F10> <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_mrw_current',  'quit': v:true })<CR>
  "nnoremap <buffer><silent>   <F9>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_emoji',        'quit': v:true })<CR>
  "if has('win32')
  "  nnoremap <buffer><silent> <F8>  <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'open_clip_history', 'quit': v:true })<CR>
  "endif

  nnoremap <buffer><silent> <CR>    <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'ff_mychoosewin', 'quit': v:true })<CR>
  nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i       <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> P       <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  nnoremap <buffer><silent> q       <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent><expr> l <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'vsplit'}, 'quit': v:true })<CR>
  nnoremap <buffer><silent><expr> L <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'split'},  'quit': v:true })<CR>
  nnoremap <buffer><silent> d       <Cmd>call ddu#ui#ff#do_action('itemAction', { 'name': 'delete' })<CR>
endfunction

" ddu-source-buffer
call ddu#custom#patch_local('buffer', #{
      \   ui: 'ff',
      \   sources: [
      \     #{
      \       name: 'buffer',
      \       params: #{ path: $HOME },
      \     },
      \   ],
      \   sourceOptions: #{
      \     _: #{
      \       columns: ['icon_filename'],
      \     },
      \   },
      \   kindOptions: #{
      \     buffer: #{
      \       defaultAction: 'open',
      \     },
      \   },
      \   uiParams: #{
      \     buffer: g:floating_ddu_ui_params,
      \   }
      \ })

command! DduBuffer call ddu#start({ 'name': 'buffer' })

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
      \     file_old: g:floating_ddu_ui_params,
      \   }
      \ })

command! DduFileOld call ddu#start(#{ name: 'file_old' })

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
      \     emoji: g:floating_ddu_ui_params,
      \   }
      \ })

command! DduEmoji call ddu#start({ 'name': 'emoji' })

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


" windows-clipboard-history

if has('win32')
  call ddu#custom#patch_local('clip_history', #{
        \   ui: 'ff',
        \   sources: [
        \     #{
        \       name: 'windows-clipboard-history',
        \       params: #{ prefix: 'Clip:' },
        \     }
        \   ],
        \})

  command! DduClip call ddu#start({ 'name': 'clip_history' })
endif

if g:is_enable_my_debug
  echo "begin /plugins/ff.ddu.vim end"
endif

