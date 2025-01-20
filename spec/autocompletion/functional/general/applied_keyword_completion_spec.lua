-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion


local function context(line)
  return {filetype = nil, line = line, basename='some_file'} 
end

describe('general completions', function()
  describe('keyword completions that operate on their prefix', function()
    describe('%code', function()
      it('surrounds its prefix with single backquotes', function()
        local result = fc(context('hello world%code'))
        assert.are.same({"hello `world`"}, result.lines )
        assert.is_nil(result.offset)
      end)
      it('also works at the beginning', function()
        local result = fc(context('world%code'))
        assert.are.same({"`world`"}, result.lines )
        assert.is_nil(result.offset)
      end)
    end)
    describe('%idx', function()
       it("adds brackets after the identifier with a continuation", function()
        local result = fc(context('hello my_variable%idx'))
        assert.are.same({"hello my_variable[]"}, result.lines )
       end)
      
    end)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later

