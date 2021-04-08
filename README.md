# cc-discordbot
Usage of a Python script with `discord.py`, and websockets to make a CC wrapper around discord's bot api.

Note: This can only send back 1 message per message received. This might change in the future.

# Installation
Install Python and the Python script (Tested on version 3.9.0)
On Linux, Python is typically pre installed.

Retrieve the python script,
`wget https://raw.githubusercontent.com/SkyTheCodeMaster/cc-discordbot/main/bot.py`

In the same directory as the python script, create `token.txt` with the bot token in it.

On Computercraft, retrieve the CC script.
`wget https://raw.githubusercontent.com/SkyTheCodeMaster/cc-discordbot/main/bot.lua`

Now you need to edit `bot.lua` to suit your needs of a discord bot.

# Usage
Open `bot.py`, and *then* open `bot.lua`. You can restart `bot.lua` without restarting `bot.py`, but do not open 2 instances of `bot.lua`.
