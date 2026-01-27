local mason_servers = {
  --"astro",
  "cssls",
  --"css_variables",
  --"cssmodules_ls",
  "docker_compose_language_service",
  "dockerls",
  "html",
  "intelephense",
  "lua_ls",
  "marksman",
  --"rust_analyzer",
  --"svelte",
  "tailwindcss",
  "ts_ls",
  --"vtsls",
  --"vue_ls",
}

local non_mason_servers = {
  "laravel_ls",
}

local M = {
  mason_servers = mason_servers,
  non_mason_servers = non_mason_servers,
}

function M:setup()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = mason_servers,
    automatic_enable = true,
  })

  vim.lsp.enable(non_mason_servers)

  -- 読み込み中にくるくる回るアレ
  -- https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md#-examples
  ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
  local progress = vim.defaulttable()
  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local value = ev.data.params
          .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
      if not client or type(value) ~= "table" then
        return
      end
      local p = progress[client.id]

      for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
          p[i] = {
            token = ev.data.params.token,
            msg = ("[%3d%%] %s%s"):format(
              value.kind == "end" and 100 or value.percentage or 100,
              value.title or "",
              value.message and (" **%s**"):format(value.message) or ""
            ),
            done = value.kind == "end",
          }
          break
        end
      end

      local msg = {} ---@type string[]
      progress[client.id] = vim.tbl_filter(function(v)
        return table.insert(msg, v.msg) or not v.done
      end, p)

      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(table.concat(msg, "\n"), "info", {
        id = "lsp_progress",
        title = client.name,
        opts = function(notif)
          notif.icon = #progress[client.id] == 0 and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

return M
