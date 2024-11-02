-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'

return {
  {
    "^(%s*)(.*)(@@@)",
    C.replace_suffix_and_add_lines{lines={}, suffix="#{}", offset={0, -1}}
  },
  {"^(%s*)case.*(%s*)$", C.replace_suffix_and_add_lines{lines={}, suffix=""}},
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
