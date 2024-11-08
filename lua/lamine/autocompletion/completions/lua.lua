-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'

return {
  {
    "^(%s*)(local)(%s+)(require[\"'].*[\"']%.)(.*)$",
    C.replace_matches{nil, nil, C.match_elements(" ", 5, " = ")}
  },
  {
    "^(%s*)(local)(%s+)(%w+)(%s*)(%=%s*)$",
    C.replace_matches{
      nil,   nil,  ' ', nil, '', C.match_elements(" = ", 4, " or ")}
  },
  {
    "^(%s*)(.*)(req)$",
    C.replace_suffix_and_add_lines{lines={}, suffix="require'"}
  },
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
