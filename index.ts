import puppeteer from "puppeteer";

async function takeScreenshot() {
  const browser = await puppeteer.launch({
    executablePath: '/usr/bin/chromium',
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    headless: "new",
  });

  const page = await browser.newPage();
  await page.goto("http://localhost:3000/ogp_templates/1", {
    waitUntil: "networkidle0",
  });

  await page.waitForSelector("h1");

  await new Promise(resolve => setTimeout(resolve, 21000));

  await page.screenshot({ path: "screenshot.png" });

  await browser.close();
}

takeScreenshot();
