local g = vim.g
local fn = vim.fn
local api = vim.api
local opt = vim.opt
local keymap = vim.keymap

local utils = require("utils")
local km_opts = require("const.keymap")
local ddu = require("plugins.plugin.config.ddu.core")
local ffutils = require("plugins.plugin.config.ddu.ui.ff.utils")

local M = {}

function M.setup()
  ddu.patch_local("lsp_definition", {
    sync = true,
    sources = {
      { name = 'lsp_definition', }
    },
    uiParams = {
      ff = {
        immediateAction = 'open',
      },
    }
  })

  ddu.patch_local("lsp_workspaceSymbol", {
    sources = {
      { name = 'lsp_workspaceSymbol', }
    },
    sourceOptions = {{
      lsp = {{
        volatile = true,
      },
    },
    uiParams = {
      ff = {
        ignoreEmpty = false
      },
    }
  }}})

  ddu.patch_local("lsp_callHierarchy", {
    sources = {{
      name = 'lsp_callHierarchy',
      params = {
        method = 'callHierarchy/outgoingCalls',
      }
    }},
    uiParams = {
      ff= {
        displayTree = true,
        startFilter = false,
      },
    }
  })

  api.nvim_create_user_command("DduLspDefinition", function()
    ffutils.open("lsp_definition")
  end, {})
  api.nvim_create_user_command("DduLspWorkspaceSymbol", function()
    ffutils.open("lsp_workspaceSymbol")
  end, {})
  api.nvim_create_user_command("DduLspCallHierarchy", function()
    ffutils.open("lsp_callHierarchy")
  end, {})
end

return M
