-- Load all snippets provided by `friendly-snippets`.
require('luasnip.loaders.from_vscode').lazy_load()

local ls = require("luasnip")
local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.add_snippets("markdown", {
  s("t", fmt("- [{}] {}", { c(2, { t " ", t "-", t "x" }), i(1, "task") })),
})
