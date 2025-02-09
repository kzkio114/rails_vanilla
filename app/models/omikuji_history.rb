class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :saved, -> { where(saved: true).order(created_at: :desc).limit(3) }
end
