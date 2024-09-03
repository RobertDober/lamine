-- local dbg = require("debugger")
-- dbg.auto_where = 2

local lines = {
  'Line 1',
  'Line 2',
  'Line 3',
}

local function set(fl, ll, data)
  local data = data
  if type(data) == "string" then
    data = {data}
  end
  return vim.api.nvim_buf_set_lines(0, fl, ll, false, data)
end

local function assert_buffer(lines)
  assert.are.same(lines, vim._buffer.lines)
end

local function assert_cursor(cur)
  assert.are.same(cur, vim._buffer.cursor)
end


describe('assure that the stubbed vim.api.nvim_buf_set_lines does exactly the same thing as the real one', function()
  before_each(function()
    vim._stub_buffer{lines = lines}
    assert_buffer(lines)
    assert_cursor{1, 0}
  end)

  describe('setting any line with a positive line number', function()
    it('can set line number 1', function()
      set(0, 1, "new")
      assert_buffer({"new", "Line 2", "Line 3"})
      assert_cursor{1, 0}
    end)
    it('can set line number 2', function()
      set(1, 2, "new")
      assert_buffer({"Line 1", "new", "Line 3"})
      assert_cursor{1, 0}
    end)
    it('can set line number 3', function()
      vim._stub_buffer{cursor={2, 3}}
      set(2, 3, "new")
      assert_buffer({"Line 1", "Line 2", "new"})
      assert_cursor{2, 3}
    end)
  end)

  describe('setting any line with a negative line number', function()
    it('can set line number 1', function()
      set(-4, -3, "new")
      assert_buffer({"new", "Line 2", "Line 3"})
    end)
    it('can set line number 2', function()
      set(-3, -2, "new")
      assert_buffer({"Line 1", "new", "Line 3"})
    end)
    it('#wip can set line number 3', function()
      set(-2, -1, "new")
      assert_buffer({"Line 1", "Line 2", "new"})
    end)
  end)

  describe('inserting lines with positive line numbers', function()
    it('inserts before first line', function()
      set(0, 0, {"a", "b"})
      assert_buffer({"a", "b", "Line 1", "Line 2", "Line 3"})
    end)
    it('inserts in the middle', function()
      set(1, 1, {"a", "b"})
      assert_buffer({"Line 1", "a", "b", "Line 2", "Line 3"})
    end)
    it('insert at the end', function()
      set(3, 3, {"new"})
      assert_buffer({"Line 1", "Line 2", "Line 3", "new"})
    end)
  end)

  describe('inserting lines with negativ line numbers', function()
    it('inserts before first line', function()
      set(-5, -5, {"a", "b"})
      assert_buffer({"a", "b", "Line 1", "Line 2", "Line 3"})
    end)
    it('inserts in the middle', function()
      set(-3, -3, {"a", "b"})
      assert_buffer({"Line 1", "a", "b", "Line 2", "Line 3"})
    end)
    it('insert at the end', function()
      set(-1, -1, {"new"})
      assert_buffer({"Line 1", "Line 2", "Line 3", "new"})
    end)
  end)

  describe('some mixed cases', function()
    it('delete last line', function()
      set(2, -1, {})
      assert_buffer({"Line 1", "Line 2"})
    end)
    it('replace buffer', function()
      set(0, -1, {"a", "b", "c"})
      assert_buffer({"a", "b", "c"})
    end)

  end)

  describe('cursor going out of scope', function()
    it("line is shortened too much => end of current line", function()
      vim._stub_buffer{cursor={2, 3}}
      set(0, -1, {"a", "b", "c"})
      assert_cursor{2, 0}
    end)
    it("line disappears and last line shorter than the column position => end of last line", function()
      vim._stub_buffer{cursor={2, 3}}
      set(0, -1, {"an"})
      assert_cursor{1, 1}
    end)
    it("line disappears and last line at least as long as the column position => color position in last line", function()
      vim._stub_buffer{cursor={3, 3}}
      set(0, -1, {"alpha", "beta"})
      assert_cursor{2, 3}
    end)
    
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
