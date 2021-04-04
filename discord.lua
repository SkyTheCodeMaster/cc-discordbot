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

local socket,err = http.websocket(url)
if not socket then error(err) end

--- Posts a message to the channel ID.
-- @tparam number channel Channel ID to post to.
-- @tparam string message Message to post into the channel.
local function postMessage(channel,msg)
  local headers = {
    ["content"] = msg
  }
  http.post("https://discord.com/api/v8/channels/"..tostring(channel) .."/messages"
end
  
return {
  postMessage = postMessage,   
}
