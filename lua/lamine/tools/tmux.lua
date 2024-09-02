-- local dbg = require("debugger")
-- dbg.auto_where = 2

vim.os = os
local function compile_winaddr(winaddr)
  if not winaddr then
    return " -l"
  end
  if string.match(winaddr, "^[-+]") then
    return " -t :" .. winaddr
  end
  return " -t " .. winaddr
end

local function select_tmux_window(window)
  os.execute('tmux select-window -t ' .. window)
end

local function send_keys(keys)
  -- print("sending to tmux: --------------->")
  -- print(keys)
  os.execute(keys)
end

local function send_and_select_tmux_window(params)
  -- vim.cmd('echomsg "' .. params.window .. '"')
  send_keys('tmux send-keys -t ' .. params.window .. ' "' .. params.command .. '" C-m')
  if params.switch then
    select_tmux_window(params.window)
  end
end

local function run_command_and_switch(params)
  vim.cmd('write!')
  send_and_select_tmux_window{
    command = params.command,
    switch  = true,
    window  = params.window 
  }
end

local function switch_to_window(winaddr)
  local compiled = compile_winaddr(winaddr)
  local command = 'tmux select-window' .. compiled
  -- p('command to be executed', command)
  return os.execute(command)
end

return {
  run_command_and_switch = run_command_and_switch,
  switch_to_window = switch_to_window,
  send_and_select_tmux_window = send_and_select_tmux_window,
}
-- SPDX-License-Identifier: AGPL-3.0-or-later
