-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'ruby', line = line, basename='hello.rb'} 
end
describe('attribute_readers', function()
  describe('att at the beginning, no suffix', function()
    it('no indent', function()
      local result = fc(context('att'))
      assert.are.same({"attr_reader "}, result.lines)
      assert.is_nil(result.offset)
    end)
    it('indent', function()
      local result = fc(context('  att  '))
      assert.are.same({"  attr_reader "}, result.lines)
      assert.is_nil(result.offset)
    end)
  end)
  describe('no completion', function()
    it('prefix', function()
      local result = fc(context(' prefix att'))
      assert.is_nil(result)
    end)
    it('suffix', function()
      local result = fc(context('  att suffix'))
      assert.is_nil(result)
    end)
  end)

end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
