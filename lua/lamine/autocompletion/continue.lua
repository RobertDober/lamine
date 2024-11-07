-- local dbg = require("debugger")
-- dbg.auto_where = 2
local api = require'lamine.api'
local B = require'lamine.autocompletion.continuations.bufvar'
local C = require'lamine.context'
local function autocontinue()
  local continuation = B.remove_continuation()
  if continuation then
    -- LATER: if type(continuation) == 'table' then
    local offset = C.relative_offset(continuation)
    api.set_cursor(offset)
  end
end

return {
  autocontinue = autocontinue,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
