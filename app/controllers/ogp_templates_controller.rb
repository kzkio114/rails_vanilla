class OgpTemplatesController < ApplicationController
  def show
    @snake = Snake.find_by(id: params[:id]) || Snake.first # nil回避
  end
end

