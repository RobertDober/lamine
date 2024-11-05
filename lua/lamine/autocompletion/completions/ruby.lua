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
  {"^(%s*)def.*(%s*)$", C.replace_suffix_and_add_lines{lines={"  ", "end"}, offset={1, 999}, suffix=""}},
  {"^(%s*)case.*(%s*)$", C.replace_suffix_and_add_lines{lines={"  ", "end"}, offset={1, 999}, suffix=""}},
  {
    "^(%s*)(memo%s)(%w+)(%s*)$",
    C.replace_matches_and_add_lines{replacers={nil, 'def ', nil, ''}, lines={C.match_elements("  @__", 3, "__ ||= "), "end" }, offset={1, 999}}, 
  },
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
