local api = require "vim.api"

vim.g.floaterm_autoclose = 0
vim.g.floaterm_height = 0.8
vim.g.floaterm_width = 0.85
vim.g.floaterm_position = "bottom"

-- api.nvim_create_user_command("Floaterm", function(args)
-- end, {
--   nargs = "0"
-- })

-- local Floaterm = function()
--   
-- end

-- keymap
vim.keymap.set("n", "<C-w>", "<Cmd>FloatermNew<CR>", { silent = true })

