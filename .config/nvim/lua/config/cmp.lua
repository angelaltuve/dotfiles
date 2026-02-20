local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"

return {
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
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
  },
  sources = cmp.config.sources {
    { name = "async_path" },
    { name = "nvim_lua" },
    { name = "nvim_lsp", keyword_length = 1 },
    { name = "luasnip", keyword_length = 2 },
    { name = "buffer", keyword_length = 3 },
    { name = "spell", keyword_length = 3 },
    { name = "lazydev", group_index = 0 },
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
}
