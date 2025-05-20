-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function strftimefn(fmt)
  return function()
    return vim.api.nvim_eval('strftime("' .. fmt .. '", localtime())')
  end
end

return {
  date = strftimefn('%F'),
  datetime = strftimefn('%FT%T'),
  time = strftimefn('%T'),
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
