-- local dbg = require("debugger")
-- dbg.auto_where = 2

if vim.g.loaded_commentary then
  vim.keymap.set('n','<Leader>co', ':Commentary<CR>', {})
  vim.keymap.set('v','<Leader>co', ":'<,'>Commentary<CR>", {})
end
-- SPDX-License-Identifier: AGPL-3.0-or-later
