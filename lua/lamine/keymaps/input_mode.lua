-- local dbg = require("debugger")
-- dbg.auto_where = 2

local keys = {
  ['<Leader><Space>'] = '<Esc>',
  ['<Leader>r'] = '<C-r>',
  ['<Leader>c'] = '<C-c>',
  ['<Leader>p'] = '<C-p>',
  ['<Leader>:'] = '\\',
  ['<Leader>n'] = '~',
  ['$$<Space>'] = '<Esc>:w!<Cr>',
}

for shortcut, mapping in pairs(keys) do
  vim.keymap.set('i', shortcut, mapping, {})
end
-- SPDX-License-Identifier: AGPL-3.0-or-later
