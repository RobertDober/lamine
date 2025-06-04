-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function split_at(line, col)
  local prefix = string.sub(line, 1, col-1)
  local suffix = string.sub(line, col)
  return prefix, suffix
end

local function split(inputstr, sep, fun)
  local sep = sep or "%S+"
  
    local t = {}
  for str in string.gmatch(inputstr, sep) do
    if fun then
      table.insert(t, fun(str))
    else
      table.insert(t, str)
    end
  end
  return t
end

return {
  split = split,
  split_at = split_at,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
