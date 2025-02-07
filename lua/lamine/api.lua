-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function abspath()
  return vim.fn.expand("%:p")
end

local function basename()
  return vim.fn.expand("%:t")
end

local function cursor()
  return vim.api.nvim_win_get_cursor(0)
end

local function dirname()
  return vim.fn.expand("%:p:h")
end

local function filetype()
  return vim.o.filetype
end

local function set_cursor(row, col)
  if type(row) == "table" then
    return vim.api.nvim_win_set_cursor(0, row)
  end
  vim.api.nvim_win_set_cursor(0, {row, col})
end

local function lines(f, l)
  return vim.api.nvim_buf_get_lines(0, f - 1, l, false)
end
local get_lines = lines

local function relpath()
  return vim.fn.expand("%")
end

local function set_lines(f, l, data)
  local data = data
  if type(data) == "string" then
    data = { data }
  end
  return vim.api.nvim_buf_set_lines(0, f - 1, l, false, data)
end

local function set_lines_after(data, f)
  local data = data
  local f = f or cursor()[1] + 1
  if type(data) == "string" then
    data = { data }
  end
  local l = f + #data - 1
  return vim.api.nvim_buf_set_lines(0, f-1, l-1, false, data)
end

local function replace_lines(f, l, fun, ...)
  local additional_args = {...}
  local result = fun(get_lines(f, l), unpack(additional_args))
  return set_lines(f, l, result)
end

return {
  abspath = abspath,
  basename = basename,
  cursor = cursor,
  dirname = dirname,
  filetype = filetype,
  get_lines = get_lines,
  lines = lines,
  relpath = relpath,
  replace_lines = replace_lines,
  set_cursor = set_cursor,
  set_lines = set_lines,
  set_lines_after = set_lines_after,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
