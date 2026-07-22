--local preference = require("plugins.rc.ui.statusline.config")
local colours = require("plugins.rc.ui.statusline.config.colour")
local sl_util = require("plugins.rc.ui.statusline.util")

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    --event = {
    --  "VeryLazy",
    --},
    opts = require("plugins.rc.ui.statusline.config"),
    config = function(_, opts)
      --opt.laststatus = 3
      local ll = require("lualine")
      ll.setup(opts)
    end,
  },
  {
    "arkav/lualine-lsp-progress",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cond = true,
    lazy = true,
    event = {
      "LspAttach",
    },
    opts = {
      "lsp_progress",
      display_components = {
        "lsp_client_name",
        "spinner",
        {
          "title",
          "percentage",
          "message"
        }
      },
      colors = {
        percentage = colours.cyan,
        title = colours.cyan,
        message = colours.cyan,
        spinner = colours.cyan,
        lsp_client_name = colours.magenta,
        use = true,
      },
      separators = {
        component = " ",
        progress = " | ",
        percentage = {
          pre = "",
          post = "%% "
        },
        title = {
          pre = "",
          post = ": "
        },
        lsp_client_name = {
          pre = "[",
          post = "]"
        },
        spinner = {
          pre = "",
          post = ""
        },
        message = {
          pre = "(",
          post = ")",
          commenced = "In Progress",
          completed = "Completed"
        },
      },
      timer = {
        progress_enddelay = 500,
        spinner = 1000,
        lsp_client_name_enddelay = 1000
      },
      spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
    },
    config = function(_, opts)
      -- lualine-lsp-progress ------------------------------
      -- Inserts a component in lualine_c at left section
      local ll = require("lualine")
      local p = ll.get_config()
      sl_util.ins_lual_c(p, opts)
      -- lsp_progress の後にキャップを挿入して中央側の三角形を描画する
      sl_util.ins_lual_c(p, require("plugins.rc.ui.statusline.config").inner_cap_right)
      ll.setup(p)
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cond = true,
    lazy = true,
    event = {
      "FileReadPost",
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
      },
    },
    config = function(_, opts)
      -- vim.opt.termguicolors = true
      require("bufferline").setup(opts)
      --require("keybindings.bufferline-kb").basic()
    end,
  },
}
