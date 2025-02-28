-- ---------------------------------------------------------------------------
-- LSP FORMATTER PLUGINS
-- ---------------------------------------------------------------------------

-- Utilities for creating configurations

return {
  --{
  --  lazy = true,
  --  "mhartington/formatter.nvim",
  --  dependencies = {
  --    "williamboman/mason.nvim",
  --  },
  --  event = { "LspAttach" },
  --  config = function()
  --    local util = require("formatter.util")
  --    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
  --    require("formatter").setup({
  --      -- Enable or disable logging
  --      logging = true,
  --      -- Set the log level
  --      log_level = vim.log.levels.WARN,
  --      -- All formatter configurations are opt-in
  --      filetype = {
  --        -- Formatter configurations for filetype "lua" go here
  --        -- and will be executed in order
  --        lua = {
  --          -- "formatter.filetypes.lua" defines default configurations for the
  --          -- "lua" filetype
  --          require("formatter.filetypes.lua").stylua,

  --          -- You can also define your own configuration
  --          function()
  --            -- Supports conditional formatting
  --            if util.get_current_buffer_file_name() == "special.lua" then
  --              return nil
  --            end

  --            -- Full specification of configurations is down below and in Vim help
  --            -- files
  --            return {
  --              exe = "stylua",
  --              args = {
  --                "--search-parent-directories",
  --                "--stdin-filepath",
  --                util.escape_path(util.get_current_buffer_file_path()),
  --                "--",
  --                "-",
  --              },
  --              stdin = true,
  --            }
  --          end,
  --        },

  --        -- Use the special "*" filetype for defining formatter configurations on
  --        -- any filetype
  --        ["*"] = {
  --          -- "formatter.filetypes.any" defines default configurations for any
  --          -- filetype
  --          require("formatter.filetypes.any").remove_trailing_whitespace,
  --        },
  --      },
  --    })

  --    local augroup = vim.api.nvim_create_augroup
  --    local autocmd = vim.api.nvim_create_autocmd
  --    augroup("__formatter__", { clear = true })
  --    autocmd("BufWritePre", {
  --      group = "__formatter__",
  --      command = ":FormatWrite",
  --    })
  --  end,
  --},
  {
    -- https://github.com/stevearc/conform.nvim
    lazy = true,
    "stevearc/conform.nvim",
    event = { "LspAttach" },
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- Use a sub-list to run only the first available formatter
          javascript = { { "prettierd", "prettier" } },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
      -- exec formatting before write to file
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })

      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
