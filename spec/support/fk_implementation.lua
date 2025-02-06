-- local dbg = require("debugger")
-- dbg.auto_where = 2
local function feedkeys(key, mode, escape)
  table.insert(vim.fed_keys, {key=key, mode=mode, escape=escape})
end

local function replace_termcodes(code, from_part, do_lt, special)
  return {
    code = code,
    from_part = from_part,
    do_lt = do_lt,
    special = special
  }
end

local function create_user_command()
end

return {
  create_user_command = create_user_command,
  feedkeys = feedkeys,
  replace_termcodes = replace_termcodes,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
