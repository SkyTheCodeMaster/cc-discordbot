--- Discord API for CC
-- @module[kind=misc] discord

-- Get the bot token from "token.txt"
local tokenFile = fs.open("token.txt","r")
if not tokenFile then error("Please create \"token.txt\" and place your bot token in it!") end
local token = tokenFile.readAll()
tokenFile.close()

-- Get websocket endpoint
local endpoint,err = http.get("https://discord.com/api/v8/gateway/bot",{["Authorization"] = "Bot " .. token})
if not endpoint then error(err) end

local data = textutils.unserializeJSON(endpoint.readAll())
local shards = data.shards
local url = data.url
local sessionStartLimit = data["session_start_limit"]

-- Prepare the identifier
local identifier = {
  ["op"] = 2,
  ["d"] = {
    ["token"] = "Bot " .. token,
    ["intents"] = 512,
  },
}
-- Connect to the socket.
local socket,err = http.websocket(url .. "/?v=8&encoding=json",{["Authorization"] = "Bot " .. token,["Content-Type"] = "application/json"})
if not socket then error(err) end
-- Send the identifier to Discord.
socket.send(textutils.serializeJSON(identifier))

--- Posts a message to the channel ID.
-- @tparam number channel Channel ID to post to.
-- @tparam string message Message to post into the channel.
local function postMessage(channel,msg)
  local body = {
    ["content"] = msg,
    ["tts"] = false,
  }
  local headers = {
    ["Authorization"] = "Bot " .. token,
    ["Content-Type"] = "application/json",
  }
  http.post("https://discord.com/api/v8/channels/"..tostring(channel) .."/messages/?v=8&encoding=json",body,headers)
end
  
return {
  postMessage = postMessage,   
}
