-- local dbg = require("debugger")
-- dbg.auto_where = 2
return function()
  local handle = io.popen("pwd")
  local output = handle:read("*l")
  handle:close()
  return output
end
  
-- SPDX-License-Identifier: AGPL-3.0-or-later
