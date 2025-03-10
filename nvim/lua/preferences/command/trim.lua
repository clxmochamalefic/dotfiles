local M = {}

local current_line = 0;
local current_col = 0;

M.setup = function()
  local function saveCurrent()
    current_line = vim.fn["line"](".")
    current_col = vim.fn["col"](".")
  end
  local function loadCurrent()
    vim.cmd("call cursor(" .. current_line .. ", " .. current_col .. ")")
    --current_col = vim.fn["col"](".")
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
    vim.cmd([[silent! %s#\v\s*\r##g]])
    loadCurrent()
  end
  vim.api.nvim_create_user_command("TrimEnd", trimEnd, {})
end

return M
