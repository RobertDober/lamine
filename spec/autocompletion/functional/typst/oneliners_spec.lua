-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'typst', line = line, basename='hello.typ'} 
end

describe('page breaks', function()
  it("expands at beginning of the line as follows", function()
    local result = fc(context('pbr '))
    local expected = {
      '#pagebreak(weak: true)',
      ''
    }
    assert.are.same(expected, result.lines)
    assert.are.same({1, 1}, result.offset)
  end)
  it("whitespace is removed", function()
    local result = fc(context('  pbr '))
    local expected = {
      '#pagebreak(weak: true)',
      ''
    }
    assert.are.same(expected, result.lines)
    assert.are.same({1, 1}, result.offset)
  end)
end)

describe('include', function()
  it("expands at beginning of the line as follows", function()
    local result = fc(context('inc '))
    local expected = {
      '#include "',
      ''
    }
    assert.are.same(expected, result.lines)
    assert.are.same({1, 1}, result.offset)
  end)
  it("whitespace is removed", function()
    local result = fc(context('  inc '))
    local expected = {
      '#include "',
      ''
    }
    assert.are.same(expected, result.lines)
    assert.are.same({1, 1}, result.offset)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
