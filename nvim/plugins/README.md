# README.md

> for (n)vim-preference script sytanxes

## APPENDIX: vimscript

## APPENDIX: lua

see: https://neovim.io/doc/user/api.html

### `autocmd`

```lua
  vim.api.nvim_create_augroup('<augroup_name>', {})
  vim.api.nvim_create_autocmd('<hook>', {
    pattern = '<pattern>',
    callback = function ()
      -- do something
    end
  })
```

#### e.g. create `autocmd` for filetype

1. get filetype by result `:set filetype` on Neovim

2. write below
```lua
  vim.api.nvim_create_autocmd('FileType', {
    pattern = '<filetype_name>',
    callback = function ()
      -- do something
    end
  })
```
