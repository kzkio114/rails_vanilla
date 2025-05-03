import puppeteer from "puppeteer";
import { FormData } from "undici"; // Bunでは不要、Nodeなら必要（v18未満）

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

    const response = await page.goto(url, {
      waitUntil: "networkidle0",
    });

    if (!response || !response.ok()) {
      console.error(`❌ ページの読み込みに失敗: status = ${response?.status()}`);
      return;
    }

    await page.waitForSelector("h1");
    await new Promise(resolve => setTimeout(resolve, 21000));

    const html = await page.content();
    if (html.includes("Web Console") || html.includes("Exception") || html.includes("error")) {
      console.error("❌ Railsのエラー画面が表示されています。OGPテンプレートの描画に失敗している可能性があります。");
      return;
    }

    const buffer = await page.screenshot();
    console.log("✅ スクリーンショットを取得");

    // FormDataの生成
    const form = new FormData();
    form.append("image", new Blob([buffer], { type: "image/png" }), "screenshot.png");
    form.append("id", "1");

    const uploadResponse = await fetch("http://localhost:3000/internal/ogp_upload", {
      method: "POST",
      body: form,
      // Bun では Content-Type は自動設定されるので headers は不要
    });

    if (!uploadResponse.ok) {
      console.error("❌ Railsへの画像アップロード失敗:", await uploadResponse.text());
    } else {
      const json = await uploadResponse.json();
      console.log("✅ Railsに画像をアップロード完了:", json.url);
    }

  } catch (err) {
    console.error("❌ スクリーンショット取得中にエラー:", err);
  } finally {
    await browser.close();
  }
}

takeScreenshot();
