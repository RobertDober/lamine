-- local dbg = require("debugger")
-- dbg.auto_where = 2

local ac = require'lamine.autocompletion.completion'
local fc = ac.find_completion

local function context(line)
  return {filetype = 'markdown', line = line, basename = 'hello.md'} 
end

local function assert_completion(params)
  local line = params.line or error('missing param: line')
  local lines = params.lines or error('missing param: lines')
  local offset = params.offset
  local result = fc(context(line))
  if type(lines) == 'string' then
    lines = {lines}
  end

  assert.are.same(lines, result.lines)

  if offset then
    assert.are.same(offset, result.offset)
  else
    assert.is_nil(result.offset)
  end
end

describe('completions found for markdown', function()
  it('does not find anything if there is no match', function()
    assert.is_nil(fc(context('epiufhezf gzgjrzoi')))
  end)

  it('finds a footnote at the beginning of the line', function()
    assert_completion{
      line = 'fn0',
      lines = '[^0]:'
    }
  end)

  it('finds a footnote with big numbers at the beginning of the line', function()
    assert_completion{
      line = 'fn42',
      lines = '[^42]:'
    }
  end)

  it('finds a footnote in the middle of the line', function()
    assert_completion{
      line = 'hello fn1',
      lines = 'hello [^1]'
    }
  end)

  it('finds a footnote with big numbers in the middle of the line', function()
    assert_completion{
      line = '  hello fn73',
      lines = '  hello [^73]'
    }
  end)
  it('expands headlines at the beginning of a line', function()
    assert_completion{
      line = 'hl1',
      lines = '# ',
    }
    assert_completion{
      line = '  hl7',
      lines = '  ####### ',
    }
  end)
  it('but not in the middle', function()
    assert.is_nil(fc(context('hello ##')))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
