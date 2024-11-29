local cmd_sources = {
  [":"] = { "cmdline-history", "around" },
  ["@"] = { "cmdline-history", "input", "file", "around" },
  [">"] = { "cmdline-history", "input", "file", "around" },
  ["/"] = { "line", "around" },
  ["?"] = { "line", "around" },
  ["-"] = { "line", "around" },
  ["="] = { "input" },
}

return cmd_sources
