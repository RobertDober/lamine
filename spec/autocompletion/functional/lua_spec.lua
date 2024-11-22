-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'lua', line = line, basename='hello.lua'} 
end

describe('require completions found for lua', function()
  it('does not find anything if there is no match', function()
    assert.is_nil(fc(context('epiufhezf gzgjrzoi')))
  end)
  it('finds a complex require statement first', function()
    local result = fc(context('  local require"something.completely".different'))
    assert.are.same({'  local different = require"something.completely".different'}, result.lines)
    assert.is_nil(result.offset)
  end)
  it('and a simpler one, later', function()
    local result = fc(context('  local req'))
    assert.are.same({"  local require'"}, result.lines)
    assert.is_nil(result.offset)
  end)
end)

describe('local', function()
  it('expands to local at the beginning of a line', function()
    local result = fc(context('  lo '))
    assert.are.same({"  local "}, result.lines)
    assert.is_nil(result.offset)
  end)
  it('but not later', function()
    assert.is_nil(fc(context('  hello')))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
