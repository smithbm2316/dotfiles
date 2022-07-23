#!/usr/local/bin/luajit
local followed = {
  tj = 'teej_dv',
  begin = 'beginbot',
  prime = 'theprimeagen',
  altf4 = 'thealtf4stream',
  val = 'valorant',
  panda = 'pandasaurrrr',
}

local prompt = 'Which stream do you want to watch?\n'
for k, _ in pairs(followed) do
  prompt = prompt .. k .. ', '
end
prompt = prompt:sub(1, -3) .. '\n'

io.write(prompt)
local channel = io.read()

local stream_cmd = 'streamlink twitch.tv/'
if followed[channel] then
  stream_cmd = stream_cmd .. followed[channel]
else
  stream_cmd = stream_cmd .. channel
end
stream_cmd = stream_cmd .. ' best'

os.execute(stream_cmd)
