-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'elixir', line = line, basename='hello_test.exs'} 
end

describe('complete describe...', function()
  it('completes with the block', function()
    local result = fc(context(' describe "..."'))
    assert.are.same({' describe "..." do', '   ', ' end'}, result.lines)
    assert.are.same({1, 999}, result.offset)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
