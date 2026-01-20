---@diagnostic disable: undefined-global

local colour_utils = require("utils.colour")

local M = {
  max_width         = 120,
  blend             = colour_utils.get_pumblend(),
  --use_complete  = true,
  border            = 'rounded',
  padding           = true,
  --auto_confirm_time = 3000,
  --auto_select       = false,
}

return M
