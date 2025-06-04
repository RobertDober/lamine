-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'
local map = require'lamine.functional'.map

local function rep(str, index)
  return function(matches)
    local count = tonumber(matches[index])
    return string.rep(str, count)
  end
end

local multilines = {
  {
    "^(code)(.*)",
    C.replace_matches_and_add_lines{
      replacers={'```', nil},
      lines={"  ", "```"},
      offset={1, 999}
    }
  },
}

local assertions = {
  {'ain', 'assert.is_nil('},
  {'aas', 'assert.are.same('},
  {'aie', 'assert.is_equal('},
}

local assertion_completions = map(assertions, function(assertion)
  return  {
      "^(.*)(" .. assertion[1] .. ")(%s*)$",
      C.replace_matches{nil, assertion[2], ''}
  }
end)
local onelines = {
  -- {
  --   "^(%s*)(code)(%w*)(%s*)",
  --   C.replace_matches{nil, "```", nil, ''}
  -- },
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
  {
    "^(%S+)(%%%s*)$",
    C.replace_matches{C.match_elements("`", 1, "`"), ''},
  },
  {
    "^(.*)(%s)(%S+)(%%%s*)$",
    C.replace_matches{nil, nil, C.match_elements("`", 3, "`"), ''},
  },
}


return append(
  onelines,
  -- inlines,
  multilines,
  assertion_completions 
)
-- SPDX-License-Identifier: AGPL-3.0-or-later
