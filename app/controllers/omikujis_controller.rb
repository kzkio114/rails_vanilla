class OmikujisController < ApplicationController
  def index
    @snake = Snake.includes(:omikuji_result, :snake_colors).order("RANDOM()").first
  end
end
