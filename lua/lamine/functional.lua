-- local dbg = require("debugger")
-- dbg.auto_where = 2

local F = require'lamine.functions'
local function _foldl(subject, start, stop, init, fun)
  local acc = init
  for index = start, stop do
    acc = fun(subject[index], acc)
  end
  return acc
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
  return _foldl(subject, start, stop, init, fun)
end

return {
  foldl = foldl,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
