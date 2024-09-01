-- local dbg = require("debugger")
-- dbg.auto_where = 2

local fni = require'fn_implementation'

local here = require'cwd'()
local rel_path = "ab/c-9.d/hello.txt"
local vi = {
  path = rel_path,
} 
describe("expand", function()
  it("has a relative path", function()
    assert.is_equal(rel_path, fni.expand(vi)("%"))
  end)

  it("has an absolute path", function()
    assert.is_equal(here .. "/" .. rel_path, fni.expand(vi)("%:p"))
  end)

  it("has a relative dirname path", function()
    assert.is_equal("ab/c-9.d", fni.expand(vi)("%:h"))
  end)

  it("has an absolute dirname path", function()
    assert.is_equal(here .. "/ab/c-9.d", fni.expand(vi)("%:p:h"))
  end)

  it("has also just the filename (aka `basename`)", function()
    assert.is_equal("hello.txt", fni.expand(vi)("%:t"))
  end)
end)

-- SPDX-License-Identifier: AGPL-3.0-or-later
