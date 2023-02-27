if g:is_enable_my_debug
  echo "begin /plugins/ddc.vim load"
endif

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
let s:sources = [
      \   'around',
      \   'buffer',
      \   'file',
      \   'nvim-lsp',
      \   'vsnip',
      \ ]

let s:cmd_sources = {
      \   ':': ['cmdline-history', 'cmdline', 'around'],
      \   '@': ['cmdline-history', 'input', 'file', 'around'],
      \   '>': ['cmdline-history', 'input', 'file', 'around'],
      \   '/': ['around', 'line'],
      \   '?': ['around', 'line'],
      \   '-': ['around', 'line'],
      \   '=': ['input'],
      \ }

"if has('win32')
"  let s:sources = add(s:sources, 'windows-clipboard-history')
"endif

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
let s:sourceOptions = {}

let s:sourceOptions["_"] = #{
      \   mark: '   ',
      \   ignoreCase: v:true,
      \   matchers: ['matcher_fuzzy'],
      \   sorters: ['sorter_fuzzy'],
      \   converters: [
      \     'converter_remove_overlap',
      \     'converter_truncate',
      \     'converter_fuzzy',
      \   ],
      \   maxItems: 10,
      \ }

let s:sourceOptions["around"] = #{
      \   mark: '   ',
      \   isVolatile: v:true,
      \   matchers:   ['matcher_fuzzy'],
      \   sorters:    ['sorter_fuzzy'],
      \   converters: ['converter_fuzzy'],
      \   maxItems: 8,
      \ }

let s:sourceOptions['buffer'] = #{
      \   mark: '   ',
      \   isVolatile: v:true,
      \   matchers:   ['matcher_fuzzy'],
      \   sorters:    ['sorter_fuzzy'],
      \   converters: ['converter_fuzzy']
      \ }

let s:sourceOptions['file'] = #{
      \   mark: '   ',
      \   forceCompletionPattern: '[\w@:~._-]/[\w@:~._-]*',
      \   minAutoCompleteLength: 2,
      \   sorters: ['sorter_fuzzy'],
      \ }

let s:sourceOptions["nvim-lsp"] = #{
      \   mark: '   ',
      \   isVolatile: v:true,
      \   forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \   matchers:   ['matcher_fuzzy'],
      \   sorters:    ['sorter_fuzzy'],
      \   converters: ['converter_fuzzy']
      \ }
let s:sourceOptions["omni"] = #{
      \   mark: '   ',
      \ }

"let s:sourceOptions['path'] = #{
"      \   mark: '   ',
"      \   forceCompletionPattern: '[\w@:~._-]/[\w@:~._-]*',
"      \   minAutoCompleteLength: 2,
"      \   sorters: ['sorter_fuzzy'],
"      \ }

let s:sourceOptions['vsnip'] = #{
      \   mark: '   ',
      \   dup: v:true,
      \   matchers:   ['matcher_fuzzy'],
      \   sorters:    ['sorter_fuzzy'],
      \   converters: ['converter_fuzzy']
      \ }


let s:sourceOptions["cmdline-history"] = #{
      \   mark: '   ',
      \   isVolatile: v:true,
      \   matchers:   ['matcher_fuzzy'],
      \   sorters:    ['sorter_fuzzy'],
      \   converters: ['converter_fuzzy']
      \ }

let s:sourceOptions["shell-history"] = #{
      \   mark: '   ',
      \   isVolatile: v:true,
      \   minKeywordLength: 2,
      \   maxKeywordLength: 50,
      \   matchers:   ['matcher_fuzzy'],
      \   sorters:    ['sorter_fuzzy'],
      \   converters: ['converter_fuzzy']
      \ }

"if has('win32')
"  let s:source_options["windows-clipboard-history"] = #{ mark: '', }
"endif

let s:sourceParams = {}

let s:sourceParams['around'] = #{
      \   maxSize:    500,
      \ }

let s:sourceParams['buffer'] = #{
      \   requireSameFiletype: v:false,
      \   fromAltBuf: v:true,
      \   bufNameStyle: 'basename',
      \ }

let s:sourceParams['file'] = #{
      \   trailingSlash: v:true,
      \   followSymlinks: v:true,
      \ }

"let s:sourceParams['path'] = #{
"      \   cmd: ['fd', '--max-depth', '5'],
"      \ }

let s:sourceParams['nvim-lsp'] = #{
      \   maxSize:    20,
      \ }

"if has('win32')
"  let s:source_params["windows-clipboard-history"] = #{
"    \   maxSize: 100,
"    \   maxAbbrWidth: 100,
"    \ }
"endif
"
let s:filterParams = {}
let s:filterParams['matcher_fuzzy'] = #{
      \   splitMode: 'word'
      \ }

let s:filterParams['converter_fuzzy'] = #{
      \   hlGroup: 'SpellBad'
      \ }

let s:filterParams["converter_truncate"] = #{
      \   maxAbbrWidth: 40,
      \   maxInfoWidth: 40,
      \   maxKindWidth: 20,
      \   maxMenuWidth: 20,
      \   ellipsis: '..',
      \ }


" Filetype
call ddc#custom#patch_filetype(['toml'], #{
      \   sourceOptions: {
      \     "nvim-lsp": #{ forceCompletionPattern: '\.|[=#{[,"]\s*' },
      \ }})

call ddc#custom#patch_filetype(
      \ [
      \   'python', 'typescript', 'typescriptreact', 'rust', 'markdown', 'yaml',
      \   'json', 'sh', 'lua', 'toml', 'go'
      \ ], #{
      \   sources: extend(['nvim-lsp'], s:sources),
      \ })


" integrate preferences.
let s:patch_global = {}
let s:patch_global.sources = s:sources
let s:patch_global.cmdlineSources = s:cmd_sources
let s:patch_global.sourceOptions  = s:sourceOptions
let s:patch_global.sourceParams   = s:sourceParams 
let s:patch_global.filterParams   = s:filterParams 
let s:patch_global.backspaceCompletion = v:true

" set other preferences
let s:patch_global.autoCompleteEvents = [
      \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
      \ 'CmdlineEnter', 'CmdlineChanged',
      \ ]
let s:patch_global.ui = 'pum'

call ddc#custom#patch_global(s:patch_global)


" Key mappings

" For insert mode completion
inoremap <silent><expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
inoremap <silent><expr> <C-n>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<TAB>'
inoremap <silent><expr> <C-p>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<TAB>'

inoremap <silent><expr> <CR>
      \ pum#visible() ? ddc#map#manual_complete() : '<CR>'

inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

inoremap <silent><expr> <C-l>       ddc#map#extend()
inoremap <silent><expr> <C-x><C-f>  ddc#map#manual_complete('path')


nnoremap :       <Cmd>call CommandlinePre()<CR>:

function! CommandlinePre() abort
  cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
  cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
  cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  call ddc#custom#patch_buffer('cmdlineSources',
        \ ['necovim', 'around'])

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()
  autocmd InsertEnter <buffer> ++once call CommandlinePost()

  " Enable command line completion
  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  silent! cunmap <Tab>
  silent! cunmap <S-Tab>
  silent! cunmap <C-n>
  silent! cunmap <C-p>
  silent! cunmap <C-y>
  silent! cunmap <C-e>

  " Restore sources
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif
endfunction


" use ddc.
call ddc#enable()

if g:is_enable_my_debug
  echo "end /plugins/ddc.vim load"
endif

