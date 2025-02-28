local opts = {
  defaults = {
    lazy = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
}

local M = {}

M.setup = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=main",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  --vim.api.nvim_create_autocmd("VimEnter", {
  --  callback = function(_)
  --    --vim.api.nvim_set_keymap("n", "<leader>l", ":Lazy<CR>", { silent = true, desc = "lazy" })
  --  end,
  --})

  --require("lazy").setup("plugins.rc", opts)
  require("lazy").setup("plugins.rc")
end

return M
