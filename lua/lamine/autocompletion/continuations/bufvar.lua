-- local dbg = require("debugger")
-- dbg.auto_where = 2

local B = require'lamine.tools.bufvars'
local bufvar_name = 'autocontinuations'

local function add_continuation(continuation)
  B.init_bufvar(bufvar_name, {})
  B.update_bufvar(bufvar_name, function(old)
    table.insert(old, continuation)
    return old
  end)
end

local function get_bufvar()
  return B.get_bufvar(bufvar_name)
end

local function is_empty(value)
  if type(value) == 'table' and #value > 0 then
    return false
  end
  return true
end

local function remove_continuation()
  local value = get_bufvar()
  if is_empty(value) then
    vim.print('ERROR: no continuation defined')
    return nil
  end

  local continuation = table.remove(value)
  B.update_bufvar(bufvar_name, function(_) return value end)
  return continuation
end

return {
  add_continuation = add_continuation,
  remove_continuation = remove_continuation,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
