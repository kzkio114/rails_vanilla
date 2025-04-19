class TopsController < ApplicationController
  def index
    @saved_histories = OmikujiHistory.recent
  end
end
