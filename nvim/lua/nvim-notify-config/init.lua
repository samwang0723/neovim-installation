local status_ok, notify = pcall(require, "notify")
if not status_ok then
  vim.notify("nvim-notify: cannot be found!")
  return
end

local ustatus_ok, stages_util = pcall(require, "notify.stages.util")
if not ustatus_ok then
  vim.notify("notify.stages.util: cannot be found!")
  return
end

notify.setup({
  timeout = 3000,
  max_width = 80,
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "",
  },
})

vim.g.notify_default_opts = { width = 80 }
