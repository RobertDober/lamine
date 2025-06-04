-- local dbg = require("debugger")
-- dbg.auto_where = 2

local A = require'tools.active_support'
local P = require'tools.path'

local append = require'lamine.tools.table'.append
local split = require'lamine.tools.string'.split

local function unshift(tbl, ele)
  table.insert(tbl, 1, ele)
end

local function module(name)
  return A.camelize(string.gsub(name, '%..*$', ''))
end

return function(ctxt)
  local path = P.upto_dir(ctxt.file_path, 'lib', {{'-', '_'}})
  -- vim.print{path = path}
  local dirs = split(path, '[^%/]+')
  -- vim.print{dirs = dirs}

  local prefix={}
  local suffix={}

  local count = 0
  for _, dir in ipairs(dirs) do
    local indent = string.rep('  ', count)
    table.insert(prefix, indent .. 'module ' .. module(dir))
    unshift(suffix, indent .. 'end')
    count = count + 1
  end
  table.insert(prefix, string.rep('  ', count + 1))

  local preamble = {'# frozen_string_literal: true', ''}
  local lines = append( preamble, prefix, suffix),
  vim.print{lines = lines}

  return {
    lines = lines,
    lnb = count + 3, 
  }
end
-- SPDX-License-Identifier: AGPL-3.0-or-later
