class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(100000) }

  broadcasts_to ->(_) { "public-history" },
    inserts_by: :replace,
    target: "public-history-list",
    partial: "omikujis/history_item"
end