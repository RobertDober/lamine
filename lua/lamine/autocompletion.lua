-- local dbg = require("debugger")
-- dbg.auto_where = 2

local C = require'lamine.autocompletion.completion'
local context = require'lamine.context'

local function autocomplete()
  local ctxt = context.current_context()
  local completion = C.find_completion(ctxt)
  -- vim.print(completion)
  if completion then
    return C.complete_with(completion)
  end
end

return {
  autocomplete = autocomplete,
  autocontinue = require'lamine.autocompletion.continue'.autocontinue,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
