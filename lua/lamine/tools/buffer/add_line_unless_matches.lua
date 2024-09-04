-- local dbg = require("debugger")
-- dbg.auto_where = 2

local context = require'lamine.context'
return function(line, match, lnb, replace)
  local ll = context.line_at(lnb)
  if string.match(ll, match) then
    if replace then
      return context.set_lines(lnb, lnb, line)
    end
    return
  end

  return context.set_lines(lnb, -1, line)
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
