local g = vim.g

local utils = require("utils")

return {
  {
    lazy = true,
    'higashi000/sarahck.vim',
    cmd = {
      "SarahckChannelList",
      "SarahckPostMessage",
      "SarahckDispChannel",
    },
    config = function()
      local config = utils.read_secrets("messaging.json")
      if config then
        utils.echo("token : " .. config.tokens.slack)
        g.slackToken = config.tokens.slack
      end
    end
  },
}
