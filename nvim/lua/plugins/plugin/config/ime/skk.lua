---@diagnostic disable: undefined-global
local g = vim.g
local o = vim.o
local fn = vim.fn
local opt = vim.opt

local utils = require("utils")
--local helper = require("plugins.plugin.ddc.helper")

local M = {}

--function M.setup()
--  --  skkeleton
--  local skkeleton_dir = fn.expand("~/.cache/.skkeleton")
--  if fn.isdirectory(skkeleton_dir) ~= 1 then
--    fn.mkdir(skkeleton_dir, "p")
--  end
--
--  -- ref: https://github.com/uga-rosa/dotfiles/blob/daffddc37f8ac005fcb62567b14f823a1e2e817b/nvim/lua/rc/plugins/skk.lua#L6
--  -- 👆 THANK YOU!!!!
--  vim.keymap.set({ "i", "c" }, "<C-j>", "<Plug>(skkeleton-toggle)")
--
--  vim.fn["denops#plugin#wait_async"]("skkeleton", function()
--    vim.g["skkeleton#mlapped_keys"] = { "<C-g>" }
--    vim.fn["skkeleton#register_keymap"]("input", "<C-g>", "zenkaku")
--    vim.fn["skkeleton#register_keymap"]("input", "<C-h>", "katakana")
--    vim.fn["skkeleton#register_keymap"]("input", "'", "henkanPoint")
--    local path = vim.fn.stdpath("config") .. "/script/azik/skkeleton.json"
--    local buffer = utils.fs.read(path)
--    local kanaTable = vim.json.decode(buffer)
--    kanaTable[" "] = "henkanFirst"
--    kanaTable["/"] = "abbrev"
--    vim.fn["skkeleton#register_kanatable"]("azik", kanaTable, true)
--
--    local lazy_root = require("lazy.core.config").options.root
--    vim.fn["skkeleton#config"]({
--      kanaTable = "azik",
--      eggLikeNewline = true,
--      globalDictionaries = {
--        vim.fs.joinpath(lazy_root, "dict", "SKK-JISYO.L"),
--        vim.fs.joinpath(lazy_root, "dict", "SKK-JISYO.jinmei"),
--      },
--      userDictionary = "~/.secret/SKK-JISYO.user",
--      markerHenkan = "<>",
--      markerHenkanSelect = ">>",
--      registerConvertResult = true,
--      sources = { "deno_kv" },
--      databasePath = vim.fn.stdpath("data") .. "/skkeleton.db",
--      completionRankFile = "~/.cache/.skkeleton/rank.json",
--    })
--
--    vim.fn["skkeleton#initialize"]()
--  end)
--
--  -- Integration with ddc.vim
--  helper.patch_global({
--    sourceOptions = {
--      skkeleton = {
--        mark = "[Skk]",
--        matchers = { "skkeleton" },
--        sorters = {},
--        converters = {},
--        isVolatile = true,
--      },
--    },
--  })
--
--  vim.api.nvim_create_autocmd("User", {
--    pattern = "skkeleton-enable-post",
--    callback = function()
--      helper.patch_buffer("sources", helper.sources.skkeleton)
--    end,
--  })
--  vim.api.nvim_create_autocmd("User", {
--    pattern = "skkeleton-disable-post",
--    callback = function()
--      helper.remove_buffer("sources")
--    end,
--  })
--end

return M
