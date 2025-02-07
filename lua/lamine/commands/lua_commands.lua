-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = require'lamine.api'
local flatten = require'lamine.tools.table'.flatten
local function _sort(lines, pattern)
  local chunks = {}
  local current_chunk = {}
  for _, line in ipairs(lines) do
    if string.match(line, pattern) then
      table.insert(chunks, current_chunk)
      current_chunk = {line}
    else
      table.insert(current_chunk, line)
    end
  end
  table.insert(chunks, current_chunk)
  table.sort(chunks, function(l,r)
    if l[1] and r[1] then
      return l[1] < r[1]
    end
    return false
  end)
  return flatten(unpack(chunks))
end

local function sort(args)
  local pattern = args.fargs[1]
  api.replace_lines(args.line1, args.line2, _sort, pattern)
end

vim.api.nvim_create_user_command('Sort', sort, {nargs='*', range=true})
-- SPDX-License-Identifier: AGPL-3.0-or-later
