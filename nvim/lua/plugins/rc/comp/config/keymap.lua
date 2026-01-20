---@diagnostic disable: undefined-global
local utils = require("utils")
local km_opts = require("const.keymap")

-- exprをつけないと、元々の `<CR>` が動いてくれない
local opts_4insert           = km_opts.n
local opts_4insert_with_key  = km_opts.en
local opts_4command          = km_opts.en
local opts_4term             = km_opts.ens

local pum_insert_relative = vim.fn["pum#map#insert_relative"]
local pum_select_relative = vim.fn["pum#map#select_relative"]
local pum_confirm = vim.fn["pum#map#confirm"]
local pum_cancel = vim.fn["pum#map#cancel"]
local pum_current_item = vim.fn["pum#current_item"]
local ddc_manual_complete = vim.fn["ddc#map#manual_complete"]
-- local ddc_hide = vim.fn["ddc#hide"]

local function is_pum_visible()
  local isVisible = vim.fn["pum#visible"]()
  utils.io.debug_echo("pumvisible: ", tostring(isVisible))
  return isVisible
end

local is_pum_entered = function ()
  vim.fn["pum#entered"]()
end

local pum_incr = function()
  --pum_insert_relative(1)
  pum_insert_relative(1)
end

local pum_decr = function()
  --pum_insert_relative(-1)
  pum_insert_relative(-1)
end

---
--- @class keymap_opts
---| mapped_key                       # [string] handle_else()を実行したときの戻り値
---| is_return_key_when_can_complete  # [boolean] handle_can_complete()を実行したときに `mapped_key` を返すか / true: 返す
---| handle_pumvisible                # [function] pumvisible=trueの時の実行
---| handle_can_complete              # [function] ddc#map#can_complete=trueの時の実行
---| handle_else                      # [function] 上述のいずれでもない場合の実行
---

---
--- @function on_pum_state
---
--- @param opts  # [keymap_opts]
local on_pum_state = function(opts)
  local v = ""
  if opts.is_return_key_when_can_complete or false then
    v = mapped_key
  end

  if is_pum_visible() then
    --vim.notify("__IS_PUM_VISIBLE__")
    --local item = pum_current_item()
    --vim.print(item)
      --vim.notify("__未選択__")
    opts.handle_pumvisible()

  elseif is_pum_entered() then
    --vim.notify("__IS_PUM_ENTERED__")
    opts.handle_pumvisible()

  elseif vim.fn["ddc#map#can_complete"]() then
    vim.notify("__IS_PUM_INVISIBLE_CAN_COMPLETE__")
    opts.handle_can_complete()

    --vim.notify("v: " .. v)
    return v

  else
    --vim.notify("__IS_PUM_INVISIBLE_AND_HAVENOT_COMPLETE__")
    opts.handle_else()
    return opts.mapped_key
  end
end

local M = {}

M.ddc_preference = function()
  utils.io.begin_debug("ddc_preference")

  --  Key mappings
  --  For insert mode completion
  utils.io.keymap_set({
    mode = { "i" },
    lhs = "<C-n>",
    rhs = function()
      on_pum_state({
        mapped_key = "<C-n>",
        handle_pumvisible = pum_incr,
        handle_can_complete = ddc_manual_complete,
        handle_else = function()  end,
      })
    end,
    opts = opts_4insert,
  })
  utils.io.keymap_set({
    mode = { "t" },
    lhs = "<C-n>",
    rhs = function()
      on_pum_state({
        mapped_key = "<C-n>",
        handle_pumvisible = pum_incr,
        handle_can_complete = ddc_manual_complete,
        handle_else = function()  end,
      })
    end,
    opts = opts_4term,
  })
  utils.io.keymap_set({
    mode = { "c", },
    lhs = "<C-n>",
    rhs = function()
      on_pum_state({
        mapped_key = "<C-n>",
        handle_pumvisible = pum_incr,
        handle_can_complete = ddc_manual_complete,
        handle_else = function()  end,
      })
    end,
    opts = opts_4command,
  })
  utils.io.keymap_set({
    mode = { "i" },
    lhs = "<C-p>",
    rhs = function()
      on_pum_state({
        mapped_key = "<C-p>",
        handle_pumvisible = pum_decr,
        handle_can_complete = ddc_manual_complete,
        handle_else = function()  end,
      })
    end,
    opts = opts_4insert,
  })
  utils.io.keymap_set({
    mode = { "t" },
    lhs = "<C-p>",
    rhs = function()
      on_pum_state({
        mapped_key = "<C-p>",
        handle_pumvisible = pum_decr,
        handle_can_complete = ddc_manual_complete,
        handle_else = function()  end,
      })
    end,
    opts = opts_4term,
  })
  utils.io.keymap_set({
    mode = { "c", },
    lhs = "<C-p>",
    rhs = function()
      on_pum_state({
        mapped_key = "<C-p>",
        handle_pumvisible = pum_decr,
        handle_can_complete = ddc_manual_complete,
        handle_else = function()  end,
      })
    end,
    opts = opts_4command,
  })
  --utils.io.keymap_set({
  --  mode = { "i", "c", "t" },
  --  lhs = "<C-e>",
  --  rhs = function()
  --    utils.io.end_debug("ddc: <C-e>")
  --    if is_pum_visible() then
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
      if is_pum_visible() then
        pum_confirm()
        return ""
      end
    end,
    opts = km_opts.n,
  })
  -- Tab key select completion item
  utils.io.keymap_set({
    mode = { "i" },
    lhs = "<Tab>",
    rhs = function()
      on_pum_state({
        mapped_key = "<Tab>",
        is_return_key_when_can_complete = true,
        handle_pumvisible = pum_confirm,
        handle_can_complete = function()  end,
        handle_else = function()  end,
      })
    end,
    --opts = km_opts.bns,
    opts = opts_4insert_with_key,
  })
  utils.io.keymap_set({
    mode = { "c" },
    lhs = "<Tab>",
    rhs = function()
      on_pum_state({
        mapped_key = "<Tab>",
        is_return_key_when_can_complete = true,
        handle_pumvisible = pum_confirm,
        handle_can_complete = function()  end,
        handle_else = function()  end,
      })
    end,
    opts = km_opts.n,
    --opts = opts_4insert_with_key,
  })
  -- (ON INSERT MODE ONLY) Enter key select completion item
  utils.io.keymap_set({
    mode = { "i" },
    lhs = "<CR>",
    rhs = function()
      utils.io.end_debug("ddc: <CR>")
      if is_pum_visible() then
        pum_confirm()
      end

      return "<CR>"
    end,
    -- exprをつけないと、元々の `<CR>` が動いてくれない
    opts = km_opts.en,
  })
  utils.io.keymap_set({
    mode = { "i", "c", "t" },
    lhs = "<C-l>",
    rhs = function()
      utils.io.end_debug("ddc: <C-l>")
      if is_pum_visible() then
        vim.fn["ddc#map#extend"]()
        return ""
      else
        return "<C-l>"
      end
    end,
    opts = km_opts.n,
  })

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
    mode = { "i", },
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
    opts = opts_4insert_with_key,
  })

  utils.io.end_debug("snippet_preference")
end


return M
