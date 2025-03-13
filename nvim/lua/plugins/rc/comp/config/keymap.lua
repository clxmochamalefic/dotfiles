---@diagnostic disable: undefined-global
local utils = require("utils")
local km_opts = require("const.keymap")

local pum_insert_relative = vim.fn["pum#map#insert_relative"]
local pum_select_relative = vim.fn["pum#map#select_relative"]
local pum_confirm = vim.fn["pum#map#confirm"]
local pum_cancel = vim.fn["pum#map#cancel"]
local ddc_manual_complete = vim.fn["ddc#map#manual_complete"]
-- local ddc_hide = vim.fn["ddc#hide"]

local function pumvisible()
  local r = vim.fn["pum#visible"]()
  utils.io.debug_echo("pumvisible: ", tostring(r))
  return r
  --  return vim.fn["pum#visible"]()
end

local M = {}

M.ddc_preference = function()
  utils.io.begin_debug("ddc_preference")

  --  Key mappings
  --  For insert mode completion
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-n>",
    rhs = function()
      utils.io.end_debug("ddc: <C-n>")
      if pumvisible() then
        utils.io.end_debug("pum:visibled")
        -- ddcmanualcomp = false
        pum_insert_relative(1)
      elseif vim.fn["ddc#map#can_complete"]() then
        -- ddcmanualcomp = true
        utils.io.end_debug("ddc: manual completion")
        ddc_manual_complete()
      else
        utils.io.end_debug("ddc: default")
        return "<C-n>"
      end
    end,
    opts = km_opts.n,
  })
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-p>",
    rhs = function()
      utils.io.end_debug("ddc: <C-p>")
      if pumvisible() then
        -- ddcmanualcomp = false
        pum_insert_relative(-1)
      elseif vim.fn["ddc#map#can_complete"]() then
        -- ddcmanualcomp = true
        utils.io.end_debug("ddc: manual completion")
        ddc_manual_complete()
      else
        utils.io.end_debug("ddc: default")
        return "<C-p>"
      end
    end,
    opts = km_opts.n,
  })
  --utils.io.keymap_set({
  --  mode = { "i", "c", "t" },
  --  lhs = "<C-e>",
  --  rhs = function()
  --    utils.io.end_debug("ddc: <C-e>")
  --    if pumvisible() then
  --      pum_cancel()
  --      return ""
  --    else
  --      return "<C-e>"
  --    end
  --  end,
  --  opts = km_opts.n,
  --})
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-y>",
    rhs = function()
      utils.io.end_debug("ddc: <C-y>")
      if pumvisible() then
        pum_confirm()
        return ""
      end
    end,
    opts = km_opts.n,
  })
  -- Tab key select completion item
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<Tab>",
    rhs = function()
      utils.io.end_debug("ddc: <Tab>")
      --if pumvisible() then
      --  vim.fn["pum#map#confirm"]()
      --  return ""
      --end
      if pumvisible() then
        -- ddcmanualcomp = false
        pum_confirm()
        --elseif vim.fn["ddc#map#can_complete"]() then
        --  -- ddcmanualcomp = true
        --  vim.fn["ddc#map#manual_complete"]()
      else
        return "<Tab>"
      end
    end,
    opts = km_opts.n,
  })
  -- (ON INSERT MODE ONLY) Enter key select completion item
  utils.io.keymap_set({
    mode = { "i" },
    lhs = "<CR>",
    --rhs   = function()
    --  if pumvisible() then
    --    vim.fn["ddc#map#manual_complete"]()
    --  else
    --    return "<CR>"
    --  end
    --end,
    rhs = function()
      utils.io.end_debug("ddc: <CR>")
      if pumvisible() then
        pum_confirm()
      end

      return "<CR>"
    end,
    -- exprをつけないと、元々の `<CR>` が動いてくれない
    opts = km_opts.en,
  })
  -- Manually open the completion menu
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-Space>",
    rhs = function()
      utils.io.end_debug("ddc: <C-Space>")
      if pumvisible() then
        ddc_manual_complete()
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
      utils.io.end_debug("ddc: <C-l>")
      if pumvisible() then
        vim.fn["ddc#map#extend"]()
        return ""
      else
        return "<C-l>"
      end
    end,
    opts = km_opts.n,
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
  --    opts  = km_opts.n
  --  })

  utils.io.end_debug("ddc_preference")
end

M.snippet_preference = function()
  utils.io.begin_debug("snippet_preference")

  local vsnip = {
    expandable = vim.fn["vsnip#expandable"],
    available = vim.fn["vsnip#available"],
    jumpable = vim.fn["vsnip#jumpable"],
  }

  utils.io.keymap_set({
    mode = { "i", "s" },
    lhs = "<Tab>",
    rhs = function()
      utils.io.end_debug("ddc-snip: <Tab>")
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
    -- exprをつけないと、元々の `<CR>` が動いてくれない
    opts = km_opts.en,
  })
  --utils.io.keymap_set({
  --  mode = { "i", "s" },
  --  lhs = "<S-Tab>",
  --  rhs = function()
  --    utils.io.end_debug("ddc-snip: <S-Tab>")
  --    if vsnip.jumpable(-1) == 1 then
  --      utils.io.feedkey("<Plug>(vsnip-jump-prev)", "")
  --      return ""
  --    else
  --      return "<C-d>"
  --    end
  --  end,
  --  -- exprをつけないと、元々の `<CR>` が動いてくれない
  --  opts = km_opts.en,
  --})

  utils.io.end_debug("snippet_preference")
end


return M
