-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'elixir', line = line, basename='hello.ex'} 
end

describe('inline completions found for elixir', function()
  it('does not find anything if there is no match', function()
    assert.is_nil(fc(context('epiufhezf gzgjrzoi')))
  end)
  it('replaces @@@ with the correct #{}', function()
    local result = fc(context('some string "is@@@'))
    assert.are.same({'some string "is#{}'}, result.lines)
    assert.are.same({0, -1}, result.offset)
    assert.are.same({0, 999}, result.continue)
  end)
  it('replaces fn with the arrow form', function()
    local result = fc(context('capture_io(fn'))
    assert.are.same({'capture_io(fn -> '}, result.lines)
    assert.are.same({0, 999}, result.offset)
  end)
  it('replaces &&& with the pipe form', function()
    local result = fc(context(' somefn&&&'))
    assert.are.same({' somefn |> '}, result.lines)
    assert.are.same({0, 999}, result.offset)
  end)
end)

describe('doc and moduledoc', function()
  it('completes doc with a preceding @', function()
    local result = fc(context(' @doc  '))
    local expected_lines = {
      ' @doc ~S"""',
      ' ',
      ' """'
    }
    assert.are.same(expected_lines, result.lines)
    assert.are.same({1, 999}, result.offset)
  end)
  it('completes doc without a preceding @', function()
    local result = fc(context(' doc'))
    local expected_lines = {
      ' @doc ~S"""',
      ' ',
      ' """'
    }
    assert.are.same(expected_lines, result.lines)
    assert.are.same({1, 999}, result.offset)
  end)
  it('also works for module docs', function()
    local result = fc(context(' moduledoc '))
    local expected_lines = {
      ' @moduledoc ~S"""',
      ' ',
      ' """'
    }
    assert.are.same(expected_lines, result.lines)
    assert.are.same({1, 999}, result.offset)
    
  end)
end)

describe('optional opts', function()
  it('inserts the needed stuff', function()
    local result = fc(context('  def some( x, optopt'))
    assert.are.same({'  def some( x, options \\\\ []) do', '    ', '  end'}, result.lines)
    assert.are.same({1, 999}, result.offset)
    assert.is_nil(result.continue)
  end)
end)

describe('subtype completions not defined', function()
  it('does not replace describe"..."', function()
    local result = fc(context(' describe "..."'))
    assert.is_nil(result)
  end)
end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
