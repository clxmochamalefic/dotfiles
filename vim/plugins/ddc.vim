if g:is_enable_my_debug
  echo "begin /plugins/ddc.vim load"
endif

call ddc#custom#patch_global('ui', 'pum')
" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', [
      \   'nvim-lsp',
      \   'around',
      \   'emoji',
      \   'shell-history',
      \ ])

call ddc#custom#patch_global('cmdlineSources', [
      \   'cmdline',
      \   'cmdline-history',
      \   'around',
      \ ])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', #{
      \   _: #{
      \     mark: '| vim',
      \     ignoreCase: v:true,
      \     matchers: ['matcher_fuzzy'],
      \     sorters: ['sorter_fuzzy'],
      \     converters: ['converter_fuzzy'],
      \   },
      \   around: #{
      \     mark: '| Around'
      \   },
      \   nvim-lsp: #{
      \     mark: '| LSP',
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \   },
      \   cmdline: #{
      \     ignoreCase: v:false,
      \     mark: '| Cmdline',
      \     forceCompletionPattern: '\S/\S*',
      \   },
      \   cmdline-history: #{
      \     mark: '| CmdlineHistory',
      \   },
      \   emoji: #{
      \	    mark: '| Emoji',
      \	    matchers: ['emoji'],
      \     forceCompletionPattern: '[a-zA-Z_:]\w*',
      \	    sorters: [],
      \	  },
      \   shell-history: #{
      \     mark: '| ShellHistory',
      \     minKeywordLength: 4,
      \     maxKeywordLength: 50,
      \   },
      \ })

" Add matching patterns
call ddc#custom#patch_global('keywordPattern', '[a-zA-Z_:]\w*')

call ddc#custom#patch_global('sourceParams', #{
      \   around: #{
      \     maxSize: 500
      \   },
      \ })

" Mappings

" Use pum.vim
call ddc#custom#patch_global('autoCompleteEvents', [
      \   'InsertEnter',
      \   'TextChangedI',
      \   'TextChangedP',
      \   'CmdlineEnter',
      \   'CmdlineChanged',
      \   'TermOutput',
      \ ])
call ddc#custom#patch_global('completionMenu', 'pum.vim')

" For insert mode completion
inoremap <silent><expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
inoremap <silent><expr> <C-n>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<C-n>'

inoremap <silent><expr> <CR>
      \ pum#visible() ? ddc#map#manual_complete() : '<CR>'

inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

inoremap <silent><expr> <C-l>   ddc#map#extend()
inoremap <silent><expr> <C-x><C-f> ddc#map#manual_complete('path')

" Use ddc.
call ddc#enable()


if g:is_enable_my_debug
  echo "end /plugins/ddc.vim load"
endif

