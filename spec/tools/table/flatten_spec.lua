-- local dbg = require("debugger")
-- dbg.auto_where = 2 do

local flatten = require'lamine.tools.table'.flatten

describe('flatten', function()
  it('combines an empty table into an empty table', function()
    assert.are.same({}, flatten({}, {}))
  end)
  it('combines many tables into a table', function()
    local t1 = {1, 10, 11}
    local t2 = {2, 110, 21}
    local t3 = {4}
    local result= {1, 10, 11, 2, 110, 21, 4}
    assert.are.same(result, flatten({}, t1, t2, {}, t3, {}))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
