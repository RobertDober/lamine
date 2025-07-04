-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'
-- local P = require'lamine.autocompletion.patterns'


local default_completions = {
  {
    "^(%s*)(.*)(%s*)$",
    C.replace_matches_and_add_lines{replacers={nil,  nil, ' {'}, lines={C.indent(1), "}" }, offset={1, 999}}, 
  }
}

return append(
  default_completions
)

-- SPDX-License-Identifier: AGPL-3.0-or-later
