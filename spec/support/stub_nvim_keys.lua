-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function reset_keys()
  vim.fed_keys = {}
end

local function typed_keys(index)
  if index then
    return vim.fed_keys[index]
  end
  return vim.fed_keys
end

local function assert_expect_keys(expected)
  local fun = vim.keymaps[expected.mode][expected.keys]
    local expected = {
      escape = expected.escape or false,
      key = {
        code = expected.code,
        do_lt = false,
        from_part = expected.from_part or true,
        special = expected.special or true,
      },
      mode = expected.mode
    }
  reset_keys()
  fun()
  assert.are.same(expected, typed_keys(1))
end

return {
  assert_expect_keys = assert_expect_keys,
  reset_keys = reset_keys,
  typed_keys = typed_keys,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
