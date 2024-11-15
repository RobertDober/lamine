-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function reset_evals()
  vim.evals = {}
end

vim.evals = vim.evals or {}
vim.api = vim.api or {}
function vim.api.nvim_eval(cmd)
 table.insert(vim.evals, cmd)
 return vim.evals[cmd]
end

return {
  reset_evals = reset_evals,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
