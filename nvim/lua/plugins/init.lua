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

    use { 'neovim/nvim-lspconfig', config = "require('nvim-lspconfig-config')" }

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
