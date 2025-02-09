-- local dbg = require("debugger")
-- dbg.auto_where = 2

local fntl = require'lamine.functional'
local find = fntl.find
local find_value = fntl.find_value

local F = require'lamine.functions.ho.functions'
local S = require'lamine.functions.ho.strings'
local T = require'lamine.functions.ho.tables'

local entries = {
  { "abc", 1 },
  { "abd", 2 }
}
describe('just find an entry', function()
  it('might not find anything', function()
    local finder = F.concat(T.first, S.match_with("xxx"))
    assert.is_nil(find(entries, finder))
  end)
  it('might find something', function()
    local finder = F.concat(T.first, S.match_with("a.d"))
    assert.are.same({"abd", 2}, find(entries, finder))
  end)
end)

describe('find matching pattern', function()
  local finder = S.match_subject('a line')
  it('will find the first', function()
    assert.is_equal('line', find({'line', '^a.*'}, finder))
  end)
  it('will find the last', function()
    assert.is_equal('^a.*', find({'xxx', '^a.*'}, finder))
  end)
  it('returns nil if nothing is found', function()
    assert.is_nil(find({'xxx$', 'hello'}, finder))
  end)
  it('also returns nil for an empty table', function()
    assert.is_nil(find({}, finder))
  end)
end)

describe('find value', function()
  it('still might not find anything', function()
    local finder = F.concat(T.first, S.match_with("xxx")) assert.is_nil(find_value(entries, finder))
  end)
  it('can return a value', function()
    local finder = function(pair)
      a, b = string.match(pair[1], "(.)(.)d")
      if a then
        return {a, b, pair[2]}
      end
    end

    local result = find_value(entries, finder)
    assert.are.same({"a", "b", 2}, result)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
