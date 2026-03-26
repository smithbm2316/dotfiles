import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.registerShortcut("ctrl+r", {
    description: "Toggle reasoning off/on",
    handler(ctx) {
      if (!ctx.model?.reasoning) return;
      pi.setThinkingLevel(pi.getThinkingLevel() === "off" ? "xhigh" : "off");
    },
  });
}
