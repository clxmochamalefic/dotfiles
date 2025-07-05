local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

require("utils.string")

local sub_util = require("utils..util")

local M = {}

M.fs = require("utils..fs")
M.io = require("utils..io")
M.env = require("utils..env")
M.window = require("utils..window")
M.depends = require("utils..depends")
M.util = sub_util
M.table = require("utils.table")

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
		if mt == nil then
			return false
		end
		if tostring(mt) == super then
			return true
		end

		mt = getmetatable(mt)
	end
end

return M
