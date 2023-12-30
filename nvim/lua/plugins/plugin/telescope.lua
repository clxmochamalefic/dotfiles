local g = vim.g
local fn = vim.fn

local myutils = require("utils")
local env = require("utils.sub.env")
local depends = require("utils.sub.depends")

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
      { "Z", "Telescope buffers", mode = "n" },
      { "<leader>f", "Telescope oldfiles", mode = "n" },
    },
    event = {
      'VimEnter',
    },
    config = function ()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("frecency")
      require("telescope").load_extension("live_grep_args")

      local lgas = require("telescope").extensions.live_grep_args.live_grep_args
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f',  builtin.find_files, { desc = 'Telescope: Find files', })
      --vim.keymap.set('n', '<leader>g',  builtin.live_grep,  { desc = 'Telescope: live grep', })
      --vim.keymap.set('n', '<C-g>',      builtin.live_grep,  { desc = 'Telescope: live grep', })
      vim.keymap.set('n', '<leader>g',  lgas,  { desc = 'Telescope: live grep args', })
      vim.keymap.set('n', '<C-g>',      lgas,  { desc = 'Telescope: live grep args', })
      vim.keymap.set('n', 'Z',          builtin.buffers,    { desc = 'Telescope: buffers', })
      vim.keymap.set('n', '<leader>h',  builtin.help_tags,  { desc = 'Telescope: help tags', })
      vim.keymap.set('n', '<leader>a',  "<Cmd>Telescope frecency workspace=CWD<CR>",  { desc = 'Telescope: frecency workspace=CWD', })


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
--          frecency = {
--            db_root = env.join_path(env.getHome(), ".cache", "frecency"),
--            show_scores = false,
--            show_unindexed = true,
--            ignore_patterns = { "*.git/*", "*/tmp/*" },
--            disable_devicons = false,
--            workspaces = {
--              ["conf"]    = env.join_path(env.getHome(), ".cache"),
--              ["data"]    = env.join_path(env.getHome(), ".local", "share"),
--              ["project"] = env.join_path(env.getHome(), "repos"),
----              ["wiki"]    = env.join_path(env.getHome(), "wiki"),
----              ["conf"]    = "/home/my_username/.config",
----              ["data"]    = "/home/my_username/.local/share",
----              ["project"] = "/home/my_username/projects",
----              ["wiki"]    = "/home/my_username/wiki"
--            }
--          },
        },
      }
    end
  },
  {
    lazy = true,
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    init = function()
      if not depends.has('fzf') then
        depends.install('fzf', { winget = 'fzf' })
      end
    end,
    config = function()
    end
  },
  {
    lazy = true,
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
    },
    init = function()
      local sqliteZipPath = env.join_path(env.getHome(), ".cache", "sqlite-dll-win-x64.zip")
      local sqliteDestPath = env.join_path(env.getHome(), ".lib", "sqlite")

      myutils.io.echo(sqliteZipPath)
      myutils.io.echo(sqliteDestPath)

      local curlCmd = "!curl https://www.sqlite.org/2023/sqlite-dll-win-x64-3440200.zip -o " .. sqliteZipPath
      local unzipCmd = "!Expand-Archive -LiteralPath " .. sqliteZipPath .. " -DestinationPath " .. sqliteDestPath .. " -Force"

          vim.cmd(curlCmd)
          vim.cmd(unzipCmd)
      if not depends.has('sqlite3') then
        depends.install('sqlite3', {winget = 'SQLite.SQLite' })
        if env.is_windows() then
          --vim.cmd([[!curl https://www.sqlite.org/2023/sqlite-dll-win-x64-3440200.zip -o ${sqliteZipPath}]])
          --vim.cmd([[!Expand-Archive -LiteralPath ${sqliteZipPath} -DestinationPath ${sqliteDestPath} -Force]])
          --vim.cmd("!curl https://www.sqlite.org/2023/sqlite-dll-win-x64-3440200.zip -o " .. sqliteZipPath)
          --vim.cmd("!Expand-Archive -LiteralPath " .. sqliteZipPath .. " -DestinationPath " .. sqliteDestPath .. " -Force")
          vim.cmd(curlCmd)
          vim.cmd(unzipCmd)
        end
      end
    end,
    config = function()
      local sqliteDestPath = env.join_path_slash(env.getHome(), ".lib", "sqlite")
      local dllPath = env.join_path_slash(sqliteDestPath, "sqlite3.dll")
      g.sqlite_clib_path = dllPath
    end,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim" ,
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
    
    init = function()
      if not depends.has('ripgrep') then
        depends.install('ripgrep', { winget = 'BurntSushi.ripgrep.MSVC' })
      end
    end,
    config = function()
    end,
  },
}
