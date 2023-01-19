if g:is_enable_my_debug
  echo "begin /plugins/ddu.vim load"
endif

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
      \     _: #{
      \       span: 2,
      \     },
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
      \     filer: #{
      \       search: expand('%:p'),
      \       sort: 'filename',
      \       span: 2,
      \       sortTreesFirst: v:true,
      \     },
      \     icon_filename: #{
      \       span: 2,
      \     },
      \   }

call ddu#custom#patch_local('filer', #{
      \   ui: 'filer',
      \   sources: s:ddu_filer_sources,
      \   sourceOptions: s:ddu_filer_source_options,
      \   kindOptions: s:ddu_filer_kind_options,
      \   actionOptions: s:ddu_filer_action_options,
      \   uiParams: s:ddu_filer_ui_params,
      \ })

autocmd TabEnter,CursorHold,FocusGained <buffer>
      \ call ddu#ui#filer#do_action('checkItems')

autocmd FileType ddu-filer          call s:ddu_filer_my_settings()

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

  nnoremap <buffer><silent> x
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'cut'})<CR>

  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'paste'})<CR>

  nnoremap <buffer><silent> d
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>

  nnoremap <buffer><silent> r
        \ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'rename'})<CR>

  nnoremap <buffer><silent> R
        \ <Cmd>call ddu#ui#filer#do_action('refreshItems')<Bar>redraw<CR>

  nnoremap <buffer><silent> a
        \ <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>

  nnoremap <buffer><silent> A
        \ <Cmd>call ddu#ui#ff#do_action('itemAction', #{ name: 'ChooseWin' })<CR>

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

  nnoremap <buffer><silent> <TAB>
        \ <Cmd>call ddu#ui#filer#do_action('expandItem', {'mode': 'toggle'})<CR>

endfunction

command! DduFiler     call ddu#start({ 'name': 'filer' })

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
      \     buffer: #{
      \       span: 2,
      \     },
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
      \     file_old: #{
      \       search: expand($HOME),
      \       span: 2,
      \     },
      \   }
      \ })

command! DduFileOld call ddu#start(#{ name: 'file_old' })
nnoremap  \|  :<C-u>DduFileOld<CR>


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
      \     emoji: #{
      \       span: 2,
      \     },
      \   }
      \ })

command! DduEmoji call ddu#start({ 'name': 'emoji' })

" Insert emoji mapping.
inoremap <C-x><C-e> <Cmd>call ddu#start({'sources': [{'name': 'emoji'}]})<CR>


" ddu-source-custom-list

" LspAction ====================
let s:lsp_actions = {
      \   'SHOW REFACTOR code actions': #{
      \     name: 'SHOW REFACTOR code actions',
      \     depend: 'Lspsaga',
      \     command: 'code_action',
      \   },
      \   'vim.lsp.buf.declaration()': #{
      \     name: 'vim.lsp.buf.declaration()',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.declaration()',
      \   },
      \   'SHOW defined source on floating window': #{
      \     name: 'SHOW defined source on floating window',
      \     depend: 'Lspsaga',
      \     command: 'peek_definition',
      \   },
      \   'JUMP cursor to defined line FOR PROPERTY': #{
      \     name: 'JUMP cursor to defined line FOR PROPERTY',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.definition()',
      \   },
      \   'vim.lsp.buf.formatting{timeout_ms = 5000, async = true}': #{
      \     name: 'vim.lsp.buf.formatting{timeout_ms = 5000, async = true}',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.formatting{timeout_ms = 5000, async = true}',
      \   },
      \   'SHOW definition on floating window': #{
      \     name: 'SHOW definition on floating window',
      \     depend: 'Lspsaga',
      \     command: 'hover_doc',
      \   },
      \   'SHOW implementation source on this BUFFER': #{
      \     name: 'SHOW implementation source on this BUFFER',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.implementation()',
      \   },
      \   'SHOW reference': #{
      \     name: 'SHOW reference',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.references()',
      \   },
      \   'EXEC rename by floating window': #{
      \     name: 'EXEC rename by floating window',
      \     depend: 'Lspsaga',
      \     command: 'rename',
      \   },
      \   'JUMP cursor to defined line FOR TYPE': #{
      \     name: 'JUMP cursor to defined line FOR TYPE',
      \     depend: 'lua',
      \     command: 'vim.lsp.buf.type_definition()',
      \   },
      \   'SHOW diagnostics this line on floating window': #{
      \     name: 'SHOW diagnostics this line on floating window',
      \     depend: 'Lspsaga',
      \     command: 'show_line_diagnostics',
      \   },
      \   'JUMP DIAGNOSTICS line NEXT': #{
      \     name: 'JUMP DIAGNOSTICS line NEXT',
      \     depend: 'Lspsaga',
      \     command: 'diagnostic_jump_next',
      \   },
      \   'JUMP DIAGNOSTICS line PREV': #{
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

