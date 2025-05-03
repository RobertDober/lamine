-- local dbg = require("debugger")
-- dbg.auto_where = 2

vim.keymap.set('n',':dol', ':lua dofile("./.local/xxx.lua")()<CR>', {})
vim.keymap.set('n',':newl', ':tabnew ./.local/xxx.lua<CR>', {})
vim.keymap.set('v',':dol', ':lua dofile("./.local/xxx.lua")()<CR>', {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
