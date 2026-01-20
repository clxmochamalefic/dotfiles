
return {
  {
    'hat0uma/csvview.nvim',
    lazy = true,
    cmd = {
      'CsvViewEnable',
      'CsvViewDisable',
      'CsvViewToggle',
    },
    opts = {
      parser = {
        async_chunksize = 50,
        delimiter = {
          default = ",",
          ft = {
            tsv = "\t",
          },
        },
        quote_char = '"',
        comments = {
          -- "#",
          -- "--",
          -- "//",
        },
      },
      view = {
        min_column_width = 5,
        spacing = 2,
        display_mode = "border",
      },
    },
    config = function(_, opts)
      require('csvview').setup(opts)
    end,
  },
  {
    "folke/zen-mode.nvim",
    lazy = true,
    dependencies = {
      "folke/twilight.nvim",
    },
    cmd = {
      "ZenMode",
      "ZenModeDisable",
    },
    keys = {
      { "gz", "<cmd>ZenMode<CR>", mode = "n" },
    },
    opts = {
      window = {
        --backdrop = .95,
        width   = .90,  -- .90 => 90%
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- Lua
  {
    "folke/twilight.nvim",
    lazy = true,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}
