-- local dbg = require("debugger")
-- dbg.auto_where = 2
local concat = require'lamine.functions.ho.functions'.concat
describe('no functions => error', function()
  it('raises an error, as promised above', function()
    assert.has_error(concat, "must not concat empty function list")
  end)
end)

describe('single gunction=> NOP', function()
  it('just calls the first function', function()
    assert.is.equal(42, concat(function(a) return a + 22 end)(20))
  end)
end)

describe('and many functions )', function()
  local function increment(x) return x + 1 end
  local function double(m) return 2 * m end
  it('increments doubles and converts to a string', function()
    local result = concat(increment, double, tostring)(20)
    assert.is.equal('42', result)
  end)
end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
