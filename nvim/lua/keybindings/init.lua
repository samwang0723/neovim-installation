local map = vim.api.nvim_set_keymap

map('n', '<leader>ct', '<Plug>(go-coverage-toggle)<CR>', { noremap = true, silent = true })
map('n', '<leader>tn', ':TestNearest<CR>', { noremap = true, silent = true })
map('n', '<leader>tf', ':TestFile<CR>', { noremap = true, silent = true })
map('n', '<leader>fs', ':GoFillStruct<CR>', { noremap = true, silent = true })
map('n', '<leader>do', ':DiffviewOpen<CR>', { noremap = true, silent = true })
map('n', '<leader>dc', ':DiffviewClose<CR>', { noremap = true, silent = true })
map('n', 'vs', ':vsplit<CR>', { noremap = true, silent = true })
map('n', 'hs', ':split<CR>', { noremap = true, silent = true })
map('n', '"', ':WhichKey<CR>', { noremap = true, silent = true })

-- Lspsaga keybindings
map('n', '<leader>ca', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
map('n', '<leader>cd', ':Lspsaga show_line_diagnostics<CR>', { noremap = true, silent = true })
map('n', 'gh', ':Lspsaga lsp_finder<CR>', { noremap = true, silent = true })
map('n', 'hh', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true })
map('n', 'rn', ':Lspsaga rename<CR>', { noremap = true, silent = true })
map('n', 'pd', ':Lspsaga preview_definition<CR>', { noremap = true, silent = true })
map('n', '[e', ':Lspsaga diagnostic_jump_next<CR>', { noremap = true, silent = true })
map('n', ']e', ':Lspsaga diagnostic_jump_prev<CR>', { noremap = true, silent = true })
map('n', 'gs', ':Lspsaga signature_help<CR>', { noremap = true, silent = true })
map('t', '<F6>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', { noremap = true, silent = true })
map('n', '<F7>', ':Lspsaga toggle_floaterm<CR>', { noremap = true, silent = true })
map('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })
map('n', '<C-f>', ':NERDTreeToggle %<CR>', { noremap = true, silent = true })

-- sqls keybindings
map('n', '<leader>se', ':SqlsExecuteQuery<CR>', { noremap = true, silent = true })
map('n', '<leader>sd', ':SqlsShowDatabases<CR>', { noremap = true, silent = true })
map('n', '<leader>ss', ':SqlsShowSchemas<CR>', { noremap = true, silent = true })
map('n', '<leader>sc', ':SqlsShowConnections<CR>', { noremap = true, silent = true })
