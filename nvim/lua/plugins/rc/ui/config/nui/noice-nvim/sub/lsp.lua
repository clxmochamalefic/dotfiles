-- ---------------------------------------------------------------------------
-- LSP CONFIG FOR NOICE-NVIM
-- ---------------------------------------------------------------------------

local _throttle = 1000 / 30

--- @class noice_config
--- @field override table
--- @field hover table
--- @field signature table
--- @field message table
--- @field documentation table
--- @field notify table
--- @field progress table
local M = {
  override = {
    ---- override the default lsp markdown formatter with Noice
    --["vim.lsp.util.convert_input_to_markdown_lines"] = false,
    ---- override the lsp markdown formatter with Noice
    --["vim.lsp.util.stylize_markdown"] = false,
    ---- override cmp documentation with Noice (needs the other options to work)
    --["cmp.entry.get_documentation"] = false,
  },
  hover = {
    enabled = false,
    --view = "mini",
  },
  signature = {
    enabled = false,
    --view = "mini",
  },
  message = {
    enabled = false,
    view = "notify",
    opts = {},
  },
  documentation = {
    enabled = false,
    --view = "mini",
  },
  notify = {
    enabled = true,
    view = "notify",
  },
  progress = {
    enabled = true,
    format = "lsp_progress",
    format_done = "lsp_progress_done",
    throttle = _throttle,
    --view = "mini",
  },
}

return M
