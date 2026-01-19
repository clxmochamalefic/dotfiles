-- ---------------------------------------------------------------------------
-- TELESCOPE PLUGINS (fuzzy finder / fzf)
-- ---------------------------------------------------------------------------

local tu = require("plugins.rc.ui.fzf._util")

local builtin = nil

--
-- Telescope: builtin lsp doc symbols
--
local function get_symlist()
  if (builtin == nil) then
    builtin = require("telescope.builtin")
  end
  builtin.lsp_document_symbols()
end

local function get_mappings(actions)
  actions = actions or require("telescope.actions")
  return {
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
  }
end

local function get_themes(themes)
  themes = themes or require("telescope.themes")
  return {
    themes.get_dropdown({
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
  }
end

return {
  {
    lazy = true,
    "nvim-telescope/telescope.nvim",
    --tag = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
      --"nvim-telescope/telescope-fzf-native.nvim",
      --"nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "pbogut/fzf-mru.vim",
      "nvim-telescope/telescope-ui-select.nvim",

      "xiyaowong/telescope-emoji.nvim",

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
    },
    keys = {
      -- buffer
      { "z",         tu.CallBuiltinBuffer,    { mode = "n", desc = "Telescope: buffers" } },
      -- find file
      { "<leader>f", tu.CallBuiltinFindFiles, { mode = "n", desc = "Telescope: Find files" } },
      -- find help
      { "<leader>h", tu.CallBuiltinHelpTags,  { mode = "n", desc = "Telescope: help tags" } },

      -- freecency in project root
      --{
      --  "<leader>b",
      --  tu.CallFrecencyCurrentDir,
      --  { mode = "n", desc = "Telescope: frecency workspace={project_root}" },
      --},
      -- live grep
      { "<leader>g", tu.CallBuiltinLiveGrep,  { mode = "n", desc = "Telescope: live grep" } },

      -- symbol list
      { "<leader>i", get_symlist,             { mode = "n", desc = "Telescope: builtin lsp doc symbols" } },
    },
    opts = {
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
        --frecency = {
        --  path_display = tu.FileNameFirst,
        --},
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
        --frecency = {
        --  db_root = myutils.env.join_path(myutils.env.getHome(), ".cache", "frecency"),
        --  show_scores = false,
        --  show_unindexed = true,
        --  ignore_patterns = { "*.git/*", "*/tmp/*" },
        --  disable_devicons = false,
        --  workspaces = {
        --    ["conf"] = myutils.env.join_path(myutils.env.getHome(), ".cache"),
        --    ["data"] = myutils.env.join_path(myutils.env.getHome(), ".local", "share"),
        --    ["project"] = myutils.env.join_path(myutils.env.getHome(), "repos"),
        --    --              ["wiki"]    = env.join_path(env.getHome(), "wiki"),
        --    --              ["conf"]    = "/home/my_username/.config",
        --    --              ["data"]    = "/home/my_username/.local/share",
        --    --              ["project"] = "/home/my_username/projects",
        --    --              ["wiki"]    = "/home/my_username/wiki"
        --  },
        --},
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })
    end,
    config = function(_, opts)
      local act = require("telescope.actions")
      local map = get_mappings(act)
      opts.defaults.mappings = map

      local thm = require("telescope.themes")
      opts.defaults["ui-select"] = get_themes(thm)

      local t = require("telescope")
      t.setup(opts)

      builtin = t.builtin
    end,
  },
}
