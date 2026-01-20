local const = require("const.colour")

local M = {}

local function get_pumblend()
  return const.blend.value
end
local function get_winblend()
  return const.blend.max - get_pumblend()
end

M.get_pumblend = get_pumblend
M.get_winblend = get_winblend

return M
