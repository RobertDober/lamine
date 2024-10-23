-- local dbg = require("debugger")
-- dbg.auto_where = 2

local F = require'lamine.functions'
local function foldl_part(subject, init, fun, start, stop)
  local acc = init
  local start = start or 1
  local stop = stop or #subject
  for index = start, stop do
    acc = fun(subject[index], acc)
  end
  return acc
end

local function find(subject, finder)
  for _, candidate in ipairs(subject) do
    if finder(candidate) then
      return candidate
    end
  end
end

local function find_value(subject, finder)
  for _, candidate in ipairs(subject) do
    local value = finder(candidate)
    if value then
      return value, candidate
    end
  end
end

local function foldl(subject, init_or_fun, fun)
  local init = init_or_fun
  local fun = fun
  local start = 1
  local stop = #subject
  if not fun then
    fun = init_or_fun
    init = subject[1]
    start = 2
  end
  fun = F.assure_function(fun)
  return foldl_part(subject, init, fun, start)
end

local function map(subject, fun)
  return foldl(subject, {}, function(ele, result)
    table.insert(result, F.assure_function(fun)(ele))
    return result
  end)
end

return {
  find = find,
  find_value = find_value,
  foldl = foldl,
  fold_vargs = fold_vargs,
  foldl_part = foldl_part,
  map = map,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
