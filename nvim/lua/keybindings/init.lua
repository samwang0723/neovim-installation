local map = vim.api.nvim_set_keymap

map('n', 'vs', ':vsplit<CR>', { noremap = true, silent = true })
map('n', 'hs', ':split<CR>', { noremap = true, silent = true })
map('n', '<C-f>', ':NERDTreeToggle %<CR>', { noremap = true, silent = true })
map('n', '"', ':WhichKey<CR>', { noremap = true, silent = true })

-- Lspsaga keybindings
map('n', '<leader>ca', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
map('n', '<leader>cd', ':Lspsaga show_line_diagnostics<CR>', { noremap = true, silent = true })
map('n', 'gh', ':Lspsaga lsp_finder<CR>', { noremap = true, silent = true })
map('n', 'hh', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true })
map('n', 'rn', ':Lspsaga rename<CR>', { noremap = true, silent = true })
map('n', '[e', ':Lspsaga diagnostic_jump_next<CR>', { noremap = true, silent = true })
map('n', ']e', ':Lspsaga diagnostic_jump_prev<CR>', { noremap = true, silent = true })
map('n', 'gs', ':Lspsaga signature_help<CR>', { noremap = true, silent = true })
map('t', '<F6>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', { noremap = true, silent = true })
map('n', '<F7>', ':Lspsaga toggle_floaterm<CR>', { noremap = true, silent = true })
map('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })
