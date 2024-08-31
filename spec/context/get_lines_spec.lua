vim._stub_buffer{file = 'get_lines.txt'}

local context = require'context'

describe("current line", function()
  it("is where?", function()
    local line = context.current_line()
    assert.is.equal("Line One", line)
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
  end)
end)

-- describe("current char", function()
--   it("is l", function()
--     assert.is.equal("l", context.current_char())
--   end)
--   it("has a prefix", function()
--     assert.is_equal("a", context.prefix())
--   end)
--   it("has a suffix", function()
--     assert.is_equal("pha", context.suffix())
--   end)
-- end)
