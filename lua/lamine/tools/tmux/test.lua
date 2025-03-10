-- local dbg = require("debugger")
-- dbg.auto_where = 2

local context = require'lamine.context'.current_context
local find = require'lamine.functional'.find
local S = require'lamine.functions.ho.strings'

local elixir_triggers = {
  '^%s*test',
  '^%s*describe',
}

local function search_for_test_file(path)
  if string.match(path, "_test%.exs$") then
    return path
  end
  local new_path = string.gsub(path, 'lib/', 'test/')
  return string.gsub(new_path, '%.ex$', '_test.exs')
end

local function elixir_test_command(all)
  if all then
    return {command='mix test'}
  end
  local ctxt = context()
  local file = search_for_test_file(ctxt.file_path)
  local line = ctxt.line
  local suffix = ''
  local triggered = find(elixir_triggers, S.match_subject(line))
  if triggered then
    suffix = ':' .. tostring(ctxt.lnb)
  end
  return {
    command = 'mix test ' .. file .. suffix
  }
end

local ft_test_commands =  {
  elixir = elixir_test_command,
}
local function test_command()
  local tc = ft_test_commands[vim.o.ft]
  if tc then
    return tc()
  end

end

return {
  test_command = test_command,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
