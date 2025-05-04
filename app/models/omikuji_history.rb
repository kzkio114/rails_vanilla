class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  has_one_attached :image

  scope :recent, -> { order(created_at: :desc).limit(10) }


  broadcasts_to ->(_) { "public-history" },
  inserts_by: :prepend,
  target: "public-history-list",
  partial: "omikujis/history_item"
end