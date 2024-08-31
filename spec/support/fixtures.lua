-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function rel_path(path)
  return "spec/fixtures/" .. path
end

local function read_fixture(path)
  local file = io.open(rel_path(path))
  local content = file:read('*a')
  file:close()
  return content
end

local function read_fixture_lines(path)
  local t = {}
  for line in io.lines(rel_path(path)) do
    table.insert(t, line)
  end
  return t
end

return {
  read_fixture = read_fixture,
  read_fixture_lines = read_fixture_lines,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
