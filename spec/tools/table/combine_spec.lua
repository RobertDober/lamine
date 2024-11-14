-- local dbg = require("debugger")
-- dbg.auto_where = 2 do

local combine = require'lamine.tools.table'.combine
local abort = require'lamine.tools.table'.abort

describe('combine, no abort', function()
  it('combines an empty table into an empty table', function()
    assert.are.same({}, combine({}, {1, 2}, function_which_does_not_exist))
  end)
  it('can add two tables', function()
    local result = combine(
    {2, 3},
    {1, 2},
    function(a, b) return a + 10*b end
    )
    assert.are.same({12, 23}, result)
  end)
  it('can also use a context', function()
    local result = combine(
    {2, 3},
    {1, 2},
    function(a, b, ctxt) ctxt.count = ctxt.count + 1; return a + 10*b - ctxt.count end,
    {count=0}
    )
    assert.are.same({11, 21}, result)
  end)
end)

describe('aborting', function()
  it('means nil', function()
    local result = combine({1, 2}, {3, 4}, function(x) 
      if x < 2 then
        return x
      end
      return abort
    end)
    assert.is_nil(result)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
