vim.o.timeout = true
vim.o.timeoutlen = 300

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  vim.notify("which_key: cannot be found!")

  return
end

wk.register({
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
  },
  s = {
    name = "Sqls",
    e = { ":SqlsExecuteQuery<cr>", "Execute Query" },
    d = { ":SqlsShowDatabases<cr>", "Show Databases" },
    s = { ":SqlsShowSchemas<cr>", "Show Schemas" },
    c = { ":SqlsShowConnections<cr>", "Show Connections" },
  },
  d = {
    name = "Diffview",
    o = { ":DiffviewOpen<cr>", "Open Diffview" },
    c = { ":DiffviewClose<cr>", "Close Diffview" },
  },
  g = {
    name = "Golang",
    c = { ":GoCoverageToggle<cr>", "Toggle Coverage" },
    s = { ":GoFillStruct<cr>", "Fill Struct" },
  },
  t = {
    name = "Tester",
    n = { ":TestNearest<cr>", "Test Nearest" },
    f = { ":TestFile<cr>", "Test File" },
  }
}, { prefix = '<leader>' })
