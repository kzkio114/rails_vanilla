class TopsController < ApplicationController
  def index
    @recent_histories = OmikujiHistory.includes(:snake).order(created_at: :desc).limit(10)
  end
end
