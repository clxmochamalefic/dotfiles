-- ---------------------------------------------------------------------------
-- rust_analyzer - rust LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

local M = {}

M.setup = function(baseLc, lc, opts)
  opts = opts or {}

  opts.root_dir = baseLc.util.root_pattern("Cargo.toml")
  opts.cmd = { "ra-multiplex" }
  opts.filetypes = { "rust" }
  opts.settings = {
    ["rust-analyzer"] = {
      lruCapacity = 64,
      enableEnhancedTyping = false,
      assist = {
        importGranularity = "module",
        importPrefix = "by_crate",
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
        allTargets = false,
      },
      cargo = {
        loadOutDirsFromCheck = true,
        -- allFeatures = true,
      },
      completion = {
        autoimport = {
          enable = true,
        },
      },
      diagnostics = {
        disabled = {
          "unresolved-macro-call",
        },
      },
    },
  }
  lc.setup(opts)
end

return M
