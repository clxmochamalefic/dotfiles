-- ---------------------------------------------------------------------------
-- JAVA-DAP (debug adapter protocol) CONFIGS
-- ---------------------------------------------------------------------------
--
local myutils = require('utils')

local M = {
  dap = nil
}

M.setup = function(dap, opt)
  if M.dap ~= nil then
    return
  end

  M.dap = dap

  if M.dap ~= nil then
    return
  end

  local h = opt.host or '127.0.0.1'
  local p = opt.port or 8080

  M.dap.adapters.java = function(callback)
    -- FIXME:
    -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
    -- The response to the command must be the `port` used below
    callback({
      type = 'server';
      host = h;
      port = p;
    })
  end

  M.dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Debug (Attach) - Remote";
      hostName = h;
      port = p;
      javaExec = myutils.depends.which('java'),

      ---- You need to extend the classPath to list your dependencies.
      ---- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
      --classPaths = {},

      ---- If using multi-module projects, remove otherwise.
      --projectName = "yourProjectName",

      --javaExec = "/path/to/your/bin/java",
      --mainClass = "your.package.name.MainClassName",

      ---- If using the JDK9+ module system, this needs to be extended
      ---- `nvim-jdtls` would automatically populate this property
      --modulePaths = {},
      --name = "Launch YourClassName",
      --request = "launch",
      --type = "java"
    },
  }
end

return M
