class Snake < ApplicationRecord
  belongs_to :omikuji_result
  has_many :snake_colors, dependent: :destroy

  has_one_attached :image

end
