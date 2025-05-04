class Snake < ApplicationRecord
  belongs_to :omikuji_result
  has_many :snake_colors, dependent: :destroy

  def self.random_snake
    includes(:omikuji_result, :snake_colors).order("RANDOM()").first
  end

  has_one_attached :image

  after_create_commit { GenerateOgpJob.perform_later(id) }
end
