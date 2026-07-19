-- ---------------------------------------------------------------------------
-- TELESCOPE PLUGINS (fuzzy finder / fzf)
-- ---------------------------------------------------------------------------

local debug = require("utils.debug")
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
local paste_reg_to_prompt = function()
  local text = vim.fn.getreg('+')
  vim.api.nvim_paste(text, false, -1)
end
local paste_search_to_prompt = function()
  local text = vim.fn.getreg('/')
  local len = string.len(text)

  if text:startswith("\\<") then
    text = string.sub(text, 3, len-2)
    len = len - 2
  end
  if text:endswith("\\>") then
    text = string.sub(text, 1, len-2)
    len = len - 2
  end

  vim.api.nvim_paste(text, false, -1)
end

local function get_mappings(actions)
  if actions == nil then
    return {}
  end
  vim.fn.getreg("/")

  return {
    i = {
      --["<esc>"] = actions.close,
      ["<C-v>"] = paste_reg_to_prompt,
      ["<C-b>"] = paste_search_to_prompt,
    },
    n = {
      ["p"] = paste_reg_to_prompt,
      ["P"] = paste_search_to_prompt,

      -- vertical split show
      ["["] = actions.select_vertical,
      ["v"] = actions.select_vertical,
      -- horizontal split show
      ["]"] = actions.select_horizontal,
      ["s"] = actions.select_horizontal,

      ["<Tab>"] = actions.select_tab,
      ["t"] = actions.select_tab,

      ["<CR>"] = actions.select_default,
    },
  }
end

--telescope.nvim: config start94516.5604644 [+0] (+0)
--telescope.nvim: done `nvim_create_autocmd`94516.5605167 [+0] (+5.2300005336292e-05)
--telescope.nvim: done `get_mappings()`94516.5605354 [+0] (+7.1000002208166e-05)
--telescope.nvim: done `get_themes()`94516.5605562 [+0] (+9.180000051856e-05)
--telescope.nvim: done `setup()`94516.5616961 [+0] (+0.0012317000073381)


local function get_themes(themes)
  if themes == nil then
    return {}
  end
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
      "nvim-telescope/telescope-fzf-native.nvim",
      --"nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "pbogut/fzf-mru.vim",
      "nvim-telescope/telescope-ui-select.nvim",

      "xiyaowong/telescope-emoji.nvim",

      "delphinus/telescope-memo.nvim",

      -- NOTE: Lua のリストは 1 始まりなので [0] だと nil になり依存に入らない
      require("plugins.rc.ui.notify")[1],
    },
    cmd = {
      "Telescope",
      "Telescope buffers",

      "Telescope oldfiles",
      "Telescope find_files",

      "Telescope live_grep",

      "Telescope git_status",
      "Telescope git_commits",

      "Telescope resume",

      "Telescope notify",
    },
    keys = {
      -- buffer
      { "z",         tu.CallBuiltinBuffer,    { mode = "n", desc = "Telescope: buffers" } },
      -- find file
      { "<leader>f", tu.CallBuiltinFindFiles, { mode = "n", desc = "Telescope: Find files" } },
      -- find help
      { "<F1>", tu.CallBuiltinHelpTags,       { mode = "n", desc = "Telescope: help tags" } },

      -- freecency in project root
      --{
      --  "<leader>b",
      --  tu.CallFrecencyCurrentDir,
      --  { mode = "n", desc = "Telescope: frecency workspace={project_root}" },
      --},
      -- live grep
      { "<leader>g", tu.CallBuiltinLiveGrep,  { mode = "n", desc = "Telescope: live grep" } },

      -- symbol list
      { "<leader>s", get_symlist,             { mode = "n", desc = "Telescope: builtin lsp doc symbols" } },
      { "<leader>r", tu.CallBuiltinResume,    { mode = "n", desc = "Telescope: resume" } },

      { "<leader>n", "<cmd>Telescope notify<cr>",  { mode = "n", desc = "Telescope: notify" } },
    },
    opts = {
      pickers = {
        buffers = {
          path_display = tu.FileNameFirst,
        },
        find_files = {
          path_display = tu.FileNameFirst,
          -- 取り込み中のプレビュー再読込がメインループを塞いで
          -- 入力の反映が遅れるため、find_files ではプレビューを使わない
          previewer = false,
          -- 除外は Lua パターン(file_ignore_patterns)ではなく fd 側で行う
          -- Lua パターンは Windows のパスセパレータ(`\`)にマッチしない上に
          -- 全エントリ×全パターンの照合コストがかかる
          find_command = {
            "fd",
            "--type", "f",
            "--color", "never",
            -- 巨大ツリー(ホームディレクトリ直下等)で ,f したときの暴走ガード
            -- 上限に達した場合は一覧が不完全になる点に注意
            "--max-results", "30000",
            "--exclude", ".git",
            "--exclude", ".cache",
            "--exclude", ".claude",
            "--exclude", ".vs",
            "--exclude", ".vscode",
            "--exclude", "node_modules",
            "--exclude", "vendor",
            "--exclude", "framework",
            "--exclude", "build",
            "--exclude", "dist",
          },
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
        -- 検索から除外するものを指定
        -- NOTE: ここは Lua パターンで全エントリと照合されるため最小限にする
        --       (パスは Windows では `\` 区切りなので `[/\\]` で両対応させる)
        --       find_files / live_grep の除外は fd / rg 側のオプションで行う
        file_ignore_patterns = {
          "%.git[/\\]",
          "node_modules[/\\]",
          "vendor[/\\]",
          "%-lock%.json$",
        },
        vimgrep_arguments = {
          -- ripggrepコマンドのオプション
          -- NOTE: `-uu`(ignore 無視 + 隠しファイル)は vendor / node_modules
          --       まで全走査して極端に遅くなるので使わない
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
          "--glob=!node_modules/",
          "--glob=!vendor/",
          "--glob=!framework/",
          "--glob=!build/",
          "--glob=!dist/",
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
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "TelescopeResults",
      --   callback = function(ctx)
      --     vim.api.nvim_buf_call(ctx.buf, function()
      --       vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      --       vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
      --     end)
      --   end,
      -- })
    end,
    config = function(_, opts)
      debug.show_now_ms("telescope.nvim: config start")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })
      debug.show_now_ms("telescope.nvim: done `nvim_create_autocmd`")

      local act = require("telescope.actions")
      local map = get_mappings(act)
      opts.defaults.mappings = map
      debug.show_now_ms("telescope.nvim: done `get_mappings()`")

      local thm = require("telescope.themes")
      opts.defaults["ui-select"] = get_themes(thm)
      debug.show_now_ms("telescope.nvim: done `get_themes()`")

      local t = require("telescope")
      t.setup(opts)
      debug.show_now_ms("telescope.nvim: done `setup()`")

      -- fzf-native (Cソーター) が使えるなら有効化する
      -- これがないと Lua 製ソーターになり大量エントリで極端に遅くなる
      pcall(t.load_extension, "fzf")
      debug.show_now_ms("telescope.nvim: done `load_extension(fzf)`")

      builtin = t.builtin
    end,
  },
}
