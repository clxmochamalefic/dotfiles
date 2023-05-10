-- define tabstop by filetype
local augroup = vim.api.nvim_create_augroup('FileTypeIndent', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = augroup,
    pattern = {
        "*.html",
        "*.phtml",
        "*.js",
        "*.jsx",
        "*.ts",
        "*.tsx",
        "*.css",
        "*.sass",
        "*.scss",
        "*.prisma",
        "*.vim",
        "*.yaml",
        "*.yml",
        "*.toml",
        "*.tml",
        "*.lua",
        "*.blade.php"
    },
    callback = function ()
        -- do something
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
        "blade",
    },
    callback = function ()
        -- do something
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

