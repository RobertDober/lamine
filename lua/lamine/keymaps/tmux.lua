-- local dbg = require("debugger")
-- dbg.auto_where = 2

local tmux = require'lamine.tools.tmux'
local function tmux_navigate(dir)
  return function()
    tmux.switch_to_window(dir)
  end
end

vim.keymap.set('n', '<space>c', tmux_navigate('console'), {})
vim.keymap.set('n', '<space>ec', tmux_navigate('elixir-console'), {})
vim.keymap.set('n', '<space>sv', tmux_navigate('server'), {})
vim.keymap.set('n', '<space>ta', tmux_navigate(), {})
vim.keymap.set('n', '<space>th', tmux_navigate('-1'), {})
vim.keymap.set('n', '<space>tl', tmux_navigate('+1'), {})
vim.keymap.set('n', '<space>ts', tmux_navigate('shell'), {})
vim.keymap.set('n', '<space>tt', tmux_navigate('tests'), {})
vim.keymap.set('n', '<space>tvl', tmux_navigate('libvim'), {})
vim.keymap.set('n', '<space>tvm', tmux_navigate('mainvim'), {})
vim.keymap.set('n', '<space>tvs', tmux_navigate('specvim'), {})
vim.keymap.set('n', '<space>tvt', tmux_navigate('testvim'), {})
-- SPDX-License-Identifier: AGPL-3.0-or-later