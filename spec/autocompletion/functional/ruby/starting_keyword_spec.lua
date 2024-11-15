-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'ruby', line = line, basename='hello.rb'} 
end

describe('starting keywords', function()
  describe('priv', function()
    it('completes priv', function()
      local result = fc(context('priv'))
      assert.are.same({"private"}, result.lines)
      assert.is_nil(result.offset)
    end)

    it('completes space priv', function()
      local result = fc(context('  priv '))
      assert.are.same({"  private"}, result.lines)
      assert.is_nil(result.offset)
    end)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
