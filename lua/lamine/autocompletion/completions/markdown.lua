-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'

return {
  {
    "^(fn)(%d+)(.*)$",
    C.replace_matches{"[^", C.match_elements(2, "]:") , nil},
  },
  {
    "^(.*)(fn)(%d+)(.*)$",
    C.replace_matches{nil, "[^", C.match_elements(3, "]") , nil},
  },
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
