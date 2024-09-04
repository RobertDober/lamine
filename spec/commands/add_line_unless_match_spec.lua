-- local dbg = require("debugger")
-- dbg.auto_where = 2

local balum = require'lamine.tools.buffer.add_line_unless_matches'

local lines = {"alpha", "beta"}

describe('add_line_unless_match', function()
  before_each(function()
    vim._stub_buffer{lines = lines}
  end)
  
  it("does not replace beta if matching and no replace flag", function()
    balum("**********", "beta", -1)
    assert.are.same(lines, vim._buffer.lines)
  end)
  it("replaces beta if matching if the replace flag is set", function()
    balum("gamma", "beta", -1, true)
    assert.are.same({"alpha", "gamma"}, vim._buffer.lines)
  end)
  it("replaces beta if not matching if the replace flag is set", function()
    balum("gamma", "does not match", -1, true)
    assert.are.same({"alpha", "gamma"}, vim._buffer.lines)
  end)
  it("replaces beta if not matching if the replace flag is not set", function()
    balum("gamma", "does not match", -1, true)
    assert.are.same({"alpha", "gamma"}, vim._buffer.lines)
  end)
end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
