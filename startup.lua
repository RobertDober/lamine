local LNB = "^.*:(%d+)$"
local function file_and_lnb(file)
  if string.match(file, LNB) then
    local lnb = string.gsub(file, LNB, "%1")
    print(lnb)
    local file = string.gsub(file, ":%d+$", "") 
    return file .. ' -c "tabnew '.. file ..'|normal ' .. lnb .. 'Gzz"'
  end
  return file 
end

local function mk_directive(dir, arg)
  if dir == "cs" then
    return '-c "colorscheme ' .. arg .. '"'
  end
  if string.match(arg, "^%d+$") then
    return '-c "tabnew '.. dir ..'|normal ' .. arg .. 'Gzz"'
  end
  return ""
end

local function mk_command(arg)
  local directive, argument = string.match(arg, "^([^:]+):(.*)$")
  if directive then
    return mk_directive(directive, argument)
  end
  return arg
end

local command = 'nvim -u ~/gh/lua/lamine/lamine.lua'


for _, file in ipairs(arg) do
  command = command .. ' ' .. mk_command(file)
end
if os.getenv("DEBUG_LAMINE") or os.getenv("DEBUG_LAMINE_STARTUP") then
  print(command)
end
os.execute(command)
