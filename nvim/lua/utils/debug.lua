-- ---------------------------------------------------------------------------
-- DEBUG UTILITIES FUNCTION
-- ---------------------------------------------------------------------------
local M = {}

local FLOOR_UNIT = 10000

local firstTime = 0
local beforeTime = 0

local show_now_ms = function(message)
  local now = vim.fn.reltimefloat(vim.fn.reltime())

  if firstTime == 0 then
    firstTime = now
  end

  beforeTime = now

  local diffBefore = math.floor((now - beforeTime) * FLOOR_UNIT) / FLOOR_UNIT
  local diffFirst  = math.floor((now -  firstTime) * FLOOR_UNIT) / FLOOR_UNIT

  vim.print(message .. now .. ' [+' .. diffBefore .. 'ms] (+' .. diffFirst .. 'ms)')

  return now
end

M.show_now_ms = show_now_ms
M.show_now   = show_now_ms

return M

