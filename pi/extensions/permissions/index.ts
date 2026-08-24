import path from "node:path";
import os from "node:os";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { notify } from "../notify.ts";

const SESSION_ENTRY_CUSTOM_ID = "permissions.allowed-tool-call" as const;

interface CustomSessionEntry {
  toolName: string;
  input:
    | string
    | {
        path?: string;
        pattern?: string;
      };
}

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (!ctx.hasUI) {
      return {
        block: true,
        reason: "Tool call disallowed due to no UI for confirmation from user.",
      };
    }

    // default permissions:
    // - require confirmation all `bash` tool calls
    // - allow all `codemode` tool calls
    // - allow all other tool calls that are for files in the current directory,
    // require confirmation for these tool calls outside of the current
    // directory
    let input: CustomSessionEntry["input"] = "";
    switch (event.toolName) {
      case "bash": {
        if (typeof event.input.command === "string") {
          input = event.input.command;
        }
        break;
      }
      case "codemode": {
        return;
      }
      case "find":
      case "grep": {
        if (isSafePath(event.input.path) && isSafePattern(event.input.pattern)) {
          return;
        } else if (event.input.pattern === "string") {
          input = { path: event.input.path as string, pattern: event.input.pattern as string };
        }
        break;
      }
      case "edit":
      case "ls":
      case "read":
      case "write": {
        if (isSafePath(event.input.path)) {
          return;
        } else if (typeof event.input.path === "string") {
          input = event.input.path;
        }
        break;
      }
    }

    const alreadyAllowed =
      input &&
      ctx.sessionManager.getBranch().some((sessionEntry) => {
        if (
          sessionEntry.type !== "custom" ||
          sessionEntry.customType !== SESSION_ENTRY_CUSTOM_ID ||
          typeof sessionEntry.data !== "string"
        ) {
          return false;
        }

        const sessionData = (JSON.parse(sessionEntry.data) ?? {}) as {
          toolName?: string;
          input?: string | { path?: string; pattern?: string };
        };
        if (
          !sessionData.toolName ||
          !sessionData.input ||
          sessionData.toolName !== event.toolName
        ) {
          return false;
        }

        if (typeof sessionData.input === "string") {
          return sessionData.input === input;
        }

        if (
          (event.toolName !== "find" && event.toolName !== "grep") ||
          !sessionData.input.path ||
          event.input.path !== sessionData.input.path ||
          !sessionData.input.pattern ||
          event.input.pattern !== sessionData.input.pattern
        ) {
          return false;
        } else {
          return true;
        }
      });
    if (alreadyAllowed) return;

    notify(`Waiting for user confirmation of ${event.toolName} call.`, "warning");
    const shouldAllow = await ctx.ui.confirm(
      `Allow "${event.toolName}" tool call?:`,
      typeof input === "string" ? input : JSON.stringify(input, null, 2),
    );
    if (!shouldAllow) {
      return {
        block: true,
        reason: "Tool call disallowed by user.",
      };
    } else {
      pi.appendEntry(
        SESSION_ENTRY_CUSTOM_ID,
        typeof input === "string" ? input : JSON.stringify(input),
      );
      return;
    }
  });

  // `agent_end` fires after each low-level run; Pi may still retry, compact,
  // or continue with queued follow-ups. Notify only after the full run settles.
  pi.on("agent_settled", () => notify("pi-coding-agent", "Ready for input"));
}

export function isSafePath(input: unknown): boolean {
  if (
    typeof input !== "string" ||
    input.endsWith(".git") ||
    input.includes(".git/") ||
    input.endsWith(".jj") ||
    input.includes(".jj/")
  ) {
    return false;
  }

  const resolvedPath = path.resolve(input.replaceAll(/~|\$HOME/g, os.homedir()));
  return (
    // path is in current directory
    !path.relative(process.cwd(), resolvedPath).startsWith("..") ||
    // path is in pi install directory (for reading its own documentation, installed by mise)
    !path
      .relative(
        path.resolve(os.homedir(), ".local/share/mise/installs/npm-earendil-works-pi-coding-agent"),
        resolvedPath,
      )
      .startsWith("..")
  );
}

const BLACKLISTED_PATTERNS = [
  ".crt",
  ".db",
  ".env",
  ".key",
  ".log",
  ".p12",
  ".pem",
  ".pub",
  ".sqlite",
  ".sqlite3",
  "ed25519",
  "rsa",
];

export function isSafePattern(input: unknown): boolean {
  return typeof input === "string" ? !BLACKLISTED_PATTERNS.includes(input) : false;
}
