-- ---------------------------------------------------------------------------
-- C-SHARP-DAP (debug adapter protocol) CONFIGS
-- ---------------------------------------------------------------------------
--
local myutils = require('utils')

local M = {
  dap = nil
}

local ft = {
  "cs",
  "cshtml",
  "vb",
}


M.setup = function(dap, opt)
  if M.dap ~= nil then
    return
  end

  M.dap = dap

  if M.dap ~= nil then
    return
  end

  local h = opt.host or '127.0.0.1'
  local p = opt.port or 8080

  dap.adapters.coreclr = {
    type = 'executable',
    command = '/usr/local/netcoredbg',
    args = { '--interpreter=vscode' }
  }
  dap.adapters.netcoredbg = {
    type = "executable",
    command = global.mason_path .. "/packages/netcoredbg/netcoredbg",
    args = { "--interpreter=vscode" },
  }

  dap.configurations.ps1 = {
    {
      type = 'ps1',
      name = "Attach to process",
      request = "attach",
      pid = require('dap.utils').pick_process,
      args = {},
    }
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }
end

return M
