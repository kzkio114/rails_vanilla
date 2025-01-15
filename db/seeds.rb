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
  { name: "吉", description: "控えめな良い運勢です。" },
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
    name: "アオダイショウ（青大将）",
    omikuji_result_name: "大吉",
    colors: [
      { layer: 1, color: "#4CAF50" },
      { layer: 2, color: "#3e8e41" },
      { layer: 3, color: "#2e7d32" },
      { layer: 4, color: "#1b5e20" },
      { layer: "tail-outer", color: "#2e7d32" }
    ]
  },
  {
    name: "シロマダラ（白斑）",
    omikuji_result_name: "大吉",
    colors: [
      { layer: 1, color: "#FFFFFF" },
      { layer: 2, color: "#DADADA" },
      { layer: 3, color: "#C0C0C0" },
      { layer: 4, color: "#A9A9A9" },
      { layer: "tail-outer", color: "#C0C0C0" }
    ]
  },
  {
    name: "シマヘビ（縞蛇）",
    omikuji_result_name: "中吉",
    colors: [
      { layer: 1, color: "#2196F3" },
      { layer: 2, color: "#1976D2" },
      { layer: 3, color: "#1565C0" },
      { layer: 4, color: "#0D47A1" },
      { layer: "tail-outer", color: "#1565C0" }
    ]
  },
  {
    name: "ジムグリ（地潜）",
    omikuji_result_name: "中吉",
    colors: [
      { layer: 1, color: "#8B0000" },
      { layer: 2, color: "#A52A2A" },
      { layer: 3, color: "#B22222" },
      { layer: 4, color: "#CD5C5C" },
      { layer: "tail-outer", color: "#A52A2A" }
    ]
  },
  {
    name: "タカチホヘビ（高千穂蛇）",
    omikuji_result_name: "小吉",
    colors: [
      { layer: 1, color: "#6A5ACD" },
      { layer: 2, color: "#483D8B" },
      { layer: 3, color: "#7B68EE" },
      { layer: 4, color: "#9370DB" },
      { layer: "tail-outer", color: "#7B68EE" }
    ]
  },
  {
    name: "ヒバカリ（日計）",
    omikuji_result_name: "小吉",
    colors: [
      { layer: 1, color: "#A9A9A9" },
      { layer: 2, color: "#808080" },
      { layer: 3, color: "#696969" },
      { layer: 4, color: "#D3D3D3" },
      { layer: "tail-outer", color: "#808080" }
    ]
  },
  {
    name: "ヤマカガシ（山楝蛇）",
    omikuji_result_name: "吉",
    colors: [
      { layer: 1, color: "#FF4500" },
      { layer: 2, color: "#FFD700" },
      { layer: 3, color: "#FFA500" },
      { layer: 4, color: "#FF6347" },
      { layer: "tail-outer", color: "#FFA500" }
    ]
  },
  {
    name: "ニホンマムシ（蝮）",
    omikuji_result_name: "凶",
    colors: [
      { layer: 1, color: "#8B0000" },
      { layer: 2, color: "#2F4F4F" },
      { layer: 3, color: "#4B0082" },
      { layer: 4, color: "#800000" },
      { layer: "tail-outer", color: "#8B0000" }
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
