-- local dbg = require("debugger")
-- dbg.auto_where = 2
require'lamine.init_args'
local M = {}

M.config = {}
M.dependencies = {
    { dir = '~/codeberg/lua/lampe' },
    { dir = '~/codeberg/lua/lampe_kwdfun' },
  }

return M
-- SPDX-License-Identifier: AGPL-3.0-or-later
