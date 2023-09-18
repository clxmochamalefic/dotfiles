local utils = require("utils")

local g = vim.g
local fn = vim.fn
local opt = vim.opt
local api = vim.api
local keymap = vim.keymap

return {
  {
    'tpope/vim-dadbod',
    lazy = true,
    event = { 'VimEnter' },
    dependencies = {
      'tpope/vim-dotenv',
      'kristijanhusak/vim-dadbod-ui'
    },
    build = function()
      utils.io.begin_debug("build: /plugins/db.lua")

      local db_toml_dir = vim.fn.expand('~/.cache/vim_dadbod')
      vim.g.dbs = {}

      if vim.fn.isdirectory(db_toml_dir) ~= 1 then
        local mkdircmd = '!mkdir ' .. db_toml_dir
        utils.io.echo(mkdircmd)
        vim.cmd(mkdircmd)
      end

      utils.io.end_debug("build: /plugins/db.lua")
    end,
    config = function ()
      utils.io.begin_debug("/plugins/db.lua")

      -- TOML FORMAT
      -- [local]
      -- connection_string = "mysql://xxxx"
      -- type =  "mysql"
      -- port = "3306"
      -- user =  "LOCAL"
      -- password =  "PASSWD"
      -- [local.ssh]
      -- address = "localhost"
      -- port = "22"
      -- user = "LOCAL"
      -- password = "PASSWD"
      -- identifier = ""

      -- local filelist =  vim.fn.expand(db_toml_dir + "/*.toml")
      -- local splitted = vim.fn.split(filelist, "\n")
      -- for s:file in s:splitted
      --   let s:read = dein#toml#parse_file(expand(s:file))
      --   for s:prefix in keys(s:read)
      --     let s:preference = s:read[s:prefix]
      --     let s:conn_str = s:preference['type'] . "://" . s:preference['user'] . ":" . s:preference['password'] . "@" . s:preference['host'] . ":" . s:preference['port']
      --     let g:dbs[fnamemodify(s:file, ':t') . "." . s:prefix] = s:conn_str
      --   endfor
      -- endfor

      utils.io.end_debug("/plugins/db.lua")
    end
  }
}

