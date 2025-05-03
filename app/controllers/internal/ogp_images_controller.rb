class Internal::OgpImagesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    snake = ::Snake.find_by(id: params[:id])

    unless snake
      render json: { error: "Snake not found" }, status: :not_found and return
    end

    if params[:image].present?
      # 🔽 既存画像を明示的に削除してからアップロード（PurgeJobを防ぐ）
      snake.image.detach if snake.image.attached?

      # 🔽 添付
      snake.image.attach(params[:image])

      # 🔽 公開URLを返す（Cloudflare R2 の pub URL + ActiveStorageのキー）
      public_url = "https://pub-1907a15a98994ec0915c588d7425f466.r2.dev/#{snake.image.key}"

      render json: { url: public_url }, status: :ok
    else
      render json: { error: "No image provided" }, status: :bad_request
    end
  end
end
