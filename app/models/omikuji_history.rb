class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(100000) }


  broadcasts_to ->(_) { "public-history" },
  inserts_by: :prepend,
  target: "public-history-list",
  partial: "omikujis/history_item"

  broadcasts_to ->(_) { "my-history" },
  inserts_by: :prepend,
  target: "my-history-list",
  partial: "omikujis/history_item"
end