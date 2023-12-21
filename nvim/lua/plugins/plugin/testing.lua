local api = vim.api

return {
  {
    lazy = true,
    'nvim-neotest/neotest',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      'rcasia/neotest-java',
    },
    cmd = {
      "NeotestNear",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-java")({
            ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
          }),
          --require("neotest-python")({
          --  dap = { justMyCode = false },
          --}),
          --require("neotest-plenary"),
          --require("neotest-vim-test")({
          --  ignore_file_types = { "python", "vim", "lua" },
          --}),
        },
      })

      -- https://github.com/nvim-neotest/neotest?tab=readme-ov-file#usage
      local function execTestForCursorNear()
        require("neotest").run.run({strategy = "dap"})
      end
      local function stopTest()
        require("neotest").run.stop()
      end

      api.nvim_create_user_command("NeotestNear", execTestForCursorNear,  {})
      api.nvim_create_user_command("NeotestStop", stopTest,  {})
    end
  },
}
