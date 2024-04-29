local myutils = require("utils")

local thisenv = myutils.env.get_env_name()

if thisenv == "wsl" then
  thisenv = "win"
end

local env = require("preferences.config.env." .. thisenv)
env.setup()
