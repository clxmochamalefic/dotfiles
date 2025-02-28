-- ---------------------------------------------------------------------------
-- MESSAGE CONFIG FOR NOICE-NVIM
-- ---------------------------------------------------------------------------

return {
  -- NOTE: If you enable messages, then the cmdline is enabled automatically.
  -- This is a current Neovim limitation.
  enabled = true, -- enables the Noice messages UI
  view = "notify", -- default view for messages
  view_error = "notify", -- view for errors
  view_warn = "notify", -- view for warnings
  view_history = "messages", -- view for :messages
  view_search = false, -- view for search count messages. Set to `false` to disable
}
