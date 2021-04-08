# Import aiohttp for communicating with CC, discord for communicating with discord, json for constructing the json to send to CC.
from aiohttp import web
import discord
import json
import asyncio

# Debug variable
debug = False

# Retrieve the token
tokenFile = open("token.txt","r")
token = tokenFile.read()
tokenFile.close()

async def hello(request):
  return web.Response(text="Hello, world")


savesocket = {}
async def websocket_handler(request):
  ws = web.WebSocketResponse()
  print("Websocket connection")
  await ws.prepare(request)
  global savesocket
  savesocket = ws
  while True:
    await asyncio.sleep(5) #This keeps the socket open.
  return ws
  

class MyClient(discord.Client):
  async def on_ready(self):
    print('Logged on as {0}!'.format(self.user))
    await self.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name="\">>\", Please dont send me emojis!"))

  async def on_message(self, message):
    if message.author.bot or message.author == client.user:
      return
    if message.content.startswith(">>"):
      print("Message received, constructing JSON")
      # build json
      data = {}
      author = {}
      author["id"] = str(message.author.id)
      author["name"] = message.author.name
      author["discriminator"] = message.author.discriminator
      data["author"] = author
      data["message"] = message.content
      print(message.channel.id)
      data["chanid"] = str(message.channel.id)
      json_data = json.dumps(data)
      if debug:
        await message.channel.send(json_data)
      if savesocket != {}:
        await savesocket.send_str(json_data)
        msg = await savesocket.receive()
        await message.channel.send(msg.data)

client = MyClient()
async def run_bot():
  await client.start(token)

app = web.Application()
app.add_routes([web.get('/ws', websocket_handler)])


async def run_sockets():
  runner = web.AppRunner(app)
  await runner.setup()
  site = web.TCPSite(runner,'localhost',8080)
  return await site.start()

webapp = asyncio.ensure_future(run_sockets())
discordbot = asyncio.ensure_future(run_bot())

loop = asyncio.get_event_loop()
loop.run_forever()
