-- ---------------------------------------------------------------------------
--  WINPICK CONFIG
-- ---------------------------------------------------------------------------

local api = vim.api
local opt = vim.opt

local utils = require("utils")
local wndutil = require("utils..window")

local M = {}

local excluded_filetypes = {
  --"",
  --"NvimTree",
  "NeogitCommitMessage",
  --"toggleterm",
  "gitrebase",
  "notify",
  --"noice",
}
local excluded_buftypes = {
  --"",
  --"NvimTree",
  "NeogitCommitMessage",
  --"toggleterm",
  "gitrebase",
  --"nofile",
  "notify",
  --"noice",
}

local exclude_create_label_filetypes = {
  "",
  "NvimTree",
}

M.opts = {
  border = "double",
  --filter = nil, -- doesn't ignore any window by default
  ---@diagnostic disable-next-line: unused-local
  filter = function(winid, bufnr)
    local bt = vim.api.nvim_buf_get_option(bufnr, "buftype")
    if vim.tbl_contains(excluded_buftypes, bt) then
      return false
    end

    --local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local ft = vim.bo[bufnr].filetype
    if vim.tbl_contains(excluded_filetypes, ft) then
      return false
    end

    --local win = vim.api.win_findbuf(bufnr)
    --local config = vim.api.nvim_win_get_config(win)
    --if config.relative ~= "" then -- is_floating_window?
    --  return false
    --end

    return true
  end,
  prompt = "Pick a window: ",
  --format_label = M.winpick.defaults.format_label, -- formatted as "<label>: <buffer name>"
  ---@diagnostic disable-next-line: unused-local
  format_label = function(label, winid, bufnr)
    local ft = vim.bo[bufnr].filetype
    local bt = vim.bo[bufnr].buftype
    --local wbr = vim.bo[bufnr].wbr

    if vim.tbl_contains(exclude_create_label_filetypes, ft) then
      return string.format("[%s] %s", label, ft)
    end

    local path = wndutil.getBufPathPartialyShorten(bufnr, 1, 2)
    --local name = wndutil.getBufName(bufnr)
    return string.format("[%s] %s", label, path)
    --return string.format("%s: [%s/%s/%s] %s", label, ft, bt, wbr, path)
  end,
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
      --opt.laststatus = 3
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
