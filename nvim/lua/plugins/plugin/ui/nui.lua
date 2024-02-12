local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

return {
  {
    "VonHeikemen/fine-cmdline.nvim",
    lazy = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = { "VimEnter" },
    config = function()
      -- nui.nvim --------------------------------------------------
      local popup = require("nui.popup")
      local event = require("nui.utils.autocmd").event

      local messagePopup = popup({
        enter = true,
        focusable = true,
        border = {
          style = "rounded",
          text = {
            top = "[ messages ]",
            top_align = "center",
          },
        },
        position = "50%",
        size = {
          width = "80%",
          height = "60%",
        },
      })

      -- unmount component when cursor leaves buffer
      messagePopup:on(event.BufLeave, function()
        messagePopup:unmount()
      end)

      vim.api.nvim_create_user_command("PopMess", function()
        -- mount/open the component
        messagePopup:mount()
        local message = api.nvim_command("messages")
        if message == "" then
          message = "<Message is empty...>"
        end
        vim.api.nvim_buf_set_lines(messagePopup.bufnr, 0, 1, false, { message })

        --keymap.set("n", "q", api.nvim_command('q'))
      end, { nargs = 0 })

      -- fine-cmdline by nui.nvim --------------------------------------------------
      require("fine-cmdline").setup({
        cmdline = {
          enable_keymaps = true,
          smart_history = true,
          prompt = " :  ",
        },
        popup = {
          position = {
            row = "10%",
            col = "50%",
          },
          size = {
            width = "60%",
          },
          border = {
            style = "rounded",
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        hooks = {
          before_mount = function(input)
            -- code
          end,
          after_mount = function(input)
            -- code
          end,
          set_keymaps = function(imap, feedkeys)
            -- code
          end,
        },
      })

      -- vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
    end,
    keys = {
      { ":", "<cmd>FineCmdline<CR>", mode = "n" },
    },
  },
}
