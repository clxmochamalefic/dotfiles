if g:is_enable_my_debug
  echo "begin /plugins/db.lazy.post.source.vim"
endif

" TOML FORMAT
" [local]
" connection_string = "mysql://xxxx"
" type =  "mysql"
" port = "3306"
" user =  "LOCAL"
" password =  "PASSWD"
" [local.ssh]
" address = "localhost"
" port = "22"
" user = "LOCAL"
" password = "PASSWD"
" identifier = ""

let s:db_toml_dir = expand($HOME . '/.cache/vim_dadbod')
let g:dbs = {}

if !isdirectory(s:db_toml_dir)
  let s:mkdir_cmd = '!mkdir ' . s:db_toml_dir
  silent exec s:mkdir_cmd
endif

let s:filelist =  expand(s:db_toml_dir . "/*.toml")
let s:splitted = split(s:filelist, "\n")
"for s:file in s:splitted
"  let s:read = dein#toml#parse_file(expand(s:file))
"  for s:prefix in keys(s:read)
"    let s:preference = s:read[s:prefix]
"    let s:conn_str = s:preference['type'] . "://" . s:preference['user'] . ":" . s:preference['password'] . "@" . s:preference['host'] . ":" . s:preference['port']
"    let g:dbs[fnamemodify(s:file, ':t') . "." . s:prefix] = s:conn_str
"  endfor
"endfor

if g:is_enable_my_debug
  echo "end /plugins/db.lazy.post.source.vim"
endif

