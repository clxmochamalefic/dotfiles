local g = vim.g
local fn = vim.fn
local api = vim.api
local keymap = vim.keymap

require("utils.string")

local M = {}

M.depends = require("utils.depends")
M.env = require("utils.env")
M.fs = require("utils.fs")
M.io = require("utils.io")
M.string = require("utils.string")
M.table = require("utils.table")
M.try_catch = require("utils.try_catch") -- 疑似trycatch
M.window = require("utils.window")

-- key exists in array
function M.isContainsInArray(set, key)
	return set[key] ~= nil
end

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
