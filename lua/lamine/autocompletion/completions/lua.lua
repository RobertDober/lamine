-- local dbg = require("debugger")
-- dbg.auto_where = 2
local completers = require'lamine.autocompletion.completers'

return {
  {"^(.*)(req)$", completers.replace_suffix_and_add_lines{lines={}, suffix="require'"}},
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
