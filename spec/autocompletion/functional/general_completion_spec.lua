-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = nil, line = line, basename='some_file'} 
end

describe('general completions', function()

  it('does not find anything if there is no match', function()
    assert.is_nil(fc(context('epiufhezf gzgjrzoi')))
  end)

  describe('arrows', function()
    local arrows = {
      ['->'] = '→',
      ['=>'] = '⇒',
      ['<-'] = '←',
      ['<='] = '⇐',
    }

    for shortcut, arrow in pairs(arrows) do
      it(shortcut .. ' is autocompleted to ' .. arrow, function()
        local result = fc(context("abc" .. shortcut))
        assert.are.same({"abc"..arrow}, result.lines)
      end)
    end
  end)

  describe('predefinded functions', function()
    it('does not replace an undefined function', function()
      assert.is_nil(fc(context'some text %undefined function'))
    end)
    it('replaces the date function', function()
      local result = fc(context('prefix %date'))
      assert(string.match(result.lines[1], "prefix 2%d%d%d-%d%d-%d%d"))
      assert.is_nil(result.offset)
    end)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later

