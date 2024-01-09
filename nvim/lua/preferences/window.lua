-- ---------------------------------------------------------------------------
--  WINDOW AND FLOATING WINDOW PREFERENCES
-- ---------------------------------------------------------------------------

local api = vim.api

local M = {}

M.setup = function()
  api.nvim_create_user_command("CloseAllFloatingWindows", M.CloseAllFloatingWindows, {})
end

M.CloseAllFloatingWindows = function()
  local closed_windows = {}
  for _, win in ipairs(api.nvim_list_wins()) do
    local config = api.nvim_win_get_config(win)
    if config.relative ~= "" then  -- is_floating_window?                                    
      api.nvim_win_close(win, false)  -- do not force
      table.insert(closed_windows, win)
    end
  end

  print(string.format('Closed %d windows: %s', #closed_windows, vim.inspect(closed_windows)))
end


return M
