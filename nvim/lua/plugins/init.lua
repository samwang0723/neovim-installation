local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.api.nvim_command('packadd packer.nvim')
end

return require('packer').startup({
  function(use)
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
    use { 'tami5/lspsaga.nvim', config = "require('lspsaga-config')" }
    -- ruby on rails
    use 'vim-ruby/vim-ruby'
    use 'tpope/vim-rails'
    use 'tpope/vim-endwise'
    use 'tpope/vim-bundler'
    use 'slim-template/vim-slim'
    -- sass highlight
    use 'JulesWang/css.vim'
    use 'cakebaker/scss-syntax.vim'
    use 'isRuslan/vim-es6'
    -- prettier
    use 'prettier/vim-prettier'
    -- Copilot
    use 'github/copilot.vim'
    -- vim testing helper
    use 'vim-test/vim-test'
    -- go install github.com/cweill/gotests/...
    use 'buoto/gotests-vim'
    -- popup key bindings
    use { "folke/which-key.nvim", config = "require('whichkey-config')" }
    -- controlling
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {
      'romgrk/barbar.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
      'APZelos/blamer.nvim',
      setup = function()
        vim.g.blamer_enabled = 1
      end
    }
    use {
      "j-hui/fidget.nvim",
      setup = function()
        window = {
          blend = 0,
        }
      end
    }
    use {
      'preservim/tagbar',
      cmd = 'TagbarToggle',
      setup = function()
        vim.g.tagbar_type_go = {
          ctagstype  = 'go',
          kinds      = {
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
          sro        = '.',
          kind2scope = {
            t = 'ctype',
            n = 'ntype',
          },
          scope2kind = {
            ctype = 't',
            ntype = 'n'
          },
          ctagsbin   = 'gotags',
          ctagsargs  = '-sort -silent'
        }
        vim.api.nvim_set_keymap("n", "<F8>", "<cmd>TagbarToggle<cr>", { silent = true, noremap = true })
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
        vim.g.airline_theme = 'one'
      end,
      config = function()
        vim.cmd [[colorscheme one]]
        vim.cmd [[set background=dark]]
        vim.cmd [[set termguicolors]]
      end
    }

    use {
      'preservim/nerdtree',
      setup = function()
        vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>NERDTreeToggle<cr>", { silent = true, noremap = true })
      end,
      config = function()
        vim.g.NERDTreeDirArrowExpandable = '├'
        vim.g.NERDTreeDirArrowCollapsible = '└'
        vim.g.NERDTreeMapActivateNode = '<tab>'
        vim.cmd [[set mouse=a]]
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

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
          diagnostic_config)

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

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

        local util = require('lspconfig/util')
        local lsp = require('lspconfig')
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
            local root = fname:match ".*/github.com/samwang0723/.-/"
            return root ~= nil and root or util.root_pattern(".git", "Gemfile")(fname)
          end,
          commandPath = '/Users/samwang/.asdf/shims/solargraph',
          useBundler = true,
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
          filetypes = {
            "ruby"
          },
        }
        -- Javascript & Typescript
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
        -- HTML support
        lsp.html.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }
        -- CSS support
        lsp.cssls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }
        -- CSS support
        lsp.dockerls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }
        -- lua support
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
        -- markdown
        lsp.marksman.setup {}
      end
    }

    use {
      'fatih/vim-go',
      run = ':GoUpdateBinaries',
      ft = 'go',
      setup = function()
        vim.g.go_diagnostics_enabled = 0
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
        vim.g.go_fmt_autosave = 0
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
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
      cmd = 'Telescope'
    }
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})