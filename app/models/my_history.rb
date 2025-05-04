class MyHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(5) }

  after_create_commit :generate_ogp

  private

  def generate_ogp
    Rails.logger.info("📄 MyHistory作成: Snake##{snake_id} の OGP生成ジョブをキューに追加")
    GenerateOgpJob.perform_later(snake_id)
  end
end
