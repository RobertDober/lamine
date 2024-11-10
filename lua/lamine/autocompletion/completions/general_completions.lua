-- local dbg = require("debugger")
-- dbg.auto_where = 2
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

-- vim.print(completions)
return completions

-- return {
  --   {
    --     "^(.*)(=>)(%s+)$",
    --     C.replace_matches{nil, '⇒4
    --   },
    --   {
      --     "^(%s*)(local)(%s+)(%w+)(%s*)(%=%s*)$",
      --     C.replace_matches{
        --       nil,   nil,  ' ', nil, '', C.match_elements(" = ", 4, " or ")}
        --     },
        --     {
          --       "^(%s*)(.*)(req)$",
          --       C.replace_suffix_and_add_lines{lines={}, suffix="require'"}
          --     },
          --   }
          -- SPDX-License-Identifier: AGPL-3.0-or-later
