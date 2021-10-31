local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

vim.cmd [[set shiftwidth=0]]
vim.cmd [[set tabstop=4]]
vim.cmd [[set softtabstop=-1]]
vim.cmd [[set expandtab]]
vim.cmd [[set autoindent]]
vim.cmd [[set smartindent]]

function goimports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'itchyny/lightline.vim'
    use 'ryanoasis/vim-devicons'
    use 'Yggdroot/indentLine'
    use 'jiangmiao/auto-pairs'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'
    use 'itchyny/vim-gitbranch'
    use 'andrewstuart/vim-kubernetes'
    use 'tsandall/vim-rego'
    use 'folke/lsp-colors.nvim'
    use 'tami5/lspsaga.nvim'

    use {
        'APZelos/blamer.nvim',
        setup = function()
            vim.g.blamer_enabled = 1
        end
    }
    use {
        'preservim/tagbar',
        cmd = 'TagbarToggle',
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
            vim.api.nvim_set_keymap("n", "<F8>", "<cmd>TagbarToggle<cr>" ,{silent = true, noremap = true})
        end
    }
    use {
        'alvan/vim-closetag',
        setup = function()
            vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.tpl'
            vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx'
            vim.g.closetag_filetypes = 'html,xhtml,phtml'
            vim.g.closetag_xhtml_filetypes = 'xhtml,jsx'
            vim.g.closetag_emptyTags_caseSensitive = 1
            vim.g.closetag_shortcut = '>'
            vim.g.closetag_close_shortcut = '<leader>>'
        end
    }
--    use 'ekalinin/Dockerfile.vim'
    use {
        'hashivim/vim-terraform',
        setup = function()
            vim.g.terraform_fmt_on_save = 1
        end
    }

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
        'preservim/nerdtree',
        setup = function()
            vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>NERDTreeToggle<cr>" ,{silent = true, noremap = true})
        end,
        config = function()
            vim.g.NERDTreeDirArrowExpandable = '├'
            vim.g.NERDTreeDirArrowCollapsible = '└'
            vim.g.NERDTreeMapActivateNode = '<tab>'
            vim.cmd[[set mouse=a]]
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

            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config)

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            
            local on_attach = function(client, bufnr)
              local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
              local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
            
              buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
            
              -- Mappings.
              local opts = { noremap=true, silent=true }
              buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
              buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
              buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--              buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
              buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--              buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--              buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--              buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--              buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
              buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--              buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
              buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--              buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
              buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
              buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
              buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
            
              -- Set some keybinds conditional on server capabilities
              if client.resolved_capabilities.document_formatting then
                buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
              elseif client.resolved_capabilities.document_range_formatting then
                buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
              end
            
              -- Set autocommands conditional on server_capabilities
              if client.resolved_capabilities.document_highlight then
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

            util = require('lspconfig/util')
            require('lspconfig').gopls.setup {
                root_dir = function(fname) 
                    local root = fname:match ".*/github.com/samwang0723/.-/"
                    return root ~= nil and root or util.root_pattern(".git", "go.mod")(fname)
	            end,
                cmd = {"gopls", "-v", "-rpc.trace", "serve", "--debug=localhost:6060"},
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                  debounce_text_changes = 150,
                },
                settings = {
                  gopls = {
                    analyses = {
                      unusedparams = true,
                    },
                    completeUnimported= true,
                    staticcheck= false,
                    usePlaceholders= true,
                    semanticTokens= true,
                    codelenses= {
                      generate= true,
                      test= true,
                    },
                    matcher= "fuzzy",
                    symbolMatcher= "fuzzy",
                    analyses= {
                      printf= true,
                      fillreturns= true,
                      nonewvars= true,
                      undeclaredname= true,
                      unusedparams= true,
                      unreachable= true,
                      fieldalignment= true,
                      ifaceassert= true,
                      nilness= true,
                      shadow= true,
                      unusedwrite= true,
                    },
                    annotations= {
                      escape= true,
                      inline= true,
                      bounds= true,
                    },
                    deepCompletion= true,
                    tempModfile= false,
                    expandWorkspaceToModule= false,
                    experimentalWorkspaceModule= true,
                    verboseOutput= true,
                  },
                },
            }
        end
    }

    use {
        'fatih/vim-go',
        run = ':GoUpdateBinaries',
        ft = 'go',
        setup = function()
            vim.g.go_diagnostics_enabled = 1
            vim.g.go_highlight_types = 1
            vim.g.go_highlight_fields = 1
            vim.g.go_highlight_functions = 1
            vim.g.go_highlight_function_calls = 1
            vim.g.go_highlight_operators = 1
            vim.g.go_highlight_extra_types = 1
            vim.g.go_highlight_build_constraints = 1
            vim.g.go_highlight_generate_tags = 1
            vim.g.go_gocode_propose_source = 0
            vim.g.go_template_autocreate = 0
            vim.g.go_fmt_autosave = 1
            vim.g.go_gopls_enabled = 0
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
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        cmd = 'Telescope',
        setup = function()
            vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>Telescope find_files<cr>", {noremap = true})
        end
    }
end)

