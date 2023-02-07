vim.o.background = "dark"
-- vim.g.tokyonight_style = "storm" -- day / night
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true
local colorscheme = "onedark"
-- tokyonight
-- OceanicNext
-- gruvbox
-- zephyr
-- nord
-- onedark
-- nightfox
-- one

-- color palette
-- black = "#181a1f",
-- bg0 = "#282c34",
-- bg1 = "#31353f",
-- bg2 = "#393f4a",
-- bg3 = "#3b3f4c",
-- bg_d = "#21252b",
-- bg_blue = "#73b8f1",
-- bg_yellow = "#ebd09c",
-- fg = "#abb2bf",
-- purple = "#c678dd",
-- green = "#98c379",
-- orange = "#d19a66",
-- blue = "#61afef",
-- yellow = "#e5c07b",
-- cyan = "#56b6c2",
-- red = "#e86671",
-- grey = "#5c6370",
-- light_grey = "#848b98",
-- dark_cyan = "#2b6f77",
-- dark_red = "#993939",
-- dark_yellow = "#93691d",
-- dark_purple = "#8a3fa0",
-- diff_add = "#31392b",
-- diff_delete = "#382b2c",
-- diff_change = "#1c3448",
-- diff_text = "#2c5372",

local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  return
end

onedark.setup {
  -- Main options --
  style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false, -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- toggle theme style ---
  toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    keywords = 'none',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  -- #bc7cd7
  -- #74adea
  -- #f2d233
  -- #a1c181
  -- #d9d5d0
  -- #ff941a
  colors = {},
  highlights = {
    ["@keyword"] = { fg = '#bc7cd7' },
    ["@keyword.return"] = { fg = '#bc7cd7' },
    ["@keyword.operator"] = { fg = '#bc7cd7' },
    ["@conditional"] = { fg = '#bc7cd7' },
    ["@repeat"] = { fg = '#bc7cd7' },
    ["@type.qualifier"] = { fg = '#bc7cd7' },
    ["@string"] = { fg = '#a1c181', fmt = 'bold' },
    ["@function"] = { fg = '$blue' },
    ["@function.call"] = { fg = '$yellow' },
    ["@function.builtin"] = { fg = '$red' },
    ["@function.micro"] = { fg = '#ff941a' },
    ["@method"] = { fg = '#74adea', fmt = 'bold' },
    ["@method.call"] = { fg = '$yellow' },
    ["@variable"] = { fg = '#d9d5d0' },
    ["@variable.builtin"] = { fg = '$red' },
    ["@string.regex"] = { fg = '$cyan' },
    ["@string.escape"] = { fg = '$cyan' },
    ["@field"] = { fg = '#d9d5d0' },
    ["@property"] = { fg = '$red' },
    ["@punctuation.bracket"] = { fg = '#d9d5d0' },
    ["@type.definition"] = { fg = '$yellow' },
    ["@type.builtin"] = { fg = '$cyan' },
    ["@regex"] = { fg = '$cyan' },
    ["@parameter"] = { fg = '#d9d5d0' },
    ["@operator"] = { fg = '$blue' },
    ["@namespace"] = { fg = '#d9d5d0' },
    ["@constant"] = { fg = '#d9d5d0' },
    ["@constant.builtin"] = { fg = '$red' },
  },

  -- Plugins Config --
  diagnostics = {
    darker = false, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}
onedark.load()

status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " cannot be found!")
  return
end

status_ok, colors = pcall(require, 'nvim-highlight-colors')
if not status_ok then
  return
end

colors.setup {
  render = 'background', -- or 'foreground' or 'first_column'
  enable_named_colors = true,
  enable_tailwind = false
}
colors.turnOn()
