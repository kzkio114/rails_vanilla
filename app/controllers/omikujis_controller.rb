class OmikujisController < ApplicationController
  def index
    # セッションに保存された蛇を取得、なければランダムに選ぶ
    @snake = if session[:snake_id]
               Snake.includes(:snake_colors).find_by(id: session[:snake_id])
             else
               Snake.random_snake.tap { |snake| session[:snake_id] = snake.id }
             end
  end

  def reset
    # セッションをリセットして新しい蛇を選ぶ
    session.delete(:snake_id)
    redirect_to root_path, notice: "もう一度占いを引き直しました！"
  end
end
