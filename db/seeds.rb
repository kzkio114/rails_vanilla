# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# おみくじ結果を作成
omikuji_results = [
  { name: "大吉", description: "非常に良い運勢です！" },
  { name: "中吉", description: "良いことが起こりそうです。" },
  { name: "小吉", description: "少しだけ良いことがあるかも。" },
  { name: "凶", description: "注意が必要です。" },
]

omikuji_results.each do |result|
  OmikujiResult.find_or_create_by!(name: result[:name]) do |omikuji|
    omikuji.description = result[:description]
  end
end

# 蛇のデータを作成
snakes_data = [
  {
    name: "緑の蛇",
    omikuji_result_name: "大吉",
    colors: [
      { layer: 1, color: "#4CAF50" },
      { layer: 2, color: "#3e8e41" },
      { layer: 3, color: "#2e7d32" },
      { layer: 4, color: "#1b5e20" },
      { layer: "tail-outer", color: "#1b5e20" } # 修正
    ]
  },
  {
    name: "青の蛇",
    omikuji_result_name: "中吉",
    colors: [
      { layer: 1, color: "#2196F3" },
      { layer: 2, color: "#1976D2" },
      { layer: 3, color: "#1565C0" },
      { layer: 4, color: "#0D47A1" },
      { layer: "tail-outer", color: "#0D47A1" } # 修正
    ]
  },
  {
    name: "赤の蛇",
    omikuji_result_name: "小吉",
    colors: [
      { layer: 1, color: "#F44336" },
      { layer: 2, color: "#E53935" },
      { layer: 3, color: "#D32F2F" },
      { layer: 4, color: "#B71C1C" },
      { layer: "tail-outer", color: "#B71C1C" } # 修正
    ]
  },
  {
    name: "黄色の蛇",
    omikuji_result_name: "凶",
    colors: [
      { layer: 1, color: "#FFEB3B" },
      { layer: 2, color: "#FBC02D" },
      { layer: 3, color: "#F9A825" },
      { layer: 4, color: "#F57F17" },
      { layer: "tail-outer", color: "#F57F17" } # 修正
    ]
  }
]

snakes_data.each do |snake_data|
  omikuji_result = OmikujiResult.find_by!(name: snake_data[:omikuji_result_name])
  snake = Snake.find_or_create_by!(name: snake_data[:name], omikuji_result: omikuji_result)

  snake_data[:colors].each do |color_data|
    SnakeColor.find_or_create_by!(snake: snake, layer: color_data[:layer]) do |snake_color|
      snake_color.color = color_data[:color]
    end
  end
end


puts "Seeding completed successfully!"
