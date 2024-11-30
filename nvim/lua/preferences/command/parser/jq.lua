---@diagnostic disable: undefined-global
local M = {}

-- jq command
M.setup = function()
  --    windows       : > winget install jqlang.jq --silent
  --    brew on macOS : % brew install jq
  --    linux (debian): $ sudo apt -y update
  --                    $ sudo apt -y install jq
  --    linux (RHEL)  : $ sudo yum -y install epel-release
  --                    $ sudo yum -y install jq

  vim.api.nvim_create_user_command("JqFullPath", "!j+ '%:p'", {})
  vim.api.nvim_create_user_command("JqRelative", "!j+ '.'", {})

  --local augroup = vim.api.nvim_create_augroup("MyJson", { clear = true })
  --vim.api.nvim_create_autocmd("FileType", {
  --  group = augroup,
  --  pattern = {
  --    "json",
  --  },
  --  callback = function()
  --    -- do something
  --    vim.keymap.set("n", "Jq", "!j+ '%:p'", { noremap = true, silent = true, buffer = true })
  --    vim.keymap.set("n", "Jqf", "!j+ '.'", { noremap = true, silent = true, buffer = true })
  --  end,
  --})
end

return M
