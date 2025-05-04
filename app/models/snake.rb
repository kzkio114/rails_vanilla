class Snake < ApplicationRecord
  belongs_to :omikuji_result
  has_many :snake_colors, dependent: :destroy

  def self.random_snake
    includes(:omikuji_result, :snake_colors).order("RANDOM()").first
  end
end
