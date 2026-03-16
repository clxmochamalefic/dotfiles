---@diagnostic disable: undefined-global

local _COLOUR = require("const.colour")

local M = {
  max_width         = 120,
  blend             = _COLOUR.get_pumblend(),
  --use_complete  = true,
  border            = 'rounded',
  padding           = true,
  --auto_confirm_time = 3000,
  --auto_select       = false,
}

return M
