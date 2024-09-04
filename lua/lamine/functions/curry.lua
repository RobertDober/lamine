-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ph = function() end
local _ = ph

local function combine(t1, t2)
  local t = { }
  for _, i in ipairs(t1) do
    if i == ph then
      local from = table.remove(t2, 1)
      table.insert(t, from)
    else
      table.insert(t, i)
    end
  end
  for _, i in ipairs(t2) do
    table.insert(t, i)
  end
  return t
end

local function curry(fun, ...)
  local predefined = {...}
  return function(...)
    local current = {...}
    local all = combine(predefined, current)
    return fun(table.unpack(all))
  end
end

return {
  curry = curry,
  _ = _,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
