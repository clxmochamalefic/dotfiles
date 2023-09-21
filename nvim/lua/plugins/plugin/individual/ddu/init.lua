local M = {
  ui = {
    filer = require("plugins.plugin.individual.ddu.ui.filer"),
    ff    = require("plugins.plugin.individual.ddu.ui.ff"),
    lsp   = require("plugins.plugin.individual.ddu.ui.lsp_actions"),
  },
}

function M.setup()
  M.ui.filer.setup()
  M.ui.ff.setup()
  M.ui.lsp.setup()
end

return M

