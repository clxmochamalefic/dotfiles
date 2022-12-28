"---------------------------------------------------------------------------
" dein GLOBAL PREFERENCE

let g:dein#install_progress_type = 'floating'

let s:dein_toml_path = g:my_initvim_path . '/dein/'

" plugin preference file open mapping
let g:dein_toml_filepath        = s:dein_toml_path . 'dein.toml'
let g:colorscheme_filepath      = s:dein_toml_path . 'colorscheme.toml'
let g:dein_lazy_toml_filepath   = s:dein_toml_path . 'dein.lazy.toml'
let g:ddc_lazy_toml_filepath    = s:dein_toml_path . 'ddc.lazy.toml'
let g:ddu_lazy_toml_filepath    = s:dein_toml_path . 'ddu.lazy.toml'
let g:lsp_lazy_toml_filepath    = s:dein_toml_path . 'lsp.lazy.toml'

" plugin list
let g:dein_plugins = [
  \ expand(g:dein_toml_filepath),
  \ expand(g:colorscheme_filepath),
  \ expand(g:dein_lazy_toml_filepath),
  \ expand(g:ddc_lazy_toml_filepath),
  \ expand(g:ddu_lazy_toml_filepath),
  \ expand(g:lsp_lazy_toml_filepath),
  \ ]

if g:is_enable_my_debug
  echo "begin dein.vim load"
endif

"---------------------------------------------------------------------------
" dein exec

" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" add dein repo dir path to runtimepath
execute 'set runtimepath+=' . s:dein_repo_dir

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
    call s:dein_add_wrapper(g:dein_lazy_toml_filepath)
    call s:dein_add_wrapper(g:ddc_lazy_toml_filepath)
    call s:dein_add_wrapper(g:ddu_lazy_toml_filepath)
    call s:dein_add_wrapper(g:lsp_lazy_toml_filepath)

    call dein#end()
    call dein#save_state()
  endif

  " その他インストールしていないものはこちらに入れる
  "if dein#check_install()
  "  call dein#install()
  "endif

  " remove plugin on toml undefined 
  call map(dein#check_clean(), "delete(v:val, 'rf')")
endfunction

function! s:reload_plugin_hard(tomls) abort
  call dein#clear_state()
  call s:reload_plugin(a:tomls)
endfunction

command! ReloadPluginHard execute s:reload_plugin_hard(g:dein_plugins)
command! Rel ReloadPluginHard

" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。
call s:reload_plugin(g:dein_plugins)

if g:is_enable_my_debug
  echo "end dein.vim load"
endif
