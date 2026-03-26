import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

type Verbosity = "low" | "medium" | "high";

type CodexPayload = {
  text?: { verbosity?: Verbosity; [key: string]: unknown };
  [key: string]: unknown;
};

// https://developers.openai.com/cookbook/examples/gpt-5/gpt-5_new_params_and_tools
// https://github.com/earendil-works/pi/issues/4026#issuecomment-4355618912
export default function (pi: ExtensionAPI) {
  pi.on("before_provider_request", (event, ctx) => {
    if (ctx.model?.api !== "openai-codex-responses") return;

    const payload = event.payload as CodexPayload;
    return {
      ...payload,
      text: {
        ...payload.text,
        verbosity: "low",
      },
    };
  });
}
