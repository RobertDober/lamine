vim.cmd"edit tests/context/get_lines.txt"
local context = require'context'

describe("current line", function()
  it("is where?", function()
    local line = vim.api.nvim_get_current_line()
    -- assert.is.equal("Line One", context.current_line())
    assert.is.equal("Line One", line)
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
