-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'ruby', line = line, basename='hello.rb'} 
end
describe('block spec', function()
  describe('tangling do', function()
    it('no indent', function()
      local line = 'RSpec.describe "hello" do'
      local result = fc(context(line))
      assert.are.same({line, "  ", "end"}, result.lines)
      assert.are.same({1, 999}, result.offset)
    end)
    it('with indent', function()
      local line = ' x.each do'
      local result = fc(context(line))
      assert.are.same({line, "   ", " end"}, result.lines)
      assert.are.same({1, 999}, result.offset)
    end)
  end)
  describe(' do with args', function()
    it('block params', function()
      local line = '  some_call do'
      local params = ' |a, b|'
      local result = fc(context(line .. params))
      assert.are.same({line .. ' |a, b|', "    ", "  end"}, result.lines)
      assert.are.same({1, 999}, result.offset)
    end)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
