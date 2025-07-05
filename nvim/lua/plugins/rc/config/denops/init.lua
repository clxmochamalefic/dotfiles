local g = vim.g
local fn = vim.fn

local utils = require("utils")
local env = require("utils..env")

local M = {
  addr = "127.0.0.1",
  host = "0.0.0.0",
  port = 33576,
}

function M.setup()
  -- hostとの競合回避想定
  if env.is_wsl() then
    -- guest: wsl2 only
    M.port = 33577
  else
    -- host: windows / linux / macOS
    M.port = 33576
  end
end

function M.configure()
  g.denopsPath = fn["stdpath"]("data") .. "/lazy/denops.vim/denops/@denops-private"
  g.denops_server_addr = M.addr .. ":" .. M.port
end

function M.build4win()
  local denopsCliPath = g.denopsPath .. "/cli.ts"
  local serviceScriptPath = g.my_home_preference_path .. "/boot_denops.bat"
  utils.io.debug_echo("denops PATH: " .. denopsCliPath)

  -- Windows起動時にdenopsを上げてくれるやつを ~/.config/nvim/boot_denops.lua に記述
  if not utils.fs.exists(serviceScriptPath) then
    local body = "deno run -A --no-lock " .. denopsCliPath .. " --hostname=" .. M.host .. " --port " .. M.port
    io.open(serviceScriptPath, "w"):write(body):close()
  end

  local startupBat = [[~/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup/boot_denops.vbs]]
  io.open(startupBat, "w")
    :write([[Set ws = CreateObject("Wscript.Shell")\nws.run "cmd /c ]] .. serviceScriptPath .. [[", vbhide]])
    :close()
end

function M.build4anyhost()
  --local denopsCliPath = g.denopsPath .. "/cli.ts"
  --local serviceScriptPath = g.my_home_preference_path .. "/boot_denops.bat"
  --utils.io.debug_echo("denops PATH: " .. denopsCliPath)

  ----vim.cmd("echo \"bash -c 'deno run -A --no-lock " .. denopsCliPath .. " --hostname=" .. M.host .. " --port " .. M.port .. " >> /dev/null &' \" >> ~/.bashrc ")
  --vim.cmd("sudo echo \"bash -c 'deno run -A --no-lock " .. denopsCliPath .. " --hostname=" .. M.host .. " --port " .. M.port .. " >> /dev/null &' \" >> /etc/rc.local ")
end

-- function for denops build to env
function M.build()
  if env.is_windows() then
    M.build4win()
  else
    M.build4anyhost()
  end
end

-- function for denops updated
function M.update()
  vim.cmd([[call denops#cache#update(#{reload: v:true})]]);
end

return M
