-- local dbg = require("debugger")
-- dbg.auto_where = 2

local fix = require'fixtures'
local fk = require'fk_implementation'
local fni = require'fn_implementation'

local tt = require'lamine.tools.table'

vim = {
  api ={},
  cmd = nil, -- to be stubbed
  commands = {},
  fed_keys = {},
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

vim.api.nvim_feedkeys = fk.feedkeys
vim.api.nvim_replace_termcodes = fk.replace_termcodes
vim.fn.expand = fni.expand(vim)

local function _adapt_cursor()
  local l, c = table.unpack(vim._buffer.cursor or {1, 0})
  local nl, nc = l, c
  if #vim._buffer.lines < l then
    nl = #vim._buffer.lines
  end
  local line = vim._buffer.lines[nl]
  if #line < nc then
    nc = #line - 1
  end
  vim._buffer.cursor = {nl, nc}
end

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
  if f == -1 then
    vim._buffer.lines = tt.replace_slice(vim._buffer.lines, #vim._buffer.lines + 1, l, data)
  else
    vim._buffer.lines = tt.replace_slice(vim._buffer.lines, f+1, l, data)
  end
  _adapt_cursor()
end

function vim.api.nvim_win_get_cursor(x)
  if x == 0 then
    return vim._buffer.cursor
  end
  error("Only window 0 supported") 
end

function vim.cmd(command_string)
  table.insert(vim.commands, command_string)
end

function vim.keymap.set(typ, keys, fn, options) 
  vim.keymaps[typ][keys] = fn
end

local function buffer_from_lines(lines)
  vim._buffer.lines = {}
  for _, line in ipairs(lines) do
    table.insert(vim._buffer.lines, line)
  end
end

function vim._stub_buffer(from)
  local cursor = from.cursor or {1, 0}
  local ft = from.ft or ""
  local path = from.path or ""
  if from.file then
    vim._buffer.lines = fix.read_fixture_lines(from.file)
  end
  if from.lines then
    if from.file then
      error("Must not stub a buffer from file and lines")
    end
    buffer_from_lines(from.lines)
  end
  vim._buffer.cursor = cursor
  vim.o.ft = ft
  vim.o.filetype = ft
  vim.path = path
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
