local utils = require("utils")

local api = vim.api

return {
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

      vim.api.nvim_create_user_command("QuickNotesNew", quicknotes_new, {})
      vim.api.nvim_create_user_command("QuickNotesNewDiary", quicknotes_new_diary, {})
      vim.api.nvim_create_user_command("QuickNotesNewGitBranch", quicknotes_new_gitbranch, {})
      vim.api.nvim_create_user_command("QuickNotesLsNotes", quicknotes_ls_notes, {})
      vim.api.nvim_create_user_command("QuickNotesLsDiary", quicknotes_ls_diary, {})
      vim.api.nvim_create_user_command("QuickNotesFzf", quicknotes_fzf, {})

      vim.api.nvim_create_user_command("Qn", quicknotes_ls_notes, {})

      vim.api.nvim_create_user_command("Qnn", quicknotes_new, {})
      vim.api.nvim_create_user_command("Qnd", quicknotes_new_diary, {})
      vim.api.nvim_create_user_command("Qln", quicknotes_ls_notes, {})
      vim.api.nvim_create_user_command("Qld", quicknotes_ls_diary, {})

      ---- filetype: neotree
      --local augroup_id_on_neotree = vim.api.nvim_create_augroup("quick-notes-on-neo-tree", {})
      --vim.api.nvim_create_autocmd("FileType", {
      --  group = augroup_id_on_neotree,
      --  pattern = "neo-tree",
      --  callback = function()
      --    vim.keymap.set("n", "<leader>nn", quicknotes_ls_notes, { noremap = true })
      --    vim.keymap.set("n", "<leader>nd", quicknotes_ls_diary, { noremap = true })
      --  end
      --})

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
  },
  --{
  --  lazy = true, --Should work when lazy loaded, not tested
  --  "Al0den/notion.nvim",
  --  --cmd = {
  --  --  "NotionOpen",
  --  --  "NotionGetRaw",
  --  --  "NotionUpdate",
  --  --  "NotionGetNextEvent",
  --  --  "NotionGetNextEventName",
  --  --  "NotionGetNextEventDate",
  --  --  "NotionGetNextEventAt",
  --  --},
  --  event = { "VeryLazy" },
  --  dependencies = {
  --    "nvim-telescope/telescope.nvim",
  --    "nvim-lua/plenary.nvim",
  --  },
  --  opts = {
  --    autoUpdate = true, --Allow the plugin to automatically update the data from the Notion API
  --    open = "notion", --If not set, or set to something different to notion, will open in web browser
  --    keys = { --Menu keys
  --      deleteKey = "d",
  --      editKey = "e",
  --      openNotion = "o",
  --      itemAdd = "a",
  --      viewKey = "v"
  --    },
  --    delays = { --Delays before running specific actions
  --      reminder = 4000,
  --      format = 200,
  --      update = 10000
  --    },
  --    notifications = true, --Enable notifications
  --    editor = "light", --light/medium/full, changes the amount of data displayed in editor
  --    viewOnEdit = {
  --      enabled = true, --Enable double window, view and edit simultaneously
  --      replace = false --Replace current window with preview window
  --    },
  --    direction = "vsplit", --Direction windows will be opened in
  --    noEvent = "No events",
  --    debug = false --Enable some error messages on failed API calls
  --  },
  --  config = function(_, _)
  --    --local notion_components = require("notion.components")
  --    require("notion").setup()

  --    --vim.api.nvim_create_user_command("NotionOpen", function()
  --    --  require("notion").openMenu()
  --    --end, {})
  --    ---- Get raw output from the api, as a string
  --    --vim.api.nvim_create_user_command("NotionGetRaw", function()
  --    --  notion.raw()
  --    --end, {})
  --    ---- execute update notion-document
  --    --vim.api.nvim_create_user_command("NotionUpdate", function()
  --    --  notion.update({
  --    --    silent = false,
  --    --    window = nil
  --    --  })
  --    --end, {})

  --    ---- Get formatted earliest event
  --    --vim.api.nvim_create_user_command("NotionGetNextEvent", function()
  --    --  notion_components.nextEvent()
  --    --end, {})
  --    ---- Get next event name
  --    --vim.api.nvim_create_user_command("NotionGetNextEventName", function()
  --    --  notion_components.nextEventName()
  --    --end, {})
  --    ---- Get next event date with full date format
  --    --vim.api.nvim_create_user_command("NotionGetNextEventDate", function()
  --    --  notion_components.nextEventDate()
  --    --end, {})
  --    ---- Get next event name with short date format
  --    --vim.api.nvim_create_user_command("NotionGetNextEventAt", function()
  --    --  notion_components.nextEventShortDate()
  --    --end, {})
  --  end,
  --},
}
