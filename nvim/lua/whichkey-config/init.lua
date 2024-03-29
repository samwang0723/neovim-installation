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
    f = { ":Telescope find_files<cr>", "Find Files" },
    g = { ":Telescope live_grep<cr>", "Live Grep" },
    b = { ":Telescope buffers<cr>", "Buffers" },
    r = { ":Telescope oldfiles<cr>", "Recent Files" },
    m = { ":Telescope vim_bookmarks all<cr>", "All Bookmarks" },
  },
  k = {
    name = "Packer",
    r = { ":PackerClean<cr>", "Remove Unused Plugins" },
    c = { ":PackerCompile profile=true<cr>", "Recompile Plugins" },
    i = { ":PackerInstall<cr>", "Install Plugins" },
    p = { ":PackerProfile<cr>", "Packer Profile" },
    s = { ":PackerSync<cr>", "Sync Plugins" },
    S = { ":PackerStatus<cr>", "Packer Status" },
    u = { ":PackerUpdate<cr>", "Update Plugins" },
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
    f = { ":GoTests<cr>", "Generate Function Test " },
    a = { ":GoTestsAll<cr>", "Generate Test for File" },
  },
  t = {
    name = "Tester",
    n = { ":TestNearest<cr>", "Test Nearest" },
    f = { ":TestFile<cr>", "Test File" },
    c = {
      name = "Coverage",
      s = { ":Coverage<cr>", "Coverage Show" },
      c = { ":CoverageClear<cr>", "Coverage Clear" },
    },
  },
  l = {
    name = "Lspsaga",
    a = { ":Lspsaga code_action<CR>", "Code Action" },
    d = {
      name = "Diagnostic",
      s = { ":Lspsaga show_line_diagnostics<CR>", "Show Diagnostics" },
      n = { ":Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
      p = { ":Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic" },
    },
    f = { ":Lspsaga lsp_finder<CR>", "LSP Finder" },
    h = { ":Lspsaga hover_doc<CR>", "Hover Doc" },
    r = { ":Lspsaga rename<CR>", "Rename" },
    s = { ":Lspsaga signature_help<CR>", "Signature Help" },
    p = { ":Prettier<CR>", "Prettier formatting" },
  },
  w = {
    name = "Split",
    v = { ":vsplit<cr>", "Vertical Split" },
    h = { ":split<cr>", "Horizontal Split" },
  },
  n = {
    name = "NeoAI",
    o = { ":NeoAI<cr>", "Toggle NeoAI" },
    c = { ":NeoAIClose<cr>", "Close NeoAI" },
  },
}, { prefix = "<leader>" })
