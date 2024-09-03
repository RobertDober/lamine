-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function before(lnb)
  if lnb < 0 then
    return lnb + 1
  else
    return lnb - 1
  end
end

local context = require'lamine.context'
return function(line, match, lnb, replace)
  local ll = context.line_at(lnb)
  if string.match(ll, match) then
    if replace then
      return context.set_lines(lnb, lnb, line)
    end
    return
  end

  return context.set_lines(before(lnb), -1, line)
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
