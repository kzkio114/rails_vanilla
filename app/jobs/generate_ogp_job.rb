class GenerateOgpJob < ApplicationJob
  queue_as :default

  def perform(snake_id)
    Rails.logger.info("🐍 OGP生成ジョブ開始 #{snake_id}")

    bun_path = "/root/.bun/bin/bun"
    script_path = Rails.root.join("app/lib/scripts/generate_ogp_once.ts").to_s

    success = system(bun_path, "run", script_path, snake_id.to_s)
    Rails.logger.info("✅ bun実行結果: #{success}")
    Rails.logger.error("❌ bun実行失敗") unless success
  end
end
