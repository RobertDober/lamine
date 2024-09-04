-- local dbg = require("debugger")
-- dbg.auto_where = 2

local predefined = {
  id = function(...) return unpack({...}) end,
  minus = function(a, b) return a - b end,
}

local function get_predefined(name)
  local found = predefined[name]
  if found then
    return found
  end
  error("no such predefined function: '" .. name .. "'")
end

local function assure_function(object)
  if type(object) == 'function' then
    return object
  end
  if type(object) == 'string' then
    return get_predefined(object) 
  end
end

local function reverse2(fun)
  local fun = assure_function(fun)
  return function(a,b) return fun(b, a) end
end

return {
  assure_function = assure_function,
  get_predefined = get_predefined,
  predefined = predefined,
  reverse2 = reverse2,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
