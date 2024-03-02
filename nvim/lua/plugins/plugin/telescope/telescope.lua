-- ---------------------------------------------------------------------------
-- TELESCOPE PLUGINS (fuzzy finder / fzf)
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local fs = vim.fs
local api = vim.api
local lsp = vim.lsp
local keymap = vim.keymap

local myutils = require("utils")

local builtin = nil
local tu = require("plugins.plugin.telescope.util")

return {
  {
    lazy = true,
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-ui-select.nvim",

      "delphinus/telescope-memo.nvim",
    },
    cmd = {
      "Telescope",
      "Telescope buffers",

      "Telescope oldfiles",
      "Telescope find_files",

      "Telescope live_grep",

      "Telescope git_status",
      "Telescope git_commits",

      "Telescope frecency",

      -- memolist
      "Telescope memo list",
      "Telescope memo grep",
      "Telescope memo live_grep",
      "Telescope memo grep_string",
    },
    keys = {
      { "Z", tu.CallBuiltinBuffer, { mode = "n", desc = "Telescope: buffers" } },
      { "<leader>f", tu.CallBuiltinFindFiles, { mode = "n", desc = "Telescope: Find files" } },
      { "<leader>h", tu.CallBuiltinHelpTags, { mode = "n", desc = "Telescope: help tags" } },
      {
        "<leader>b",
        tu.CallFrecencyCurrentDir,
        { mode = "n", desc = "Telescope: frecency workspace={project_root}" },
      },
      { "<leader>g", tu.CallBuiltinLiveGrep, { mode = "n", desc = "Telescope: live grep" } },
      {
        "<leader>G",
        tu.CallBuiltinLiveGrepArgs,
        { mode = "n", desc = "Telescope: live grep args" },
      },
      { "<leader>a", "<Cmd>Telescope frecency<CR>", { mode = "n", desc = "Telescope: frecency" } },
      {
        "<leader>s",
        "<Cmd>Telescope frecency workspace=CWD<CR>",
        { mode = "n", desc = "Telescope: frecency workspace=CWD" },
      },
    },
    event = {
      "VimEnter",
    },
    config = function()
      api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          api.nvim_buf_call(ctx.buf, function()
            fn.matchadd("TelescopeParent", "\t\t.*$")
            api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })

      local actions = require("telescope.actions")
      require("telescope").setup({
        pickers = {
          buffers = {
            path_display = tu.FileNameFirst,
          },
          find_files = {
            path_display = tu.FileNameFirst,
          },
          live_grep = {
            path_display = tu.FileNameFirst,
          },
          frecency = {
            path_display = tu.FileNameFirst,
          },
        },
        defaults = {
          layout_config = {
            height = 0.7,
            anchor = "N",
          },
          file_ignore_patterns = {
            -- 検索から除外するものを指定
            "^.git/",
            "^.cache/",
            "^Library/",
            "Parallels",
            "^Movies",
            "^Music",
            "node%_modules/.*",
          },
          mappings = {
            i = {
              --["<esc>"] = actions.close,
            },
            n = {
              -- vertical split show
              ["["] = actions.select_vertical,
              ["<C-v>"] = actions.select_vertical,
              ["v"] = actions.select_vertical,
              -- horizontal split show
              ["]"] = actions.select_horizontal,
              ["<C-s>"] = actions.select_horizontal,
              ["s"] = actions.select_horizontal,

              ["<Tab>"] = actions.select_tab,
              ["t"] = actions.select_tab,

              ["<CR>"] = actions.select_default,
            },
          },
          vimgrep_arguments = {
            -- ripggrepコマンドのオプション
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-uu",
          },
        },
        extensions = {
          -- ソート性能を大幅に向上させるfzfを使う
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          frecency = {
            db_root = myutils.env.join_path(myutils.env.getHome(), ".cache", "frecency"),
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            disable_devicons = false,
            workspaces = {
              ["conf"] = myutils.env.join_path(myutils.env.getHome(), ".cache"),
              ["data"] = myutils.env.join_path(myutils.env.getHome(), ".local", "share"),
              ["project"] = myutils.env.join_path(myutils.env.getHome(), "repos"),
              --              ["wiki"]    = env.join_path(env.getHome(), "wiki"),
              --              ["conf"]    = "/home/my_username/.config",
              --              ["data"]    = "/home/my_username/.local/share",
              --              ["project"] = "/home/my_username/projects",
              --              ["wiki"]    = "/home/my_username/wiki"
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
            layout_config = {
              width = 0.4,
              height = 16,
            },

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
      })
    end,
  },
}
