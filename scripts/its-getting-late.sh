#!/bin/bash
# script to remind me that it's late af, and I should go to bed
# stop debugging and start sleeping dummy
awesome-client "local naughty = require('naughty')
naughty.notify({
  title = \"You should go to bed! It's getting late\",
  timeout = 20,
  position = \"top_middle\",
  preset = naughty.config.presets.critical,
})
"
