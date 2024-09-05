-- local dbg = require("debugger")
-- dbg.auto_where = 2

local keys = {
  ['aaa'] = '[',
  ['ooo'] = '}',
  ['ppp'] = ']',
  ['zzz'] = '{',
}
for shortcut, mapping in pairs(keys) do
  vim.keymap.set('i', shortcut, mapping, {})
end
-- SPDX-License-Identifier: AGPL-3.0-or-later
