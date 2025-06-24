-- local dbg = require("debugger")
-- dbg.auto_where = 2

local A = require'tools.active_support'
local P = require'tools.path'

local append = require'lamine.tools.table'.append
local join = require'lamine.tools.table'.join
local map = require'lamine.functional'.map
local split = require'lamine.tools.string'.split

local function module(name)
  return A.camelize(string.gsub(name, '%..*$', ''))
end

local infix = { 
  '',
  '  @moduledoc ~S"""',
  '  ',
  '  """',
  '  ',
  'end',
}
-- 'defmodule ' .. A.camelize_path(path) .. ' do',
return function(ctxt)
  local path = P.upto_dir(ctxt.file_path, 'lib', {{'-', '_'}})
  -- vim.print{path = path}
  local dirs = split(path, '[^%/]+')
  local modnames = map(dirs, module)
  local name = join(modnames, ".") 

  local prefix={ "defmodule " .. modnames .. " do" }

  local lines = append(prefix, infix),
  -- vim.print{lines = lines}

  return {
    lines = lines,
    lnb = 6, 
  }
end
-
-- SPDX-License-Identifier: AGPL-3.0-or-later
