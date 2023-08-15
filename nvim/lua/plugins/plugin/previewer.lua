local utils = require('utils')

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

local revealjs_path = "~/bin/reveal.js"

--if not file_exists(revealjs_path) then
--  os.execute("mkdir " .. dirname)
--end

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
--    "vinnymeller/swagger-preview.nvim",
--    build = "npm install -g swagger-ui-watcher",
--    config = function()
--      require("swagger-preview").setup({
--        port = 6060,
--        host = "localhost",
--      })
--    end,
--    ft = { 'yaml', 'yml' },
--  },
--  {
--    lazy = true,
--    "blindFS/vim-reveal",
--    cmd = { "Reveal" },
--    build = "git clone https://github.com/hakimel/reveal.js.git " .. revealjs_path .. " && cd " .. revealjs_path .. " && npm install",
--    config = function()
--      g.reveal_root_path = revealjs_path
--      g.reveal_config = {
--        filename = 'reveal',
--        -- key1 = 'value1',
--        -- key2 = 'value2',
--      }
--    end,
--    ft = { 'markdown', 'md' },
--  },
--  {
--    lazy = true,
--    'shuntaka9576/preview-swagger.nvim',
--    cmd = "SwaggerPreview",
--    run = "yarn install",
--    build = "yarn install",
--    config = function()
--      g.pswag_node_path = g.node_host_prog
--      g.pswag_lunch_port = 6060
--    end,
--    ft = { 'yaml', 'yml' },
--  },
--  {
----    lazy = true,
--    'xavierchow/vim-swagger-preview',
--    cmd = { "GenerateDiagram" },
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
}

