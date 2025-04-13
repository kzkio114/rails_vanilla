class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(100000) }

  broadcasts_to ->(history) { "public-history" },
    inserts_by: :append,
    target: "public-history",
    partial: "omikujis/history_item"
end