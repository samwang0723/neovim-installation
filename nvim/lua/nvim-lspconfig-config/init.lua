local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  vim.notify("cmp_nvim_lsp: cannot be found!")
  return
end

local f_status_ok, fidget = pcall(require, "fidget")
if not f_status_ok then
  vim.notify("fidget: cannot be found!")
  return
end
fidget.setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local diagnostic_config = {
  -- Enable underline, use default values
  underline = true,
  -- Enable virtual text, override spacing to 2
  virtual_text = {
    spacing = 2,
  },
  -- Use a function to dynamically turn signs off
  -- and on, using buffer local variables
  signs = function(bufnr, client_id)
    local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
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
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

  if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
    vim.diagnostic.disable()
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
lsp.gopls.setup({
  root_dir = function(fname)
    local root = fname:match(".*/github.com/samwang0723/.-/")
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
      verboseOutput = true,
      gofumpt = true,
      directoryFilters = {
        "-node_modules",
        "-third_party",
      },
    },
  },
})

lsp.golangci_lint_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- Ruby on Rails LSP
lsp.solargraph.setup({
  root_dir = function(fname)
    local root = fname:match(".*/github.com/monacohq/.-/")
    return root ~= nil and root or util.root_pattern(".git", "Gemfile")(fname)
  end,
  commandPath = "/Users/samwang/.asdf/shims/solargraph",
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
})

-- Javascript & Typescript LSP
lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- HTML/CSS LSP
lsp.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

lsp.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- docker LSP
--lsp.docker_compose_language_service.setup({
--  on_attach = on_attach,
--  capabilities = capabilities,
--  flags = {
--    debounce_text_changes = 150,
--  },
--})
lsp.dockerls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- lua LSP
lsp.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "lua" },
      },
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
})

-- markdown LSP
lsp.marksman.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- vim LSP
lsp.vimls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lsp.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lsp.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

--lsp.sqls.setup({
--  on_attach = function(client, bufnr)
--    local status_ok, sqls = pcall(require, "sqls")
--    if not status_ok then
--      vim.notify("sqls: cannot be found!")
--      return
--    end
--    sqls.on_attach(client, bufnr)
--  end,
--  capabilities = capabilities,
--})

lsp.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        reportGeneralTypeIssues = false,
      },
    },
  },
})

local configs = require("lspconfig.configs")
if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = { "helm_ls", "serve" },
      filetypes = { "helm" },
      root_dir = function(fname)
        return util.root_pattern("Chart.yaml")(fname)
      end,
    },
  }
end

lsp.helm_ls.setup({
  filetypes = { "helm" },
  cmd = { "helm_ls", "serve" },
})

lsp.yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["file:///Users/samwang/Workspace/src/github.com/samwang0723/neovim-installation/nvim/syntax/compose_spec.json"] = "/docker-compose*.yml",
        ["https://json.schemastore.org/chart.json"] = "/deployment/helm/*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
  on_attach = on_attach,
})

-- This plugin automatically sets up nvim-lspconfig for rust_analyzer for you
-- , so don't do that manually, as it causes conflicts.
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = on_attach,
  },
})
