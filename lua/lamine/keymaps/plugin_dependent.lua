-- local dbg = require("debugger")
-- dbg.auto_where = 2

vim.print{leader=vim.g.mapleader}
vim.keymap.set('n',';co', ':Commentary<CR>', {})
vim.keymap.set('v',';co', ":'<,'>Commentary<CR>", {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
