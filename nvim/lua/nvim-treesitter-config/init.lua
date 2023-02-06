require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "rust", "c", "cpp", "lua", "typescript", "jsonc", "gomod", "html", "css", "dockerfile",
    "tsx", "comment", "vim", "markdown", "elixir", "javascript", "nix", "ruby", "sql", "yaml", "json" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true
  },
  autotag = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autopairs = { enable = true },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99
