local default_mru_ignore = {
}

local instance_opts = nil
local func_mru = nil
local function open_mru(opts)
  if (func_mru == nil) then
    func_mru = require("telescope").extensions.mru_files.mru_files
  end
  opts = opts or instance_opts or {}
  func_mru(opts)
end

return {
  {
    'mikemcbride/telescope-mru.nvim',
    dependencies = {
      "nvim-telescope/telescope.nvim",
      'junegunn/fzf',
    },
    lazy = true,
    keys = {
      { "<leader>m", "<Cmd>Telescope fzf_mru<CR>", { mode = "n", desc = "Telescope: fzf_mru" } },
    },
    cmd = {
      'Telescope fzf_mru',
    },
    opts = {
      ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
      end,
      max_items = 50,
    },
    init = function()
      vim.api.nvim_create_user_command("TelescopeMru", open_mru, {})
    end,
    config = function(_, opts)
      instance_opts = opts

      local t = require("telescope")
      t.load_extension("mru_files")

      func_mru = t.extensions.mru_files.mru_files
    end,
  },
  --{
  --  lazy = true,
  --  'pbogut/fzf-mru.vim',
  --  dependencies = {
  --    "nvim-telescope/telescope.nvim",
  --    'junegunn/fzf',
  --  },
  --  -- mru
  --  keys = {
  --    { "<leader>m", "<Cmd>Telescope fzf_mru<CR>", { mode = "n", desc = "Telescope: fzf_mru" } },
  --  },
  --  cmd = {
  --    'Telescope fzf_mru',
  --  },
  --  config = function()
  --    require('telescope').load_extension('fzf_mru')
  --  end,
  --},
}
