require('nvim-cmp-config')
require('nvim-treesitter-config')
require('colorscheme')

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
    use 'itchyny/vim-gitbranch'
    use 'andrewstuart/vim-kubernetes'
    use 'tsandall/vim-rego'
    use 'folke/lsp-colors.nvim'
    use { 'tami5/lspsaga.nvim', config = "require('lspsaga-config')" }
    -- ruby on rails
    --use 'vim-ruby/vim-ruby'
    --use 'tpope/vim-rails'
    --use 'tpope/vim-endwise'
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
    use { 'romgrk/barbar.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
    use {
      'APZelos/blamer.nvim',
      setup = function()
        vim.g.blamer_enabled = 1
      end
    }
    use 'arkav/lualine-lsp-progress'
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

    -- colorscheme
    -- use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
    use 'navarasu/onedark.nvim'
    -- use 'rakr/vim-one'

    -- nerdtree to file explorer
    use {
      'preservim/nerdtree',
      config = function()
        vim.g.NERDTreeDirArrowExpandable = '├'
        vim.g.NERDTreeDirArrowCollapsible = '└'
        vim.g.NERDTreeMapActivateNode = '<tab>'
        vim.cmd [[set mouse=a]]
      end
    }
    use 'brenoprata10/nvim-highlight-colors'

    -- snippets and auto completion
    use {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      tag = "v<CurrentMajor>.*",
      -- install jsregexp (optional!:).
      run = "make install_jsregexp"
    }
    use 'rafamadriz/friendly-snippets'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- Autocompletion with LSPs
    use { 'neovim/nvim-lspconfig', config = "require('nvim-lspconfig-config')" }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- telescope for convinient search
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
