-- local dbg = require("debugger")
-- dbg.auto_where = 2
local append = require'lamine.tools.table'.append
local abort = require'lamine.tools.table'.abort
local C = require'lamine.autocompletion.completers'
local map = require'lamine.functional'.map
local predefined_functions = require'lamine.autocompletion.completions.predefined_functions'
local S = require'lamine.functions.ho.strings'

local arrows = {
  {'%-%>', '→'},
  {'%=%>', '⇒'},
  {'%<%-', '←'},
  {'%<%=', '⇐'},
}

local completions = map(arrows, function(arrow)
  local pattern = "^(.*)(" .. arrow[1] .. ")(%s*)$"
  local replacement = C.replace_matches{nil, arrow[2], ''}
  return {pattern, replacement}
end)

local fold_completion
for i = 3, 5 do
  fold_completion = {
    "^(.*)(%s+)(ofld)(" .. tostring(i) .. ")(%s*)$",
    C.replace_matches{nil, nil, string.rep("{", i), '', ''}
  }
  table.insert(completions, fold_completion)
  fold_completion = {
    "^(.*)(%s+)(cfld)(" .. tostring(i) .. ")(%s*)$",
    C.replace_matches{nil, nil, string.rep("}", i), '', ''}
  }
  table.insert(completions, fold_completion)
end

local predefined_function_completions = {
  {
    "^(.*)(%%)([_%w]+)(%s*)$",
    C.replace_matches{nil, '',  C.get_function(predefined_functions, 3, abort), ''} 
  },
  {
    "^(.*%s)([%S]+)(%%code)(%s*)$",
    C.replace_matches{nil, S.surround_with("`", "`", 2), '', ''}
  },
  {
    "^([%S]+)(%%code)(%s*)$",
    C.replace_matches{S.surround_with("`", "`", 1), '', ''}
  },
  {
    "^(.*%s)([_%w]+)(%%idx)(%s*)$",
    C.replace_matches({nil, nil, '[]', ''}, {offset={0, -1}, continue={0, 999}})
  },
  {
    "^([_%w]+)(%%idx)(%s*)$",
    C.replace_matches({nil, '[]', ''}, {offset={0, -1}, continue={0, 999}})
  },
}
-- vim.print(completions)

return append(
completions,
predefined_function_completions
)
-- SPDX-License-Identifier: AGPL-3.0-or-later
