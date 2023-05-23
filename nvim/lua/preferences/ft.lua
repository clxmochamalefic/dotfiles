local ft = {}

local opt = vim.opt
local fn = vim.fn
local api = vim.api
local g = vim.g

ft.setup = function()
  -- define tabstop by filetype
  local augroup = api.nvim_create_augroup('FileTypeIndent', { clear = true })
  api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = augroup,
    pattern = {
      "*.html",
      "*.phtml",
      "*.js",
      "*.jsx",
      "*.ts",
      "*.tsx",
      "*.css",
      "*.sass",
      "*.scss",
      "*.prisma",
      "*.vim",
      "*.yaml",
      "*.yml",
      "*.toml",
      "*.tml",
      "*.lua",
      "*.blade.php"
    },
    callback = function ()
      -- do something
      opt.tabstop = 2
      opt.softtabstop = 2
      opt.shiftwidth = 2
    end
  })
  api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
      "blade",
    },
    callback = function ()
      -- do something
      opt.tabstop = 2
      opt.softtabstop = 2
      opt.shiftwidth = 2
    end
  })
end

return ft

