-- local dbg = require("debugger")
-- dbg.auto_where = 2

local assert_expect_keys = require'stub_nvim_keys'.assert_expect_keys
local A = require'lamine.autocompletion'
_G.assert = assert

describe('input mode keymappings', function()
  local shortcuts = {
    ['<Tab><Space>'] = '<Esc>',
    ['<Tab>='] = '<Esc>A',
    ['<Tab>$'] = '<Esc>$',
    ['<Tab>r'] = '<C-r>',
    ['<Tab>c'] = '<C-c>',
    ['<Tab>p'] = '<C-p>',
    ['<Tab>:'] = '\\',
    ['<Tab>n'] = '~',
    ['$<Space>'] = '<Esc>:w!<Cr>',
    ['$-'] =  '<Esc>:wqa<cr>',
    ['$!!'] =  '<Esc>:qa!<cr>',
    -- ['=('] = '{',
    -- ['=)'] = '}',
    -- [':)'] = ']',
    -- [':('] = ']',
    [':l'] = '|',
    ['-a'] = '<Esc>A',
  }

  for shortcut, mapping in pairs(shortcuts) do
    it(shortcut .. ' in input mode is mapped to ' .. mapping, function()
      assert.is.equal(mapping, vim.keymaps.i[shortcut])
    end)
  end
end)

describe('triggered functions', function()
  it('-p does <c-p>', function()
    assert_expect_keys{
      mode = 'i',
      keys = '-p',
      code = '<c-p>',
    }
  end)
end)

describe('defined functions', function()
  it('calls the correct function for autocompletion', function()
    assert.is.equal(A.autocomplete, vim.keymaps.i[',,'])
  end)
  it('calls the correct function for autocontinue', function()
    assert.is.equal(A.autocontinue, vim.keymaps.i[',;'])
  end)
end)
-- SPDX-License-Identifier: AGPL-3.0-or-later
