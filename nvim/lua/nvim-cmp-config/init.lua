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

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("cmp: cannot be found!")
  return
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
      elseif cmp.visible() then
        cmp.select_next_item()
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
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
  },
})
