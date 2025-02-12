class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :saved, -> { where(saved: true).order(created_at: :desc).limit(10) }

  broadcasts_to ->(history) { "history_list" }, inserts_by: :append, target: "history-list"
end