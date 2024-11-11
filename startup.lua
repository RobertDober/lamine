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

local command = 'nvim -u ~/gh/lua/lamine/lamine.lua'
for _, file in ipairs(arg) do
  command = command .. ' ' .. file_and_lnb(file)
end
print(command)
os.execute(command)
