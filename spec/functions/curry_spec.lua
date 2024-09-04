-- local dbg = require("debugger")
-- dbg.auto_where = 2


local C = require'lamine.functions.curry'

local function concat(...)
  local r = ''
  for _, c in ipairs({...}) do
    r = r .. tostring(c)
  end
  return r
end

describe('setup', function()
  it('is loaded correctly', function()
    assert.is.equal("function", type(C._))
  end)
end)

describe('no placeholders', function()
  local prefix = C.curry(concat, "hello")
  it('can say no more', function()
    assert.is.equal("hello", prefix())
  end)
  it('can do a well known greeting', function()
    assert.is.equal("helloworld", prefix("world")) 
  end)
  it('can do even more', function()
    assert.is.equal("helloevenmore", prefix("even", "more")) 
  end)
end)

describe("placeholders", function()
  local greet = C.curry(concat, C._, ' "', C._, '"')
  it('knows english', function()
    assert.is.equal('hello "friend"', greet('hello', 'friend'))
  end)
  it('knows french', function()
    assert.is.equal('salut "ami"', greet('salut', 'ami'))
  end)
  it('missing params are replaced by nil', function()
    assert.is.equal('ciao ""', greet('ciao'))
  end)
end)

describe('currying fixed param functions', function()
  local function add_weight(a, b, f)
    return a + f * b
  end
  it('works without placeholders', function()
    assert.is.equal(21, C.curry(add_weight, 1)(2, 10))
  end)
  it('works with placeholders', function()
    assert.is.equal(21, C.curry(add_weight, C._, C._, 5)(1, 4))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
