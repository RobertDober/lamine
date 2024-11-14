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
    "^(%s*)(hl)(%d)(%s*)$",
    C.replace_matches{nil, '', rep('#', 3), ' '}
  },
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
