local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("null_ls: cannot be found!")
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  debug = false,
  sources = {
    -- brew install shfmt
    formatting.shfmt,
    formatting.rome,
    -- StyLua
    formatting.stylua,
    -- Golang
    formatting.gofumpt,
    formatting.gofmt,
    formatting.goimports,
    -- Python
    formatting.autopep8,
    -- frontend
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "typescript",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "go",
        "ruby",
      },
      command = "prettier",
      args = { "--config", vim.env.HOME .. "/.prettierrc.yml", "-" },
      to_stdin = true,
    }),
    formatting.fixjson,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.dprint,
    formatting.sql_formatter,
    formatting.buf,
    -- diagnostics.codespell,
    -- diagnostics.write_good,
    formatting.cbfmt,
  },

  -- on_attach = function(client)
  --    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })")
  --  end,

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "ff", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "rf", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end

    if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
      vim.diagnostic.disable()
    end
  end,
})

vim.cmd([[
    augroup format_on_save
        autocmd!
        autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
    augroup end
]])

local prettier_status_ok, prettier = pcall(require, "prettier")
if not prettier_status_ok then
  vim.notify("prettier: cannot be found!")
  return
end

prettier.setup({
  debug = false,
  filetypes = {
    "javascript",
    "typescript",
    "css",
    "scss",
    "html",
    "json",
    "yaml",
    "markdown",
    "go",
    "ruby",
  },
  bin = "prettier",
  --args = { "--config", vim.env.HOME .. "/.prettierrc.yml", "-" },
  --to_stdin = true,
  ["null-ls"] = {
    condition = function()
      return prettier.config_exists({
        -- if `false`, skips checking `package.json` for `"prettier"` key
        check_package_json = false,
      })
    end,
    runtime_condition = function(params)
      -- return false to skip running prettier
      return true
    end,
    timeout = 5000,
  },
  cli_options = {
    -- arrow_parens = "always",
    -- bracket_spacing = true,
    -- bracket_same_line = false,
    embedded_language_formatting = "auto",
    -- end_of_line = "lf",
    -- html_whitespace_sensitivity = "css",
    -- jsx_bracket_same_line = false,
    -- jsx_single_quote = false,
    print_width = 80,
    --prose_wrap = "preserve",
    quote_props = "preserve",
    -- semi = true,
    -- single_attribute_per_line = false,
    single_quote = true,
    --tab_width = 2,
    trailing_comma = "none",
    --use_tabs = false,
    --vue_indent_script_and_style = false,
  },
})
