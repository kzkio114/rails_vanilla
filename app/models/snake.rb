class Snake < ApplicationRecord
  belongs_to :omikuji_result
  has_many :snake_colors, dependent: :destroy

  has_one_attached :image

  # ランダムな蛇を取得（関連データも含めて）
  def self.random_snake
    includes(:omikuji_result, :snake_colors).order("RANDOM()").first
  end

  # Snake作成後にOGP生成ジョブを実行
  after_create_commit do
    Rails.logger.info "🐍 Snake ##{id} が作成されました → OGPジョブ実行"
    GenerateOgpJob.perform_later(id)
  end
end
