-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function get_bufvar(name)
  return vim.b[name]
end

local function init_bufvar(name, value)
  if vim.b[name] then
    return 
  end

  vim.b[name] = value
end

local function set_bufvar(name, value)
  vim.b[name] = value
end

local function update_bufvar(name, fun)
  local value = get_bufvar(name)
  value = fun(value)
  set_bufvar(name, value)
end

return {
  get_bufvar = get_bufvar,
  init_bufvar = init_bufvar,
  set_bufvar = set_bufvar,
  update_bufvar = update_bufvar,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
