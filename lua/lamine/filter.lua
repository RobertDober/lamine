-- local dbg = require("debugger")
-- dbg.auto_where = 2
local api = require'lamine.api'
local map = require'lamine.functional'.map

local function filter_lines(lnb1, lnb2, filter_fun, write_file)
  local lines = api.get_lines(lnb1, lnb2)
  local result = filter_fun(lines)
  api.set_lines(lnb1, lnb2, result.lines)
  local message = "*not* saved"
  if write_file then
    vim.api.nvim_exec('write!', true)
    message = "buffer saved!"
  end
  if result.message then
    vim.api.nvim_exec('echo "' .. result.message .. ' (' .. message .. ')"', false)
  end
end

local function filter_selected_lines(filter_fun, write_file)
  local selection_lnbs = api.selected_range()
  filter_lines(selection_lnbs[1], selection_lnbs[2], filter_fun, write_file)
end

local function map_lines(lnb1, lnb2, map_fun, write_file)
  local lines = api.get_lines(lnb1, lnb2)
  local result = map(lines, map_fun) 
  api.set_lines(lnb1, lnb2, result)
  local message = "*not* saved"
  if write_file then
    vim.api.nvim_exec('write!', true)
    message = "buffer saved!"
  end
end

local function map_selected_lines(map_fun, write_file)
  local selection_lnbs = api.selected_range()
  map_lines(selection_lnbs[1], selection_lnbs[2], map_fun, write_file)
end

return {
  filter_lines = filter_lines,
  filter_selected_lines = filter_selected_lines,
  map_lines = map_lines,
  map_selected_lines = map_selected_lines,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
