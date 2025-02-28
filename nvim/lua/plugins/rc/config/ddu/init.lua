local M = {
  ui = {
    filer = require("plugins.rc.config.ddu.ui.filer"),
    ff    = require("plugins.rc.config.ddu.ui.ff"),
  },
}

function M.setup()
  M.ui.filer.setup()
  M.ui.ff.setup()
end

return M

