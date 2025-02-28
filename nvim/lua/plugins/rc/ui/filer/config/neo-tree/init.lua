local env = require("utils.sub.env")

local M = {}

function M.get_require()
  local nc = M.nc or require('neo-tree.command')
  if (not M.nc) then
    M.nc = nc
  end
  return nc
end

--function M.cd(path)
--  local nc = M.get_require()
--  nc.execute({
--    reveal_file = path,           -- path to file or folder to reveal
--    reveal_force_cwd = true,      -- change cwd without asking if needed
--  })
--end

function M.cd(path)
  local nc = M.get_require()
  nc.execute({
    dir = path,
    reveal = true,
    --reveal_file = path,           -- path to file or folder to reveal
    reveal_force_cwd = false, -- change cwd without asking if needed
  })
end

function M.setup()
  local nc = M.get_require()
  local cd = M.cd

  local function opts(desc)
    local bufnr = vim.fn["bufnr"]()
    return {
      desc = "neo-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  --require('neo-tree.command').execute({
  --action = "focus",          -- OPTIONAL, this is the default value
  --source = "filesystem",     -- OPTIONAL, this is the default value
  --position = "left",         -- OPTIONAL, this is the default value
  --reveal_file = reveal_file, -- path to file or folder to reveal
  --reveal_force_cwd = true,   -- change cwd without asking if needed
  --})

  local cd_preference = function()
    cd(vim.g.my_initvim_path)
  end
  local cd_home = function()
    cd("~")
  end
  local cd_repos = function()
    cd("~" .. env.get_path_splitter_for_current_env() .. "repos")
  end
  local cd_docs = function()
    cd("~" .. env.get_path_splitter_for_current_env() .. "Documents")
  end

  local augroup_id = vim.api.nvim_create_augroup("neo-tree", {})
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup_id,
    pattern = "neo-tree",
    callback = function()
      --vim.keymap.set("n", "<C-v>", close_wrap(api.node.open.vertical), opts("Open: Vertical Split"))

      vim.keymap.set("n", "^", cd_preference, opts("Open: my preference"))
      vim.keymap.set("n", "~", cd_home, opts("Open: $HOME"))
      vim.keymap.set("n", "\\", cd_repos, opts("Open: repos"))
      vim.keymap.set("n", "=", cd_docs, opts("Open: Documents"))

      vim.keymap.set("n", ">", "<Cmd>vertical resize +10<CR>", { noremap = true, buffer = true })
      vim.keymap.set("n", "<lt>", "<Cmd>vertical resize -10<CR>", { noremap = true, buffer = true })
    end,
  })
end

return M
