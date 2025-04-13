class OmikujisController < ApplicationController
  before_action :set_saved_histories, only: %i[index create reset]

  def index
  end

  def create
    @snake = Snake.random_snake
    session[:snake_id] = @snake.id

    @history = OmikujiHistory.create!(snake: @snake)

    # MyHistoryを更新
    MyHistory.create!(snake: @snake)
    my_history_count = MyHistory.count
    if my_history_count > 5
      MyHistory.order(created_at: :asc).limit(my_history_count - 5).destroy_all
    end

    @saved_histories = OmikujiHistory.recent
    @my_histories = MyHistory.recent

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "#{@snake.name} が選ばれました！" }
    end
  end

  def reset
    session.delete(:snake_id)

    OmikujiHistory.delete_all
    MyHistory.delete_all

    @saved_histories = []
    @my_histories = []

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "履歴をリセットしました！" }
    end
  end

  private

  def set_saved_histories
    @saved_histories = OmikujiHistory.recent
    @my_histories = MyHistory.recent
  end
end
