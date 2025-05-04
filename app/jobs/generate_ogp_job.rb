class GenerateOgpJob < ApplicationJob
  queue_as :default

  def perform(snake_id)
    Rails.logger.info("🐍 OGP生成ジョブ開始 #{snake_id}")

    # Flyで確認したパスを使用（`fly ssh console`で `which bun` の結果）
    bun_path = "/root/.bun/bin/bun"

    # 実行コマンド
    success = system(bun_path, "run", "app/lib/tasks/generate_ogp_once.ts", snake_id.to_s)

    Rails.logger.info("✅ bun実行結果: #{success}")
    Rails.logger.error("❌ bun実行失敗") unless success
  end
end
