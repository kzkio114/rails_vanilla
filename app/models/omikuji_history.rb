class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(10) }

  broadcasts_to ->(_) { "public-history" },
    inserts_by: :replace,
    target: "public-history-list",
    partial: "omikujis/history"
end
