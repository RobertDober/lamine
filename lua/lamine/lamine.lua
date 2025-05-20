-- local dbg = require("debugger")
-- dbg.auto_where = 2
vim.g.lamine_version="0.0.1a"
vim.g.lamine_date="2025-05-20"

require'lamine.keymaps'
require'lamine.commands'
vim.g.mapleader = ';'
vim.o.jumpoptions = 'stack'

vim.print{lamine_lamine_lua = true}
require'config.lazy'
require'lazy'.setup( {
  {
    { dir = '~/codeberg/lua/lampe' },
    { dir = '~/codeberg/lua/lampe_kwdfun' },
  }
})
require'lamine.init_args'
-- SPDX-License-Identifier: AGPL-3.0-or-later
-- SPDX-License-Identifier: AGPL-3.0-or-later
