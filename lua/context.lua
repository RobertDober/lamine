-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function current_line()
  return vim.api.nvim_get_current_line()
end

local function abspath()
  return vim.fn.expand("%:p")
end

local function basename()
  return vim.fn.expand("%:t")
end

local function cursor()
  return vim.api.nvim_win_get_cursor(0)
end

local function cursor()
  return vim.api.nvim_win_get_cursor(0)
end

local function col()
  return cursor()[2]
end

local function current_char()
  return string.sub(current_line(), col()+1, col()+1)
end


local function current_lnb()
  return cursor()[1]
end


local function dirname()
  return vim.fn.expand("%:p:h")
end

local function filetype()
  return vim.o.filetype
end

local function lines(f, l)
  local result = vim.api.nvim_buf_get_lines(0, f - 1, l, false)
  return result
end

local function line_at(lnb)
  return lines(lnb, lnb+1)[1]
end

local function next_lines(offset)
  local offset = offset or 1
  return lines(current_lnb()+offset, current_lnb()+offset)[1]
end

local function post_line()
  return line_at(current_lnb() + 1)
end

local function pre_line()
  return line_at(current_lnb() - 1)
end

local function prefix()
  return string.sub(current_line(), 1, col())
end

local function relpath()
  return vim.fn.expand("%")
end

local function set_lines(f, l, data)
  return vim.api.nvim_buf_set_lines(0, f - 1, l, false, data)
end

local function set_current_line(data, lnb)
  local lnb = lnb or current_lnb()
  local data = data or {""}
  if type(data) == "string" then
    data = {data}
  end
  return set_lines(lnb, lnb, data)
end

local function suffix()
  return string.sub(current_line(), col()+2)
end

local function current_context()
  local ctxt = {
    abspath = abspath(),
    basename = basename(),
    char = current_char(),
    col = col(),
    cursor = cursor(),
    dirname = dirname(),
    file_path = vim.fn.expand("%"),
    filetype = filetype(),
    line = current_line(),
    lnb = current_lnb(),
    post_line = post_line(),
    pre_line = pre_line(),
    prefix = prefix(),
    relpath = relpath(),
    suffix = suffix(),
  }
  return ctxt
end

return {
  basename = basename,
  col = col,
  current_char = current_char,
  current_context = current_context,
  current_line = current_line,
  current_lnb = current_lnb,
  dirname = dirname,
  filetype = filetype,
  line_at = line_at,
  lines = lines,
  next_lines = next_lines,
  post_line = post_line,
  pre_line = pre_line,
  prefix = prefix,
  relpath = relpath,
  set_current_line = set_current_line,
  set_lines = set_lines,
  suffix = suffix,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
