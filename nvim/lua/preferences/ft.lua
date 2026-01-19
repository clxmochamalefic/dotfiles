local ft = {}

ft.setup = function()
  -- TODO: おそらく `ft` に対するものと `ft` を補正するものに分けたほうがいい
  ft.tabstop()
  ft.filetype()
end

ft.tabstop = function()
  -- define tabstop by filetype
  local augroup = vim.api.nvim_create_augroup('FileTypeIndent', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
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
      vim.opt.tabstop = 2
    end
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
      "blade",
    },
    callback = function ()
      -- do something
      vim.opt.tabstop = 2
    end
  })
end

ft.filetype = function()
  local augroup = vim.api.nvim_create_augroup('CmakePreference', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = augroup,
    pattern = {
      "*CMakeLists.txt",
    },
    callback = function ()
      -- do something
      vim.opt.ft = "cmake"
    end
  })
end

return ft

