-- ---------------------------------------------------------------------------
-- TELESCOPE PLUGINS (fuzzy finder / fzf)
-- ---------------------------------------------------------------------------

local g = vim.g
local fn = vim.fn
local lsp = vim.lsp
local keymap = vim.keymap

local myutils = require("utils")

local builtin = nil

--
-- telescope.nvim ビルトインを取得する
-- 純粋に毎回 `require` 書くの面倒くさかった
--
function GetBuiltin()
  if builtin == nil then
    builtin = require('telescope.builtin')
  end
  return builtin
end

--
-- telescope builtin 向けのデフォルト設定
--
function GetDefaultOpts()
  return {
    search_dirs = { myutils.fs.get_project_root_current_buf() }
  }
end

--
-- telescope.nvim ビルトインの `find_files` をコールする
--
-- @param opts options: default => GetDefaultOpts()
--
function CallBuiltinFindFiles(opts)
  opts = opts or GetDefaultOpts()
  GetBuiltin().find_files(opts)
end
--
-- telescope.nvim ビルトインの `live_grep` をコールする
--
-- @param opts options: default => default_opts
--
function CallBuiltinLiveGrep(opts)
  opts = opts or GetDefaultOpts()
  GetBuiltin().live_grep(opts)
end
--
-- telescope.nvim 拡張の `live_grep_args` をコールする
--
-- @param opts options: default => GetDefaultOpts()
--
function CallBuiltinLiveGrepArgs(opts)
  opts = opts or GetDefaultOpts()
  require("telescope").extensions.live_grep_args.live_grep_args(opts)
end

--
-- telescope.nvim ビルトインの `buffer` をコールする
-- bufferの一覧をfzfする
--
-- @param opts options: default => default_opts
--
function CallBuiltinBuffer(opts)
  opts = opts or {}
  GetBuiltin().buffers(opts)
end

--
-- telescope.nvim 拡張の `help_tags` をコールする
-- vimヘルプをfzfする
--
-- @param opts options: default => default_opts
--
function CallBuiltinHelpTags(opts)
  opts = opts or {}
  GetBuiltin().help_tags(opts)
end

--
-- telescope.nvim 拡張の `frecency` をコールする
-- 開いた際のバッファのファイルが管理されている `.git` フォルダの位置を親フォルダとしてfzfする
--
-- @param opts options: default => default_opts
--
function CallFrecencyCurrentDir()
  local project_root = myutils.fs.get_project_root_current_buf()
  vim.cmd("Telescope frecency workspace=" .. project_root .. "<CR>")
end


return {
  {
    lazy = true,
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      'nvim-telescope/telescope-ui-select.nvim',
    },
    cmd = {
      'Telescope',
      'Telescope buffers',

      'Telescope oldfiles',
      'Telescope find_files',

      'Telescope live_grep',

      'Telescope git_status',
      'Telescope git_commits',

      'Telescope frecency',
    },
    keys = {
      { "Z",          CallBuiltinBuffer,                            { mode = "n", desc = 'Telescope: buffers', } },
      { "<leader>f",  CallBuiltinFindFiles,                         { mode = "n", desc = 'Telescope: Find files', } },
      { "<leader>h",  CallBuiltinHelpTags,                          { mode = "n", desc = 'Telescope: help tags', } },
      { "<leader>b",  CallFrecencyCurrentDir,                       { mode = "n", desc = 'Telescope: frecency workspace={project_root}', } },
      { '<leader>g',  CallBuiltinLiveGrep,                          { mode = 'n', desc = 'Telescope: live grep', } },
      { '<leader>G',  CallBuiltinLiveGrepArgs,                      { mode = 'n', desc = 'Telescope: live grep args', } },
      { "<leader>a",  "<Cmd>Telescope frecency<CR>",                { mode = "n", desc = 'Telescope: frecency', } },
      { "<leader>s",  "<Cmd>Telescope frecency workspace=CWD<CR>",  { mode = "n", desc = 'Telescope: frecency workspace=CWD', } },
    },
    event = {
      'VimEnter',
    },
    config = function ()

      --local builtin = require('telescope.builtin')

      --keymap.set('n', '<leader>f',  BuiltinFindFilesWrapper, { desc = 'Telescope: Find files', })
      --keymap.set('n', 'Z',          builtin.buffers,    { desc = 'Telescope: buffers', })
      --keymap.set('n', '<leader>h',  builtin.help_tags,  { desc = 'Telescope: help tags', })
      --keymap.set('n', '<leader>a',  "<Cmd>Telescope frecency workspace=CWD<CR>",  { desc = 'Telescope: frecency workspace=CWD', })

      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
          file_ignore_patterns = {
            -- 検索から除外するものを指定
            "^.git/",
            "^.cache/",
            "^Library/",
            "Parallels",
            "^Movies",
            "^Music",
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
            db_root = env.join_path(env.getHome(), ".cache", "frecency"),
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            disable_devicons = false,
            workspaces = {
              ["conf"]    = env.join_path(env.getHome(), ".cache"),
              ["data"]    = env.join_path(env.getHome(), ".local", "share"),
              ["project"] = env.join_path(env.getHome(), "repos"),
--              ["wiki"]    = env.join_path(env.getHome(), "wiki"),
--              ["conf"]    = "/home/my_username/.config",
--              ["data"]    = "/home/my_username/.local/share",
--              ["project"] = "/home/my_username/projects",
--              ["wiki"]    = "/home/my_username/wiki"
            }
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            },
            layout_config = {
              width = 0.4,
              height = 16
            }

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
        },
      }

    end
  },
  {
    lazy = true,
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    init = function()
      if not myutils.depends.has('fzf') then
        myutils.depends.install('fzf', { winget = 'fzf' })
      end
    end,
    config = function()
      require("telescope").load_extension("fzf")
    end
  },
  {
    lazy = true,
    "nvim-telescope/telescope-frecency.nvim",
    event = {
      'VimEnter',
    },
    init = function()
    end,
    config = function()
      --require("telescope").load_extension("frecency")
    end,
  },
  {
    lazy = true,
    "nvim-telescope/telescope-live-grep-args.nvim" ,
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
    event = {
      'VimEnter',
    },
    keys = {
    },
    init = function()
      if not myutils.depends.has('ripgrep') then
        myutils.depends.install('ripgrep', { winget = 'BurntSushi.ripgrep.MSVC' })
      end
    end,
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
