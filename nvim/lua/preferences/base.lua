-- ---------------------------------------------------------------------------
--  BASE PREFERENCES
-- ---------------------------------------------------------------------------

local base = {}

local utils = require('utils')

local g = vim.g
local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

base.setup = function()
  --  define default file encoding and fileformat
  opt.encoding = "utf-8"
  opt.fileencoding = "utf-8"
  opt.ff = "dos"

  -- ---------------------------------------------------------------------------
  --  PATH

  --  UndoFiles
  local home_tmp_dir = fn.expand('~/.cache/vim_tmp')
  local undofiles = fn.expand(home_tmp_dir .. '/undofiles')
  local bkupfiles = fn.expand(home_tmp_dir .. '/backupfiles')

  --  ~/tmp 以降のディレクトリがない場合は新規作成
  if fn.isdirectory(home_tmp_dir) ~= 1 then
    fn.execute('!mkdir -p ' .. home_tmp_dir)
    fn.execute('!mkdir ' .. undofiles)
    fn.execute('!mkdir ' .. bkupfiles)
  end

  opt.undodir = undofiles
  opt.backupdir = bkupfiles

  --  ctags path
  opt.tags = "./tags;~"

  --  autochdir (auto change directory by buffer file path)
  opt.autochdir = true

  -- ---------------------------------------------------------------------------
  --  Window
  opt.wildmenu = true
  --  コマンドライン補完設定
  opt.wildmode = "list:full,full"
  opt.hidden = true
  --  編集中ファイルがあっても別画面に切り替え可能に
  cmd("set noequalalways")


  -- ---------------------------------------------------------------------------
  -- " sound

  --  enable mute
  api.nvim_set_option("t_vb", "")
  -- api.nvim_set_option("visualbell", true)
  g.visualbell = true
  g.noerrorbells = true


  -- ---------------------------------------------------------------------------
  -- " I/O

  --  use clipboard
  g.nopaste = true
  keymap.set("n", "<S-Insert>", "<C-R>+")
  opt.clipboard = "unnamedplus"


  -- ---------------------------------------------------------------------------
  -- " input (key)

  -- +++++++++++++++
  --  define mapleader character
  --  (`mapleader` is preference of combination prefix character
  g.mapleader = ","

  -- +++++++++++++++
  --  tab and tabstop

  --  disable use tabcharacter and define tabstop
  opt.tabstop = 2
  opt.smartindent = true
  opt.shiftwidth = 4
  opt.expandtab = true
  opt.backspace = "indent,eol,start"

  -- ---------------------------------------------------------------------------
  --  Display

  --  use gui color preference on terminal
  opt.termguicolors = true

  --  show whitespace characters
  opt.list = true
  g.listchars = "tab:»-,trail:-,eol:↲,extend»,precede«,nbsp:%"

  --  Windows でもパスの区切り文字を / にする
  opt.shellslash = true

  -- +++++++++++++++
  -- " display - line number

  --  display line number
  opt.number = true

  --  display linespace(lineheight)
  opt.linespace = 2

  -- ---------------------------------------------------------------------------
  --  input (IME)

  --  日本語入力に関する設定:
  if fn.has('multi_byte_ime') or fn.has('xim') then
    -- IME ON時のカーソルの色を設定(設定例:紫)
    cmd("highlight CursorIM guibg=Purple guifg=NONE")
    -- 挿入モード・検索モードでのデフォルトのIME状態設定
    opt.iminsert = 0
    opt.imsearch = 0
    if fn.has('xim') and fn.has('GUI_GTK') then
      -- XIMの入力開始キーを設定:
      -- 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
      -- opt.imactivatekey=s-space
    end
    -- 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
    -- inoremap <silent> <ESC> <ESC>:opt.iminsert=0<CR>
  end


  -- ---------------------------------------------------------------------------
  -- " input (mouse)
  --
  -- " 解説:
  --  mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
  --  ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
  --  が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
  --  という問題を引き起す。
  --
  --  どのモードでもマウスを使えるようにする
  opt.mouse = "a"
  --  マウスの移動でフォーカスを自動的に切替えない
  --  (mousefocu切替る/nomousefocu切り替えない)
  g.nomousefocus = true
  --  入力時にマウスポインタを隠す (nomousehide:隠さない)
  opt.mousehide = true
  --  ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
  -- opt.guioptions+=a

  -- ---------------------------------------------------------------------------
  --  terminal
  if fn.has('win32') then
    opt.shell = "pwsh"
    opt.shellcmdflag = "-c"
    opt.shellquote = '\"'
    opt.shellxquote = ''
  end

  api.nvim_create_augroup('Terminal', { clear = true })
  api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    callback = function()
      -- do something
      cmd.startinsert()
    end
  })


  g.float_window_row = 10
  g.float_window_width = 30

  utils.resize_float_window_default()

  api.nvim_create_autocmd('VimResized', { callback = utils.resize_float_window_default })
  api.nvim_create_user_command("ResizeFloatWindow", utils.resize_float_window_default, {})
end

return base
