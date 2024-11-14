-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'lamine.autocompletion.completers'

local function rep(str, index)
  return function(matches)
    local count = tonumber(matches[index])
    return string.rep(str, count)
  end
end

return {
  {
    "^(pbr)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={'#pagebreak(weak: true)', ''},
      lines = {''},
      offset={1, 1}
    }, 
  },
  {
    "^(inc)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={'#include ""'},
      offset={0, 7}
    }, 
  },
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
  }
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
