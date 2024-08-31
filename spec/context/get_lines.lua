#!/usr/bin/env -S nvim -l
require 'config.lazy'
-- require("lazy").setup({
--   spec = {
--     -- import your plugins
--     { import = "plugins" },
--   install = {"nvim-lua/plenary.nvim", lazy=false},
--   },
--   -- Configure any other settings here. See the documentation for more details.
--   -- colorscheme that will be used when installing plugins.
--   -- automatically check for plugin updates
--   checker = { enabled = true },
-- })
require 'plenary.test_harness'
vim.cmd('PlenaryBustedFile tests/context/get_lines_spec.lua')
