-- ---------------------------------------------------------------------------
--  BASE PREFERENCES
-- ---------------------------------------------------------------------------

local utils = require('utils')
local M = {}

function M.load(_collection)
  --  define default file encoding and fileformat
  vim.opt.encoding =  "utf-8"
  vim.opt.fileencoding = "utf-8"
  vim.opt.ff= "dos"


  -- ---------------------------------------------------------------------------
  --  PATH

  --  UndoFiles
  local home_tmp_dir = vim.fn.expand('~/.cache/vim_tmp')
  local undofiles = vim.fn.expand(home_tmp_dir .. '/undofiles')
  local bkupfiles = vim.fn.expand(home_tmp_dir .. '/backupfiles')

  --  ~/tmp 以降のディレクトリがない場合は新規作成
  if vim.fn.isdirectory(home_tmp_dir) ~= 1 then
    vim.fn.execute('!mkdir -p ' .. home_tmp_dir)
    vim.fn.execute('!mkdir ' .. undofiles)
    vim.fn.execute('!mkdir ' .. bkupfiles)
  end

  vim.opt.undodir = undofiles
  vim.opt.backupdir = bkupfiles

  --  ctags path
  vim.opt.tags = "./tags;~"

  --  autochdir (auto change directory by buffer file path)
  vim.opt.autochdir = true

  -- ---------------------------------------------------------------------------
  --  Window
  vim.opt.wildmenu = true
  --  コマンドライン補完設定
  vim.opt.wildmode = "list:full,full"
  vim.opt.hidden = true
  --  編集中ファイルがあっても別画面に切り替え可能に
  vim.cmd("set noequalalways")


  -- ---------------------------------------------------------------------------
  -- " sound

  --  enable mute
  vim.api.nvim_set_option("t_vb", "")
  -- vim.api.nvim_set_option("visualbell", true)
  vim.g.visualbell = true
  vim.g.noerrorbells = true


  -- ---------------------------------------------------------------------------
  -- " I/O

  --  use clipboard
  vim.g.nopaste = true
  vim.keymap.set("n", "<S-Insert>", "<C-R>+")
  vim.opt.clipboard = "unnamed"


  -- ---------------------------------------------------------------------------
  -- " input (key)

  -- +++++++++++++++
  --  define mapleader character
  --  (`mapleader` is preference of combination prefix character
  vim.g.mapleader = ","

  -- +++++++++++++++
  --  tab and tabstop

  --  disable use tabcharacter and define tabstop
  vim.opt.tabstop = 2
  vim.opt.smartindent = true
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  vim.opt.backspace= "indent,eol,start"

  -- ---------------------------------------------------------------------------
  --  Display

  --  use gui color preference on terminal
  vim.opt.termguicolors = true

  --  show whitespace characters
  vim.opt.list = true
  vim.g.listchars = "tab:»-,trail:-,eol:↲,extend»,precede«,nbsp:%"

  --  Windows でもパスの区切り文字を / にする
  vim.opt.shellslash = true

  -- +++++++++++++++
  -- " display - line number

  --  display line number
  vim.opt.number = true

  --  display linespace(lineheight)
  vim.opt.linespace = 2

  -- ---------------------------------------------------------------------------
  --  input (IME)

  --  日本語入力に関する設定:
  if vim.fn.has('multi_byte_ime') or vim.fn.has('xim') then
    -- IME ON時のカーソルの色を設定(設定例:紫)
    vim.cmd("highlight CursorIM guibg=Purple guifg=NONE")
    -- 挿入モード・検索モードでのデフォルトのIME状態設定
    vim.opt.iminsert = 0
    vim.opt.imsearch = 0
    if vim.fn.has('xim') and vim.fn.has('GUI_GTK') then
      -- XIMの入力開始キーを設定:
      -- 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
      -- vim.opt.imactivatekey=s-space
    end
    -- 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
    -- inoremap <silent> <ESC> <ESC>:vim.opt.iminsert=0<CR>
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
  vim.opt.mouse = "a"
  --  マウスの移動でフォーカスを自動的に切替えない
  --  (mousefocu切替る/nomousefocu切り替えない)
  vim.g.nomousefocus = true
  --  入力時にマウスポインタを隠す (nomousehide:隠さない)
  vim.opt.mousehide = true
  --  ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
  -- vim.opt.guioptions+=a

  -- ---------------------------------------------------------------------------
  --  terminal
  if vim.fn.has('win32') then
    vim.opt.shell = "pwsh"
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellquote = '\"'
    vim.opt.shellxquote = ''
  end

  vim.api.nvim_create_augroup('Terminal', { clear = true })
  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    callback = function ()
      -- do something
      vim.fn.startinsert()
    end
  })


  vim.g.float_window_row = 10
  vim.g.float_window_width = 30

  utils.resize_float_window_default()

  vim.api.nvim_create_autocmd('VimResized', { callback = utils.resize_float_window_default })
  vim.api.nvim_create_user_command("ResizeFloatWindow", utils.resize_float_window_default, {})
end

return M

