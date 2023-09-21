require("lualine-config")
require("nvim-cmp-config")
require("nvim-treesitter-config")
require("colorscheme")
require("null_ls-config")
require("mason-config")
require("nvim-notify-config")
require("neo-ai-config")

local sc_status_ok, smartcolumn = pcall(require, "smartcolumn")
if sc_status_ok then
  smartcolumn.setup({
    disabled_filetypes = { "dashboard", "packer" },
  })
else
  vim.notify("smartcolumn: cannot be found!")
end

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.api.nvim_command("packadd packer.nvim")
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    use("ryanoasis/vim-devicons")
    use("nvim-tree/nvim-web-devicons")
    use("Yggdroot/indentLine")
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    })
    use("airblade/vim-gitgutter")
    use("itchyny/vim-gitbranch")
    use("andrewstuart/vim-kubernetes")
    use("tsandall/vim-rego")
    use("folke/lsp-colors.nvim")
    use({ "tami5/lspsaga.nvim", config = "require('lspsaga-config')" })
    -- ruby on rails
    --use 'vim-ruby/vim-ruby'
    --use 'tpope/vim-rails'
    --use 'tpope/vim-endwise'
    use("slim-template/vim-slim")
    -- sass highlight
    use("JulesWang/css.vim")
    use("cakebaker/scss-syntax.vim")
    use("isRuslan/vim-es6")
    -- prettier
    use("MunifTanjim/prettier.nvim")
    -- Copilot
    use("github/copilot.vim")
    -- vim testing helper
    use("vim-test/vim-test")
    -- go install github.com/cweill/gotests/...
    use("buoto/gotests-vim")
    use({
      "andythigpen/nvim-coverage",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("coverage").setup({
          commands = true,
        })
      end,
    })
    -- popup key bindings
    use({ "folke/which-key.nvim", config = "require('whichkey-config')" })
    -- controlling
    use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
    use({
      "romgrk/barbar.nvim",
      requires = { "nvim-web-devicons" },
    })
    use({
      "APZelos/blamer.nvim",
      setup = function()
        vim.g.blamer_enabled = 1
      end,
    })
    -- lualine status bar
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "nvim-web-devicons", opt = true },
    })
    -- use 'arkav/lualine-lsp-progress'
    use({
      "preservim/tagbar",
      cmd = "TagbarToggle",
      setup = function()
        vim.g.tagbar_type_go = {
          ctagstype = "go",
          kinds = {
            "p:package",
            "i:imports:1",
            "c:constants",
            "v:variables",
            "t:types",
            "n:interfaces",
            "w:fields",
            "e:embedded",
            "m:methods",
            "r:constructor",
            "f:functions",
          },
          sro = ".",
          kind2scope = {
            t = "ctype",
            n = "ntype",
          },
          scope2kind = {
            ctype = "t",
            ntype = "n",
          },
          ctagsbin = "gotags",
          ctagsargs = "-sort -silent",
        }
      end,
    })
    use({
      "alvan/vim-closetag",
      setup = function()
        vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.tpl"
        vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx"
        vim.g.closetag_filetypes = "html,xhtml,phtml"
        vim.g.closetag_xhtml_filetypes = "xhtml,jsx"
        vim.g.closetag_emptyTags_caseSensitive = 1
        vim.g.closetag_shortcut = ">"
        vim.g.closetag_close_shortcut = "<leader>>"
      end,
    })
    use("samwang0723/sqls.nvim")
    use({
      "hashivim/vim-terraform",
      setup = function()
        vim.g.terraform_fmt_on_save = 1
      end,
    })
    -- colorscheme
    use("navarasu/onedark.nvim")
    -- nerdtree to file explorer
    --use({ "preservim/nerdtree" })
    --use("Xuyuanp/nerdtree-git-plugin")
    use({
      "nvim-tree/nvim-tree.lua",
      requires = {
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
      },
      config = "require('nvim-tree-config')",
    })
    use("brenoprata10/nvim-highlight-colors")
    -- snippets and auto completion
    use({
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      tag = "v<CurrentMajor>.*",
      -- install jsregexp (optional!:).
      run = "make install_jsregexp",
    })
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")
    use({ "samwang0723/nvim-cmp" }) -- Autocompletion plugin
    use("hrsh7th/cmp-nvim-lsp") -- Autocompletion with LSPs
    use("hrsh7th/cmp-buffer") -- Autocompletion with buffer
    use("hrsh7th/cmp-path") -- Autocompletion with path
    use("onsails/lspkind-nvim")
    use({ "samwang0723/nvim-lspconfig", config = "require('nvim-lspconfig-config')" })
    use({ "j-hui/fidget.nvim", tag = "legacy" })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("jose-elias-alvarez/null-ls.nvim")
    use("williamboman/mason.nvim")
    -- telescope for convenient search
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
      },
      cmd = "Telescope",
    })
    use({
      "akinsho/toggleterm.nvim",
      tag = "*",
      config = function()
        require("toggleterm").setup()
      end,
    })
    use({ "rcarriga/nvim-notify" })
    use({ "m4xshen/smartcolumn.nvim" })
    use({
      "samwang0723/dashboard-nvim",
      event = "VimEnter",
      config = function()
        require("dashboard").setup({
          config = {
            theme = "hyper",
            week_header = {
              enable = true,
            },
            shortcut = {
              { desc = " Update", group = "@property", action = "PackerSync", key = "u" },
              {
                icon = " ",
                icon_hl = "@variable",
                desc = "Files",
                group = "Label",
                action = "Telescope find_files",
                key = "f",
              },
              {
                desc = " Live Grep",
                group = "Number",
                action = "Telescope live_grep",
                key = "g",
              },
            },
          },
        })
      end,
      requires = { "nvim-web-devicons" },
    })

    -- csv support
    use({
      "cameron-wags/rainbow_csv.nvim",
      config = function()
        require("rainbow_csv").setup()
      end,
      -- optional lazy-loading below
      module = {
        "rainbow_csv",
        "rainbow_csv.fns",
      },
      ft = {
        "csv",
        "tsv",
        "csv_semicolon",
        "csv_whitespace",
        "csv_pipe",
        "rfc_csv",
        "rfc_semicolon",
      },
    })

    use({ "towolf/vim-helm" })
    use({ "MunifTanjim/nui.nvim" })
    use({
      "Bryley/neoai.nvim",
      config = "require('neo-ai-config')",
    })
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
