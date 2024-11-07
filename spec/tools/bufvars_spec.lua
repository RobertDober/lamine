-- local dbg = require("debugger")
-- dbg.auto_where = 2

local b = require'lamine.tools.bufvars'

describe('init if necessary', function()
  before_each(function()
    vim.b = {}
  end)
  it('will set the bufvar', function()
    b.init_bufvar('uuu', 42)
    assert.is.equal(42, vim.b.uuu)
  end)
  it('will not change a set bufvar', function()
    b.set_bufvar('xxx', 42)
    assert.is.equal(42, vim.b.xxx)
    b.init_bufvar('xxx', 43)
    assert.is.equal(42, vim.b.xxx)
  end)
  it('can modify a bufvar', function()
    b.set_bufvar('yyy', {100})
    assert.are.same({100}, b.get_bufvar('yyy'))
    b.update_bufvar('yyy', function(old_value)
      table.insert(old_value, 200)
      return old_value
    end)
    assert.are.same({100, 200}, b.get_bufvar('yyy'))
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
