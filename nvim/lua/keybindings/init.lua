local map = vim.api.nvim_set_keymap

map("n", "<C-f>", ":NERDTreeToggle %<CR>", { noremap = true, silent = true })
map("n", '"', ":WhichKey<CR>", { noremap = true, silent = true })
map("n", "<C-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
map("i", "<C-t>", '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
map("n", "<C-l>", "<Cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })
map("n", "<F8>", ":TagbarToggle<CR>", { noremap = true, silent = true })
map("n", "<C-p>", ":Copilot panel<CR>", { noremap = true, silent = true })
map("n", "<C-]>", "<Plug>(copilot-next)", { noremap = true, silent = true })
map("n", "<C-[>", "<Plug>(copilot-previous)", { noremap = true, silent = true })
