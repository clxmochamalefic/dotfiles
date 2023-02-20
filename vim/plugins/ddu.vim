if g:is_enable_my_debug
  echo "begin /plugins/ddu.vim load"
endif

let g:ddu_float_window_col            = g:float_window_col
let g:ddu_float_window_row            = g:float_window_row
let g:ddu_float_window_width          = g:float_window_width
let g:ddu_float_window_height         = g:float_window_height
let g:ddu_float_window_preview_width  = 120
let g:ddu_float_window_preview_col    = 0
let g:ddu_float_window_preview_height = g:ddu_float_window_height

let g:floating_ddu_ui_params = #{
      \   span: 2,
      \
      \   split: 'floating',
      \   floatingBorder: 'rounded',
      \   filterFloatingPosition: 'bottom',
      \   filterSplitDirection: 'floating',
      \   winRow: g:ddu_float_window_row,
      \   winCol: g:ddu_float_window_col,
      \   winWidth: g:ddu_float_window_width,
      \   winHeight: g:ddu_float_window_height,
      \
      \   previewFloating: v:true,
      \   previewVertical: v:true,
      \   previewFloatingBorder: 'rounded',
      \   previewFloatingZindex: 10000,
      \   previewCol: g:ddu_float_window_preview_col,
      \   previewWidth: g:ddu_float_window_preview_width,
      \   previewHeight: g:ddu_float_window_preview_height,
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
      \     file: #{ defaultAction: 'open', },
      \     file_old: #{ defaultAction: 'open', },
      \     file_rec: #{ defaultAction: 'open', },
      \     action: #{ defaultAction: 'do', },
      \     word: #{ defaultAction: 'append', },
      \     dein_update: #{ defaultAction: 'viewDiff', },
      \     custom-list: #{ defaultAction: 'callback', },
      \   },
      \   uiParams: #{
      \     _: g:floating_ddu_ui_params,
      \   },
      \   actionOptions: #{
      \     echo:     #{ quit: v:false, },
      \     echoDiff: #{ quit: v:false, },
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

execute "source " . g:my_initvim_path . "/plugins/ddu.filer.vim"
execute "source " . g:my_initvim_path . "/plugins/ddu.ff.vim"

if g:is_enable_my_debug
  echo "begin /plugins/ddu.vim end"
endif

