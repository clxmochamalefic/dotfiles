-- ---------------------------------------------------------------------------
--  BUILD SYSTEM PREFERENCES
-- ---------------------------------------------------------------------------

return {
  lazy = true,
  event = { "VeryLazy" },
  "HiPhish/gradle.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  cmd = {
    -- Echo an OK
    "GradleHanshake",
    -- Raise an error
    "GradleThrow",
    -- Display a list of Gradle tasks
    "GradleTasks",
  },
  config = function() end,
}
