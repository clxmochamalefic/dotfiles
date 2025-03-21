local mapping = {}

local opt = vim.opt
local fn = vim.fn
local api = vim.api
local g = vim.g
local keymap = vim.keymap

mapping.setup = function()
  -- ---------------------------------------------------------------------------
  -- input (key_mapping)
  keymap.set("n", ";", ":", { noremap = true, silent = true })

  -- tag jump
  keymap.set("n", "<C-U>", "<C-]>", { noremap = true, silent = true })
  keymap.set("t", "<C-U>", "<C-]>", { noremap = true, silent = true })

  -- create new tab
  keymap.set("n", "tn", "<Cmd>tabnew<CR>", { noremap = true, silent = true })

  -- escape from insert mode
  keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })

  -- tabキーでターミナルの補完聞かない問題
  keymap.set({ "i", "c" }, "<C-a>", "<Home>", { noremap = true })
  keymap.set({ "i", "c" }, "<C-e>", "<End>", { noremap = true })
  --  today date and time
  -- nmap <C-;> <ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR>
  -- nmap <F7> <ESC>i<C-R>=strftime("%H:%M")<CR><CR>

  keymap.set({ "i", "c" }, "<S-Tab>", "<C-d>", { silent = true })

  --  auto insert semicolon to after last character in current line
  local function isEndSemicolon()
    return fn.getline(".")[fn.col("$") - 2] ~= ";"
  end

  -- keymap.set("i", "<expr>;;", function() return isEndSemicolon() and "<C-O>$;<CR>" or "<C-O>$<CR>" end, { noremap = true, silent = true })

  --  XML / HTML の閉じタグ自動入力
  local augroup = api.nvim_create_augroup("MyXML", { clear = true })
  api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
      "xml",
      "html",
      "phtml",
      "blade.php",
    },
    callback = function()
      -- do something
      keymap.set("i", "</", "</<C-x><C-o>", { noremap = true, silent = true, buffer = true })
    end,
  })

  --  Help画面でのqだけでのヘルプ終了
  -- local help_augroup = api.nvim_create_augroup('QuitHelp', { clear = true })
  -- api.nvim_create_autocmd("FileType", {
  --   group = help_augroup,
  --   pattern = {
  --     "help",
  --   },
  --   callback = function()
  --     -- do something
  --     keymap.set("n", "q", fn.execute("quit"), { noremap = true, silent = true, buffer = true })
  --   end
  -- })

  --  閉じかっこの自動入力
  -- inoremap {<Enter> {}<Left><CR><BS><ESC><S-o>
  -- inoremap [<Enter> []<Left><CR><BS><ESC><S-o>
  -- inoremap (<Enter> ()<Left><CR><BS><ESC><S-o>
end

return mapping
