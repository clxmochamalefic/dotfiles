-- ---------------------------------------------------------------------------
-- DDC PLUGINS
-- ---------------------------------------------------------------------------

local utils = require("utils")
local km_opts = require("const.keymap")

local ddc_config = require("plugins.plugin.config.ddc")

local pum_insert_relative = vim.fn["pum#map#insert_relative"]
local pum_select_relative = vim.fn["pum#map#select_relative"]
local pum_confirm = vim.fn["pum#map#confirm"]
local pum_cancel = vim.fn["pum#map#cancel"]
local pum_visible = vim.fn["pum#visible"]
local ddc_manual_complete = vim.fn["ddc#map#manual_complete"]
local ddc_hide = vim.fn["ddc#hide"]

local vsnip = {
  expandable = vim.fn["vsnip#expandable"],
  available = vim.fn["vsnip#available"],
  jumpable = vim.fn["vsnip#jumpable"],
}

-- local ddcmanualcomp = false

local function pumvisible()
  local r = vim.fn["pum#visible"]()
  utils.io.debug_echo("pumvisible: ", tostring(r))
  return r
  --  return vim.fn["pum#visible"]()
end

local function ddc_init()
  utils.io.begin_debug("ddc_init")

  vim.fn["ddc#custom#patch_global"](ddc_config.global.get_config())
  vim.fn["ddc#custom#patch_filetype"]({'noice'}, ddc_config.notice.get_config())
  

  --  use ddc.
  vim.fn["ddc#enable"]()
  vim.fn["ddc#enable_cmdline_completion"]()
  vim.fn["ddc#enable_terminal_completion"]()

  utils.io.end_debug("ddc_init")
end

local function ddc_preference()
  utils.io.begin_debug("ddc_preference")

  --  Key mappings
  --  For insert mode completion
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-n>",
    rhs = "",
    opts = {
      callback = function()
        if pumvisible() then
          -- ddcmanualcomp = false
          vim.fn["pum#map#insert_relative"](1)
        elseif vim.fn["ddc#map#can_complete"]() then
          -- ddcmanualcomp = true
          vim.fn["ddc#map#manual_complete"]()
        else
          return "<C-n>"
        end
      end,
    },
  })
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-p>",
    rhs = "",
    opts = {
      callback = function()
        if pumvisible() then
          -- ddcmanualcomp = false
          vim.fn["pum#map#insert_relative"](-1)
        elseif vim.fn["ddc#map#can_complete"]() then
          -- ddcmanualcomp = true
          vim.fn["ddc#map#manual_complete"]()
        else
          return "<C-p>"
        end
      end,
    },
  })
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-e>",
    rhs = function()
      if pumvisible() then
        vim.fn["pum#map#cancel"]()
        return ""
      else
        return "<C-e>"
      end
    end,
    opts = km_opts.e,
  })
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-y>",
    rhs = function()
      if pumvisible() then
        vim.fn["pum#map#confirm"]()
        return ""
      end
    end,
    opts = km_opts.e,
  })
  -- Tab key select completion item
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<Tab>",
    rhs = function()
      --if pumvisible() then
      --  vim.fn["pum#map#confirm"]()
      --  return ""
      --end
      if pumvisible() then
        -- ddcmanualcomp = false
        vim.fn["pum#map#insert_relative"](1)
      --elseif vim.fn["ddc#map#can_complete"]() then
      --  -- ddcmanualcomp = true
      --  vim.fn["ddc#map#manual_complete"]()
      else
        return "<Tab>"
      end
    end,
    opts = km_opts.e,
  })
  -- Enter key select completion item
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<CR>",
    --rhs   = function()
    --  if pumvisible() then
    --    vim.fn["ddc#map#manual_complete"]()
    --  else
    --    return "<CR>"
    --  end
    --end,
    rhs = function()
      if pumvisible() then
        vim.fn["pum#map#confirm"]()
        return ""
      end
      return "<CR>"
    end,
    opts = km_opts.e,
  })
  -- Manually open the completion menu
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-Space>",
    rhs = function()
      if pumvisible() then
        vim.fn["ddc#map#manual_complete"]()
        return ""
      else
        return "<C-Space>"
      end
    end,
    opts = {
      replace_keycodes = false,
      expr = true,
      desc = "[ddc.vim] Manually open popup menu",
    },
  })
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-l>",
    rhs = function()
      if pumvisible() then
        vim.fn["ddc#map#extend"]()
        return ""
      else
        return "<C-l>"
      end
    end,
    opts = km_opts.ns,
  })
  --  utils.io.keymap_set({
  --    mode  = { "i", "c", "t" },
  --    lhs   = '<C-x><C-f>',
  --    rhs   = function()
  --      if pumvisible() then
  --        vim.fn["ddc#map#manual_complete"]('path')
  --        return ""
  --      else
  --        return '<C-x><C-f>'
  --      end
  --    end,
  --    opts  = km_opts.ns
  --  })

  utils.io.end_debug("ddc_preference")
end

local function snippet_preference()
  utils.io.begin_debug("snippet_preference")

  utils.io.keymap_set({
    mode = { "i", "s" },
    lhs = "<Tab>",
    rhs = function()
      if vsnip.expandable() == 1 then
        utils.io.feedkey("<Plug>(vsnip-expand)", "")
        return ""
      elseif vsnip.available(1) == 1 then
        utils.io.feedkey("<Plug>(vsnip-expand-or-jump)", "")
        return ""
      else
        return "<Tab>"
      end
    end,
    opts = km_opts.e,
  })
  utils.io.keymap_set({
    mode = { "i", "s" },
    lhs = "<S-Tab>",
    rhs = function()
      if vsnip.jumpable(-1) == 1 then
        utils.io.feedkey("<Plug>(vsnip-jump-prev)", "")
        return ""
      else
        return "<S-Tab>"
      end
    end,
    opts = km_opts.e,
  })

  utils.io.end_debug("snippet_preference")
end

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
      --      'matsui54/ddc-buffer',
      --  'ddc-dictionary',
      "LumaKernel/ddc-source-file",
      "tani/ddc-fuzzy",
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

      'vim-skk/skkeleton',

      "matsui54/denops-popup-preview.vim",
      "matsui54/denops-signature_help",
    },
    event = {
      "InsertEnter"
    },
    config = function()
      ddc_init()
      ddc_preference()
      snippet_preference()
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
    "matsui54/denops-popup-preview.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/pum.vim",
    },
    event = { "User DenopsReady" },
    config = function()
      vim.g.popup_preview_config = {
        delay = 10,
        maxWidth = 100,
        winblend = vim.g.blend,
      }
      vim.api.nvim_call_function("popup_preview#enable", {})
    end,
    init = function() end,
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
