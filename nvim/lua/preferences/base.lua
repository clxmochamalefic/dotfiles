-- ---------------------------------------------------------------------------
--  BASE PREFERENCES
-- ---------------------------------------------------------------------------

--  define default file encoding and fileformat
vim.o.encoding =  "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.ff= "dos"


-- ---------------------------------------------------------------------------
--  PATH

--  UndoFiles
local home_tmp_dir = vim.fn.expand('~/.cache/vim_tmp')
local undofiles = vim.fn.expand(home_tmp_dir + '/undofiles')
local bkupfiles = vim.fn.expand(home_tmp_dir + '/backupfiles')

--  ~/tmp 以降のディレクトリがない場合は新規作成
if vim.fn.isdirectory(home_tmp_dir) ~= 1 then
  vim.fn.execute('!mkdir -p ' + home_tmp_dir)
  vim.fn.execute('!mkdir ' + undofiles)
  vim.fn.execute('!mkdir ' + bkupfiles)
end

vim.o.undodir = undofiles
vim.o.backupdir = bkupfiles

--  ctags path
vim.o.tags = "./tags;~"

--  autochdir (auto change directory by buffer file path)
vim.o.autochdir = true

-- ---------------------------------------------------------------------------
--  Window
vim.o.wildmenu = true
--  コマンドライン補完設定
vim.o.wildmode = "list:full,full"
vim.o.hidden = true
--  編集中ファイルがあっても別画面に切り替え可能に
vim.o.noequalalways = true


-- ---------------------------------------------------------------------------
-- " sound

--  enable mute
vim.o.t_vb = ""
vim.o.visualbell = true
vim.o.noerrorbells = true


-- ---------------------------------------------------------------------------
-- " I/O

--  use clipboard
vim.o.nopaste = true
vim.keymap.set("n", "<S-Insert>", "<C-R>+")
vim.o.clipboard = "unnamed"


-- ---------------------------------------------------------------------------
-- " input (key)

-- +++++++++++++++
--  define mapleader character
--  (`mapleader` is preference of combination prefix character
vim.g.mapleader = ","

-- +++++++++++++++
--  tab and tabstop

--  disable use tabcharacter and define tabstop
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.backspace= "indent,eol,start"

-- ---------------------------------------------------------------------------
--  Display

--  use gui color preference on terminal
vim.o.termguicolors = true

--  show whitespace characters
vim.o.list = true
vim.o.listchars= "tab:»-,trail:-,eol:↲,extend»,precede«,nbsp:%"

--  Windows でもパスの区切り文字を / にする
vim.o.shellslash = true

-- +++++++++++++++
-- " display - line number

--  display line number
vim.o.number = true

--  display linespace(lineheight)
vim.o.linespace = 2

-- ---------------------------------------------------------------------------
--  input (IME)

--  日本語入力に関する設定:
if vim.fn.has('multi_byte_ime') or vim.fn.has('xim') then
    -- IME ON時のカーソルの色を設定(設定例:紫)
    vim.cmd("highlight CursorIM guibg=Purple guifg=NONE")
    -- 挿入モード・検索モードでのデフォルトのIME状態設定
    vim.o.iminsert = 0
    vim.o.imsearch = 0
    if vim.fn.has('xim') && vim.fn.has('GUI_GTK')
        -- XIMの入力開始キーを設定:
        -- 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
        -- vim.o.imactivatekey=s-space
    end
    -- 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
    -- inoremap <silent> <ESC> <ESC>:vim.o.iminsert=0<CR>
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
vim.o.mouse = "a"
--  マウスの移動でフォーカスを自動的に切替えない
--  (mousefocu切替る/nomousefocu切り替えない)
vim.o.nomousefocus = true
--  入力時にマウスポインタを隠す (nomousehide:隠さない)
vim.o.mousehide = true
--  ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
-- vim.o.guioptions+=a

-- ---------------------------------------------------------------------------
--  terminal
if vim.fn.has('win32') then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = "-c"
  vim.o.shellquote = '\"'
  vim.o.shellxquote = ''
end

vim.api.nvim_create_augroup('Terminal', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function ()
    -- do something
    vim.fn.startinsert()
  end
})


function _G.resize_float_window()
  vim.g.float_window_col = 8
  vim.g.float_window_height = 30

  vim.g.float_window_row = vim.eval("&lines") - vim.g.float_window_height - 2
  vim.g.float_window_width = vim.eval("&columns") - (vim.g.float_window_col * 2)
end

resize_float_window()

vim.api.nvim_create_autocmd('VimResized', { callback = resize_float_window() })
