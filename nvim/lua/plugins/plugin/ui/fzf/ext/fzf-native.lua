local myutils = require("utils")

local function init()
  if not myutils.depends.has("fzf") then
    myutils.depends.install("fzf", { winget = "junegunn.fzf" })
  end
  if not myutils.depends.has("cmake") then
    myutils.depends.install("cmake", { winget = "Kitware.CMake" })
  end
end

return {
  {
    lazy = true,
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    config = function()
      init()
      require("telescope").load_extension("fzf")
    end,
  },
}
