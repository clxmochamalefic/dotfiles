if g:is_enable_my_debug
  echo "begin " . expand('%/h') . " load"
endif

"+++++++++++++++
" define command

" jq command
" if cannot use
"   windows       : > pwsh -command "Start-Process -verb runas pwsh" "'-command winget install stedolan.jq'"
"   brew on macOS : % brew install jq
"   linux (debian): $ sudo apt -y update
"                   $ sudo apt -y install jq
"   linux (RHEL)  : $ sudo yum -y install epel-release
"                   $ sudo yum -y install jq
command! Jqf !jq '.'
command! Jq !jq '%:p'

" preference file open mapping
let s:ginitvim_filepath = g:my_initvim_path . '/ginit.vim'
let s:initvim_filepath  = g:my_initvim_path . '/init.vim'


" plugin preference file open mapping
let s:dein_toml_path  = g:my_initvim_path . '/dein/'

let s:dein_toml_filepath        = s:dein_toml_path . 'dein.toml'
let s:dein_lazy_toml_filepath   = s:dein_toml_path . 'dein.lazy.toml'
let s:ddc_lazy_toml_filepath    = s:dein_toml_path . 'ddc.lazy.toml'
let s:ddu_lazy_toml_filepath    = s:dein_toml_path . 'ddu.lazy.toml'
let s:lsp_lazy_toml_filepath    = s:dein_toml_path . 'lsp.lazy.toml'
let s:colorscheme_filepath      = s:dein_toml_path . 'colorscheme.toml'

" init.vim open
command! Preferences execute 'e ' . s:initvim_filepath
command! Pref Preferences
command! Pr Preferences

" ginit.vim open
command! PreferencesGui execute 'e ' . s:ginitvim_filepath
command! PrefGui Preferences
command! Pg PreferencesGui

" dein.toml open
command! Plugins execute 'e ' . s:basic_plugin_filepath
command! Plu Plugins

" dein_lazy.toml open
command! PluginsLazy execute 'e ' . s:lazy_load_plugin_filepath
command! Pll PluginsLazy

" themes.toml open
command! PluginsTheme execute 'e ' . s:theme_plugin_filepath
command! Pt PluginsTheme

" init.vim reload
if !exists('*reload_functions')
  let &stl.='%{reload_functions}'
  function! s:reload_preference() abort
    if has("gui_running")
      execute 'source ' . s:ginitvim_filepath
    endif
    execute 'call dein#call_hook("add")'
  endfunction
  function! s:reload_all() abort
    call s:reload_preference()
    call s:reload_plugin_hard(g:dein_plugins)
  endfunction
endif

command! ReloadPreference execute s:reload_preference()
command! Rer ReloadPreference
command! ReloadAll execute s:reload_all()
command! Rea ReloadAll

" show dein.vim install and update progress
command! DeinProgress echo dein#get_progress()
command! Dp DeinProgress

if g:is_enable_my_debug
  echo "end " . expand('%/h') . " load"
endif
