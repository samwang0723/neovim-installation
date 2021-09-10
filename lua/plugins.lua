local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]
vim.g.go_fmt_autosave = 1

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

--    use {
--        'sainnhe/gruvbox-material',
--        setup = function()
--            vim.g.gruvbox_material_background = 'soft'
--        end,
--        config = function()
--            vim.cmd[[colorscheme gruvbox-material]]
--        end
--    }

	use {
		'rakr/vim-one',
		setup = function()
			vim.g.one_allow_italics = 1
			vim.g.airline_theme='one'
		end,
		config = function()
			vim.cmd[[colorscheme one]]
			vim.cmd[[set background=dark]]
			vim.cmd[[set termguicolors]]
		end
	}

    use {
        'Yggdroot/indentLine',
        setup = function()
            vim.g.indentLine_defaultGroup = 'SpecialKey'
            vim.g.indentLine_char = '┆'
        end,
        config = function()
        end
    }

    use {
        'preservim/nerdtree',
        setup = function()
            vim.api.nvim_set_keymap("n", "<C-d>", "<cmd>NERDTreeToggle<cr>" ,{silent = true, noremap = true})
        end
    }

    use {
        'fatih/vim-go',
        run = ':GoUpdateBinaries',
        ft = 'go',
        setup = function()
            vim.g.go_diagnostics_enabled = 1
            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            local check_back_space = function()
                local col = vim.fn.col('.') - 1
                if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    return true
                else
                    return false
                end
            end

            _G.tab_complete = function()
                if vim.fn.pumvisible() == 1 then
                    return t "<C-n>"
                elseif check_back_space() then
                    return t "<Tab>"
                else
                    return t "<C-x><C-o>"
                end
            end

            _G.s_tab_complete = function()
                if vim.fn.pumvisible() == 1 then
                    return t "<C-p>"
                else
                    return t "<C-h>"
                end
            end

            _G.enter_key = function()
                if vim.fn.pumvisible() == 1 then
                    return t "<C-y>"
                else
                    return t "<CR>"
                end
            end

            vim.api.nvim_set_keymap("i", "<tab>", "<C-R>=v:lua.tab_complete()<CR>" ,{silent = true, noremap = true})
            vim.api.nvim_set_keymap("i", "<s-tab>", "<C-R>=v:lua.s_tab_complete()<CR>" ,{silent = true, noremap = true})
            vim.api.nvim_set_keymap('i', '<enter>', '<C-R>=v:lua.enter_key()<CR>' ,{silent = true, noremap = true})
        end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function()
        diagnostic_config = {
            -- Enable underline, use default values
            underline = true,
            -- Enable virtual text, override spacing to 2
            virtual_text = {
                spacing = 2,
                prefix = '<',
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

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config)
            vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',{silent = true, noremap = true})
            vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',{silent = true, noremap = true})
            require('lspconfig').gopls.setup{}
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        cmd = 'Telescope',
        setup = function()
            vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>Telescope find_files<cr>", {noremap = true})
        end
    }

    use {
        'preservim/tagbar',
        setup = function()
            vim.g.tagbar_type_go = {
                ctagstype = 'go',
                kinds = {
                    'p:package',
                    'i:imports:1',
                    'c:constants',
                    'v:variables',
                    't:types',
                    'n:interfaces',
                    'w:fields',
                    'e:embedded',
                    'm:methods',
                    'r:constructor',
                    'f:functions'
                },
                sro = '.',
                kind2scope = {
                    t = 'ctype',
                    n = 'ntype',
                },
                scope2kind = {
                    ctype = 't',
                    ntype = 'n'
                },
                ctagsbin  = 'gotags',
                ctagsargs = '-sort -silent'
            }
            vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>TagbarToggle<cr>" ,{silent = true, noremap = true})
        end
}
end)

