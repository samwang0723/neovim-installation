local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("null_ls: cannot be found!")
  return
end

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>lfa", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] formatting" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] formatting on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>lfr", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] range formatting" })
    end
  end,
})

local p_status_ok, prettier = pcall(require, "prettier")
if not p_status_ok then
  vim.notify("prettier: cannot be found!")

  return
end

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.code_actions.xo,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.formatting.sqlformat,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.pycodestyle,
    null_ls.builtins.diagnostics.alex,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.tidy,
    --null_ls.builtins.formatting.rubocop,
  },
  filetypes = {
    "sh",
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "go",
    --"ruby",
    "sql",
    "python",
    --"lua",
    "vim",
    "dockerfile",
    "xml",
  },
})
