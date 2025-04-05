class OmikujiHistory < ApplicationRecord
  belongs_to :snake

  scope :recent, -> { order(created_at: :desc).limit(10) }

  broadcasts_to ->(history) { "history-list" },
                inserts_by: :prepend,
                target: "history-list",
                partial: "omikujis/history"

  after_create_commit do
    Rails.logger.info "[Turbo] Broadcast triggered for history ##{id}"
  end
end