-- local dbg = require("debugger")
-- dbg.auto_where = 2
-- $
local A = require'lamine.autocompletion'

describe('replacing a @@@', function()
  -- for demonstration, comment me
  vim._stub_buffer{lines={'  "@@@'}, ft='ruby', path='xxx.rb', cursor={1, 6}}
  A.autocomplete()
  assert.is.equal('  "#{}', vim.api.nvim_get_current_line())
  assert.are.same({1, 5}, vim._buffer.cursor)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
