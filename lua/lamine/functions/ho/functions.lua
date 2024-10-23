-- local dbg = require("debugger")
-- dbg.auto_where = 2

-- local foldl_part = require'lamine.functional'.foldl_part
local function chain_functions(fun, arg)
  return fun(arg)
end

local function concat(...)
  local functions = {...}
  if #functions == 0 then
    error("must not concat empty function list")
  end
  return function(arg)
    local val = functions[1](arg)

    for i = 2, #functions do
      -- print(val)
      val = functions[i](val)
    end
    return val
  end
end


return {
  concat = concat,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
