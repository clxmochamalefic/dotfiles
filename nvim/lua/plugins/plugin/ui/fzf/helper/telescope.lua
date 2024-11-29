-- ---------------------------------------------------------------------------
-- TELESCOPE PLUGIN HELPER (fuzzy finder / fzf)
-- ---------------------------------------------------------------------------

M = {}

local utils = require("utils")
local winpick = require("plugins.plugin.config.winpick")

M.setup = function()
  M.action_state = require("telescope.actions.state")
  M.actions = require("telescope.actions")
  M.transform_mod = require("telescope.actions.mt").transform_mod

  winpick.import_depends()
  M.winpick = winpick

  -- define actrions
  local mod = {}
  mod.winpick = function()
    local winid = M.winpick.choose_for_focus()
    local entry = M.action_state.get_selected_entry()
    if winid then
      utils.try_catch({
        try = function()
          if M.win_count() <= 1 then
            vim.cmd("edit " .. entry.filename)
            return
          end

          local my_winpick = require("plugins.plugin.config.winpick")
          my_winpick.choose_for_focus()
          --entry.lnum
          vim.cmd("edit " .. entry.filename)
        end,
        catch = function()
          vim.cmd("edit " .. entry.filename)
        end,
      })
      vim.api.nvim_set_current_win(winid)
    end
  end
  M.mod = M.transform_mod(mod)
end

return M
