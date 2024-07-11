return {
  {
    lazy = true,
    "rgroli/other.nvim",
    cmd = { "Other" },
    keys = {
      { "<leader>." },
    },
    config = function()
      require("other-nvim").setup({
        mappings = {
          -- builtin mappings
          "livewire",
          "angular",
          "laravel",
          "rails",
          "golang",
          -- custom mapping
          {
            pattern = "/path/to/file/src/app/(.*)/.*.ext$",
            target = "/path/to/file/src/view/%1/",
            transformer = "lowercase",
          },
        },
        keybindings = {
          ["<cr>"] = "open_file_by_command()",
          ["<esc>"] = "close_window()",
          q = "close_window()",
          t = "open_file_tabnew()",
          o = "open_file()",
          v = "open_file_vs()",
          s = "open_file_sp()",
        },
        transformers = {
          -- defining a custom transformer
          lowercase = function(inputString)
            return inputString:lower()
          end,
        },
        style = {
          -- How the plugin paints its window borders
          -- Allowed values are none, single, double, rounded, solid and shadow
          border = "solid",

          -- Column seperator for the window
          seperator = "|",

          -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
          width = 0.7,

          -- min height in rows.
          -- when more columns are needed this value is extended automatically
          minHeight = 2,
        },
      })

      vim.api.nvim_set_keymap("n", "<leader>.", "<cmd>:Other<CR>", { noremap = true, silent = true })
    end,
  },
}
