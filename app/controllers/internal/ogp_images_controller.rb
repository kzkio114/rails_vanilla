class Internal::OgpImagesController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    snake = ::Snake.find_by(id: params[:id])

    unless snake
      render json: { error: "Snake not found" }, status: :not_found and return
    end

    if params[:image].respond_to?(:tempfile)
      snake.image.detach if snake.image.attached?

      snake.image.attach(
        io: params[:image].tempfile,
        filename: "ogp_#{SecureRandom.hex(6)}.png",
        content_type: params[:image].content_type
      )

      public_url = "https://pub-1907a15a98994ec0915c588d7425f466.r2.dev/#{snake.image.key}"

      render json: { url: public_url }, status: :ok
    else
      render json: { error: "No image provided" }, status: :bad_request
    end
  end
end
