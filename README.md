🐍 巳年おみくじアプリ
このアプリは、バニラRails 8 を意識して構築されたシンプルかつ演出豊かなおみくじWebアプリです。Gemやライブラリへの依存を最小限に抑えつつ、Hotwire (Turbo + Stimulus) を中心としたリアルタイムUXとSNSシェア、OGP生成まで実現しています。

✨ 主な特徴
おみくじ結果に応じた動的な葉っぱアニメーション（Stimulus + CSS）

Puppeteer + Bun によるOGP画像生成 → Cloudflare R2 に保存 → SNS表示に活用

Twitter (X) シェアボタンはアニメーション完了後に出現（JS制御）

Turbo Streams によるリアルタイム履歴更新

Turbo Frame を使った非同期なプライバシーポリシー表示

ユーザー登録・認証機能なしでも動作可能なセッション管理のみ設計

GitHubアイコン付きのリンクで開発元明記

🧰 技術構成
技術	内容
フレームワーク	Ruby on Rails 8（バニラ志向で設計）
フロント	Hotwire（Turbo & Stimulus）
JSビルド	Bun（Node.js代替として導入）
画像生成	Puppeteer（TypeScript）
画像保存	Cloudflare R2 + ActiveStorage
デプロイ	Fly.io または Kamal + GCP Compute Engine

🧑‍💻 開発方針
バニラ志向：Gemや過剰な依存を避け、HotwireとRails標準機能を最大限活用

軽量・高速表示：再描画を抑え、TurboとStimulusで効率よくDOM制御

可搬性：Puppeteer/BunはRailsとは独立して動作し、他環境でも流用しやすい設計

🔗 外部リンク
🔧 GitHub リポジトリ

📜 プライバシーポリシー