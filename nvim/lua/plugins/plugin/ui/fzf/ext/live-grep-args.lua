local myutils = require("utils")

return {
  {
    lazy = true,
    "nvim-telescope/telescope-live-grep-args.nvim",
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
    event = {
      "VimEnter",
    },
    keys = {},
    init = function()
      if not myutils.depends.has("ripgrep") then
        myutils.depends.install("ripgrep", { winget = "BurntSushi.ripgrep.MSVC" })
      end
      if not myutils.depends.has("fd") then
        myutils.depends.install("fd", { apt = "find_fd", winget = "sharkdp.fd" })
      end
    end,
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
