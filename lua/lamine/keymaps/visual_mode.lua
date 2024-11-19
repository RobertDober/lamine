-- local dbg = require("debugger")
-- dbg.auto_where = 2


local keys = {
  ['<Leader>$'] = '<Esc>$',
  ['<Leader>r'] = '<C-r>',
  ['<Leader><Space>'] = '<Esc>',
  ['$l'] = '<<',
  ['$r'] = '>>',
}

for shortcut, mapping in pairs(keys) do
  vim.keymap.set('v', shortcut, mapping, {})
end
-- SPDX-License-Identifier: AGPL-3.0-or-later
