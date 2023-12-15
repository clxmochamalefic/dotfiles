local g = vim.g
local keymap = vim.keymap

local M = {}

function M.on_attach(bufnr)
    local api = require("nvim-tree.api")
    local float_preview = require("float-preview")

    local function opts(desc)
      return {
        desc = "nvim-tree: " .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    float_preview.attach_nvimtree(bufnr)
    local close_wrap = float_preview.close_wrap

    keymap.set("n", "<C-t>",  close_wrap(api.node.open.tab),              opts("Open: New Tab"))
    keymap.set("n", "<C-v>",  close_wrap(api.node.open.vertical),         opts("Open: Vertical Split"))
    keymap.set("n", "<C-s>",  close_wrap(api.node.open.horizontal),       opts("Open: Horizontal Split"))
    keymap.set("n", "<CR>",   close_wrap(api.node.open.edit),             opts("Open"))
    keymap.set("n", "o",      close_wrap(api.node.open.edit),             opts("Open"))
    keymap.set("n", "l",      close_wrap(api.node.open.edit),             opts("Open"))
    keymap.set("n", "O",      close_wrap(api.node.open.no_window_picker), opts("Open: No Window Picker"))

    keymap.set("n", "c",      close_wrap(api.fs.copy.node),   opts("Copy"))
    keymap.set("n", "x",      close_wrap(api.fs.cut),         opts("Cut"))
    keymap.set("n", "p",      close_wrap(api.fs.paste),       opts("Paste"))

    keymap.set("n", "y",      api.fs.copy.filename,           opts("Copy Name"))
    keymap.set("n", "Y",      api.fs.copy.relative_path,      opts("Copy Relative Path"))
    keymap.set("n", "gy",     api.fs.copy.absolute_path,      opts("Copy Absolute Path"))

    keymap.set("n", "h",      api.node.navigate.parent_close, opts("Close Directory"))

    keymap.set("n", "<Tab>",  api.tree.change_root_to_node,   opts("Change Directory"))
    keymap.set("n", "R",      api.tree.reload,                opts("Refresh"))
    keymap.set("n", "S",      api.tree.search_node,           opts("Search"))

    keymap.set("n", "b",      close_wrap(api.fs.create),      opts("Create"))
    keymap.set("n", "d",      close_wrap(api.fs.remove),      opts("Delete"))
    keymap.set("n", "r",      close_wrap(api.fs.rename),      opts("Rename"))

    -- parent
    local goto_parent = (function() api.tree.change_root("..") end)
    keymap.set("n", "<BS>",   goto_parent,  opts("Change Directory to .."))

    -- home
    local goto_home = (function() api.tree.change_root("~") end)
    keymap.set("n", "~",      goto_home,    opts("Change Directory to HOME"))
    -- setting
    local goto_config = (function() api.tree.change_root(g.my_initvim_path) end)
    keymap.set("n", "^",      goto_config,  opts("Rename"))
    -- repository
    local goto_repos = (function() api.tree.change_root("~\\repos") end)
    keymap.set("n", "\\",     goto_repos,   opts("Rename"))
    -- documents
    local goto_doc = (function() api.tree.change_root("~\\Documents") end)
    keymap.set("n", "=",      goto_doc,     opts("Rename"))
end

return M
