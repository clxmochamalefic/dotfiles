local colour = require("plugins.rc.ui.statusline.config.colour")

local options = {
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
}

local sections = {
  lualine_a = { "mode" },
  lualine_b = { "branch", "diff", "diagnostics" },
  lualine_c = { { "filename", path = 4 } },
  lualine_x = {},
  --lualine_y = { { "progress", color = colour.sub2 }, { "filetype", color = colour.sub2 } },
  --lualine_z = { { "location", color = colour.sub3 }, { "filetype", color = colour.sub3 } },
  lualine_y = { { "encoding" }, { "fileformat" }, { "filetype" } },
  lualine_z = { { "progress" }, { "location" } },
}
local inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { { "filename", path = 4 } },
  lualine_x = { "location" },
  lualine_y = {},
  lualine_z = {},
}

local tab_windows = {
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
}

local tab_tabs = {
  {
    "tabs",
    mode = 1,
    --tabs_color = {
    --  active = colors.violet,
    --},
  },
}

local tabline = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = tab_windows,
  lualine_x = tab_tabs,
  lualine_y = {},
  lualine_z = {},
}

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

local extensions = {
  "fzf",
  "lazy",
  "man",
  "mason",
  "nvim-tree",
  "nvim-dap-ui",
  "toggleterm",
}

local M = {
  options = options,
  sections = sections,
  inactive_sections = inactive_sections,
  tabline = tabline,
  extensions = extensions,
}

return M
