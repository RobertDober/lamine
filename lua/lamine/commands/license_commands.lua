-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = require'lamine.api'
local ft_make_file = require'lamine.commands.ft_make_file'

local make_file_options = {
  nargs = '?',
  complete = ft_make_file.completion_function
}

local function make_file(args)
  local template_data = ft_make_file.ft_function(vim.o.ft, args.fargs[1])
  vim.print{make_template_data = template_data}
  api.set_lines(1, 1, template_data.lines) 
  api.set_cursor(template_data.lnb or 2, template_data.col or 999)
  vim.api.nvim_feedkeys('a', 'i', false)
end

vim.api.nvim_create_user_command(
  'MakeFile', 
  make_file, 
  make_file_options
  )
-- SPDX-License-Identifier: AGPL-3.0-or-later
