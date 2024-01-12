-- ---------------------------------------------------------------------------
-- UI NOTIFY PLUGINS
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

 return {
    lazy = true,
    'rcarriga/nvim-notify',
    event = { 'VimEnter' },
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        config = function()
          local telescope = require 'telescope'
          telescope.load_extension 'notify'

          keymap.set('n', '<leader>n', telescope.extensions.notify.notify)
        end,
      },
    },
    init = function()
      vim.notify = require("notify")
      vim.notify.setup({
        max_width = 120,
        background_colour = "#000000",
        fps = 10,
      })
    end
  },
  {
    lazy = true,
    "folke/noice.nvim",
    event = { 'VimEnter' },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    opts = {
      -- add any options here
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.handlers['textDocument/hover']"] = false,
            ["vim.lsp.handlers['textDocument/signatureHelp']"] = false,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          --override = {
          --  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          --  ["vim.lsp.util.stylize_markdown"] = true,
          --  ["cmp.entry.get_documentation"] = true,
          --},
          hover = {
            enabled = false,
            --silent = true, -- set to true to not show a message if hover is not available
            --view = nil, -- when nil, use defaults from documentation
            -----@type NoiceViewOptions
            --opts = {}, -- merged with defaults from documentation
          },
          signature = {
            enabled = false,
            --auto_open = {
            --  enabled = true,
            --  trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            --  luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            --  throttle = 1000, -- Debounce lsp signature help request by 50ms
            --},
            --view = nil, -- when nil, use defaults from documentation
            -----@type NoiceViewOptions
            --opts = {}, -- merged with defaults from documentation
          },
        },
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '^%d+ changes?; after #%d+' },
                { find = '^%d+ changes?; before #%d+' },
                { find = '^Hunk %d+ of %d+$' },
                { find = '^%d+ fewer lines;?' },
                { find = '^%d+ more lines?;?' },
                { find = '^%d+ line less;?' },
                { find = '^Already at newest change' },
                { kind = 'wmsg' },
                { kind = 'emsg', find = 'E486' },
                { kind = 'quickfix' },
              },
            },
            view = 'mini',
          },
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '^%d+ lines .ed %d+ times?$' },
                { find = '^%d+ lines yanked$' },
                { kind = 'emsg', find = 'E490' },
                { kind = 'search_count' },

                { kind = '.*textDocument/hover.*' },
                { kind = '.*textDocument/formatting.*' },
                { kind = '.*textDocument/publishDiagnostics.*' },
                { kind = '.*textDocument/signatureHelp.*' },
                { kind = '.*textDocument/signatureHelp.*' },
                { kind = '.*WinResized Autocommands.*' },

                { find = '.*textDocument/hover.*' },
                { find = '.*textDocument/formatting.*' },
                { find = '.*textDocument/publishDiagnostics.*' },
                { find = '.*textDocument/signatureHelp.*' },
                { find = '.*textDocument/signatureHelp.*' },
                { find = '.*WinResized Autocommands.*' },
              },
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = 'notify',
              any = {
                { find = '^No code actions available$' },
                { find = '^No information available$' },
              },
            },
            view = 'mini',
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  }
