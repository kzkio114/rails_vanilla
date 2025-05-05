import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    requestAnimationFrame(() => {
      const container = document.querySelector(".fortune-effect-container");
      const resultText = container?.dataset?.leafResult?.trim();

      const xButton = document.getElementById("x-share-button");
      if (xButton) {
        xButton.classList.remove("visible");
        xButton.disabled = true;
      }

      if (resultText) {
        this.spawnFallingLeaves(resultText);
      }
    });
  }

  spawnFallingLeaves(resultText) {
    const container = document.querySelector(".fortune-effect-container");
    if (!container) return;

    const { leafCount, colors, duration } = this.getLeafSettings(resultText);
    const reshuffleButton = document.getElementById("reshuffle-button");

    if (reshuffleButton) {
      reshuffleButton.disabled = true;
      reshuffleButton.classList.remove("visible");
    }

    if (!leafCount) {
      if (reshuffleButton) {
        setTimeout(() => {
          reshuffleButton.disabled = false;
          reshuffleButton.classList.add("visible");
        }, 700);
      }
      return;
    }

    for (let i = 0; i < leafCount; i++) {
      setTimeout(() => {
        const color = this.getRandomColor(colors);
        const { animationName, styleElement } = this.createLeafAnimation();
        const leaf = this.createLeaf(color, animationName, duration);

        container.appendChild(leaf);
        document.head.appendChild(styleElement);

        setTimeout(() => {
          leaf.remove();
          styleElement.remove();
        }, (duration * 1000) + 1000);
      }, i * 50);
    }

    if (reshuffleButton) {
      const totalAnimationTime = (leafCount * 100) + 1000;

      setTimeout(() => {
        reshuffleButton.disabled = false;
        reshuffleButton.classList.add("visible");

        const xButton = document.getElementById("x-share-button");
        if (xButton) {
          xButton.disabled = false;
          xButton.classList.add("visible");
        }
      }, totalAnimationTime);
    }
  }


  getLeafSettings(resultText) {
    switch (resultText) {
      case "大大吉":
        return { leafCount: 160, colors: ["#FFD700", "#FFC107", "#FFF8DC"], duration: 7 };
      case "大吉":
        return { leafCount: 120, colors: ["#4CAF50", "#8BC34A", "#FF9800", "#FFC107"], duration: 7 };
      case "中吉":
        return { leafCount: 50, colors: ["#FF9800", "#FF7043", "#EF5350"], duration: 7 };
      case "小吉":
        return { leafCount: 35, colors: ["#8D6E63", "#A1887F", "#689F38"], duration: 7 };
      case "吉":
        return { leafCount: 15, colors: ["#AED581", "#C5E1A5", "#DCEDC8"], duration: 7 };
      case "凶":
        return { leafCount: 0 };
      default:
        return {};
    }
  }

  getRandomColor(colors) {
    return colors[Math.floor(Math.random() * colors.length)];
  }

  getRandomLeafPath() {
    const leafShapes = [
      "M12 2C8 2 4 8 6 12c2 4 6 6 6 10 0-4 4-6 6-10 2-4-2-10-6-10z", // 柔らかい葉
      "M12 2C9 2 5 7 5 12s4 10 7 10 7-5 7-10-4-10-7-10z", // 丸みのある葉
      "M12 2 Q4 10 12 18 Q20 10 12 2 M11.5 18 L12 24", //棒付き葉っぱ
      "M12 2 L22 12 Q12 22 2 12 Z M12 2 L12 32" //イチョウ
    ];
    return leafShapes[Math.floor(Math.random() * leafShapes.length)];
  }

  createLeafAnimation() {
    const animationName = `leaf-fall-${Math.random().toString(36).substr(2, 5)}`;
    const swingX = `${Math.random() > 0.5 ? '-' : ''}${Math.floor(Math.random() * 30 + 20)}px`;
    const rotateMid = Math.floor(Math.random() * 180 + 90);
    const rotateEnd = rotateMid + Math.floor(Math.random() * 180 + 90);

    const style = document.createElement("style");
    style.innerHTML = `
      @keyframes ${animationName} {
        0% { transform: translateX(0) translateY(-50px) rotate(0deg); opacity: 1; }
        50% { transform: translateX(${swingX}) translateY(50vh) rotate(${rotateMid}deg); }
        100% { transform: translateX(0) translateY(100vh) rotate(${rotateEnd}deg); opacity: 0; }
      }
    `;
    return { animationName, styleElement: style };
  }

  createLeaf(color, animationName, duration) {
    const leaf = document.createElement("div");
    leaf.className = "leaf-drop";

    leaf.style.left = Math.random() * 100 + "vw";
    leaf.style.animation = `${animationName} ${duration + Math.random() * 3}s ease-in forwards`;
    leaf.style.animationDelay = Math.random() * 2 + "s";
    leaf.style.opacity = Math.random() * 0.5 + 0.5;

    const scale = (Math.random() * 0.5 + 0.75).toFixed(2);
    leaf.style.transform = `scale(${scale})`;

    const leafPath = this.getRandomLeafPath();

    leaf.innerHTML = `
    <svg class="leaf-svg" viewBox="0 0 24 24" fill="${color}" xmlns="http://www.w3.org/2000/svg">
      <path d="${leafPath}" fill="${color}" />
      <path d="M12 2 L12 -4" stroke="${color}" stroke-width="1.5" />
    </svg>
  `;
    return leaf;
  }
}
