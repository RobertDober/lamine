-- local dbg = require("debugger")
-- dbg.auto_where = 2
vim.g.lamine_version="0.0.1"
vim.g.lamine_date="2024-10-28"

require'lamine.keymaps'
require'lamine.commands'
vim.g.mapleader = ';'
vim.o.jumpoptions = 'stack'

-- SPDX-License-Identifier: AGPL-3.0-or-later
