local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
  vim.notify("luasnip: cannot be found!")
  return
end

local luasnip_loader_status_ok, luasnip_loader = pcall(require, "luasnip.loaders.from_vscode")
if not luasnip_loader_status_ok then
  vim.notify("luasnip.loaders.from_vscode: cannot be found!")
  return
end

luasnip_loader.lazy_load()

local lk_status_ok, lspkind = pcall(require, "lspkind")
if not lk_status_ok then
  vim.notify("lspkind: cannot be found!")
  return
end

lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("cmp: cannot be found!")
  return
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true, -- do not show text alongside icons
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      before = function(entry, vim_item)
        vim_item.menu = "[" .. entry.source.name .. "]"
        return vim_item
      end,
    }),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    -- Copilot Source
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "luasnip", group_index = 2 },
  }, {
    { name = "biffer" },
  }),
})
