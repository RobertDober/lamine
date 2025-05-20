-- local dbg = require("debugger")
-- dbg.auto_where = 2

local parser = require'lamine.tools.string'

vim.print{version=1, name="lamine.init_args"}
local commands={}
parser.split(vim.env.LAMINE_ARGS, "%S+", function(part)
  print("part: " .. part)
  return 1
end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
