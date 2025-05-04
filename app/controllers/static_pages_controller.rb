class StaticPagesController < ApplicationController
  def privacy
    render layout: false if turbo_frame_request?
  end
end
