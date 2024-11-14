-- local dbg = require("debugger")
-- dbg.auto_where = 2
local append = require'lamine.tools.table'.append
local C = require'lamine.autocompletion.completers'
local map = require'lamine.functional'.map

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

-- vim.print(completions)
return completions

-- SPDX-License-Identifier: AGPL-3.0-or-later
