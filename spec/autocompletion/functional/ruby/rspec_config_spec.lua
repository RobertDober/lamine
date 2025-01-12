-- local dbg = require("debugger")
-- dbg.auto_where = 2
-- def parse_markdown(_,_), do: {:ok, [], []}$

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'ruby', line = line, basename='hello.rb'} 
end
describe('rspec config spec', function()
  it('completes as desired', function()
    local line = 'rspec_conf'
    local result = fc(context(line))
    assert.are.same({"RSpec.configure do |config|", "  config.include ", "end"}, result.lines)
    assert.are.same({1, 999}, result.offset)
  end)
  it('needs to be in the first line', function()
    local line = ' rspec_conf'
    local result = fc(context(line))
    assert.is_nil(result)
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
