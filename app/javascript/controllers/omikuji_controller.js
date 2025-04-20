import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const result = document.querySelector(".omikuji-result");
    const resultText = result?.textContent?.trim();

    this.spawnFallingLeaves(resultText);
  }

  spawnFallingLeaves(resultText) {
    const container = document.querySelector(".fortune-effect-container");
    if (!container) return;

    let leafCount = 0;
    let colors = [];
    let duration = 7;

    switch (resultText) {
      case "大大吉":
        leafCount = 160;
        colors = ["#FFD700", "#FFC107", "#FFF8DC"];
        duration = 14;
        break;
      case "大吉":
        leafCount = 120;
        colors = ["#4CAF50", "#8BC34A", "#FF9800", "#FFC107"];
        break;
      case "中吉":
        leafCount = 50;
        colors = ["#FF9800", "#FF7043", "#EF5350"];
        break;
      case "小吉":
        leafCount = 35;
        colors = ["#8D6E63", "#A1887F", "#689F38"];
        break;
      case "吉":
        leafCount = 15;
        colors = ["#AED581", "#C5E1A5", "#DCEDC8"];
        break;
      default:
        return;
    }

    for (let i = 0; i < leafCount; i++) {
      const color = colors[Math.floor(Math.random() * colors.length)];
      const leaf = document.createElement("div");

      const leafId = `leaf-fall-${Math.random().toString(36).substr(2, 5)}`;
      const animationName = `${leafId}`;

      const style = document.createElement("style");
      style.innerHTML = `
        @keyframes ${animationName} {
          0% { transform: translateY(-50px) rotate(0deg); opacity: 1; }
          100% { transform: translateY(100vh) rotate(${Math.random() * 720}deg); opacity: 0; }
        }
      `;
      document.head.appendChild(style);

      leaf.className = "leaf-drop";
      leaf.innerHTML = `
        <svg class="leaf-svg" viewBox="0 0 24 24" width="24" height="24" fill="${color}">
          <path d="M12 2C9 2 4 5 4 12s5 10 8 10 8-5 8-10-4-10-8-10z"/>
        </svg>
      `;

      leaf.style.left = Math.random() * 100 + "vw";
      leaf.style.animation = `${animationName} ${duration}s ease-in forwards`;
      leaf.style.animationDelay = Math.random() * 2 + "s";
      leaf.style.opacity = Math.random() * 0.5 + 0.5;

      container.appendChild(leaf);

      setTimeout(() => {
        leaf.remove();
        style.remove();
      }, duration * 1000 + 2000);
    }
  }
}
