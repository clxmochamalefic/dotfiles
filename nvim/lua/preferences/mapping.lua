-- ---------------------------------------------------------------------------
--  input (key_mapping)
vim.keymap.set("n", ";", ":", { noremap = true, silent = true })

--  tag jump
vim.keymap.set("n", "<C-J>", "<C-]>", { noremap = true, silent = true })

vim.keymap.set("t", "<C-J>", "<C-]>", { noremap = true, silent = true })

--  today date and time
-- nmap <C-;> <ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR>
-- nmap <F7> <ESC>i<C-R>=strftime("%H:%M")<CR><CR>

--  auto insert semicolon to after last character in current line
local function isEndSemicolon()
  return vim.fn.getline(".")[vim.fn.col("$")-2] ~= ';'
end

vim.keymap.set("i", "<expr>;;", function() return isEndSemicolon() and "<C-O>$;<CR>" or "<C-O>$<CR>" end, { noremap = true, silent = true })


--  XML / HTML の閉じタグ自動入力
local augroup = vim.api.nvim_create_augroup('MyXML', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "xml",
    "html",
    "phtml",
    "blade.php",
  },
  callback = function ()
    -- do something
    vim.keymap.set("i", "</", "</<C-x><C-o>", { noremap = true, silent = true, buffer = true })
  end
})

--  Help画面でのqだけでのヘルプ終了
local help_augroup = vim.api.nvim_create_augroup('QuitHelp', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = help_augroup,
  pattern = {
    "help",
  },
  callback = function ()
    -- do something
    vim.keymap.set("n", "q", vim.fn.execute("quit"), { noremap = true, silent = true, buffer = true })
  end
})


--  閉じかっこの自動入力
-- inoremap {<Enter> {}<Left><CR><BS><ESC><S-o>
-- inoremap [<Enter> []<Left><CR><BS><ESC><S-o>
-- inoremap (<Enter> ()<Left><CR><BS><ESC><S-o>

