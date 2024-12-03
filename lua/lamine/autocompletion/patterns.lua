-- local dbg = require("debugger")
-- dbg.auto_where = 2
local function first_word(replacement)
  return {"^(%s*)(%w+)(.*)(%s*)$", replacement}
end

local function word(replacement)
  return {"^(%s*)(%w+)(%s*)$", replacement}
end

return {
  first_word = first_word,
  word = word,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
