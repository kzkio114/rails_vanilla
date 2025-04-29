class ModalsController < ApplicationController

  def create
    @css_class = ["style-red", "style-blue", "style-green"].sample
  end

  def destroy
    @saved_histories = OmikujiHistory.recent
  end
end
