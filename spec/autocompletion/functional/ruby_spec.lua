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

  describe('string interpolation', function()
    it('replaces @@@ with the correct #{}', function()
      local result = fc(context('some string "is@@@'))
      assert.are.same({'some string "is#{}'}, result.lines)
      assert.are.same({0, -1}, result.offset)
    end)

    it('replaces @@@ inside a string', function()
      local result = fc(context('in @@@ the middle'))
      assert.are.same({'in #{} the middle'}, result.lines)
      assert.are.same({0, -1}, result.offset)
    end)
  end)

  describe('case', function()
    it('inserts lines, not changing first', function()
      local result = fc(context('  case some_function()'))
      local expected = {
        '  case some_function()',
        '    ',
        '  end'
      }
      assert.are.same(expected, result.lines)
      assert.are.same({1, 999}, result.offset)
    end)
  end)

  describe('results', function()
    it('inserts an ok result', function()
      local result = fc(context('  OK'))
      assert.are.same({'  {ok: true, '}, result.lines)
      assert.are.same({0, 999}, result.offset)
    end)
    it('inserts an error result', function()
      local result = fc(context('  ERR'))
      assert.are.same({'  {ok: false, '}, result.lines)
      assert.are.same({0, 999}, result.offset)
    end)
    it('inserts a not ok result', function()
      local result = fc(context('  NOK'))
      assert.are.same({'  {ok: false, '}, result.lines)
      assert.are.same({0, 999}, result.offset)
    end)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
