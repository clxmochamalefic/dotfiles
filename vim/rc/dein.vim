"---------------------------------------------------------------------------
" dein GLOBAL PREFERENCE

let g:dein#install_progress_type = 'floating'

let s:dein_toml_path = g:my_initvim_path . '/dein/'

" plugin preference file open mapping
let g:dein_toml_filepath          = s:dein_toml_path . 'dein.toml'

let g:colorscheme_filepath        = s:dein_toml_path . 'colorscheme.toml'
let g:statusline_filepath         = s:dein_toml_path . 'statusline.toml'

let g:dein_lazy_toml_filepath     = s:dein_toml_path . 'dein.lazy.toml'

let g:ddc_lazy_toml_filepath      = s:dein_toml_path . 'ddc.lazy.toml'
let g:ddu_lazy_toml_filepath      = s:dein_toml_path . 'ddu.lazy.toml'

let g:git_lazy_toml_filepath      = s:dein_toml_path . 'git.lazy.toml'
let g:lsp_lazy_toml_filepath      = s:dein_toml_path . 'lsp.lazy.toml'
let g:db_lazy_toml_filepath       = s:dein_toml_path . 'db.lazy.toml'

let g:floating_lazy_toml_filepath = s:dein_toml_path . 'floating.lazy.toml'
let g:nui_lazy_toml_filepath      = s:dein_toml_path . 'nui.lazy.toml'
let g:ui_lazy_toml_filepath       = s:dein_toml_path . 'ui.lazy.toml'

" plugin list
let g:dein_plugins = [
  \ expand(g:dein_toml_filepath),
  \
  \ expand(g:colorscheme_filepath),
  \ expand(g:statusline_filepath),
  \
  \ expand(g:dein_lazy_toml_filepath),
  \
  \ expand(g:ddc_lazy_toml_filepath),
  \ expand(g:ddu_lazy_toml_filepath),
  \
  \ expand(g:git_lazy_toml_filepath),
  \ expand(g:lsp_lazy_toml_filepath),
  \ expand(g:db_lazy_toml_filepath),
  \
  \ expand(g:floating_lazy_toml_filepath),
  \ expand(g:nui_lazy_toml_filepath),
  \ expand(g:ui_lazy_toml_filepath),
  \ ]

if g:is_enable_my_debug
  echo "begin dein.vim load"
endif

"---------------------------------------------------------------------------
" dein exec

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

" load plugins
function! s:dein_add_wrapper(toml) abort
  if g:is_enable_my_debug
    echo "load " . a:toml
  endif
  let l:is_lazy = stridx(a:toml, '.lazy.toml') > -1 ? 1 : 0
  call dein#load_toml(a:toml, {'lazy': l:is_lazy})
endfunction

function! s:reload_plugin(tomls) abort
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "for toml in a:tomls
    "  let l:is_lazy = stridx(toml, '.lazy.toml') > -1 ? 1 : 0
    "  call dein#load_toml(toml, {'lazy': l:is_lazy})
    "endfor
    call s:dein_add_wrapper(g:dein_toml_filepath)

    call s:dein_add_wrapper(g:colorscheme_filepath)
    call s:dein_add_wrapper(g:statusline_filepath)

    call s:dein_add_wrapper(g:dein_lazy_toml_filepath)

    call s:dein_add_wrapper(g:ddc_lazy_toml_filepath)
    call s:dein_add_wrapper(g:ddu_lazy_toml_filepath)

    call s:dein_add_wrapper(g:git_lazy_toml_filepath)
    call s:dein_add_wrapper(g:lsp_lazy_toml_filepath)
    call s:dein_add_wrapper(g:db_lazy_toml_filepath)

    call s:dein_add_wrapper(g:floating_lazy_toml_filepath)
    call s:dein_add_wrapper(g:nui_lazy_toml_filepath)
    call s:dein_add_wrapper(g:ui_lazy_toml_filepath)

    call dein#end()
    call dein#save_state()
  endif

  " その他インストールしていないものはこちらに入れる
  if dein#check_install()
    call dein#install()
  endif

  " remove plugin on toml undefined 
  call map(dein#check_clean(), "delete(v:val, 'rf')")
endfunction

function! s:reload_plugin_hard(tomls) abort
  call dein#clear_state()
  call s:reload_plugin(a:tomls)
endfunction


function! s:reload_plugin_preference() abort
  let l:filelist =  expand(g:my_initvim_path . "/plugins/*.vim")
  let l:splitted = split(l:filelist, "\n")
  for l:file in l:splitted
    runtime l:file
  endfor
endfunction

command! ReloadPluginHard execute s:reload_plugin_hard(g:dein_plugins)
command! Rel ReloadPluginHard

command! ReloadPluginPreference execute s:reload_plugin_hard(g:dein_plugins)
command! Rep ReloadPluginHard

" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。
call s:reload_plugin(g:dein_plugins)

if g:is_enable_my_debug
  echo "end dein.vim load"
endif
