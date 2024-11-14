-- local dbg = require("debugger")
-- dbg.auto_where = 2


local function date()
  return vim.api.nvim_eval('strftime("%F", localtime())')
end

return {
  date = date,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
