-- local dbg = require("debugger")
-- dbg.auto_where = 2
local append = require'lamine.tools.table'.append
local map = require'lamine.functional'.map
local C = require'lamine.autocompletion.completers'
local P = require'lamine.autocompletion.patterns'

local function rep(str, index)
  return function(matches)
    local count = tonumber(matches[index])
    return string.rep(str, count)
  end
end

local defined_instructions = {
  set = '#set',
}

local instructions = {
  {
    '^(%w+)(%s*)$',
    C.replace_matches{C.match_against_table(defined_instructions), ''}
  },
}
local one_liners = {
  br = '#linebreak()',
  inc = '#include "',
  pbr = '#pagebreak(weak: true)',
}

local with_continuation = {
  strike = {'#strike("")', -2}, 
}
local fcalls = {
  sub = 'sub',
}

local completions = {
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
  {
    "^(%s*)(%s*)$",
    C.replace_matches{nil, "#"}
  },
}

local completes_with_cont = {
 { "strike", '#strike("")', -2 },
 { "unicode", '\\u{}', -1},
}
local function make_completion_with_cont(word)
  local match = word[1]
  local replacement = word[2]
  local offset = word[3]
  return {
    "^(.*)(" .. match .. ")(%s*)$",
    C.replace_matches({nil, replacement, ''}, {offset={offset}, continue={0,999}}, false) 
  }
end

local continuations = map(completes_with_cont, make_completion_with_cont)
return append(
instructions,
continuations,
completions
)
-- SPDX-License-Identifier: AGPL-3.0-or-later
