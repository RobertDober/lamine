-- local dbg = require("debugger")
-- dbg.auto_where = 2

local C = require'lamine.functions.curry'
local F = require'lamine.functional'
local S = require'lamine.functions.ho.strings'
local T = require'lamine.tools.table'
local context = require'lamine.context'
local report = require'lamine.tools.report'


local function _apply(r, context, match)
  if not r then
    return match
  end
  if type(r) == "string" then
    return r
  end
  if type(r) == "number" then
    return T.get(context, r)
  end
  local result = r(context, match)
  report{label = '_apply', result = result}
  return result
end

local function match_against_table(tbl)
  return function(_matches, match)
    local replacement = tbl[match]
    if replacement then
      if replacement == true then
        return match
      end
      return replacement
    end
    return T.abort
  end
end

local function match_elements(...)
  local elements = {...}
  return function(matches)
    -- T.join(F.map(elements, C.curry(_apply, C._, matches)))
    return T.join(F.map(elements, function(element) 
      -- vim.print{matches=matches, elements=elements}
      local result = _apply(element, matches)
      -- vim.print{result=result}
      return result
    end))
  end
end

local function _maybe_replace_with(m, r, context)
  return _apply(r, context, m)
end

local function _eval_lines(lines, matches, do_not_indent)
  -- local lines = F.map(lines, function(line) return vim.print(_apply(line, matches)) end)
  --
  local lines = F.map(lines, function(line) return _apply(line, matches) end)
  -- vim.print{lines=lines}
  local prefix = matches[1]
  if string.match(prefix, "^%s+$") then
    if not do_not_indent then
      lines = F.map(lines, S.prefix_with(matches[1]))
    end
  end
  return lines
end

local function indent(n)
  local n = n or 1
  return function()
    return context.indent(n)
  end
end

local function replace_matches_and_add_lines(params)
  local lines = params.lines or {}
  local range = params.range or {0, 0}
  local replacers = params.replacers or error("required arg .replacers missing")
  local do_not_indent = false
  -- params.indent equals nil means the default value of true
  if params.indent == false then
    do_not_indent = true
  end
  return function(matches, ctxt)
    -- vim.print(matches)
    local line = T.combine(matches, replacers, _maybe_replace_with, matches)
    if line then
      line = T.join(line)
      -- vim.print(lines)
      local lines = _eval_lines(lines, matches, do_not_indent)
      -- vim.print(lines)
      lines = T.append({line}, lines)
      -- return vim.print{lines=lines, offset=params.offset, ctxt=ctxt, range=params.range}
      -- vim.print(params)
      return {lines=lines, set_cursor=params.set_cursor, offset=params.offset, ctxt=ctxt, range=params.range, continue=params.continue}
    end
  end
end

local function replace_matches(replacers, params, debug)
  local params = params or {}
  params.replacers = replacers
  if debug then
    -- vim.print(params)
  end
  return replace_matches_and_add_lines(params)
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
    return {lines=lines, offset=params.offset, continue=params.continue, ctxt=ctxt}
  end
end

local function get_function(functions, from_element, default)
  return function(matches, ctxt)
    local func = functions[matches[from_element]]
    if func then
      return func()
    else
      return default
    end
  end
end


return {
  get_function = get_function,
  indent = indent,
  match_against_table = match_against_table,
  match_elements = match_elements,
  replace_matches = replace_matches,
  replace_matches_and_add_lines = replace_matches_and_add_lines,
  replace_suffix_and_add_lines = replace_suffix_and_add_lines,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
