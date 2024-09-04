-- local dbg = require("debugger")
-- dbg.auto_where = 2

local foldl = require'lamine.functional'.foldl
local reverse2 = require'lamine.functions'.reverse2

describe('empty', function()
  it('returns the initial acc', function()
    assert.is.equal(42, foldl({}, 42, "id"))
  end)
  it('returns a function call with, nil and nil', function()
    foldl({}, function(ele, acc)
      assert.is_nil(ele)
      assert.is_nil(acc)
    end)
  end)
end)

describe('the cannonical substraction', function()
  it('from initial value with explicit function', function()
    assert.is.equal(7, foldl({1, 2}, 10, function(e, a) return a - e end))
  end)
  it('no initial value with explicit function', function()
    assert.is.equal(-1, foldl({1, 2}, function(e, a) return a - e end))
  end)
  it('no initial value with named function', function()
    assert.is.equal(1, foldl({1, 2}, "minus"))
  end)
  it('initial value with named function', function()
    assert.is.equal(5, foldl({1, 3}, 3, "minus"))
  end)
  it('we can reverse the order', function()
    assert.is.equal(-1, foldl({1, 3}, 3, reverse2("minus")))
    
  end)

end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
