-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function projection(source, model)
  local t = {}
  for k, _v in pairs(model) do
    t[k] = source[k]
  end
  return t
end

local function  _adapt_index(tbl, idx)
  if idx >= 0 then
    return idx
  end
  local len = #tbl
  return len + idx + 1
end

local function replace_slice(orig, fi, li, new)
  local fi = _adapt_index(orig, fi)
  local li = _adapt_index(orig, li)

  local t = {}
  for i = 1, fi - 1 do
    table.insert(t, orig[i])
  end

  for _, value in ipairs(new) do
    table.insert(t, value)
  end

  for i = li + 1, #orig do
    table.insert(t, orig[i])
  end
  return t
end

local function slice(tbl, fi, li)
  if fi < 0 then
    local size = #tbl
    return slice(tbl, size + fi + 1, size + li + 1)
  end
  local t = {}
  for i = fi, li do
    table.insert(t, tbl[i])
  end
  return t
end

return {
  projection = projection,
  replace_slice = replace_slice,
  slice = slice,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
