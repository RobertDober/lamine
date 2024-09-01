-- local dbg = require("debugger")
-- dbg.auto_where = 2


local _cwd = require'cwd'()

local function _basename(path)
  local path = string.gsub(path, "%/$", "")
  return string.gsub(path, ".*%/", "") 
end

local function _dirname(path)
  return string.gsub(path, "%/[^/]+$", "") 
end

local function _expand(vim, expr)
  if expr == "%" then
    return vim.path
  end
  if expr == "%:p" then
    return _cwd .. "/" .. vim.path
  end
  if expr == "%:p:h" then
    return _dirname(_cwd .. "/" .. vim.path)
  end
  if expr == "%:h" then
    return _dirname(vim.path)
  end
  if expr == "%:t" then
    return _basename(vim.path)
  end
  error(expr .. " not supported in this vim.fn.expand emulation")
end

local function expand(vim)
  return function(expression)
    return _expand(vim, expression)
  end

end

return {
  expand = expand,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
