-- local dbg = require("debugger")
-- dbg.auto_where = 2

local abort = {'local constant tools.table.abort'}
local function append(...)
  local tables = {...}
  local result = {}
  for _, t in ipairs(tables) do
    for _, e in ipairs(t) do
      table.insert(result, e)
    end
  end
  return result
end

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

local function combine(tbl1, tbl2, fun, context)
  local t = {}
  for i = 1, #tbl1 do
    -- vim.print{i=i, t=t}
    local result = fun(tbl1[i], tbl2[i], context)
    if result == abort then
      return
    end
    table.insert(t, result)
  end
  return t
end

local function flatten(...)
  local tables = {...}
  local result = {}
  for _, atable in ipairs(tables) do
    for _, element in ipairs(atable) do
      table.insert(result, element)
    end
  end
  return result
end

local function get(subject, idx)
  return subject[_adapt_index(subject, idx)]
end

local function join(tbl, with)
  local with = with or ''
  local r = tbl[1] 
  if not r then
    return ''
  end
  for i = 2, #tbl do
    r = r .. with .. tbl[i]
  end
  return r
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
  abort = abort,
  append = append,
  combine = combine,
  flatten = flatten,
  get = get,
  join = join,
  projection = projection,
  replace_slice = replace_slice,
  slice = slice,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
