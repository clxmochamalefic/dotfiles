---@diagnostic disable: undefined-global
-- ---------------------------------------------------------------------------
-- DDC PLUGINS
-- ---------------------------------------------------------------------------

local _COLOUR = require("const.colour")
local ddc_config = require("plugins.rc.comp.config")

local vsnip = {
  expandable = vim.fn["vsnip#expandable"],
  available = vim.fn["vsnip#available"],
  jumpable = vim.fn["vsnip#jumpable"],
}

-- local ddcmanualcomp = false

return {
  {
    "Shougo/ddc.vim",
    lazy = true,
    dependencies = {
      "vim-denops/denops.vim",

      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",

      "Shougo/ddc-source-lsp",
      "Shougo/ddc-source-around",
      --      'Shougo/ddc-buffer',
      'matsui54/ddc-source-buffer',
      --  'ddc-dictionary',
      "LumaKernel/ddc-source-file",
      "tani/ddc-fuzzy",
      "Shougo/ddc-source-cmdline",
      "Shougo/ddc-cmdline-history",
      "delphinus/ddc-shell-history",
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-source-omni",
      --  'ddc-path',
      "Shougo/ddc-sorter_rank",
      --      'hrsh7th/vim-vsnip',
      --      'hrsh7th/vim-vsnip-integ',
      "rafamadriz/friendly-snippets",
      --      'yuki-yano/tsnip.nvim',
      "hrsh7th/vim-vsnip",
      "uga-rosa/ddc-source-vsnip",

      "Shougo/ddc-converter_remove_overlap",
      "matsui54/ddc-converter_truncate",

      "Milly/windows-clipboard-history.vim",

      --'vim-skk/skkeleton',

      "matsui54/denops-popup-preview.vim",
      "matsui54/denops-signature_help",
    },
    event = ddc_config.events,
    config = function()
      ddc_config.keymap.ddc_preference()
      ddc_config.keymap.snippet_preference()
      ddc_config.ddc_init()
    end,
  },

  --  {
  --    lazy = true,
  --    'matsui54/ddc-buffer',
  --  },

  -- deprecated
  --  {
  --    lazy = true,
  --    'yuki-yano/tsnip.nvim',
  --    dependencies = {
  --      'vim-denops/denops.vim',
  --    },
  --    config = function()
  --      if pcall(require, "nui.input") then
  --        vim.g.tsnip_use_nui = true
  --      end
  --    end,
  --  },
  --

  {
    lazy = true,
    "Shougo/ddc-source-lsp",
    dependencies = {
      "vim-denops/denops.vim",
    },
  },
  {
    lazy = true,
    "uga-rosa/ddc-source-vsnip",
    dependencies = {
      "vim-denops/denops.vim",
      "hrsh7th/vim-vsnip",
    },
    config = function() end,
  },
  {
    lazy = true,
    "hrsh7th/vim-vsnip",
  },
  {
    lazy = true,
    cond = false,
    "matsui54/denops-popup-preview.vim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "vim-denops/denops.vim",
      "Shougo/pum.vim",
    },
    event = {
      --"User DenopsReady"
      "VeryLazy",
      "TextChangedP",
      "MenuPopup",
      "QuickFixCmdPost",
    },
    config = function()
      vim.g.popup_preview_config = {
        --delay = 10,
        delay = 1000,
        maxWidth = 100,
        winblend = _COLOUR.get_winblend() ,
      }

      local async = require("plenary.async")

      -- 設定そのものを遅延ロード
      --vim.defer_fn(function()
      --  vim.api.nvim_call_function("popup_preview#enable", {})
      --end, 500)

      local fn_name = "popup_preview#enable"
      local fn = vim.fn[fn_name]
      vim.notify("popup-preview: ENTERED")
      async.run(fn, function(result)
        vim.notify("popup-preview: GET READY!!" .. result)
      end)

      --vim.notify("popup-preview: ENTERED")
      --async.run(function()
      --  vim.api.nvim_call_function("popup_preview#enable", {})
      --  vim.notify("popup-preview: GET READY!!")
      --end)
    end,
    --init = function() end,
  },
  {
    lazy = true,
    "matsui54/denops-signature_help",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/pum.vim",
    },
    event = { "User DenopsReady" },
    config = function()
      vim.g.signature_help_config = {
        contentsStyle = "currentLabel",
        viewStyle = "virtual",
      }
      vim.api.nvim_call_function("signature_help#enable", {})
    end,
  },
}
