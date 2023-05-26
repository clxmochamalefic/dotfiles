local define = {
  e    = { expr    = true },
  b    = { buffer  = true },
  n    = { noremap = true },
  s    = { silent  = true },
  eb   = { expr    = true, buffer  = true, },
  en   = { expr    = true,                 noremap = true, },
  es   = { expr    = true,                                 silent = true, },
  ebn  = { expr    = true, buffer = true,  noremap = true, },
  ebs  = { expr    = true, buffer = true,                  silent = true, },
  ens  = { expr    = true,                 noremap = true, silent = true, },
  ebns = { expr    = true, buffer = true,  noremap = true, silent = true, },
  bn   = {                 buffer  = true, noremap = true, },
  bns  = {                 buffer  = true, noremap = true, silent = true, },
  ns   = {                                 noremap = true, silent = true, },
}

return define
