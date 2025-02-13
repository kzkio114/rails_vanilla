class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(10) }

  broadcasts_to ->(history) { "history-list" },
                inserts_by: :append,
                target: "history-list",
                partial: "omikujis/history"
end