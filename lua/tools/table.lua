-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function projection(source, model)
  local t = {}
  for k, _v in pairs(model) do
    t[k] = source[k]
  end
  return t
end

local function slice(tbl, fi, li)
  local t = {}
  for i = fi, li do
    table.insert(t, tbl[i])
  end
  return t
end

return {
  projection = projection,
  slice = slice,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
