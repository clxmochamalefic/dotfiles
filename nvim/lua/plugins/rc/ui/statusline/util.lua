local M = {}

function M.ins(config, component)
  table.insert(config, component)
end

function M.ins_lual_c(config, component)
  M.ins(config.sections.lualine_c, component)
end

function M.ins_lual_x(config, component)
  M.ins(config.sections.lualine_x, component)
end

return M
