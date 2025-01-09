-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'

local function rep(str, index)
  return function(matches)
    local count = tonumber(matches[index])
    return string.rep(str, count)
  end
end

local onelines = {
  {
    "^(%s*)code(%w*)(%s*)",
    C.replace_matches{nil, "```", nil, ''}
  },
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


return append(
  onelines
  -- inlines
)
-- SPDX-License-Identifier: AGPL-3.0-or-later
