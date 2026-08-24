import path from "node:path"
import os from "node:os"
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent"
import { notify } from "../notify.ts"

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    let input = ""

    switch (event.toolName) {
      case "bash": {
        input = event.input.command as string
        break
      }
      case "codemode": {
        return
      }
      case "edit": {
        input = event.input.path as string
        break
      }
      case "find":
      case "grep":
      case "ls":
      case "read": {
        if (
          isSafePath(event.input.path) ||
          (event.toolName === "find" && isSafePattern(event.input.pattern))
        ) {
          return
        }

        input = JSON.stringify(event.input, null, 2)
        break
      }
      case "write": {
        input = event.input.path as string
      }
    }

    if (!ctx.hasUI) {
      return {
        block: true,
        reason: "Tool call disallowed due to no UI for confirmation from user.",
      }
    }

    notify(`Waiting for user confirmation of ${event.toolName} call.`, "warning")
    const shouldAllow = await ctx.ui.confirm(`Allow "${event.toolName}" tool call?:`, input)
    return shouldAllow ? undefined : { block: true, reason: "Tool call disallowed by user." }
  })

  // `agent_end` fires after each low-level run; Pi may still retry, compact,
  // or continue with queued follow-ups. Notify only after the full run settles.
  pi.on("agent_settled", () => notify("pi-coding-agent", "Ready for input"))
}

export function isSafePath(input: unknown): boolean {
  if (typeof input !== "string") return false
  const resolvedPath = path.resolve(input.replaceAll(/~|\$HOME/g, os.homedir()))
  return !path.relative(process.cwd(), resolvedPath).startsWith("..")
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
]

export function isSafePattern(input: unknown): boolean {
  return typeof input === "string" ? !BLACKLISTED_PATTERNS.includes(input) : false
}
