-- ---------------------------------------------------------------------------
--  HIGHLIGHT PREFERENCES
-- ---------------------------------------------------------------------------
--
local M = {}

local md_fenced_language_list = {
  -- native and compiler languages
  'c',
  'cpp',
  'cs',
  'java',
  --'obj-c',
  'kotlin',
  'php',

  -- shell script languages
  'bash=sh',
  'zsh=sh',

  --'pwsh',

  -- SQL
  'sql',

  -- web languages
  'html',
  'css',
  'sass',
  'scss',
  'javascript',
  'typescript',
  'js=javascript',
  'json=javascript',
  'ts=typescript',

  -- markup languages
  'xml',

  -- vim preference script languages
  'lua',
  'vim'
}

local augroup_name = "MyMarkdownHighlight"

M.setup = function()
  vim.api.nvim_create_augroup(augroup_name, { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup_name,
    pattern = {
      "markdown",
      "md",
    },
    callback = function()
      vim.g.markdown_fenced_languages = md_fenced_language_list
    end
  })
end

return M

