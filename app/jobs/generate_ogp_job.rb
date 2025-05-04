class GenerateOgpJob < ApplicationJob
  queue_as :default

  def perform(snake_id)
    # Fly 上で動作する Bun Worker に SolidQueue を通じて Snake ID を渡すだけでOK
    # Worker 側が ogp_templates/#{snake_id} を開いてスクリーンショットを Rails に POST する
    puts "📤 OGP生成ジョブを Snake##{snake_id} に対して実行"
    # ※実処理は Bun 側で行われる（Rails は enqueue だけ）
  end
end
