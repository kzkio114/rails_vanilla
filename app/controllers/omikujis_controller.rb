class OmikujisController < ApplicationController
  def index
    # 保存された履歴を取得（最大3件）
    @saved_histories = OmikujiHistory.order(created_at: :desc).limit(3)

    # セッションに保存された蛇を取得、なければランダムに選ぶ
    @snake = if session[:snake_id]
               Snake.includes(:snake_colors).find_by(id: session[:snake_id])
             else
               Snake.random_snake.tap { |snake| session[:snake_id] = snake.id }
             end
  end

  def draw
    # ランダムな蛇を取得
    snake = Snake.random_snake
    session[:snake_id] = snake.id

    # 履歴に追加
    OmikujiHistory.create!(snake: snake)

    # 履歴が3件を超えた場合、古いものから削除
    OmikujiHistory.order(created_at: :asc).limit(OmikujiHistory.count - 3).destroy_all if OmikujiHistory.count > 3

    redirect_to root_path, notice: "#{snake.name} が選ばれました！"
  end

  def reset
    # セッションをリセット
    session.delete(:snake_id)

    # 履歴もリセット（すべて削除）
    OmikujiHistory.delete_all

    redirect_to root_path, notice: "履歴をリセットしました！"
  end
end
