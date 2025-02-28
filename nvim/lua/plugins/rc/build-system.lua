-- ---------------------------------------------------------------------------
--  BUILD SYSTEM PREFERENCES
-- ---------------------------------------------------------------------------

return {
  {
    lazy = true,
--    event = { "VeryLazy" },
    ft = {"gradle", "java", "kotlin", "scala", "groovy"},
    "HiPhish/gradle.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    cmd = {
      -- Echo an OK
      "GradleHanshake",
      -- Raise an error
      "GradleThrow",
      -- Display a list of Gradle tasks
      "GradleTasks",
    },
    config = function() end,
  },
  {
    "trimclain/builder.nvim",
    --event = "VeryLazy",
    cmd = {
      -- build or run
      "Build",
      -- build
      "Balt",
      "Brun",
    },
    -- stylua: ignore
    keys = {
      { "<C-S-B>", function() require("builder").build() end, desc = "Balt" },
      --{ "<C-B>", function() require("builder").build() end, desc = "Build" }
    },
    opts = {
      -- location of Builder buffer; opts: "bot", "top", "vert" or float
      type = "bot",
      -- percentage of width/height for type = "vert"/"bot" between 0 and 1
      size = 0.2,
      -- size of the floating window for type = "float"
      float_size = {
        height = 0.8,
        width = 0.8,
      },
      -- which border to use for the floating window (see `:help nvim_open_win`)
      float_border = "none",
      -- number or table { above, right, below, left }, similar to CSS padding
      padding = 0,
      -- show/hide line numbers in the Builder buffer
      line_number = false,
      -- automatically save before building
      autosave = true,
      -- keymaps to close the Builder buffer, same format as for vim.keymap.set
      close_keymaps = { "q", "<Esc>" },
      -- measure the time it took to build
      measure_time = true,
      -- empty lines between the measured time message and the output data
      time_to_data_padding = 0,
      -- support colorful output by using to `:terminal` instead of a normal nvim buffer;
      -- for `color = true` the `type = "float"` isn't allowed
      color = true,
      -- commands for building each filetype, can be a string or a table { cmd = "cmd", alt = "cmd" }; see below
      -- for lua and vim filetypes `:source %` will be used by default
      commands = {
        c = "gcc % -o $basename.out && ./$basename.out",
        cpp = "g++ % -o $basename.out && ./$basename.out",
        go = {
          cmd = "go run %",
          alt = "go build % && ./$basename",
        },
        java = {
          cmd = "java %",
          alt = "javac % && java $basename",
        },
        javascript = "node %",
        -- lua = "lua %", -- this will override the default `:source %` for lua files
        markdown = "MarkdownPreview %",
        python = "python %",
        rust = {
          cmd = "cargo run",
          alt = "cargo build",
        },
        sh = "sh %",
        typescript = "ts-node %",
        zsh = "zsh %",
      },
    },
    config = function(_, opts)
      local b = require("builder")
      b.setup(opts)
      vim.api.nvim_create_user_command("Balt", function()
        b.build()
      end, { desc = "Balt is Build with alt param" })
      vim.api.nvim_create_user_command("Brun", function()
        b.build({ alt = true })
      end, { desc = "Brun is run" })
    end,
  },
}
