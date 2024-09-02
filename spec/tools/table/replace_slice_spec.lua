-- local dbg = require("debugger")
-- dbg.auto_where = 2

local replace = require'lamine.tools.table'.replace_slice
local source = {1, 2, 3}
describe("replace_slice", function()
  it("into empty", function()
    local new = {10, 20}
    local result = replace({}, 100, 101, new)
    assert.are.same(new, result)
  end)
  it("at the beginning", function()
    local result = replace(source, 0, 0, {10, 20})
    assert.are.same({10, 20, 1, 2, 3}, result)
  end)
  it("at the end", function()
    local result = replace(source, 4, 4, {10, 20})
    assert.are.same({1, 2, 3, 10, 20}, result)
  end)
  it("in the middle", function()
    local result = replace(source, 3, 2, {10, 20})
    assert.are.same({1, 2, 10, 20, 3}, result)
  end)
  it("replacing some lines", function()
    local result = replace(source, 2, 2, {10, 20})
    assert.are.same({1, 10, 20, 3}, result)
  end)

end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
