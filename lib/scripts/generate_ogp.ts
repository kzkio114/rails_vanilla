// app/lib/tasks/generate_ogp_once.ts
import puppeteer from "puppeteer";
import { FormData } from "undici";

const snakeId = Bun.argv[2];
if (!snakeId) {
  console.error("❌ Snake ID を引数に渡してください。例: bun run generate_ogp_once.ts 1");
  process.exit(1);
}

const targetUrl = `https://omikuji.fly.dev/ogp_templates/${snakeId}`;
const browser = await puppeteer.launch({ executablePath: "/usr/bin/chromium", args: ["--no-sandbox"] });

try {
  const page = await browser.newPage();
  await page.goto(targetUrl, { waitUntil: "networkidle0" });
  await page.waitForSelector("h1");
  await new Promise(resolve => setTimeout(resolve, 20000));

  const buffer = await page.screenshot();

  const form = new FormData();
  form.append("image", new Blob([buffer], { type: "image/png" }), "screenshot.png");
  form.append("id", snakeId);

  const upload = await fetch("https://omikuji.fly.dev/internal/ogp_upload", {
    method: "POST",
    body: form,
  });

  if (!upload.ok) {
    console.error("❌ アップロード失敗");
    process.exit(1);
  }

  const result = await upload.json();
  console.log("✅ アップロード成功:", result.url);
} catch (e) {
  console.error("❌ エラー:", e);
  process.exit(1);
} finally {
  await browser.close();
}
