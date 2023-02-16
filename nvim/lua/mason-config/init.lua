local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("mason: cannot be found!")
  return
end

local gopath = os.getenv("GOPATH")
local bin_path = gopath .. "/lsp"

mason.setup({
  install_root_dir = bin_path,
  PATH = "skip",
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
