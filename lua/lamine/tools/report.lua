-- local dbg = require("debugger")
-- dbg.auto_where = 2

return function(...)
  if vim.fn.eval("$LUA_DEBUG") == '' then
    return
  end

  vim.print{...}
end

-- SPDX-License-Identifier: AGPL-3.0-or-later
