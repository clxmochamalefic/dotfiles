local myutils = require("utils")

return {
  {
    lazy = true,
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    init = function()
      if not myutils.depends.has("fzf") then
        myutils.depends.install("fzf", { winget = "fzf" })
      end
    end,
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    lazy = true,
    "nvim-telescope/telescope-frecency.nvim",
    event = {
      "VimEnter",
    },
    init = function() end,
    config = function()
      --require("telescope").load_extension("frecency")
    end,
  },
}
