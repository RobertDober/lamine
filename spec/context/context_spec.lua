-- local dbg = require("debugger")
-- dbg.auto_where = 2


local api = require'lamine.api'
local context = require'lamine.context'
local tt = require'lamine.tools.table'

local cc = nil

before_each(function()
  vim._stub_buffer{file = 'get_lines.txt'}
  cc = context.current_context()
end)

describe("current line", function()
  it("is where?", function()
    local line = context.current_line()
    assert.is.equal("Line One", line)
  end)
  it("is also the line at 1", function()
    assert.is.equal("Line One", context.line_at(1))
  end)
  it("has the current char", function()
    local char = context.current_char()
    assert.is.equal("L", char)
  end)
  it("changes if we move", function()
    vim._stub_buffer{cursor = {2, 3}}
    local line = context.current_line()
    assert.is.equal("Empty", line)
    local char = context.current_char()
    assert.is.equal("t", char)
    assert.is.equal(2, context.current_lnb())
  end)
end)

describe('line_at', function()
  it('can get the first line explicitly', function()
    assert.is.equal('Line One', context.line_at(1)) 
  end)
  it('can get the last line', function()
    assert.is.equal('Line Four', context.line_at(-1)) 
  end)
end)

describe("current context", function()
  it("#wip has some values", function()
    expected = {char="L", line="Line One", lnb=1, post_line="Empty"}
    assert.are.same(expected, tt.projection(cc, expected))
  end)
end)

describe("filetype", function()
  it("is empty as for any new buffer", function()
    assert.is.equal("", api.filetype())
  end)
  it("can be accessed for a bffer", function()
    vim._stub_buffer{ft = "anything"}
    assert.is.equal("anything", api.filetype())
  end)

end)

describe("set lines", function()
  it("can set the current line", function()
    context.set_current_line("New Line")
    local new_buffer = {
      "New Line",
      "Empty",
      "",
      "Line Four",
    }
    assert.are.same(new_buffer, vim._buffer.lines)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
