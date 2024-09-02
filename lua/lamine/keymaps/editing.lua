-- local dbg = require("debugger")
-- dbg.auto_where = 2

vim.keymap.set('n', '<Leader>=', "maggVG='azz", {})
vim.keymap.set('n', '<Esc>', ":set nohlsearch<CR>", {})

vim.keymap.set('n', '=', "A", {})

vim.keymap.set('n', '$$l', '<<', {})
vim.keymap.set('n', '$$r', '>>', {})
vim.keymap.set('n', '$$-', ':wqa<cr>', {})
vim.keymap.set('n', '$$<Space>', ':w!<cr>', {})
vim.keymap.set('n', '$$i', '<C-a>', {})
vim.keymap.set('n', '$$d', '<C-x>', {})
vim.keymap.set('n', '$$e', '<C-r>', {})
vim.keymap.set('n', '$$t', '<C-t>', {})

vim.keymap.set('c', '$$-', 'wqa<cr>', {})
vim.keymap.set('i', '$$-', '<Esc>:wqa<cr>', {})
vim.keymap.set('i', '$$!!', '<Esc>:qa!<cr>', {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
