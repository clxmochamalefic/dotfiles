local M = {}

function M.is_key_exists(t, key)
	for k, _ in ipairs(t) do
		if k == key then
			return true
		end
	end
	return false
end

function M.is_value_exists(t, value)
	for _, v in ipairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

return M
