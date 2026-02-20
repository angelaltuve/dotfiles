local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("python", {
  s("pyfile", {
    t { "#!/usr/bin/env python3", "", "" },
    i(0),
  }),
})
