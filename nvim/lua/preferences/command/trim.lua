local bo = require("const.bo")

local M = {}

local current_line = 0;
local current_col = 0;
local search_pattern = "";

M.setup = function()
  local function saveCurrent()
    -- get last search pattern / 直前の検索パターンを取得
    search_pattern = vim.fn.getreg("/")
    -- get cursor position / 直前のカーソル位置を取得
    current_line = vim.fn["line"](".")
    current_col = vim.fn["col"](".")
  end
  local function loadCurrent()
    -- back cursor position to prev / 直前のカーソル位置に戻す
    vim.cmd("call cursor(" .. current_line .. ", " .. current_col .. ")")
    -- set last search pattern / 直前の検索パターンに戻す
    vim.fn.setreg("/", search_pattern)
  end
  -- erase spaces to line end
  local function trimEndSpace()
    saveCurrent()
    vim.cmd([[silent! %s#\v\s+$##g]])
    loadCurrent()
  end
  vim.api.nvim_create_user_command("TrimEndSpace", trimEndSpace, {})

  -- erase spaces to line end
  local function trimCr()
    saveCurrent()
    vim.cmd([[silent! %s#\v\r##g]])
    loadCurrent()
  end
  vim.api.nvim_create_user_command("TrimCr", trimCr, {})

  -- erase spaces to line end
  local function trimCrlf()
    saveCurrent()
    vim.cmd([[silent! %s#\v\r\n##g]])
    loadCurrent()
  end
  vim.api.nvim_create_user_command("TrimCrlf", trimCrlf, {})

  local function trimEnd()
    saveCurrent()
    local ff = vim.bo.fileformat
    if ff == bo.fileformat.dos then
      vim.cmd([[silent! %s#\v\s*$##g]])
    elseif ff == bo.fileformat.unix then
      vim.cmd([[silent! %s#\v(\s|\r)*$##g]])
    end
    loadCurrent()
  end
  vim.api.nvim_create_user_command("TrimEnd", trimEnd, {})

  local function trimCr()
    saveCurrent()
    vim.cmd([[silent! %s#\v(\s|\r)*$##g]])
    loadCurrent()
  end
  vim.api.nvim_create_user_command("TrimCr", trimCr, {})
end

M.keymap = function()
  vim.keymap.set("n", "te", "<Cmd>TrimEnd<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "tc", "<Cmd>TrimCr<CR>", { noremap = true, silent = true })
end

return M
