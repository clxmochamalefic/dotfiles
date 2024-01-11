-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) PLUGINS
-- ---------------------------------------------------------------------------

local api = vim.api

local myio = require('utils.sub.io')
local mydap = require('plugins.plugin.config.lsp-dap')
local mystr = require('utils.string')

-- https://zenn.dev/kawarimidoll/articles/36b1cc92d00453
local function dap_start(opts)
  local args = opts.fargs[1]:split(" ")
  mydap.start({
    lang = args[1],
    host = args[2],
    port = args[3],
  })
end

local complete_list = {
  'java',
}
local dap_start_complete = {
  nargs = 1,
  complete = function(_, _, _)
    return complete_list
  end
}

local cmd_bp_with_cond = '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>'
local cmd_bp_with_log_point_mess = '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'

return {
  {
    lazy = true,
    'mfussenegger/nvim-dap',
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      'rcarriga/nvim-dap-ui',             -- UI for nvim-dap
      'theHamsta/nvim-dap-virtual-text',  -- Variable values as virtual text
    },
    event = { 'LspAttach' },
    keys = {
      { "<F5>",     "<Cmd>DapContinue<CR>",         { mode = "n", silent = true, desc = 'dap: continue', } },
      { "<F10>",    "<Cmd>DapStepOver<CR>",         { mode = "n", silent = true, desc = 'dap: step over', } },
      { "<F11>",    "<Cmd>DapStepInto<CR>",         { mode = "n", silent = true, desc = 'dap: step into', } },
      { "<S-F10>",  "<Cmd>DapOut<CR>",              { mode = "n", silent = true, desc = 'dap: step out', } },
      { "<F9>",     "<Cmd>DapToggleBreakpoint<CR>", { mode = "n", silent = true, desc = 'dap: breakpoint toggle', } },
      { "<S-F9>",   cmd_bp_with_cond,               { mode = "n", silent = true, desc = 'dap: breakpoint with condition', } },
      { "<C-F9>",   cmd_bp_with_log_point_mess,     { mode = "n", silent = true, desc = 'dap: breakpoint with log point message', } },
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true, desc = 'dap: repl open', })
      vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>',  { silent = true, desc = 'dap: run last', })

      -- dap-ui
      require("dapui").setup({
        icons = { expanded = "", collapsed = "" },
        layouts = {
          {
            elements = {
              { id = "watches", size = 0.20 },
              { id = "stacks", size = 0.20 },
              { id = "breakpoints", size = 0.20 },
              { id = "scopes", size = 0.40 },
            },
            size = 64,
            position = "right",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.20,
            position = "bottom",
          },
        },
      })
      api.nvim_set_keymap('n', '<leader>d', ':lua require("dapui").toggle()<CR>', {})
      api.nvim_set_keymap('n', '<leader>.', ':lua require("dapui").eval()<CR>', {})

      local dap = require("dap")
      mydap.setup(dap)

      -- https://zenn.dev/kawarimidoll/articles/36b1cc92d00453
      api.nvim_create_user_command("DapStart", dap_start, dap_start_complete)
    end,
  },
}
