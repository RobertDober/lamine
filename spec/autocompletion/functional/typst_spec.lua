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

describe('headlines', function()
  for i = 1, 7 do
    it('expands to level ' .. tostring(i), function()
      local result = fc(context('hl' .. tostring(i)))
      local expected = {
        string.rep("=", i) .. " "
      }
      assert.are.same(expected, result.lines)
      assert.is_nil(result.offset)
    end)
  end
end)

describe('# at the beginning', function()
  for i = 0, 2 do
    it('expands to a ' .. tostring(i) .. 'space indented #', function()
      local result = fc(context(string.rep(' ', i)))
      local expected = {
        string.rep(' ', i) .. '#'
      }
      assert.are.same(expected, result.lines)
      assert.is_nil(result.offset)
    end)
  end
  for _, s in ipairs{"  1", " a", "-x"} do
    it('does not work with non whitespace ' .. s, function()
      local result = fc(context(s))
      assert.is_nil(result)
    end)
  end
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
