-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'markdown', line = line} 
end

describe('completions found for markdown', function()
  it('does not find anything if there is no match', function()
    assert.is_nil(fc(context('epiufhezf gzgjrzoi')))
  end)

  it('finds a footnote at the beginning of the line', function()
    local result = fc(context('fn0'))
    assert.are.same({'[^0]:'}, result.lines)
    assert.is_nil(result.offset)
  end)

  it('finds a footnote with big numbers at the beginning of the line', function()
    local result = fc(context('fn42'))
    assert.are.same({'[^42]:'}, result.lines)
    assert.is_nil(result.offset)
  end)

  it('finds a footnote in the middle of the line', function()
    local result = fc(context('hello fn1'))
    assert.are.same({'hello [^1]'}, result.lines)
    assert.is_nil(result.offset)
  end)

  it('finds a footnote with big numbers in the middle of the line', function()
    local result = fc(context(' hello fn73'))
    assert.are.same({' hello [^73]'}, result.lines)
    assert.is_nil(result.offset)
  end)
  
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
