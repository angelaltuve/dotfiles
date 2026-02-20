local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("markdown", {

  s("nota", {
    t { "---", "title: " },
    i(1),
    t { "", "date: " },
    f(function()
      return os.date "%Y-%m-%d"
    end),
    t { "", "tags: " },
    t { "", "---", "", "# " },
    t { "", "# Reference " },
    i(2),
    t { "", "" },
    i(0),
  }),

  s("todo", {
    t "- [ ] ",
    i(1),
  }),

  s("code", {
    t { "```" },
    i(1, "lang"),
    t { "", "" },
    i(2),
    t { "", "```" },
  }),
})
