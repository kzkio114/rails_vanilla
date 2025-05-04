// generate_ogp_server.ts
import { serve } from "bun";
import puppeteer from "puppeteer";
import { FormData } from "undici";

serve({
  port: process.env.PORT || 3000,
  fetch: async (req) => {
    const url = new URL(req.url);

    if (url.pathname !== "/generate_ogp") {
      return new Response("Not Found", { status: 404 });
    }

    const snakeId = url.searchParams.get("id");
    if (!snakeId) {
      return new Response("Missing id", { status: 400 });
    }

    console.log(`📥 ジョブ受信: Snake ID = ${snakeId}`);
    const targetUrl = `https://omikuji.fly.dev/ogp_templates/${snakeId}`;

    const browser = await puppeteer.launch({
      executablePath: "/usr/bin/chromium",
      args: ["--no-sandbox", "--disable-setuid-sandbox"],
      headless: "new",
    });

    try {
      const page = await browser.newPage();
      const response = await page.goto(targetUrl, { waitUntil: "networkidle0" });

      if (!response || !response.ok()) {
        return new Response("Failed to load page", { status: 500 });
      }

      await page.waitForSelector("h1");
      await new Promise(resolve => setTimeout(resolve, 21000));

      const buffer = await page.screenshot();

      const form = new FormData();
      form.append("image", new Blob([buffer], { type: "image/png" }), "screenshot.png");
      form.append("id", snakeId);

      const uploadResponse = await fetch("https://omikuji.fly.dev/internal/ogp_upload", {
        method: "POST",
        body: form,
      });

      if (!uploadResponse.ok) {
        return new Response("Upload failed", { status: 500 });
      }

      const json = await uploadResponse.json();
      console.log("✅ Upload 完了:", json.url);
      return new Response("Done", { status: 200 });

    } catch (e) {
      console.error("❌ エラー:", e);
      return new Response("Server Error", { status: 500 });
    } finally {
      await browser.close();
    }
  }
});
