local fn = vim.fn

--- @alias nvim_version
---| api_compatible # [Integer] has api compatible API互換有無
---| api_level = 12 # [Integer] api version
---| api_prerelease # [Integer|nil] api prerelease APIプレリリース
---| build # [String] build number ビルド番号 (git commit bash)
---| major # [Integer] major メジャーバージョン
---| minor # [Integer] minor マイナーバージョン
---| patch # [Integer] patch パッチバージョン
---| prerelease # [String] prerelease build type プレリリースビルドタイプ
---
--- e.g. vim.inspect(vim.version())
--- {
---   api_compatible = 0
--- 
---   api_level = 12
--- 
---   api_prerelease = vim.NIL
---   build = "g27fb62988"
---   major = 0
---   minor = 10
---   patch = 0
---   prerelease = "dev"
--- }

local M = {
  -- @type nvim_version neovim version
  ver_raw = nil,

  ver = {
    major = 0,
    minor = 0,
    patch = 0,
  }
}

function M.init_nvim_version()
  if ver_raw == nil then
    M.ver_raw = vim.version()
    M.ver.major = M.ver_raw.major or 0
    M.ver.minor = M.ver_raw.minor or 0
    M.ver.patch = M.ver_raw.patch or 0
  end
end

-- get neovim version
--
-- @return nvim_version neovim version
function M.get_nvim_version_raw()
  M.init_nvim_version()
  return M.ver_raw
end

function M.get_nvim_version()
  M.init_nvim_version()
  return M.ver
end

function M.get_major()
  M.init_nvim_version()
  return M.ver.major
end

function M.get_minor()
  M.init_nvim_version()
  return M.ver.minor
end

function M.get_patch()
  M.init_nvim_version()
  return M.ver.patch
end

function M.is_nvim_version_gt_08()
  return vim.fn.has("nvim-0.8") == 1
end



function M.get_env_name()
  if M.is_windows() then
    return "win"
  elseif M.is_wsl() then
    return "wsl"
  elseif M.is_linux() then
    return "linux"
  elseif M.is_mac() then
    return "mac"
  end
  return ""
end

function M.is_pure_linux()
  return fn.has("linux") == 1 and fn.has("wsl") == 0
end

function M.is_wsl_linux()
  return fn.has("linux") == 1 and fn.has("wsl") == 1
end

function M.is_linux()
  return fn.has("linux") == 1
end

function M.is_mac_os()
  return fn.has("mac") == 1
end

function M.is_macos()
  return M.is_mac_os()
end

function M.is_pure_unix()
  return fn.has("unix") == 1 and fn.has("mac") == 0
end

function M.is_unix()
  return fn.has("unix") == 1
end

function M.is_posix()
  return M.is_unix() or M.is_linux()
end

function M.is_wsl()
  return fn.has("wsl") == 1
end

function M.is_windows()
  return fn.has("win32") == 1
end

function M.is_neovide()
  return vim.g.neovide ~= nil and vim.g.neovide == true
end

function M.get_path_splitter_for_current_env()
  if M.is_linux() or M.is_unix() then
    return "/"
  end

  return "\\"
end
function M.join_path_with_separator(separator, ...)
  local args = {}
  for i = 1, select("#", ...) do
    local arg = (select(i, ...))
    args[i] = arg
  end
  local path = table.concat(args, separator)
  return path
end

function M.join_path(...)
  local separator = M.get_path_splitter_for_current_env()
  return M.join_path_with_separator(separator, ...)
end

function M.join_path_slash(...)
  return M.join_path_with_separator("/", ...)
end

function M.getHome()
  if M.is_windows() then
    return os.getenv("UserProfile")
  end
  return os.getenv("HOME")
end

function M.test()
  print(M.join_path(M.getHome(), ".lib", "sqlite"))
end

return M
