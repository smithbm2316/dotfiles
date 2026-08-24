import assert from "node:assert"
import { test } from "node:test"

import { isSafePath } from "./index.ts"

const cwd = process.cwd()

for (const input of [
  "~/.ssh",
  "~/.ssh/key.pub",
  "$HOME/path/to/dir/",
  "$HOME",
  "/usr/lib",
  cwd.split("/").slice(0, -1).join("/") + "/sibling/directory",
]) {
  test(`should NOT be a safe path: ${input}`, () => assert.strictEqual(isSafePath(input), false))
}

for (const input of [
  ".github/workflows/test.yml",
  cwd,
  cwd + "/path/to/nested/dir/",
  cwd + "/path/to/nested/dir/with-file.txt",
  ".",
  "",
  "current-dir.txt",
]) {
  test(`should be a safe path: ${input}`, () => assert.strictEqual(isSafePath(input), true))
}
