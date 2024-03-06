-- ---------------------------------------------------------------------------
--  WINPICK CONFIG
-- ---------------------------------------------------------------------------

local api = vim.api
local opt = vim.opt

local utils = require("utils")
local wndutil = require("utils.sub.window")

local M = {}

local excluded_filetypes = {
  --"",
  --"NvimTree",
  "NeogitCommitMessage",
  --"toggleterm",
  "gitrebase",
  "notify",
}
local excluded_buftypes = {
  --"",
  --"NvimTree",
  "NeogitCommitMessage",
  --"toggleterm",
  "gitrebase",
  "nofile",
}

M.opts = {
  border = "double",
  filter = nil, -- doesn't ignore any window by default
  --filter = function(winid, bufnr)
  --  print("bufnr: " .. bufnr)
  --  local bt = vim.api.nvim_buf_get_option(bufnr, "buftype")
  --  print("buftype: " .. bt)
  --  if vim.tbl_contains(excluded_buftypes, bt) then
  --    return false
  --  end

  --  --local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  --  local ft = vim.bo[bufnr].filetype
  --  print("filetype: " .. ft)
  --  if vim.tbl_contains(excluded_filetypes, ft) then
  --    return false
  --  end

  --  return true
  --end,
  prompt = "Pick a window: ",
  --format_label = M.winpick.defaults.format_label, -- formatted as "<label>: <buffer name>"
  --format_label = function(label, y, z)
  --  return string.format('%s', label)
  --end,
  chars = nil,
}

--
-- choose window for window focus
--
function M.choose_for_focus()
  utils.try_catch({
    try = function()
      local winid = M.winpick.select()
      if winid then
        vim.api.nvim_set_current_win(winid)
      end
    end,
    catch = function()
      opt.laststatus = 3
    end,
  })
end

--
-- choose window for window move
--
function M.choose_for_move()
  local bufnr = wndutil.getBufnr()
  local winid = M.winpick.select()
  if winid then
    vim.api.nvim_set_current_win(winid)
  end
end

M.setup = function()
  M.winpick = require("winpick")
  M.winpick.setup(M.opts)

  api.nvim_create_user_command("WinPick", M.choose_for_focus, {})
  --vim.keymap.set("n", "-", M.choose_for_focus)
end

return M
