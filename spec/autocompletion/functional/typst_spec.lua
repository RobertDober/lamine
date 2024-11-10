-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'typst', line = line, basename='hello.typ'} 
end

describe('the footnote', function()
  it('creates a footnote block', function()
      local result = fc(context('  Best Practicefn'))
      local expected = {
        '  Best Practice#footnote[]',
      }
      assert.are.same(expected, result.lines)
      assert.are.same({0, 8}, result.offset)
  end)
  
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
