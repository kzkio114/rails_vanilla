import puppeteer from "puppeteer";
import FormData from "form-data";
import fetch from "node-fetch"; // Node.js v18未満のとき必要

async function takeScreenshot() {
  const url = "https://omikuji.fly.dev/ogp_templates/1";

  console.log("📸 アクセス先:", url);

  const browser = await puppeteer.launch({
    executablePath: '/usr/bin/chromium',
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    headless: "new",
  });

  try {
    const page = await browser.newPage();
    const response = await page.goto(url, { waitUntil: "networkidle0" });

    if (!response || !response.ok()) {
      console.error(`❌ ページの読み込みに失敗: status = ${response?.status()}`);
      return;
    }

    await page.waitForSelector("h1");
    await new Promise(resolve => setTimeout(resolve, 20000));

    const buffer = await page.screenshot();
    console.log("✅ スクリーンショットを取得");

    const form = new FormData();
    form.append("image", buffer, {
      filename: "screenshot.png",
      contentType: "image/png"
    });
    form.append("id", "1");

    const uploadResponse = await fetch("http://localhost:3000/internal/ogp_upload", {
      method: "POST",
      body: form,
      headers: form.getHeaders()
    });

    if (!uploadResponse.ok) {
      console.error("❌ アップロード失敗:", await uploadResponse.text());
    } else {
      const json = await uploadResponse.json();
      console.log("✅ アップロード成功:", json.url);
    }

  } catch (err) {
    console.error("❌ エラー:", err);
  } finally {
    await browser.close();
  }
}

takeScreenshot();

