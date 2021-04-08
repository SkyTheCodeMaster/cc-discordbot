local sockURL = "ws://localhost:8080/ws"
local prefix = "+"

local s,err = http.websocket(sockURL)
if not s then error(err) end

while true do
  local json = s.receive()
  local data = textutils.unserializeJSON(json)
  local message = data.message:gsub(prefix,"")
  -- Insert your bot code here.
end
