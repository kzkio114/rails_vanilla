class OmikujisController < ApplicationController
  def index
    @saved_histories = OmikujiHistory.order(created_at: :desc).limit(3)
    @snake = if session[:snake_id]
               Snake.includes(:snake_colors).find_by(id: session[:snake_id])
             else
               Snake.random_snake.tap { |snake| session[:snake_id] = snake.id }
             end
  end

  def draw
    snake = Snake.random_snake
    session[:snake_id] = snake.id
    OmikujiHistory.create!(snake: snake)
    OmikujiHistory.order(created_at: :asc).limit(OmikujiHistory.count - 3).destroy_all if OmikujiHistory.count > 3
    redirect_to root_path, notice: "#{snake.name} が選ばれました！"
  end

  def reset
    session.delete(:snake_id)
    OmikujiHistory.delete_all
    redirect_to root_path, notice: "履歴をリセットしました！"
  end
end
