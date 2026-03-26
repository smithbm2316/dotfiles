import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  // toggle reasoning/thinking between the highest level and off
  pi.registerShortcut("ctrl+r", {
    description: "Toggle reasoning off/on",
    handler(ctx) {
      if (!ctx.model?.reasoning) return;
      pi.setThinkingLevel(pi.getThinkingLevel() === "off" ? "xhigh" : "off");
    },
  });

  // toggle between my selected dark and light themes
  pi.registerCommand("theme", {
    description: "Toggle theme light/dark",
    async handler(_, ctx) {
      const DARK_THEME = "catppuccin-macchiato";
      const LIGHT_THEME = "flexoki-light";

      const newThemeName =
        ctx.ui.theme.name === LIGHT_THEME ? DARK_THEME : LIGHT_THEME;
      const newTheme = ctx.ui.getTheme(newThemeName);

      const { success, error } = ctx.ui.setTheme(newTheme ?? newThemeName);
      if (!success) {
        ctx.ui.notify(
          error ?? `Could not switch to theme "${newThemeName}"`,
          "error",
        );
      } else {
        ctx.ui.notify(`Switched to theme "${newThemeName}"`, "info");
      }
    },
  });
}
