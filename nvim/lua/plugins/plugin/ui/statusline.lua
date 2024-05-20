local utils = require("utils")
local colour = require("const.colour")

local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local colors = {
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      -- 'kdheepak/tabline.nvim',
      "arkav/lualine-lsp-progress",
      "akinsho/bufferline.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      opt.laststatus = 3

      local config = {
        options = {
          icons_enabled = true,
          theme = "palenight",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true, -- global line enable
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 4 } },
          lualine_x = {},
          --lualine_y = { { "progress", color = colour.sub2 }, { "filetype", color = colour.sub2 } },
          --lualine_z = { { "location", color = colour.sub3 }, { "filetype", color = colour.sub3 } },
          lualine_y = { { "encoding" }, { "fileformat" }, { "filetype" } },
          lualine_z = { { "progress" }, { "location" } },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", path = 4 } },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "windows",
              mode = 2,
              show_filename_only = false,
              show_modified_status = true, -- Shows indicator when the window is modified.
              use_mode_colors = true,
              --windows_color = {
              --  active = colors.violet,
              --},
              disabled_buftypes = { "quickfix", "prompt" },
            },
          },
          lualine_x = {
            {
              "tabs",
              mode = 1,
              --tabs_color = {
              --  active = colors.violet,
              --},
            },
          },
          lualine_y = {},
          lualine_z = {},
        },
        ---- winbar はほかのプラグインと競合するので使わない
        --winbar = {
        --  lualine_a = { { "filetype", icon_only = true } },
        --  lualine_b = {},
        --  lualine_c = {},
        --  lualine_x = { { "filename", path = 4 } },
        --  lualine_y = { { "encoding" } },
        --  lualine_z = { { "fileformat" } },
        --},
        --inactive_winbar = {
        --  lualine_a = { { "filetype", icon_only = true } },
        --  lualine_b = {},
        --  lualine_c = {},
        --  lualine_x = { { "filename", path = 4 } },
        --  lualine_y = { { "encoding" } },
        --  lualine_z = { { "fileformat" } },
        --},
        extensions = {
          "fzf",
          "lazy",
          "man",
          "mason",
          "nvim-tree",
          "nvim-dap-ui",
          "toggleterm",
        },
      }

      -- lualine-lsp-progress ------------------------------
      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x ot right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      --ins_left({
      --  "lsp_progress",
      --  display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
      --  colors = {
      --    percentage = colors.cyan,
      --    title = colors.cyan,
      --    message = colors.cyan,
      --    spinner = colors.cyan,
      --    lsp_client_name = colors.magenta,
      --    use = true,
      --  },
      --  separators = {
      --    component = " ",
      --    progress = " | ",
      --    percentage = { pre = "", post = "%% " },
      --    title = { pre = "", post = ": " },
      --    lsp_client_name = { pre = "[", post = "]" },
      --    spinner = { pre = "", post = "" },
      --    message = { pre = "(", post = ")", commenced = "In Progress", completed = "Completed" },
      --  },
      --  timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
      --  spinner_symbols = { "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘" },
      --})

      local ll = require("lualine")
      ll.setup(config)

      -- -- tabline.nvim ------------------------------
      -- require'tabline'.setup {
      --   -- Defaults configuration options
      --   enable = true,
      --   options = {
      --     -- If lualine is installed tabline will use separators configured in lualine by default.
      --     -- These options can be used to override those settings.
      --     section_separators = {'', ''},
      --     component_separators = {'', ''},
      --     max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
      --     show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
      --     show_devicons = true, -- this shows devicons in buffer section
      --     show_bufnr = false, -- this appends [bufnr] to buffer section,
      --     show_filename_only = false, -- shows base filename only instead of relative path in filename
      --     modified_icon = "+ ", -- change the default modified icon
      --     modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
      --     show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
      --   }
      -- }
      --
      -- vim.cmd[[
      --   set guioptions-=e " Use showtabline in gui vim
      --   set sessionoptions+=tabpages,globals " store tabpages and globals in session
      -- ]]
    end,
  },
  --{
  --  "arkav/lualine-lsp-progress",
  --},
  --  {
  --    'akinsho/bufferline.nvim',
  --    dependencies = {
  --      'nvim-tree/nvim-web-devicons',
  --    },
  --    config = function()
  --      -- bufferline
  --      local ok, bufferline = pcall(require, "bufferline")
  --      if not ok then
  --        utils.io.echoe('"akinsho/bufferline.nvim" not available')
  --        return
  --      end
  --      bufferline.setup({
  --        options = {
  --          mode = "buffers",
  --          close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
  --          left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
  --          indicator = {
  --            icon = '▎', -- this should be omitted if indicator style is not 'icon'
  --            style = 'icon',
  --          },
  --          buffer_close_icon = '',
  --          modified_icon = '●',
  --          close_icon = '',
  --          left_trunc_marker = '',
  --          right_trunc_marker = '',
  --          diagnostics = "nvim_lsp",
  --          offsets = {
  --            {
  --              filetype = "NvimTree",
  --              text = "File Explorer",
  --              text_align = "left",
  --              separator = true,
  --            },
  --          },
  --          separator_style = "slant",
  --          enforce_regular_tabs = true,
  --        },
  --      })
  --    end,
  --  },
}
