local utils = require("utils")

local g = vim.g
local o = vim.o
local v = vim.v
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not g.started_by_firenvim,
    "glacambre/firenvim",
    module = false,
    cond = not not vim.g.started_by_firenvim,
    --cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      utils.io.echo("shell: " .. o.shell)
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      --if g.started_by_firenvim == true then
      --  o.laststatus = 0
      --else
      --  o.laststatus = 2
      --end
      api.nvim_create_autocmd({ "UIEnter" }, {
        callback = function(event)
          local client = api.nvim_get_chan_info(v.event.chan).client
          if client ~= nil and client.name == "Firenvim" then
            --o.laststatus = 0
          end
        end,
      })

      local enableFireNvim = {
        cmdline = "neovim",
        selector = "textarea",
        takeover = "always",
        content = "text",
        priority = 100,
      }

      g.firenvim_config = {
        globalSettings = {
          alt = "all",
        },
        localSettings = {
          [".*"] = {
            selector = "",
            priority = 0,
          },
          ["github\\.com"] = enableFireNvim,
          ["developer\\.mozilla\\.org"] = enableFireNvim,
          ["ap-northeast-1.console.aws.amazon.com"] = enableFireNvim,
        },
      }
    end,
  },
  --{
  --  -- RESTapi testing tool
  --  lazy = true,
  --  'rest-nvim/rest.nvim',
  --  dependencies = {
  --    'nvim-lua/plenary.nvim',
  --    "nvim-neotest/nvim-nio",
  --  },
  --  event = { 'VeryLazy' },
  --  cmd = {
  --    'RestNvim',         -- can be use with <Plug>RestNvim
  --    'RestNvimPreview',  -- can be use with <Plug>RestNvimPreview
  --    'RestNvimLast',
  --    'RestLog',
  --    'RestSelectEnv',
  --  },
  --  config = function()
  --    require("rest-nvim").setup({
  --      -- Open request results in a horizontal split
  --      result_split_horizontal = false,
  --      -- Keep the http file buffer above|left when split horizontal|vertical
  --      result_split_in_place = false,
  --      -- stay in current windows (.http file) or change to results window (default)
  --      stay_in_current_window_after_split = false,
  --      -- Skip SSL verification, useful for unknown certificates
  --      skip_ssl_verification = false,
  --      -- Encode URL before making request
  --      encode_url = true,
  --      -- Highlight request on run
  --      highlight = {
  --        enabled = true,
  --        timeout = 150,
  --      },
  --      result = {
  --        -- toggle showing URL, HTTP info, headers at top the of result window
  --        show_url = true,
  --        -- show the generated curl command in case you want to launch
  --        -- the same request via the terminal (can be verbose)
  --        show_curl_command = false,
  --        show_http_info = true,
  --        show_headers = true,
  --        -- table of curl `--write-out` variables or false if disabled
  --        -- for more granular control see Statistics Spec
  --        show_statistics = false,
  --        -- executables or functions for formatting response body [optional]
  --        -- set them to false if you want to disable them
  --        formatters = {
  --          json = "jq",
  --          html = function(body)
  --            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
  --          end
  --        },
  --      },
  --      -- Jump to request line on run
  --      jump_to_request = false,
  --      env_file = '.env',
  --      custom_dynamic_variables = {},
  --      yank_dry_run = true,
  --      search_back = true,

  --      -- Tree-Sitter parser
  --      ensure_installed = { "http", "json" },
  --    })
  --  end
  --},
  {
    lazy = true,
    event = { "VeryLazy" },
    "eiji03aero/quick-notes",
    dependencies = {
      'junegunn/fzf',
      'tpope/vim-fugitive',
    },
    cmd = {
      "QuickNotesNew",
      "QuickNotesNewDiary",
      "QuickNotesNewGitBranch",
      "QuickNotesLsNotes",
      "QuickNotesLsDiary",
      "QuickNotesFzf",
    },
    config = function()
      vim.g.quick_notes_directory = vim.g.my_home_cache_path .. "/quick-notes/"
      vim.g.quick_notes_suffix = 'md'

      local function opts(desc)
        local bufnr = vim.fn["bufnr"]()
        return {
          desc = "quick-notes: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      local function quicknotes_new()
        vim.cmd([[call QuickNotesNew()]])
      end
      local function quicknotes_new_diary()
        vim.cmd([[call QuickNotesNewDiary()]])
      end
      local function quicknotes_new_gitbranch()
        vim.cmd([[call QuickNotesNewGitBranch()]])
      end
      local function quicknotes_ls_notes()
        vim.cmd([[call QuickNotesLsNotes()]])
      end
      local function quicknotes_ls_diary()
        vim.cmd([[call QuickNotesLsDiary()]])
      end
      local function quicknotes_fzf()
        vim.cmd([[call QuickNotesFzf()]])
      end

      api.nvim_create_user_command("QuickNotesNew", quicknotes_new, {})
      api.nvim_create_user_command("QuickNotesNewDiary", quicknotes_new_diary, {})
      api.nvim_create_user_command("QuickNotesNewGitBranch", quicknotes_new_gitbranch, {})
      api.nvim_create_user_command("QuickNotesLsNotes", quicknotes_ls_notes, {})
      api.nvim_create_user_command("QuickNotesLsDiary", quicknotes_ls_diary, {})
      api.nvim_create_user_command("QuickNotesFzf", quicknotes_fzf, {})

      api.nvim_create_user_command("Qn", quicknotes_ls_notes, {})

      api.nvim_create_user_command("Qnn", quicknotes_new, {})
      api.nvim_create_user_command("Qnd", quicknotes_new_diary, {})
      api.nvim_create_user_command("Qln", quicknotes_ls_notes, {})
      api.nvim_create_user_command("Qld", quicknotes_ls_diary, {})

      --local augroup_id = vim.api.nvim_create_augroup("quick-notes", {})
      --vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
      --  group = augroup_id,
      --  pattern = "*",
      --  callback = function()
      --    --vim.keymap.set("n", "<C-v>", close_wrap(api.node.open.vertical), opts("Open: Vertical Split"))

      --    vim.keymap.set("n", "^", cd_preference, opts("Open: my preference"))
      --    vim.keymap.set("n", "~", cd_home, opts("Open: $HOME"))
      --    vim.keymap.set("n", "\\", cd_repos, opts("Open: repos"))
      --    vim.keymap.set("n", "=", cd_docs, opts("Open: Documents"))

      --    vim.keymap.set("n", ">", "<Cmd>vertical resize +10<CR>", { noremap = true, buffer = true })
      --    vim.keymap.set("n", "<lt>", "<Cmd>vertical resize -10<CR>", { noremap = true, buffer = true })
      --  end,
      --})
    end,
  }
}
