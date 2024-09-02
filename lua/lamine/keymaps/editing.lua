-- local dbg = require("debugger")
-- dbg.auto_where = 2

vim.keymap.set('n', '<Leader>=', "maggVG='azz", {})
vim.keymap.set('n', '<Esc>', ":set nohlsearch<CR>", {})

vim.keymap.set('n', '=', "A", {})

vim.keymap.set('n', '$$l', '<<', {})
vim.keymap.set('n', '$$r', '>>', {})
vim.keymap.set('n', '$$-', ':wqa<cr>', {})
vim.keymap.set('c', '$$-', 'wqa<cr>', {})
vim.keymap.set('i', '$$-', '<Esc>:wqa<cr>', {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
