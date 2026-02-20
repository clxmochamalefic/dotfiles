local cmd_sources = {
  [":"] = { "cmdline", "cmdline_history", "around" },
  ["@"] = { "cmdline", "cmdline_history", "input", "file", "around" },
  [">"] = { "cmdline", "cmdline_history", "input", "file", "around" },
  ["/"] = { "line", "around" },
  ["?"] = { "line", "around" },
  ["-"] = { "line", "around" },
  ["="] = { "input" },
}

return cmd_sources
