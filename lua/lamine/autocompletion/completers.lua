-- local dbg = require("debugger")
-- dbg.auto_where = 2

local F = require'lamine.functional'
local S = require'lamine.functions.ho.strings'
local T = require'lamine.tools.table'

local function replace_suffix_and_add_lines(params)
  local lines = params.lines or error("keyword lines missing")
  local suffix = params.suffix or ""
  return function(matches, ctxt)
    local line = string.gsub(ctxt.line, matches[3], suffix)
    local lines = F.map(lines, S.prefix_with(matches[2]))
    lines = T.append({line}, lines)
    return {lines=lines, ctxt=ctxt}
  end
end

return {
  replace_suffix_and_add_lines = replace_suffix_and_add_lines,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
