-- ---------------------------------------------------------------------------
-- DAP (debug adapter protocol) PLUGINS
-- ---------------------------------------------------------------------------

local basepath = 'plugins.rc.lsp.dap.'

local mydap = require(basepath .. "config")
local depends = require(basepath .. "depends")

-- https://zenn.dev/kawarimidoll/articles/36b1cc92d00453
local function dap_start(opts)
  local args = opts.fargs[1]:split(" ")
  mydap.start({
    lang = args[1],
    host = args[2],
    port = args[3],
  })
end

local complete_list = mydap.lang

local dap_start_complete = {
  nargs = 1,
  complete = function(_, _, _)
    return complete_list
  end,
}

local cmd_bp_with_cond = '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>'
local cmd_bp_with_log_point_mess =
'<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'

return {
  {
    lazy = true,
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",            -- UI for nvim-dap
      "theHamsta/nvim-dap-virtual-text", -- Variable values as virtual text
    },
    --event = { "LspAttach" },
    keys = {
      {
        "<F5>",
        "<Cmd>DapContinue<CR>",
        { mode = "n", silent = true, desc = "dap: continue" }
      },
      {
        "<F10>",
        "<Cmd>DapStepOver<CR>",
        { mode = "n", silent = true, desc = "dap: step over" }
      },
      {
        "<S-F10>",
        "<Cmd>DapStepInto<CR>",
        { mode = "n", silent = true, desc = "dap: step into" }
      },
      {
        "<S-F10>",
        "<Cmd>DapOut<CR>",
        { mode = "n", silent = true, desc = "dap: step out" }
      },
      {
        "<F9>",
        "<Cmd>DapToggleBreakpoint<CR>",
        { mode = "n", silent = true, desc = "dap: breakpoint toggle" }
      },
      {
        "<S-F9>",
        cmd_bp_with_cond,
        { mode = "n", silent = true, desc = "dap: breakpoint with condition" },
      },
      {
        "<C-F9>",
        cmd_bp_with_log_point_mess,
        { mode = "n", silent = true, desc = "dap: breakpoint with log point message" },
      },

      {
        "<leader>dr",
        '<Cmd>lua require("dap").repl.open()<CR>',
        { mode = "n", silent = true, desc = "dap: breakpoint with log point message" },
      },
      {
        "<leader>dl",
        '<Cmd>lua require("dap").run_last()<CR>',
        { mode = "n", silent = true, desc = "dap: breakpoint with log point message" },
      },
      {
        "<leader>d",
        '<Cmd>lua require("dapui").toggle()<CR>',
        { mode = "n", silent = true, desc = "dap: toggle ui window" }
      },
      {
        "<leader>.",
        '<Cmd>lua require("dapui").eval()<CR>',
        { mode = "n", silent = true, desc = "dap: eval on ui window" }
      },
    },
    cmd = {
      "DapStart",
    },
    config = function()
      depends.init()

      --vim.api.nvim_set_keymap(
      --  "n",
      --  "<leader>dr",
      --  '<Cmd>lua require("dap").repl.open()<CR>',
      --  { silent = true, desc = "dap: repl open" }
      --)
      --vim.api.nvim_set_keymap(
      --  "n",
      --  "<leader>dl",
      --  '<Cmd>lua require("dap").run_last()<CR>',
      --  { silent = true, desc = "dap: run last" }
      --)

      -- dap-ui
      --require("dapui").setup(opts)
      --vim.api.nvim_set_keymap("n", "<leader>d", ':lua require("dapui").toggle()<CR>', {})
      --vim.api.nvim_set_keymap("n", "<leader>.", ':lua require("dapui").eval()<CR>', {})

      local dap = require("dap")
      mydap.setup(dap)
      --vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { noremap = true })

      -- https://zenn.dev/kawarimidoll/articles/36b1cc92d00453
      vim.api.nvim_create_user_command("DapStart", dap_start, dap_start_complete)
    end,
  },
  {
    lazy = true,
    "folke/neodev.nvim",
    event = { "LspAttach" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui", -- UI for nvim-dap
    },
    config = function()
      require("neodev").setup({
        library = {
          plugins = {
            "nvim-dap-ui",
          },
          types = true,
        },
      })
    end,
  },
  {
    lazy = true,
    "sakhnik/nvim-gdb",
  },
  {
    lazy = true,
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      icons = { expanded = "", collapsed = "" },
      layouts = {
        {
          elements = {
            { id = "watches",     size = 0.20 },
            { id = "stacks",      size = 0.20 },
            { id = "breakpoints", size = 0.20 },
            { id = "scopes",      size = 0.40 },
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
    },
    config = function(_, opts)
      require("dapui").setup(opts)
    end,
  },
  {
    -- virtual text for variable current value on debugger
    lazy = true,
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() end,
  },
  {
    lazy = true,
    "thinca/vim-quickrun",
  },
}
