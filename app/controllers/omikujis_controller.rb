class OmikujisController < ApplicationController
  before_action :set_saved_histories, only: %i[create]

  def create
    @snake = Snake.random_snake
    session[:snake_id] = @snake.id
    OmikujiHistory.create!(snake: @snake)

    OmikujiHistory.order(created_at: :asc).limit(OmikujiHistory.count - 3).destroy_all if OmikujiHistory.count > 3

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "#{@snake.name} が選ばれました！" }
    end
  end

  def reset
    session.delete(:snake_id)
    OmikujiHistory.delete_all
    redirect_to root_path, notice: "履歴をリセットしました！"
  end

  private

  def set_saved_histories
    @saved_histories = OmikujiHistory.order(created_at: :desc).limit(3)
  end
end
