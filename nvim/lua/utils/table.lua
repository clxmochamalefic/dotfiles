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


---
--- conditionで指定した条件を満たすときに、 `key` と `value` をテーブルtに挿入する
---
--- @param t table 挿入先のテーブル
--- @param key string 挿入するキー
--- @param value table 挿入する値(テーブル)
--- @param condition bool|function 挿入する条件を判定する関数
---
--- @return boolean true: 挿入された / false: 挿入されなかった
---
function M.insert_when(t, key, value, condition)
  if type(condition) == "function" then
    -- 関数の場合に関数をコールして条件を評価
    if condition() then
      t[key] = value
      return true
    end
  end

  -- boolの場合に関数をコールして条件を評価
  if condition then
    t[key] = value
    return true
  end

	return false
end

return M
