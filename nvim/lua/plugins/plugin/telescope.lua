
return {
  {
    lazy = true,
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    cmd = {
      'Telescope',
      'Telescope buffers',
      'Telescope oldfiles',
      'Telescope find_files',
      'Telescope live_grep',
      'Telescope git_status',
      'Telescope git_commits',
    },
    event = {
      'VimEnter',
    },
    config = function ()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, {})
      vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
      vim.keymap.set('n', 'Z',          builtin.buffers, {})
      vim.keymap.set('n', '<leader>h', builtin.help_tags, {})


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
        },
      }
      require("telescope").load_extension("fzf")
    end
  },
  {
    lazy = true,
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
}
