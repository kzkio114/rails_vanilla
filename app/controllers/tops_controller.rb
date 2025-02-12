class TopsController < ApplicationController
  def index
    @saved_histories = OmikujiHistory.order(created_at: :desc).limit(10)
  end
end
