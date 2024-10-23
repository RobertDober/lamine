-- local dbg = require("debugger")
-- dbg.auto_where = 2

local map = require'lamine.functional'.map
local curry = require'lamine.functions.curry'.curry

describe('empty', function()
  it('ramains empty', function()
    assert.are.same({}, map({}, function() error("NEVER CALLED") end))
  end)
end)

describe('the cannonical addition', function()
  local input = {2, 41, 72}
  it('gets interesting values', function()
    assert.are.same({3, 42, 73}, map(input, curry('add', 1)))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
