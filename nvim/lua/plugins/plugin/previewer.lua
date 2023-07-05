local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    lazy = true,
    'iamcco/markdown-preview.nvim',
    dependencies = {
      "zhaozg/vim-diagram",
      "aklt/plantuml-syntax",
    },
    cmd = { "MarkdownPreview" },
    build = "cd app && yarn install",
    config = function()
      g.mkdp_filetypes = { "markdown" }
    end,
    ft = { 'markdown', 'pandoc.markdown', 'rmd', 'md' },
  },
--  {
--    lazy = true,
--    'shuntaka9576/preview-swagger.nvim',
--    cmd = { "SwaggerPreview" },
--    build = "yarn install",
--    --init = function()
--    --  g.node_path = vim.cmd([[!gcm node | Select-Object Source]]),
--
--    --  g.pswag_node_path = g.node_path,
--    --  g.pswag_lunch_port = 6060
--    --end,
--    config = function()
--      --g.node_path = vim.cmd([[!gcm node | Select-Object Source]]),
--
--      g.pswag_node_path = g.node_host_prog
--      g.pswag_lunch_port = 6060
--    end,
--    --opts = {
--    --  pswag_node_path = g.node_path,
--    --  pswag_lunch_port = 6060
--    --},
--    ft = { 'yaml', 'yml' },
--  },
  {
    lazy = true,
    'xavierchow/vim-swagger-preview',
    cmd = { "SwaggerPreview" },
    build = "yarn install",
    --init = function()
    --  g.node_path = vim.cmd([[!gcm node | Select-Object Source]]),

    --  g.pswag_node_path = g.node_path,
    --  g.pswag_lunch_port = 6060
    --end,
    config = function()
      --g.node_path = vim.cmd([[!gcm node | Select-Object Source]]),

      g.pswag_node_path = g.node_host_prog
      g.pswag_lunch_port = 6060
    end,
    --opts = {
    --  pswag_node_path = g.node_path,
    --  pswag_lunch_port = 6060
    --},
    ft = { 'yaml', 'yml' },
  },
}

