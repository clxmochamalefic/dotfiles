-- ---------------------------------------------------------------------------
-- DDC PLUGIN HELPER
-- ---------------------------------------------------------------------------

-- ref: https://github.com/uga-rosa/dotfiles/blob/daffddc37f8ac005fcb62567b14f823a1e2e817b/nvim/lua/rc/helper/ddc.lua
-- THANK YOU!!

local M = {}

M.sources = {
  default = { "denippet", "lsp", "buffer", "dictionary" },
  skkeleton = { "skkeleton" },
  lua = { "denippet", "lsp", "nvim-lua", "buffer", "dictionary" },
  vim = { "denippet", "necovim", "buffer", "dictionary" },
  comment = { "buffer", "dictionary" },
}

function M.patch_global(...)
  vim.fn["ddc#custom#patch_global"](...)
end

function M.patch_filetype(...)
  vim.fn["ddc#custom#patch_filetype"](...)
end

function M.patch_buffer(...)
  vim.fn["ddc#custom#patch_buffer"](...)
end

---@param ... string
function M.remove_buffer(...)
  local options = vim.fn["ddc#custom#get_buffer"]()
  local root = options
  local keys = { ... }
  local last_key = table.remove(keys)
  for _, key in ipairs(keys) do
    options = options[key]
  end
  options[last_key] = nil
  if vim.tbl_isempty(root) then
    root = vim.empty_dict()
  end
  vim.fn["ddc#custom#set_buffer"](root)
end

---@param type "source" | "filter"
---@param alias string
---@param base string
function M.alias(type, alias, base)
  vim.fn["ddc#custom#alias"](type, alias, base)
end

function M.set_context_buffer(...)
  vim.fn["ddc#custom#set_context_buffer"](...)
end

---@param fun function
---@return string
function M.register(fun)
  return vim.fn["denops#callback#register"](fun)
end

return M
