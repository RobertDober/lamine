-- local dbg = require("debugger")
-- dbg.auto_where = 2

local C = require'lamine.functions.curry'
local F = require'lamine.functional'
local S = require'lamine.functions.ho.strings'
local T = require'lamine.tools.table'


local function _apply(r, context)
  if type(r) == "string" then
    return r
  end
  if type(r) == "number" then
    return T.get(context, r)
  end
  return r(context)
end

local function match_elements(...)
  local elements = {...}
  return function(matches)
    -- T.join(F.map(elements, C.curry(_apply, C._, matches)))
    return T.join(F.map(elements, function(element) 
      return _apply(element, matches)
    end))
  end
end

local function _maybe_replace_with(m, r, context)
  if r then
    return _apply(r, context)
  end
  return m
end

local function replace_matches(replacers)
  return function(matches, ctxt)
    -- vim.print(matches)
    local line = T.combine(matches, replacers, _maybe_replace_with, matches)
    -- vim.print(lines)
    line = T.join(line)
    return {lines={line}, offset={0, 999}, ctxt=ctxt}
  end
end

local function replace_suffix_and_add_lines(params)
  local lines = params.lines or error("keyword lines missing")
  local suffix = params.suffix or ""
  return function(matches, ctxt)
    local index = #matches
    -- vim.print(matches)
    local line = string.gsub(ctxt.line, matches[index], suffix)
    local lines = F.map(lines, S.prefix_with(matches[1]))
    lines = T.append({line}, lines)
    return {lines=lines, offset={0, 999}, ctxt=ctxt}
  end
end

return {
  match_elements = match_elements,
  replace_matches = replace_matches,
  replace_suffix_and_add_lines = replace_suffix_and_add_lines,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
