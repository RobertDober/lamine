-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = require'lamine.api'
local split_at = require'lamine.tools.string'.split_at

local function insert_after(mark, text)
  local lnb, col = unpack(vim.api.nvim_buf_get_mark(0, mark))
  local line = api.get_lines(lnb, lnb)[1]
  local prefix, suffix = split_at(line, col) 
  vim.print(prefix)
  vim.print(suffix)
end

local function insert_before(mark, text)
  
end

X = {
  insert_after = insert_after,
  insert_before = insert_before,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
