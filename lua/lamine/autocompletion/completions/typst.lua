-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'
local P = require'lamine.autocompletion.patterns'

local function rep(str, index)
  return function(matches)
    local count = tonumber(matches[index])
    return string.rep(str, count)
  end
end

local one_liners = {
  inc = '#include "',
  pbr = '#pagebreak(weak: true)',
  br = '#linebreak()',
}

  local fcalls = {
    sub = 'sub',
  }

return {
  P.word(
  C.replace_matches_and_add_lines{
    replacers={'', C.match_against_table(one_liners), ''},
    lines = {''},
    offset={1, 1},
    indent= false,
  }
  ),
  {
    "^(.*)(fn)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, '#footnote[]', ''},
      offset={0, 8}
    }, 
  },
  {
    "^(hl)(%d)(%s*)$",
    C.replace_matches{'', rep('=', 2), ' '}
  },
  { 
    "^(.*)(sub)(.*)$",
    C.replace_matches{nil, "#sub(", ""}
  },
  { 
    "^(.*)(sup)(.*)$",
    C.replace_matches{nil, "#super(", ""}
  },

}
-- SPDX-License-Identifier: AGPL-3.0-or-later
