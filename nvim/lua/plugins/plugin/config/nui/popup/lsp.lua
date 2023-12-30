-- config.nui.popup.lsp

local M = {}

local Table = require("nui.table")
local Text = require("nui.text")

function M.show()
  local tbl = Table({
    bufnr = bufnr,
    columns = {
      {
        align = "right",
        header = "Name",
        columns = {
          {
            accessor_key = "shortcut",
            header = "Key"
          },
          {
            accessor_key = "name",
            header = "Name",
            accessor_fn = function(row)
              return row.lastName
            end,
          },
        },
      },
      {
        align = "left",
        accessor_key = "desc",
        header = "Description",
        cell = function(cell)
          return Text(tostring(cell.get_value()), "DiagnosticInfo")
        end,
      },
    },
    data = {
      { shortcut = "D", name = "declaration", desc = "" }
    },
  })

  tbl:render()
end
