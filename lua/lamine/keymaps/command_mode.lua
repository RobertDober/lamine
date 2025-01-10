-- local dbg = require("debugger")
-- dbg.auto_where = 2


local keys = {
  ['<Leader><Space>'] = '<Esc>',
}

for shortcut, mapping in pairs(keys) do
  vim.keymap.set('c', shortcut, mapping, {})
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
