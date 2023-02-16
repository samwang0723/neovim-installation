local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("null_ls: cannot be found!")
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    -- brew install shfmt
    formatting.shfmt,
    formatting.rome,
    -- StyLua
    formatting.stylua,
    formatting.gofumpt,
    formatting.gofmt,
    formatting.goimports,
    -- frontend
    formatting.prettier,
    formatting.fixjson,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.dprint,
    formatting.sql_formatter,
    formatting.buf,
    formatting.codespell,
  },

  on_attach = function(client)
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
  end,
})

vim.cmd([[
    augroup format_on_save
        autocmd!
        autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
    augroup end
]])
