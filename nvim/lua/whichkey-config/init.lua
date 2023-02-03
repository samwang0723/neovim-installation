vim.o.timeout = true
vim.o.timeoutlen = 300

local wk = require("which-key")

local mappings = {
  f = {
    name = "Telescope",
    f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
  },
  k = {
    name = "Packer",
    r = { ":PackerClean<cr>", "Remove Unused Plugins" },
    c = { ":PackerCompile profile=true<cr>", "Recompile Plugins" },
    i = { ":PackerInstall<cr>", "Install Plugins" },
    p = { ":PackerProfile<cr>", "Packer Profile" },
    s = { ":PackerSync<cr>", "Sync Plugins" },
    S = { ":PackerStatus<cr>", "Packer Status" },
    u = { ":PackerUpdate<cr>", "Update Plugins" }
  }
}

local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
