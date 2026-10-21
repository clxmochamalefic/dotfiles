local M = {}

local function clipFileName()
  local v = vim.fn.expand('%')
  vim.cmd([[let @+ = expand('%')]])
  vim.notify('Copied file name: ' .. v, vim.log.levels.INFO)
end

local function clipFileNameWithoutExt()
  local v = vim.fn.expand('%:r')
  vim.cmd([[let @+ = expand('%:r')]])
  vim.notify('Copied file name: ' .. v, vim.log.levels.INFO)
end

local function clipFilePath()
  local v = vim.fn.expand('%:p')
  vim.cmd([[let @+ = expand('%:p')]])
  vim.notify('Copied file path: ' .. v, vim.log.levels.INFO)
end

local function clipDirPath()
  local v = vim.fn.expand('%:p:h')
  vim.cmd([[let @+ = expand('%:p:h')]])
  vim.notify('Copied dir path: ' .. v, vim.log.levels.INFO)
end

M.setup = function()
  local opts_clip_file_name = {
    desc = "copy to OS clipboard: current buffer file name",
  }
  local opts_clip_file_name_without_ext = {
    desc = "copy to OS clipboard: current buffer file name without ext",
  }
  local opts_clip_file_path = {
    desc = "copy to OS clipboard: current buffer file path",
  }
  local opts_clip_dir_path  = {
    desc = "copy to OS clipboard: current buffer dir path",
  }

  vim.api.nvim_create_user_command("ClipFileName", clipFileName, opts_clip_file_name)
  vim.api.nvim_create_user_command("ClipFileNameWithoutExt", clipFileNameWithoutExt, opts_clip_file_name_without_ext)
  vim.api.nvim_create_user_command("ClipFilePath", clipFilePath, opts_clip_file_path)
  vim.api.nvim_create_user_command("ClipDirPath",  clipDirPath,  opts_clip_dir_path)

  vim.api.nvim_create_user_command("YankFileName", clipFileName, opts_clip_file_name)
  vim.api.nvim_create_user_command("YankFileNameWithoutExt", clipFileNameWithoutExt, opts_clip_file_name_without_ext)
  vim.api.nvim_create_user_command("YankFilePath", clipFilePath, opts_clip_file_path)
  vim.api.nvim_create_user_command("YankDirPath",  clipDirPath,  opts_clip_dir_path)
  vim.api.nvim_create_user_command("YankFn", clipFileName, opts_clip_file_name)
  vim.api.nvim_create_user_command("YankFnwe", clipFileNameWithoutExt, opts_clip_file_name_without_ext)
  vim.api.nvim_create_user_command("YankFp", clipFilePath, opts_clip_file_path)
  vim.api.nvim_create_user_command("YankDp",  clipDirPath,  opts_clip_dir_path)
end

return M
