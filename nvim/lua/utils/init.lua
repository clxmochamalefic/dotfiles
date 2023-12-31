local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

require("utils.string")

local M = {}

M.fs = require("utils.sub.fs")
M.io = require("utils.sub.io")
M.window = require("utils.sub.window")

-- key exists in array
function M.isContainsInArray(set, key)
  return set[key] ~= nil
end

-- 疑似trycatch
function M.try_catch(what)
  M.io.debug_echo("begin try --->")
  local status, exception = pcall(what.try)
  if not status then
    M.io.debug_echo("#### begin catch --->")
    what.catch(exception)
    M.io.debug_echo("<--- end catch ####")
  else
    M.io.debug_echo("<--- end try")
  end
  if what.finally then
    M.io.debug_echo("begin finally --->")
    what.finally()
    M.io.debug_echo("<--- end finally")
  end

  return exception
end

-- 型チェック
-- super thx for @paulcuth!!: https://gist.github.com/paulcuth/1270733
function M.instance_of(subject, super)

	super = tostring(super)
	local mt = getmetatable(subject)

	while true do
		if mt == nil then return false end
		if tostring(mt) == super then return true end

		mt = getmetatable(mt)
	end	
end

return M

