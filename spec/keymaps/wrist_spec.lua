-- local dbg = require("debugger")
-- dbg.auto_where = 2

describe('input mode keymappings for my wrist', function()
  local shortcuts = {
    ['zzz'] = '{',
    ['aaa'] = '[',
    ['ooo'] = '}',
    ['ppp'] = ']',
  }

  for shortcut, mapping in pairs(shortcuts) do
    it(shortcut .. ' in input mode is mapped to ' .. mapping, function()
      assert.is.equal(vim.keymaps.i[shortcut], mapping)
    end)
  end
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
