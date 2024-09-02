-- local dbg = require("debugger")
-- dbg.auto_where = 2

require'stub_os'
local fix = require'fixtures'
local fni = require'fn_implementation'
local tt = require'lamine.tools.table'

vim = {
  api ={},
  fn = {},
  g = {},
  keymap = {},
  keymaps = {
    _all={},
    c={},
    i={},
    n={},
    v={},
   },
  o = {
    ft = "",
    filetype = "",
  },
  print = print,
  _buffer = {
    lines = {},
  },
}

vim.fn.expand = fni.expand(vim)

function vim.api.nvim_get_current_line()
  return vim._buffer.lines[vim._buffer.cursor[1]]
end

function vim.api.nvim_buf_get_lines(bnr, fl, ll, flag)
  if bnr ~= 0 then
    error("Only bnr 0 allowed, not " .. bnr)
  end
  if flag ~= false then
    error("Only flag false allowed, not " .. flag)
  end
  return tt.slice(vim._buffer.lines, fl + 1, ll + 1)
end

function vim.api.nvim_buf_set_lines(bnr, f, l, flag, data)
  if bnr ~= 0 then
    error("Only bnr 0 allowed, not " .. bnr)
  end
  if flag ~= false then
    error("Only flag false allowed, not " .. flag)
  end
  vim._buffer.lines = tt.replace_slice(vim._buffer.lines, f+1, l, data)
end

function vim.api.nvim_win_get_cursor(x)
  if x == 0 then
    return vim._buffer.cursor
  end
  error("Only window 0 supported") 
end
 
function vim.keymap.set(typ, keys, fn, options) 
  vim.keymaps[typ][keys] = fn
end

function vim._stub_buffer(from)
  local cursor = from.cursor or {1, 0}
  local ft = from.ft or ""
  local path = from.path or ""
  if from.file then
    vim._buffer.lines = fix.read_fixture_lines(from.file)
  end
  vim._buffer.cursor = cursor
  vim.o.ft = ft
  vim.o.filetype = ft
  vim.path = path
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
