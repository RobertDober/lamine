-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'ruby', line = line} 
end

describe('completions found for ruby', function()
  it('does not find anything if there is no match', function()
    assert.is_nil(fc(context('epiufhezf gzgjrzoi')))
  end)
  it('replaces @@@ with the correct #{}', function()
    local result = fc(context('some string "is@@@'))
    assert.are.same({'some string "is#{}'}, result.lines)
    assert.are.same({0, -1}, result.offset)
  end)
  
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
