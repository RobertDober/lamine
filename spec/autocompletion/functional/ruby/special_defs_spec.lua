-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'ruby', line = line, basename='hello.rb'} 
end

describe('definit', function()
  it('expands to def initialize', function()
    local result = fc(context('  definit'))
    assert.are.same({"  def initialize"}, result.lines)
    assert.is_nil(result.offset)
  end)
  it('ignores trailing whitespace', function()
    local result = fc(context('  definit '))
    assert.are.same({"  def initialize"}, result.lines)
    assert.is_nil(result.offset)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
