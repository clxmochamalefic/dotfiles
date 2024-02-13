-- ---------------------------------------------------------------------------
-- LSP CONFIG FOR NOICE-NVIM
-- ---------------------------------------------------------------------------

return {
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
  progress = {
    enabled = true,
    format = "lsp_progress",
    format_done = "lsp_progress_done",
    throttle = 1000 / 30,
    --view = "mini",
  },
}
