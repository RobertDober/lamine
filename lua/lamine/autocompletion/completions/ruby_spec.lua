-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'

local starting_keywords = {
  xp = 'expect(',
  xpt = 'expect { ',
}
  
-- local function replace_matches_with
local at_beginning_completions = {
  {
    "^(%s*)(%w+)(%s*)$",
    C.replace_matches{nil, C.match_against_table(starting_keywords), ''}
  },
  {
    "^(%s*)(let%(%:)(%S+)(%s*)",
    C.replace_matches({nil, nil, nil, "{  }"}, {offset = {0, -2}, continue = {0, 999}, set_cursor = true})
  },
}

local inline_completions = {
  {
    "^(.*)(%)toq)(%s*)$",
    C.replace_matches{nil, ').to eq(', ''}
  },
}
--   {
--     "^(%s*)(.*)(@@@)",
--     C.replace_suffix_and_add_lines{lines={}, suffix="#{}", offset={0, -1}, continue={0, 999}}
--   },
--   {
--     "^(%s*)(%sOK)",
--     C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: true, ", offset={0, 999}}
--   },
--   {
--     "^(%s*)(%sNOK)",
--     C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: false, ", offset={0, 999}}
--   },
--   {
--     "^(%s*)(%sERR)",
--     C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: false, ", offset={0, 999}}
--   },
-- }

local rspec_keywords = {
  context = 'context',
  describe = 'describe',
  it = 'it',
  desc = 'desribe',
}
local block_completions = {
  {
    "^(%s*)(expect%s*)(%{)(.*)(%s*%}*%s*)$",
    C.replace_matches_and_add_lines{
      replacers = {nil, nil, nil, nil, ' }'},
      lines = { ".to" },
      offset={1, 999}}
  },
  {
    "^(%s*)(%w+)(.*)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, C.match_against_table(rspec_keywords), nil, ' do'}, 
      lines={"  ", "end"},
      offset={1, 999}
    }, 
  },
}

return append(
  at_beginning_completions,
  inline_completions,
  block_completions
)
  
-- SPDX-License-Identifier: AGPL-3.0-or-later
