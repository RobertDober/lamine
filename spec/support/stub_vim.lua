-- -- local dbg = require("debugger")
-- -- dbg.auto_where = 2

local fix = require'fixtures'

vim = {
  api ={
  },
  _buffer = {
  },
  g = {
  },
  print = print,
}

function vim.api.nvim_get_current_line()
  return vim._buffer.lines[vim._buffer.cursor[1]]
end

function vim.api.nvim_win_get_cursor(x)
  if x == 0 then
    return vim._buffer.cursor
  end
  error("Only window 0 supported") 
end

function vim._stub_buffer(from)
  local cursor = from.cursor or {1, 0}
  if from.file then
    vim._buffer.lines = fix.read_fixture_lines(from.file)
  end
  vim._buffer.cursor = cursor
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
