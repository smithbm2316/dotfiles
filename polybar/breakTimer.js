#!/usr/bin/env node

const polybarHelpers = require("polybar-helpers");
const notifier = require("node-notifier");

var config = {
  isEnable: true,
  time: 30,
};

if (process.argv[3]) {
  config.time = Number(process.argv[3]);
}

const file = process.argv[2] || ".env/break-timer";

const sendNotification = (force) => {
  if (force || config.isEnable) {
    notifier.notify({
      title: "Polybar Break Timer",
      message: "Take a break",
      time: config.time * 1000,
      urgency: "critical",
    });
  }
  text();
  return;
};

const main = async () => {
  while (config.isEnable) {
    await new Promise((resolve) =>
      setTimeout(resolve, config.time * 60 * 1000)
    );
    sendNotification();
  }
};

const text = () => {
  if (config.isEnable) {
    console.log(`ON (${config.time}m)`);
  } else {
    console.log("OFF");
  }
};

polybarHelpers((app) => {
  app.file(file);
  app.on("left", (ctx) => {
    if (config.isEnable) config.isEnable = false;
    text();
    return;
  });
  app.on("right", (ctx) => {
    if (!config.isEnable) config.isEnable = true;
    text();
    main();
    return;
  });
  app.on("middle", (ctx) => {
    text();
    return sendNotification(true);
  });
  app.on("scrollUp", (ctx) => {
    if (config.time >= 30) {
      config.time = config.time + 5;
    } else {
      config.time++;
    }
    text();
    return;
  });
  app.on("scrollDown", (ctx) => {
    if (config.time > 30) {
      config.time = config.time - 5;
    } else {
      config.time--;
    }
    if (config.time < 0) {
      config.time = 5;
    }
    text();
    return;
  });
  app.error((msg, ctx) => {
    //console.error(`ERROR in Polybar Break Timer: ${msg}`)
  });
});

main();
text();
