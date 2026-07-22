
local options = {
  icons_enabled = true,
  theme = "palenight",
  component_separators = { left = "", right = "" },
  section_separators   = { left = "", right = "" },
  disabled_filetypes   = {
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

local show_tag_stacks = function()
  -- tagstackの現在位置と全体の深さを取得 (例: 1/3)
  local current_idx = vim.fn.gettagstack().n
  local total_size = vim.fn.gettagstack().length

  if total_size == 0 then
    return ""
  else
    return string.format("Tags: %d/%d", current_idx, total_size)
  end
end

-- ハイライトグループの背景色を "#rrggbb" 形式で返す
local function get_hl_bg(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and hl.bg then
    return string.format("#%06x", hl.bg)
  end
  return "NONE"
end

-- lualine_y の中央側（左辺）に配置するキャップコンポーネント
-- "" (◄) をバー背景の上に lualine_y の背景色で描画し、セクションセパレーターに見せる
local inner_cap_left = {
  function() return "" end,
  color = function()
    return {
      fg = get_hl_bg("lualine_y_normal"),
      bg = get_hl_bg("StatusLine"),
    }
  end,
  padding   = { left = 0, right = 0 },
  separator = { left = "", right = "" },
}

-- lualine_c の中央側（右辺）に配置するキャップコンポーネント（init.lua 側で lsp_progress の後に挿入）
-- "" (►) を lualine_c 背景の上にバー背景色で描画する
local inner_cap_right = {
  function() return "" end,
  color = function()
    return {
      fg = get_hl_bg("StatusLine"),
      bg = get_hl_bg("lualine_c_normal"),
    }
  end,
  padding = { left = 0, right = 0 },
  separator = { left = "", right = "" },
}

local sections = {
  lualine_a = { "mode" },
  lualine_b = { "branch", "diff", "diagnostics" },
  lualine_c = { { "filename", path = 4 }, { show_tag_stacks, icon = '🏷️' }, },
  -- inner_cap_right は init.lua で lsp_progress の後に挿入される

  lualine_x = {},
  --lualine_y = { { "progress", color = colour.sub2 }, { "filetype", color = colour.sub2 } },
  --lualine_z = { { "location", color = colour.sub3 }, { "filetype", color = colour.sub3 } },
  lualine_y = { inner_cap_left, { "encoding" }, { "fileformat" }, { "filetype" } },
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
  inner_cap_right = inner_cap_right,
}

return M
