// adapted from: https://gist.github.com/luizribeiro/452a036d007cdddc6947e1b43972425a
// https://github.com/badlogic/pi-mono/issues/1379
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { readFileSync, writeFileSync } from "fs";
import { join, dirname } from "path";

function getDefaultModel(hasUI: boolean) {
  return hasUI
    ? ({
        provider: "openai-codex",
        model: "gpt-5.6-terra",
        thinking: "xhigh",
      } as const)
    : ({
        provider: "openai-codex",
        model: "gpt-5.4-mini",
        thinking: "off",
      } as const);
}

export default function (pi: ExtensionAPI) {
  /** Resolve settings.json relative to this extension file */
  const settingsPath = join(
    dirname(import.meta.filename),
    "..",
    "settings.json",
  );

  pi.on("session_start", async (_event, ctx) => {
    const defaults = getDefaultModel(ctx.hasUI);

    const model = ctx.modelRegistry.find(defaults.provider, defaults.model);
    if (!model) return;
    if (ctx.model?.provider === model.provider && ctx.model?.id === model.id)
      return;
    await pi.setModel(model);
    await pi.setThinkingLevel(defaults.thinking);
  });

  pi.on("session_shutdown", async () => {
    try {
      const settings = JSON.parse(readFileSync(settingsPath, "utf-8"));
      const defaults = getDefaultModel(true);
      settings.defaultProvider = defaults.provider;
      settings.defaultModel = defaults.model;
      settings.defaultThinkingLevel = defaults.thinking;
      writeFileSync(settingsPath, JSON.stringify(settings, null, 2) + "\n");
    } catch {}
  });
}
