-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = require'lamine.api'

local function current_line()
  return vim.api.nvim_get_current_line()
end

local function col()
  return api.cursor()[2]
end

local function current_char()
  return string.sub(current_line(), col()+1, col()+1)
end

local function current_lnb()
  return api.cursor()[1]
end

local function indent(n)
  local n = n or 1
  local w = vim.o.shiftwidth
  return string.rep(" ", n * w)
end

local function line_at(lnb)
  if lnb > 0 then
    return api.get_lines(lnb, lnb+1)[1]
  end
  return api.get_lines(lnb, lnb)[1]
end

local function next_lines(offset)
  local offset = offset or 1
  return api.get_lines(current_lnb()+offset, current_lnb()+offset)[1]
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

local function relative_line_offset(c)
  if c > 0 then
    return {0, c}
  end
  return {current_lnb(), c + #current_line()}
end

local function relative_offset(offset)
  local row = offset[1]
  local c = offset[2]
  if c then
    if row == 0 then
      -- vim.print{current_col=col(), col_offset=c}
      return {current_lnb(), col() + c}
    end
    return {current_lnb() + row, c}
  end
  -- vim.print{row = row}
  return relative_line_offset(row)
end


local function set_current_line(data, lnb)
  local lnb = lnb or current_lnb()
  local data = data or {""}
  if type(data) == "string" then
    data = {data}
  end
  return api.set_lines(lnb, lnb, data)
end

local function suffix()
  return string.sub(current_line(), col()+2)
end

local context_functions = {
  col = col,
  current_char = current_char,
  current_line = current_line,
  current_lnb = current_lnb,
  indent = indent,
  line_at = line_at,
  next_lines = next_lines,
  post_line = post_line,
  pre_line = pre_line,
  prefix = prefix,
  relative_offset = relative_offset,
  set_current_line = set_current_line,
  suffix = suffix,
}

local function current_context()
  local ctxt = {
    abspath = api.abspath(),
    basename = api.basename(),
    char = current_char(),
    col = col(),
    cursor = api.cursor(),
    dirname = api.dirname(),
    file_path = vim.fn.expand("%"),
    filetype = api.filetype(),
    line = current_line(),
    lnb = current_lnb(),
    post_line = post_line(),
    pre_line = pre_line(),
    prefix = prefix(),
    relpath = api.relpath(),
    subtype = api.filetype() .. string.gsub(string.gsub(api.basename(), "%.[^.]*$", ""), '^.*%_', '_'),
    suffix = suffix(),
  }
  ctxt.fn = context_functions
  return ctxt
end

context_functions.current_context = current_context
context_functions.api = api
return context_functions
-- SPDX-License-Identifier: AGPL-3.0-or-later
