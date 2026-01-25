local const = require("const.colour")

local env = require("utils.env")

local M = {}

local function get_pumblend()
  return const.blend.value
end
local function get_winblend()
  return const.blend.max - get_pumblend()
end

local function get_hl_table(key, val)
  if env.is_nvim_version_gt_08() then
    return { 0, key, val }
  end

  return { key, val, false }
end

M.get_pumblend = get_pumblend
M.get_winblend = get_winblend
M.get_hl_table = get_hl_table

return M
