-- ---------------------------------------------------------------------------
-- LSPSAGA CONFIGS
-- ---------------------------------------------------------------------------

local keymap = vim.keymap

--
-- see: https://nvimdev.github.io/lspsaga/finder/
--
-- # DEFAULT Options
-- These are default options in finder section:
--
-- - max_height = 0.5
--    - max_height of the finder window (float layout)
-- - left_width = 0.3
--    - Width of the left finder window (float layout)
-- - right_width = 0.3
--    - Width of the right finder window (float layout)
-- - default = 'ref+imp'
--    - Default search results shown, ref for “references” and imp for “implementation”
-- - methods = {}
--    - Keys are alias of LSP methods. Values are LSP methods, which you want show in finder. More info below
--    - For instance, methods = { 'tyd' = 'textDocument/typeDefinition' }
-- - layout = 'float' available value is normal and float
--    - normal will use the normal layout window priority is lower than command layout
-- - filter = {}
--    - Keys are LSP methods. Values are a filter handler. Function parameter are client_id and result
-- - silent = false
--    - If it’s true, it will disable show the no response message
--
-- # DEFAULT Keymap
-- These are default keymaps in finder.keys table section:
--
-- - shuttle = '[w' shuttle bettween the finder layout window
-- - toggle_or_open = 'o' toggle expand or open
-- - vsplit = 's' open in vsplit
-- - split = 'i' open in split
-- - tabe = 't' open in tabe
-- - tabnew = 'r' open in new tab
-- - quit = 'q' quit the finder, only works in layout left window
-- - close = '<C-c>k' close finder
--

return {
  -- lspsaga
  --    (winbar) lspsaga.Breadcrumbs => window header line symbol list
  {
    lazy = true,
    "nvimdev/lspsaga.nvim",
    event = { "LspAttach" },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>,", "<cmd>Lspsaga finder<CR>", mode = "n" },
    },
    opts = {
      finder = {
        max_height = 0.6,
        default = "tyd+ref+imp+def",
        keys = {
          toggle_or_open = "<CR>",
          vsplit = { "v", "[" },
          split = { "s", "]" },
          tabnew = "t",
          tab = "T",
          quit = "q",
          close = "<Esc>",
        },
        methods = {
          tyd = "textDocument/typeDefinition",
        },
      },
      -- https://nvimdev.github.io/lspsaga/lightbulb/
      -- hide lightbulb icon in anumber col  number col
      ui = {
        code_action = "",
      },
    },
  },
}
