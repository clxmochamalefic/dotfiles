local utils = require("utils")

local M = {
  ginitvim_filepath = vim.g.my_initvim_path .. "/ginit.lua",
  initvim_filepath = vim.g.my_initvim_path .. "/init.lua",
  commands = {
    require("preferences.command.trim"),
    require("preferences.command.reloadPreference"),
    require("preferences.command.showLoadedScripts"),
    require("preferences.command.showHighlightGroup"),
    require("preferences.command.yank"),
    require("preferences.command.parser.jq"),
  },
}

M.setup = function()
  utils.io.begin_debug(vim.fn["expand"]("%/h"))

  for _, command in ipairs(M.commands) do
    command.setup()
  end


  utils.io.end_debug(vim.fn["expand"]("%/h"))
end


return M
