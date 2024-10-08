local utils = require("utils")



local M = {
  ginitvim_filepath = vim.g.my_initvim_path .. "/ginit.lua",
  initvim_filepath = vim.g.my_initvim_path .. "/init.lua",
  commands = {
    require("preferences.command.trim"),
    require("preferences.command.reloadPreference"),
    -- require("preferences.command.replaceBigCharacters"),
  },
}

M.setup = function()
  utils.io.begin_debug(vim.fn["expand"]("%/h"))

  for _, command in ipairs(M.commands) do
    command.setup()
  end


  --  -- +++++++++++++++
  --  --  define command
  --
  --  --  jq command
  --  --  if cannot use
  --  --    windows       : > pwsh -command "Start-Process -verb runas pwsh" "'-command winget install stedolan.jq'"
  --  --    brew on macOS : % brew install jq
  --  --    linux (debian): $ sudo apt -y update
  --  --                    $ sudo apt -y install jq
  --  --    linux (RHEL)  : $ sudo yum -y install epel-release
  --  --                    $ sudo yum -y install jq
  --  vim.fn.command("Jqf", "!j+ '.'")
  --  vim.fn.command("Jq",  "!j+ '%:p'")
  --
  --  --  preference file open mapping


  -- other commands and shortcuts

  utils.io.end_debug(vim.fn["expand"]("%/h"))
end


return M
