local M = {
  ui = {
    filer = require("plugins.plugin.individual.ddu.ui.filer"),
    ff    = require("plugins.plugin.individual.ddu.ui.ff"),
  },
}

function M.setup()
  M.ui.filer.setup()
  M.ui.ff.setup()
end

return M

