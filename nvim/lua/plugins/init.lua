local opts = {
  --defaults = {
  --  lazy = true,
  --},
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- lazy.nvim resets the runtimepath on setup, which drops the dotfiles
      -- path added in stdpath("config")/init.lua. Without it, spec re-imports
      -- (run in the middle of `:Lazy update`/`sync` and by change detection)
      -- cannot find `plugins.rc`, so the plugin list collapses to lazy.nvim
      -- only and the UI/lockfile lose all update progress.
      paths = { vim.fn.expand(vim.g.preference_path) },
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

  require("lazy").setup("plugins.rc", opts)
end

return M
