vim.cmd [[set shiftwidth=0]]
vim.cmd [[set tabstop=4]]
vim.cmd [[set softtabstop=-1]]
vim.cmd [[set expandtab]]
vim.cmd [[set autoindent]]
vim.cmd [[set smartindent]]
vim.cmd [[packadd vimball]]

function goimports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local method = 'textDocument/codeAction'
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)

  -- imports is indexed with clientid so we cannot rely on index always is 1
  for _, v in next, resp, nil do
    local result = v.result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit, 'utf-16')
    end
  end
  -- Always do formating
  vim.lsp.buf.formatting_sync()
end
