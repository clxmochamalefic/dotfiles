local myutils = require("utils")

local tu = require("plugins.plugin.ui.fzf._util")

local function init()
  if not myutils.depends.has("ripgrep") then
    myutils.depends.install("ripgrep", { winget = "BurntSushi.ripgrep.MSVC" })
  end
  if not myutils.depends.has("fd") then
    myutils.depends.install("fd", { apt = "find_fd", winget = "sharkdp.fd" })
  end
end

return {
  {
    lazy = true,
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      'junegunn/fzf',
    },
    version = "^1.0.0",
    keys = {
      {
        "<leader>G",
        tu.CallBuiltinLiveGrepArgs,
        { mode = "n", desc = "Telescope: live grep args" }
      },
      -- live grep with args
      ---- freecency
      --{ "<leader>a", "<Cmd>Telescope frecency<CR>", { mode = "n", desc = "Telescope: frecency" } },
      ---- freecency in current dir
      --{
      --  "<leader>s",
      --  "<Cmd>Telescope frecency workspace=CWD<CR>",
      --  { mode = "n", desc = "Telescope: frecency workspace=CWD" },
      --},
    },
    build = init,
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
