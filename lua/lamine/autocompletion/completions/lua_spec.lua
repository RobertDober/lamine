-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'
local map = require'lamine.functional'.map

local shorts = {
  {'after', 'after_each'},
  {'before', 'before_each'},
  {'setup', 'setup'},
  {'teardown', 'teardown'},
}

local completions = map(shorts, function(shrt)
  return {
    "^(%s*)(" .. shrt[1] .. ")(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, shrt[2] .. '(function()'}, lines={"  ", "end)"}, offset={1, 999}}, 
  }
end)

table.insert(completions,
{
  "^(%s*)(desc)(%s*)$", C.replace_matches{nil, "describe('", ""}
})
-- vim.print(completions)
return completions
-- SPDX-License-Identifier: AGPL-3.0-or-later
