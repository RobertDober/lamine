-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'
  
local block_kwds = {
  describe = "describe",
  test = "test",
}

local block_completions = {
  {
    "(%s*)(%w+)(.*)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, C.match_against_table(block_kwds), nil, ' do'},
      lines={"  ", "end"},
      offset={1, 999}
    }
  }
}

local oneline_words = {
  desc = 'describe "',
  test = 'test "',
}

local oneline_completions = {
  {
    "^(%s*)(%w+)(%s*)$",
    C.replace_matches{nil, C.match_against_table(oneline_words), ''}
  },
}

return append(oneline_completions, block_completions)
  
-- SPDX-License-Identifier: AGPL-3.0-or-later
