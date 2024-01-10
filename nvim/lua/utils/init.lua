local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

require("utils.string")

local sub_util = require("utils.sub.util")

local M = {}

M.fs = require("utils.sub.fs")
M.io = require("utils.sub.io")
M.env = require("utils.sub.env")
M.window = require("utils.sub.window")
M.depends = require("utils.sub.depends")
M.util = sub_util

-- key exists in array
function M.isContainsInArray(set, key)
  return set[key] ~= nil
end

-- 疑似trycatch
M.try_catch = M.util.try_catch

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

