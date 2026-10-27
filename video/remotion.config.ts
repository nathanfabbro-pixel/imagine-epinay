import { execSync } from "node:child_process";
import { Config } from "@remotion/cli/config";

Config.setEntryPoint("remotion/src/index.ts");
Config.setVideoImageFormat("jpeg");
Config.setOverwriteOutput(true);

// Reuse the Chrome Headless Shell managed by HyperFrames (`npx hyperframes browser ensure`).
const browser =
  process.env.REMOTION_BROWSER ??
  execSync("npx hyperframes browser path", { encoding: "utf8", stdio: ["ignore", "pipe", "ignore"] })
    .trim()
    .split("\n")
    .pop();
if (browser) Config.setBrowserExecutable(browser);
