if g:is_enable_my_debug
  echo "begin /plugins/ddu.vim load"
endif

let s:ddu_float_window_col = g:float_window_col
let s:ddu_float_window_row = g:float_window_row
let s:ddu_float_window_width = g:float_window_width
let s:ddu_float_window_height = g:float_window_height
let s:ddu_float_window_preview_width = 120
let s:ddu_float_window_preview_col = 0
let s:ddu_float_window_preview_height = s:ddu_float_window_height

let s:floating_ddu_ui_params = #{
      \   span: 2,
      \
      \   split: 'floating',
      \   floatingBorder: 'rounded',
      \   filterFloatingPosition: 'top',
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

autocmd FileType ddu-ff               call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-buffer        call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-mrw           call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-mrw_current   call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-file_old      call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-filter        call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-clip_history  call s:ddu_ff_my_settings()
autocmd FileType ddu-ff-emoji         call s:ddu_ff_my_settings()

function! s:ddu_ff_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> P     <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction


" ddu-ui-filer
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

let s:ddu_filer_ui_params = #{
      \   _: s:floating_ddu_ui_params,
      \   filer: s:floating_ddu_ui_params,
      \   icon_filename: #{
      \     span: 2,
      \     padding: 2,
      \     iconWidth: 2,
      \     useLinkIcon: "grayout",
      \     sort: 'filename',
      \     sortTreesFirst: v:true,
      \   }
      \ }
let s:ddu_filer_ui_params.filer.search = expand('%:p')
let s:ddu_filer_ui_params.filer.sort = 'filename'
let s:ddu_filer_ui_params._.search = expand('%:p')
let s:ddu_filer_ui_params._.sort = 'filename'

call ddu#custom#patch_local('ff_filer', #{
      \   ui: 'filer',
      \   sources: s:ddu_filer_sources,
      \   sourceOptions: s:ddu_filer_source_options,
      \   kindOptions: s:ddu_filer_kind_options,
      \   actionOptions: s:ddu_filer_action_options,
      \   uiParams: s:ddu_filer_ui_params,
      \ })

autocmd TabEnter,WinEnter,CursorHold,FocusGained * call ddu#ui#filer#do_action('checkItems')

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
autocmd FileType ddu-ff_filer call s:ddu_filer_my_settings()


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

  nnoremap <buffer><silent> ~
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': {'path': expand($HOME)} })<CR>
  nnoremap <buffer><silent> ^
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': {'path': expand(g:my_initvim_path)} })<CR>
  nnoremap <buffer><silent> =
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'narrow', 'params': {'path': expand($HOME . "/repos")} })<CR>

  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>

  nnoremap <buffer><silent> <BS>
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>

  nnoremap <buffer><silent> c
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'copy'})<CR>

  nnoremap <buffer><silent> C
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', { 'name': 'cd' })<CR>

  nnoremap <buffer><silent> x
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'cut'})<CR>

  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'paste'})<CR>
  nnoremap <buffer><silent> P
        \ <Cmd>call ddu#ui#filer#do_action('preview')<CR>

  nnoremap <buffer><silent> d
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>

  nnoremap <buffer><silent> r
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'rename'})<CR>

  nnoremap <buffer><silent> R
        \ <Cmd>call ddu#ui#filer#do_action('refreshItems')<Bar>redraw<CR>

  nnoremap <buffer><silent> a
        \ <Cmd>call ddu#ui#filer#do_action('chooseAction')<CR>

  nnoremap <buffer><silent> A
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', #{ name: 'ChooseWin' })<CR>
" nnoremap <buffer><silent> A <Cmd>call ddu#custom#action('kind', 'file', 'test', { args -> execute('let g:foo = 1') })

  nnoremap <buffer><silent> m
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'move'})<CR>

  nnoremap <buffer><silent> b
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newFile'})<CR>

  nnoremap <buffer><silent> B
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newDirectory'})<CR>

  nnoremap <buffer><silent> yy
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'yank'})<CR>

  nnoremap <buffer><silent><expr> h
        \ ddu#ui#filer#is_tree() ? "<Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>" : "<Cmd>echoe 'cannot close this item'<CR>"

  nnoremap <buffer><silent><expr> l
        \ ddu#ui#filer#is_tree() ? "<Cmd>call ddu#ui#filer#do_action('expandItem')<CR>" : "<Cmd>echoe 'cannot open this item'<CR>"

  nnoremap <buffer><silent><expr> L
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open', 'params': {'command': 'split'}})<CR>"

  nnoremap <buffer><silent><expr> O
        \ ddu#ui#filer#is_tree() ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>"

  nnoremap <buffer><silent> <TAB>
        \ <Cmd>call ddu#ui#filer#do_action('expandItem', {'mode': 'toggle'})<CR>

endfunction

command! DduFiler     call ddu#start({ 'name': 'ff_filer' })

nnoremap  ^  :<C-u>DduFiler<CR>


" ddu-source --------------------

" ddu-source-buffer
call ddu#custom#patch_local('buffer', #{
      \   ui: 'ff',
      \   sources: [
      \     #{
      \       name: 'buffer',
      \       params: #{path: $HOME},
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


" ddu-source-custom-list

" LspAction ====================
let s:lsp_actions = {
      \   'SHOW   REFACTOR code actions': #{
      \     name: 'SHOW REFACTOR code actions',
      \     depend: 'Lspsaga',
      \     command: 'code_action',
      \   },
      \   'vim.lsp.buf.declaration()': #{
      \     name: 'vim.lsp.buf.declaration()',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.declaration()',
      \   },
      \   'SHOW  defined source on floating window': #{
      \     name: 'SHOW  defined source on floating window',
      \     depend: 'Lspsaga',
      \     command: 'peek_definition',
      \   },
      \   'JUMP  cursor to defined line FOR PROPERTY': #{
      \     name: 'JUMP cursor to defined line FOR PROPERTY',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.definition()',
      \   },
      \   'vim.lsp.buf.formatting{timeout_ms = 5000, async = true}': #{
      \     name: 'vim.lsp.buf.formatting{timeout_ms = 5000, async = true}',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.formatting{timeout_ms = 5000, async = true}',
      \   },
      \   'SHOW   definition on floating window': #{
      \     name: 'SHOW definition on floating window',
      \     depend: 'Lspsaga',
      \     command: 'hover_doc',
      \   },
      \   'SHOW   implementation source on this BUFFER': #{
      \     name: 'SHOW implementation source on this BUFFER',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.implementation()',
      \   },
      \   'SHOW   reference': #{
      \     name: 'SHOW reference',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.references()',
      \   },
      \   'RENAME on floating window': #{
      \     name: 'EXEC rename by floating window',
      \     depend: 'Lspsaga',
      \     command: 'rename',
      \   },
      \   'JUMP   cursor to defined line FOR TYPE': #{
      \     name: 'JUMP cursor to defined line FOR TYPE',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.type_definition()',
      \   },
      \   'SHOW   diagnostics this line on floating window': #{
      \     name: 'SHOW  diagnostics this line on floating window',
      \     depend: 'Lspsaga',
      \     command: 'show_line_diagnostics',
      \   },
      \   'JUMP   DIAGNOSTICS line NEXT': #{
      \     name: 'JUMP DIAGNOSTICS line NEXT',
      \     depend: 'Lspsaga',
      \     command: 'diagnostic_jump_next',
      \   },
      \   'JUMP   DIAGNOSTICS line PREV': #{
      \     name: 'JUMP DIAGNOSTICS line PREV',
      \     depend: 'Lspsaga',
      \     command: 'diagnostic_jump_prev',
      \   },
      \   'vim.lsp.buf.signature_help()': #{
      \     name: 'vim.lsp.buf.signature_help()',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.signature_help()',
      \   },
      \ }

let s:lsp_action_keys = keys(s:lsp_actions)

function! s:get_evaluated_command(key) abort
  let l:lsp_action = s:lsp_actions[a:key]
  return l:lsp_action.depend . " " . l:lsp_action.command
endfunction

let s:lsp_action_callback_id = denops#callback#register(
      \   { key -> execute(s:get_evaluated_command(key)) },
      \   #{ once: v:false }
      \ )

call ddu#custom#patch_local('lsp_actions', #{
      \   sources: [#{
      \       name: 'custom-list',
      \       params: #{
      \         texts: s:lsp_action_keys,
      \         callbackId: s:lsp_action_callback_id,
      \       }
      \     },
      \   ],
      \   kindOptions: #{ defaultAction: 'callback' },
      \ })

command! LspActions call ddu#start(#{ name: 'lsp_actions' })

" tpope/vim-dadbod

if g:is_enable_my_debug
  echo "begin /plugins/ddu.vim end"
endif

