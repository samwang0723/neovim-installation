local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  vim.notify("cmp_nvim_lsp: cannot be found!")
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = false

diagnostic_config = {
  -- Enable underline, use default values
  underline = true,
  -- Enable virtual text, override spacing to 2
  virtual_text = {
    spacing = 2,
  },
  -- Use a function to dynamically turn signs off
  -- and on, using buffer local variables
  signs = function(bufnr, client_id)
    local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
    -- No buffer local variable set, so just enable by default
    if not ok then
      return true
    end
    return result
  end,
  -- Disable a feature
  update_in_insert = false,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
  diagnostic_config)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
                  hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
                  hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
                  hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
                  augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                  augroup END
                ]], false)
  end
end

local lsputil_status_ok, util = pcall(require, "lspconfig/util")
if not lsputil_status_ok then
  vim.notify("lspconfig/util: cannot be found!")
  return
end

local lsp_status_ok, lsp = pcall(require, "lspconfig")
if not lsp_status_ok then
  vim.notify("lspconfig: cannot be found!")
  return
end

-- golang LSP
lsp.gopls.setup {
  root_dir = function(fname)
    local root = fname:match ".*/github.com/samwang0723/.-/"
    return root ~= nil and root or util.root_pattern(".git", "go.mod")(fname)
  end,
  cmd = { "gopls", "-v", "-rpc.trace", "serve", "--debug=localhost:6060" },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    gopls = {
      completeUnimported = true,
      staticcheck = false,
      usePlaceholders = true,
      semanticTokens = true,
      codelenses = {
        generate = true,
        test = true,
      },
      matcher = "fuzzy",
      symbolMatcher = "fuzzy",
      analyses = {
        printf = true,
        fillreturns = true,
        nonewvars = true,
        undeclaredname = true,
        unusedparams = true,
        unreachable = true,
        fieldalignment = true,
        ifaceassert = true,
        nilness = true,
        shadow = true,
        unusedwrite = true,
        fillstruct = true,
      },
      annotations = {
        escape = true,
        inline = true,
        bounds = true,
      },
      deepCompletion = true,
      tempModfile = false,
      expandWorkspaceToModule = false,
      experimentalWorkspaceModule = true,
      verboseOutput = true,
      gofumpt = true,
    },
  },
}
lsp.golangci_lint_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Ruby on Rails LSP
lsp.solargraph.setup {
  root_dir = function(fname)
    local root = fname:match ".*/github.com/monacohq/.-/"
    return root ~= nil and root or util.root_pattern(".git", "Gemfile")(fname)
  end,
  commandPath = '/Users/samwang/.asdf/shims/solargraph',
  useBundler = false,
  diagnostics = true,
  completion = true,
  autoformat = true,
  diagnostic = true,
  folding = true,
  references = true,
  rename = true,
  symbols = true,
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Javascript & Typescript LSP
lsp.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function()
    return vim.loop.cwd()
  end,
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- HTML/CSS LSP
lsp.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}
lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- docker LSP
lsp.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- lua LSP
lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- markdown LSP
lsp.marksman.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- vim LSP
lsp.vimls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.sqls.setup {
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lsp.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
