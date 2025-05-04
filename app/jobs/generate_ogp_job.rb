class GenerateOgpJob < ApplicationJob
  queue_as :default

  def perform(snake_id)
    Rails.logger.info("🐍 OGP生成ジョブ開始 #{snake_id}")
    bun_path = "/root/.bun/bin/bun"
    success = system(bun_path, "run", "app/lib/tasks/generate_ogp_once.ts", snake_id.to_s)
    Rails.logger.info("✅ bun実行結果: #{success}")
  end
end
