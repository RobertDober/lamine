-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'

return {
  {
    "^(%s*)(.*)(@@@)",
    C.replace_suffix_and_add_lines{lines={}, suffix="#{}", offset={0, -1}}
  },
  {
    "^(%s*)(%sOK)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: true, ", offset={0, 999}}
  },
  {
    "^(%s*)(%sNOK)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: false, ", offset={0, 999}}
  },
  {
    "^(%s*)(%sERR)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: false, ", offset={0, 999}}
  },
  {"^(%s*)case.*(%s*)$", C.replace_suffix_and_add_lines{lines={"  ", "end"}, offset={1, 999}, suffix=""}},
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
