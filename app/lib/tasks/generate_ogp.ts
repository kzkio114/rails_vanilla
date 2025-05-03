import FormData from "form-data";
import dotenv from "dotenv";
import puppeteer from "puppeteer";

dotenv.config();

const baseUrl = process.env.BASE_URL || "http://localhost:3000";
const url = `${baseUrl}/ogp_templates/1?static=true`; // Turbo等の影響を避けるためクエリ追加

async function takeScreenshot() {
  console.log("📸 アクセス先:", url);

  const browser = await puppeteer.launch({
    executablePath: "/usr/bin/chromium",
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
    headless: "new",
  });

  try {
    const page = await browser.newPage();

    // デバッグ情報を出力
    page.on("console", (msg) => console.log("🖥 console:", msg.text()));
    page.on("pageerror", (err) => console.error("⚠️ pageerror:", err));

    const response = await page.goto(url, { waitUntil: "networkidle0" });

    if (!response || !response.ok()) {
      console.error(`❌ ページの読み込みに失敗: status = ${response?.status()}`);
      return;
    }

    // より確実な要素を待つ（例: .omikuji-result）
    await page.waitForFunction(() => {
      return document.querySelector("h2.sub-title") !== null;
    }, { timeout: 60000 });    

    const html = await page.content();
    if (
      html.includes("Web Console") ||
      html.includes("Exception") ||
      html.includes("error")
    ) {
      console.error(
        "❌ Railsのエラー画面が表示されています。OGPテンプレートの描画に失敗している可能性があります。"
      );
      return;
    }

    const buffer = await page.screenshot();
    console.log("✅ スクリーンショットを取得");

    const form = new FormData();
    form.append("image", buffer, {
      filename: "screenshot.png",
      contentType: "image/png",
    });
    form.append("id", "1");

    const uploadResponse = await fetch(`${baseUrl}/internal/ogp_upload`, {
      method: "POST",
      body: form,
      headers: form.getHeaders(),
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
