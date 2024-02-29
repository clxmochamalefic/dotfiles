-- ---------------------------------------------------------------------------
-- jdtls - java LSP SERVER CONFIG
-- ---------------------------------------------------------------------------

--local

local M = {
  config = {
    java = {
      format = {
        settings = {
          url = "path/to..",
          profile = "GoogleStyle",
        },
      },
    },
  },
  baseLc = nil,
  lc = nil,
}

M.setup = function(baseLc, lc, opts)
  local root_dir = baseLc.util.root_pattern("gradle.properties", "build.gradle", "pom.xml", ".git")
  lc.setup({
    root_dir = root_dir,
  })
  --lc.start_or_attach(M.config)
  M.baseLc = baseLc
  M.lc = lc
end

M.on_attach = function()
  if M.baseLc then
    local root_dir = M.baseLc.util.root_pattern("gradle.properties", "build.gradle", "pom.xml", ".git")
    local config = M.config
    config.java.format.settings.url = "**/*/checkstyle.xml"
  end
end

return M
