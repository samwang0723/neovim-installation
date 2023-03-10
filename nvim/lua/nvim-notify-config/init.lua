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
  stages = {
    function(state)
      local next_height = state.message.height + 2
      local next_row =
      stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP)
      if not next_row then
        return nil
      end
      return {
        relative = "editor",
        anchor = "NE",
        width = state.message.width,
        height = state.message.height,
        col = vim.opt.columns:get(),
        row = next_row,
        border = "rounded",
        style = "minimal",
        opacity = 0,
      }
    end,
    function()
      return {
        opacity = { 100 },
        col = { vim.opt.columns:get() },
      }
    end,
    function()
      return {
        col = { vim.opt.columns:get() },
        time = true,
      }
    end,
    function()
      return {
        width = {
          1,
          frequency = 2.5,
          damping = 0.9,
          complete = function(cur_width)
            return cur_width < 3
          end,
        },
        opacity = {
          0,
          frequency = 2,
          complete = function(cur_opacity)
            return cur_opacity <= 4
          end,
        },
        col = { vim.opt.columns:get() },
      }
    end,
  },
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

local function auto_expand_height(msg, level, opts)
  local lines = {}
  local length = 80
  if type(msg) == "string" then
    while #msg > 0 do
      local nextline = string.gsub(msg, "(.-)(.{" .. length .. "})", function(s, t)
        return s .. "\n" .. t
      end)
      msg = nextline:sub(length + 2)
      table.insert(lines, nextline:sub(1, length))
    end
  end

  local max_width = opts.width or vim.o.columns
  local max_height = opts.height or vim.o.lines
  local win_height = #lines + 2
  if win_height > max_height then
    win_height = max_height
  end
  local win_width = 0
  for _, line in ipairs(lines) do
    local len = vim.fn.strdisplaywidth(line)
    if len > win_width and len <= max_width then
      win_width = len
    end
  end
  if win_width == 0 then
    win_width = #msg
  end
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    anchor = "SW",
    width = win_width + 2,
    height = win_height,
    row = 2,
    col = 2,
    style = "minimal",
  })
  vim.api.nvim_win_set_option(win, "wrap", false)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  return notify("", level, opts)
end

vim.notify = auto_expand_height
