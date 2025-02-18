class MyHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(5) }
end
