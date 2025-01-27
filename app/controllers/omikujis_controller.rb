class OmikujisController < ApplicationController
  def index
    @snake = Snake.random_snake
  end
end
