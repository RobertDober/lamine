-- local dbg = require("debugger")
-- dbg.auto_where = 2

vim.keymap.set('n',':l', ':lua dofile("./.local/xxx.lua")()<CR>', {})
vim.keymap.set('n',':newl', ':tabnew ./.local/xxx.lua<CR>', {})
vim.keymap.set('v',':l', ':lua dofile("./.local/xxx.lua")()<CR>', {})
-- SPDX-License-Identifier: AGPL-3.0-or-later
