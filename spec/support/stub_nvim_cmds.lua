-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function reset_cmds()
  vim.commands = {}
end

local function executed_cmds(index)
  if index then
    return vim.commands[index]
  end
  return vim.commands
end

local function assert_executed_cmds(expected)
  local fun = expected.fun or vim.keymaps[expected.mode][expected.keys]
  reset_cmds()
  fun()
  assert.is.equal(expected.command, executed_cmds(1))
end

return {
  assert_executed_cmds = assert_executed_cmds,
  reset_cmds = reset_cmds,
  executed_cmds = executed_cmds,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
