-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'


return {
  {
    "^(.*)(fn)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, '#footnote[]', ''},
      offset={0, 8}
    }, 
  },
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
