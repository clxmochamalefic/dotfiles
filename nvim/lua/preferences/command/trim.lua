local M = {}

M.setup = function()
  -- erase spaces to line end
  local function trimEndSpace()
    vim.cmd([[%s#\v\s+$##g]])
  end
  vim.api.nvim_create_user_command("TrimEndSpace", trimEndSpace, {})

  -- erase spaces to line end
  local function trimCr()
    vim.cmd([[%s#\v\r##g]])
  end
  vim.api.nvim_create_user_command("TrimCr", trimCr, {})

  -- erase spaces to line end
  local function trimCrlf()
    vim.cmd([[%s#\v\r\n##g]])
  end
  vim.api.nvim_create_user_command("TrimCrlf", trimCrlf, {})

  local function trimEnd()
    vim.cmd([[%s#\v\s*\r##g]])
  end
  vim.api.nvim_create_user_command("TrimEnd", trimEnd, {})
end

return M
