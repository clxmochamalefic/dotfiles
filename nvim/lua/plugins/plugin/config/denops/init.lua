local g = vim.g
local fn = vim.fn

local utils = require("utils")

local M = {
  addr = "127.0.0.1",
  host = "0.0.0.0",
  port = 33576,
}

function M.setup()
  -- hostとの競合回避想定
--  if fn["has"]('win32') == 1 and fn["has"]('wsl') == 1 then
--    -- guest: wsl2 only
--    M.port = 33577
--  else
    -- host: windows / linux / macOS
    M.port = 33576
--  end
end

function M.configure()
  g.denopsPath = fn["stdpath"]("data") .. "/lazy/denops.vim/denops/@denops-private"
  g.denops_server_addr = M.addr .. ":" .. M.port
end

function M.build4wsl()
  local denopsCliPath = g.denopsPath .. "/cli.ts"
  local serviceScriptPath = g.my_home_preference_path .. "/boot_denops.bat"
  utils.io.debug_echo("denops PATH: " .. denopsCliPath)

  -- Windows起動時にdenopsを上げてくれるやつを ~/.config/nvim/boot_denops.lua に記述
  if not utils.fs.exists(serviceScriptPath) then
    local body = "deno run -A --no-lock " .. denopsCliPath .. " --hostname=" .. M.host .. " --port " .. M.port
    io.open(serviceScriptPath, "w"):write(body):close()
  end

  local startupBat = [[~/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup/boot_denops.vbs]]
  io.open(startupBat, "w"):write([[Set ws = CreateObject("Wscript.Shell")\nws.run "cmd /c ]] .. serviceScriptPath .. [[", vbhide]]):close()
end

function M.build4anyhost()
  local denopsCliPath = g.denopsPath .. "/cli.ts"
  local serviceScriptPath = g.my_home_preference_path .. "/boot_denops.bat"
  utils.io.debug_echo("denops PATH: " .. denopsCliPath)

  --vim.cmd("echo \"bash -c 'deno run -A --no-lock " .. denopsCliPath .. " --hostname=" .. M.host .. " --port " .. M.port .. " >> /dev/null &' \" >> ~/.bashrc ")
  vim.cmd("sudo echo \"bash -c 'deno run -A --no-lock " .. denopsCliPath .. " --hostname=" .. M.host .. " --port " .. M.port .. " >> /dev/null &' \" >> /etc/rc.local ")
end

function M.build()
  if fn["has"]('win32') == 1 and fn["has"]('wsl') == 1 then
    if fn["has"]('linux') then
      M.build4anyhost()
    else
      M.build4wsl()
    end
  else
    M.build4anyhost()
  end
end

return M
