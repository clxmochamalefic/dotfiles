---@diagnostic disable: unused-local, undefined-global

local utils = require("utils")

local cond = true
local dadbodPreferencePath = nil

local function getDadBodPreferencePath()
  if dadbodPreferencePath == nil then
    dadbodPreferencePath = vim.fn.expand(vim.g.my_home_cache_path .. '/dadbod')
  end

  return dadbodPreferencePath
end

--
-- 設定の場所
-- ~\.cache\dadbod\connections.json
--
-- 設定例
-- ```json
-- [
--    {"url": "dbext:type=PGSQL:host=localhost:user=<user_name>:passwd=<password>:dbname=<db_name>", "name": "<your_awesome_name>"}
-- ]
-- ```
-- see also =>
-- - https://github.com/tpope/vim-dadbod?tab=readme-ov-file#usage
-- - https://github.com/vim-scripts/dbext.vim
-- - https://www.vim.org/scripts/script.php?script_id=356


return {
  {
    "tpope/vim-dadbod",
    lazy = true,
    cond = cond,
    cmd = {
      "DB",
      "DBUI",
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    keys = {
      { "<leader>s", "<cmd>DBUIToggle<CR>", mode = "n" },
    },
    dependencies = {
      "tpope/vim-dotenv",
      "vim-scripts/dbext.vim",
      "kristijanhusak/vim-dadbod-ui",
      'kristijanhusak/vim-dadbod-completion',
    },
    build = function()
      utils.io.begin_debug("build: /plugins/db.lua")

      local dirPath = getDadBodPreferencePath()
      vim.g.dbs = {}

      if vim.fn.isdirectory(dirPath) ~= 1 then
        local mkdircmd = "!mkdir " .. dirPath
        utils.io.echo(mkdircmd)
        vim.cmd(mkdircmd)
      end

      utils.io.end_debug("build: /plugins/db.lua")
    end,
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = getDadBodPreferencePath()
    end,
    config = function()
      utils.io.begin_debug("/plugins/db.lua")
      vim.g.db_ui_save_location = getDadBodPreferencePath()

      -- e.g.
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
    end,
  },
  {
    "vim-scripts/dbext.vim",
    lazy = true,
    cond = cond,
    config = function()
      vim.g.dbext_default_SQLITE_bin = 'sqlite3'
      -- プロファイルの定義
      vim.g.dbext_default_profile_MySQL_test = 'type=SQLSRV:integratedlogin=1:dbname=myDB'
      vim.g.dbext_default_profile_mysqlnodb = 'type=MYSQL:host=127.0.0.1:user=root:passwd=password:dbname=test'
      vim.g.dbext_default_profile_SQLServer_test = 'type=SQLSRV:integratedlogin=1:dbname=myDB'
      vim.g.dbext_default_profile_test = 'type=SQLITE:dbname=/dbpath/test.db'
      -- デフォルトで使用するプロファイルを指定
      vim.g.dbext_default_profile = 'test'
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    lazy = true,
    cond = cond,
    ft = {
      'sql',
      'mysql',
      'plsql'
    },
  }
}
