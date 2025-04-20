import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.audioContext = new AudioContext();
    this.isPlaying = false;
    this.loopId = null;
    this.oscillators = [];
  }

  toggle() {
    if (this.isPlaying) {
      this.stop();
    } else {
      this.start();
    }
  }

  start() {
    const now = this.audioContext.currentTime;
    this.scheduleLoop(now);
    this.playWindNoise(now);
    this.isPlaying = true;
    this.loopId = setInterval(() => {
      const now = this.audioContext.currentTime;
      this.scheduleLoop(now);
    }, 20000);
  }

  stop() {
    clearInterval(this.loopId);
    this.loopId = null;
    this.isPlaying = false;

    if (this.windSource) this.windSource.stop();

    this.oscillators.forEach((osc) => {
      try {
        osc.stop();
      } catch (e) {}
    });
    this.oscillators = [];
  }

  scheduleLoop(startTime) {
    const notes = [
      { freq: 261.63, duration: 2.0 }, // C4
      { freq: 349.23, duration: 2.5 }, // F4
      { freq: 392.00, duration: 2.0 }, // G4
      { freq: 261.63, duration: 2.0 }, // C4
    ];

    let currentTime = startTime;

    for (const note of notes) {
      const osc = this.audioContext.createOscillator();
      const gain = this.audioContext.createGain();

      osc.type = "sine";
      osc.frequency.setValueAtTime(note.freq, currentTime);
      gain.gain.setValueAtTime(0.08, currentTime);
      gain.gain.exponentialRampToValueAtTime(0.001, currentTime + note.duration);

      osc.connect(gain);
      gain.connect(this.audioContext.destination);

      osc.start(currentTime);
      osc.stop(currentTime + note.duration);

      this.oscillators.push(osc);

      currentTime += note.duration + 1.2;
    }
  }

  playWindNoise(time) {
    const bufferSize = 2 * this.audioContext.sampleRate;
    const noiseBuffer = this.audioContext.createBuffer(1, bufferSize, this.audioContext.sampleRate);
    const output = noiseBuffer.getChannelData(0);
    for (let i = 0; i < bufferSize; i++) {
      output[i] = Math.random() * 2 - 1;
    }

    const noise = this.audioContext.createBufferSource();
    noise.buffer = noiseBuffer;
    noise.loop = true;

    const filter = this.audioContext.createBiquadFilter();
    filter.type = "lowpass";
    filter.frequency.value = 1000; // 風音ぽさ

    const gain = this.audioContext.createGain();
    gain.gain.setValueAtTime(0.02, time); // 控えめな風音

    noise.connect(filter);
    filter.connect(gain);
    gain.connect(this.audioContext.destination);

    noise.start(time);
    this.windSource = noise;
  }
}
