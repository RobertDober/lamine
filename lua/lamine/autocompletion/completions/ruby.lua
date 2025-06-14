-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'
local P = require'lamine.autocompletion.patterns'

local continuing_kwds = {
  att = 'attr_reader',
}

local it_block_triggers = {
  each = 'each',
  flat_map = 'flat_map',
  map = 'map',
}

local  requires = {
  req = 'require',
  reqrel = 'require_relative',
}

local starting_keywords = {
  definit = 'def initialize',
  priv = 'private',
  ret = 'return ',
}

-- local function replace_matches_with
local at_beginning_completions = {
  {
    "^(%w+)(%s*)$",
    C.replace_matches{C.match_against_table(requires), " '"}
  },
  -- {
  --   "^(%s+)(%S*)(%s*)$",
  --   C.replace_matches_and_add_lines{
  --   }
        
  -- },
  {
    "(%s+)(.*%.)(%w+)(%s+)([_%w]+)(%s*)",
    C.replace_matches{nil, nil, C.match_against_table(it_block_triggers), ' { ', nil, ' it }'}
  },
  P.word(C.replace_matches{nil, C.match_against_table(starting_keywords), ''}),
  P.word(C.replace_matches{nil, C.match_against_table(continuing_kwds), ' '}),
}

local inline_completions = {
  {
    "^(%s*)(.*)(@@@)",
    C.replace_suffix_and_add_lines{lines={}, suffix="#{}", offset={0, -1}, continue={0, 999}}
  },
  {
    "^(%s*)(.*)(%:%=)",
    C.replace_suffix_and_add_lines{lines={}, suffix="||= ", continue={0, 999}}
  },
  {
    "^(%s*)(.*)(%sOK)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: true, ", offset={0, 999}}
  },
  {
    "^(%s*)(.*)(%sNOK)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: false, ", offset={0, 999}}
  },
  {
    "^(%s*)(%sERR)",
    C.replace_suffix_and_add_lines{lines={}, suffix=" {ok: false, ", offset={0, 999}}
  },
}

local block_kwds = {
  def = 'def',
  case = 'case',
  class = 'class',
  module = 'module',
}

local block_completions = {
  {
    "^(%s*)(%w+)(.*)(%s*)$",
    C.replace_matches_and_add_lines{
      replacers={nil, C.match_against_table(block_kwds), nil, ''},
      lines={"  ", "end"},
      offset={1, 999}
    }
  },
  {
    "^(%s*)(memo%s)(%w+)(%s*)$",
    C.replace_matches_and_add_lines{replacers={nil, 'def ', nil, ''}, lines={C.match_elements("  @__", 3, "__ ||= "), "end" }, offset={1, 999}}, 
  },
  { 
    "^(%s*)(.*)(%{%s*%|.*%|)(%s*)$",
    C.replace_matches_and_add_lines{replacers={
      nil, nil, nil, ''}, lines={"  ", "}"}, offset={1, 999}
    }, 
  },
  { 
    "^(%s*)(.*)(do%s+%|.*%|)(%s*)$",
    C.replace_matches_and_add_lines{replacers={
      nil, nil, nil, ''}, lines={"  ", "end"}, offset={1, 999}
    }, 
  },
  {
    "^(rspec_conf)(%s*)$",
    C.replace_matches_and_add_lines{replacers={'RSpec.configure do |config|', ''}, lines={'  config.include ', 'end'}, offset={1, 999}}
  },
  {
    "^(%s*)(%.)(.*)$",
    C.replace_matches_and_add_lines{replacers={nil, nil, nil}, lines={"."}, offset={1, 999}}, 
  },
}

local default_completions = {
  {
    "^(%s*)(.*)(%s+)do(%s*)$",
    C.replace_matches_and_add_lines{replacers={nil,  nil, ' do', ''}, lines={"  ", "end" }, offset={1, 999}}, 
  }
}

return append(
at_beginning_completions,
inline_completions,
block_completions,
default_completions
)

-- SPDX-License-Identifier: AGPL-3.0-or-later
