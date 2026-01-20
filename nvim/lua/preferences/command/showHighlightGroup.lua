local M = {}

local function showHighlightGroup()
  local l = vim.fn.line('.')
  local c = vim.fn.col('.')
  local hlgroup = vim.fn.synIDattr(vim.fn.synID(l, c, 1), 'name')
  local groupChain = {}

  vim.print('hlgroup: ')
  vim.print(hlgroup)
  while hlgroup ~= '' do
    table.insert(groupChain, hlgroup)
    hlgroup = vim.fn.matchstr(vim.fn.trim(vim.fn.execute('highlight ' .. hlgroup)), [[\<links\s\+to\>\s\+\zs\w\+$]])
  end

  if next(groupChain) == nil then
    vim.notify('No highlight groups')
    return
  end

  vim.print(groupChain)

  for group in groupChain do
    vim.fn.execute('highlight' .. group)
  end
end

M.setup = function()
  vim.api.nvim_create_user_command("ShowHighlightGroup", showHighlightGroup, {})
end

return M
