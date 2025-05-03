-- local dbg = require("debugger")
-- dbg.auto_where = 2

local parser = require'lamine.tools.string'

print(X)
parser.split(X, "%S+", function(part)
  print("part: " .. part)
  return 1
end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
