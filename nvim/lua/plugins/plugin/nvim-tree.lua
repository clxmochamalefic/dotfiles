local g = vim.g

local nt = require("plugins.plugin.config.nvim-tree")

return {
  {
    lazy = true,
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "JMarkin/nvim-tree.lua-float-preview",
    },
    cmd = { "NvimTreeOpen" },
    keys = {
      { "z", "<cmd>NvimTreeOpen<CR>", mode = "n" },
    },
    event = { "VimEnter" },
    config = function()
      g.loaded_netrw = 1
      g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        on_attach = nt.on_attach,
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
          exclude = { ".env", ".env.*" },
        }
      })

      local function open_nvim_tree()
        require("nvim-tree.api").tree.open()
      end

      -- open nvim-tree on vim booted / nvim-treeをvim実行時に起動する
      vim.api.nvim_create_autocmd({ "VimEnter", "TabNewEntered" }, { callback = open_nvim_tree })
    end
  },
  {
    lazy = true,
    "JMarkin/nvim-tree.lua-float-preview",
    -- default
    opts = {
      -- wrap nvimtree commands
      wrap_nvimtree_commands = true,
      -- lines for scroll
      scroll_lines = 20,

      -- window config
      window = {
        style = "minimal",
        relative = "win",
        border = "rounded",
        wrap = false,
      },
      -- window =  {
      --   wrap = false,
      --   trim_height = false,
      --   open_win_config = function()
      --     local screen_w = vim.opt.columns:get()
      --     local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
      --     local window_w_f = (screen_w - WIDTH_PADDING * 2 -1) / 2
      --     local window_w = math.floor(window_w_f)
      --     local window_h = screen_h - HEIGHT_PADDING * 2
      --     local center_x = window_w_f + WIDTH_PADDING + 2
      --     local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

      --     return {
      --       style = "minimal",
      --       relative = "editor",
      --       border = "single",
      --       row = center_y,
      --       col = center_x,
      --       width = window_w,
      --       height = window_h
      --     }
      --   end
      -- }

      -- keymap
      mapping = {
        -- scroll down float buffer
        down = { "<C-d>" },
        -- scroll up float buffer
        up = { "<C-e>", "<C-u>" },
        -- enable/disable float windows
        toggle = { "<C-x>" },
      },

      -- hooks if return false preview doesn't shown
      hooks = {
        pre_open = function(path)
          -- if file > 5 MB or not text -> not preview
          local size = require("float-preview.utils").get_size(path)
          if type(size) ~= "number" then
            return false
          end
          local is_text = require("float-preview.utils").is_text(path)
          return size < 5 and is_text
        end,
        post_open = function(bufnr)
          return true
        end,
      },
    },
  },
}
