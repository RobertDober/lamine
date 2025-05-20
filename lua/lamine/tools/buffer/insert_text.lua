-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = require'lamine.api'
local split_at = require'lamine.tools.string'.split_at

local function _insert_around(lnb, fcol, scol, ftxt, stxt)
  local line = api.get_lines(lnb, lnb)[1]
  local prefix, infix = split_at(line, fcol+1) 
  local infix, suffix = split_at(infix, scol-fcol+2)  
  line = prefix .. ftxt .. infix .. stxt .. suffix
  api.set_lines(lnb, lnb, {line})
end

local function _insert_at(lnb, col, offset, text)
  local line = api.get_lines(lnb, lnb)[1]
  local prefix, suffix = split_at(line, col+offset) 
  line = prefix .. text .. suffix
  api.set_lines(lnb, lnb, {line})
end

local function insert_after(mark, text)
  local lnb, col = unpack(vim.api.nvim_buf_get_mark(0, mark))
  _insert_at(lnb, col, 2, text)
end

local function insert_before(mark, text)
  local lnb, col = unpack(vim.api.nvim_buf_get_mark(0, mark))
  _insert_at(lnb, col, 1, text)
end

local function insert_around(fstmk, fsttxt, sndmk, sndtxt)
  local flnb, fcol = unpack(vim.api.nvim_buf_get_mark(0, fstmk))
  local slnb, scol = unpack(vim.api.nvim_buf_get_mark(0, sndmk))
  if flnb == slnb then
    _insert_around(flnb, fcol, scol, fsttxt, sndtxt)
  else
    _insert_at(flnb, fcol, 1, fsttxt)
    _insert_at(slnb, scol, 2, sndtxt)
  end
end

return {
  insert_after = insert_after,
  insert_around = insert_around,
  insert_before = insert_before,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
