class OmikujiResult < ApplicationRecord
  has_many :snakes, dependent: :destroy
end
