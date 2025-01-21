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
  { name: "大大吉", description: "かなり珍しい良い運勢です！" },
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
    name: "アオダイショウ（アルビノ）",
    omikuji_result_name: "大大吉",
    colors: [
      { layer: 1, color: "#FFFFFF", horizontal_line: false, vertical_line: false},
      { layer: 2, color: "#FFFFFF", horizontal_line: false, vertical_line: false },
      { layer: 3, color: "#FFFFFF", horizontal_line: false, vertical_line: false },
      { layer: 4, color: "#FFFFFF", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#FFFFFF", horizontal_line: false, vertical_line: false }
    ]
  },
  {
    name: "アオダイショウ（青大将）",
    omikuji_result_name: "大吉",
    colors: [
      { layer: 1, color: "#4CAF50", horizontal_line: false, vertical_line: false },
      { layer: 2, color: "#3e8e41", horizontal_line: false, vertical_line: false},
      { layer: 3, color: "#2e7d32", horizontal_line: false, vertical_line: false },
      { layer: 4, color: "#1b5e20", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#2e7d32", horizontal_line: false, vertical_line: false }
    ]
  },
  {
    name: "シロマダラ（白斑）",
    omikuji_result_name: "大吉",
    colors: [
      { layer: 1, color: "#FFFF", horizontal_line: false, vertical_line: true },
      { layer: 2, color: "#FFFF", horizontal_line: false, vertical_line: true },
      { layer: 3, color: "#FFFF", horizontal_line: false, vertical_line: true },
      { layer: 4, color: "#FFFF", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#FFFF", horizontal_line: false, vertical_line: false}
    ]
  },
  {
    name: "シマヘビ（縞蛇）",
    omikuji_result_name: "中吉",
    colors: [
      { layer: 1, color: "#2196F3", horizontal_line: true, vertical_line: false },
      { layer: 2, color: "#1976D2", horizontal_line: true, vertical_line: false },
      { layer: 3, color: "#1565C0", horizontal_line: true, vertical_line: false },
      { layer: 4, color: "#0D47A1", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#1565C0", horizontal_line: false , vertical_line: false }
    ]
  },
  {
    name: "ジムグリ（地潜）",
    omikuji_result_name: "中吉",
    colors: [
      { layer: 1, color: "#6A3427", horizontal_line: false, vertical_line: false },
      { layer: 2, color: "#6A3427", horizontal_line: false, vertical_line: false },
      { layer: 3, color: "#6A3427", horizontal_line: false, vertical_line: false },
      { layer: 4, color: "#6A3427", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#6A3427", horizontal_line: false, vertical_line: false }
    ]
  },
  {
    name: "タカチホヘビ（高千穂蛇）",
    omikuji_result_name: "小吉",
    colors: [
      { layer: 1, color: "#333132", horizontal_line: false, vertical_line: false },
      { layer: 2, color: "#333132", horizontal_line: false, vertical_line: false },
      { layer: 3, color: "#333132", horizontal_line: false, vertical_line: false },
      { layer: 4, color: "#333132", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#333132", horizontal_line: false, vertical_line: false }
    ]
  },
  {
    name: "ヒバカリ（日計）",
    omikuji_result_name: "小吉",
    colors: [
      { layer: 1, color: "#958C59", horizontal_line: false, vertical_line: false },
      { layer: 2, color: "#958C59", horizontal_line: false, vertical_line: false },
      { layer: 3, color: "#958C59", horizontal_line: false, vertical_line: false },
      { layer: 4, color: "#958C59", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#958C59", horizontal_line: false, vertical_line: false }
    ]
  },
  {
    name: "ヤマカガシ（山楝蛇）",
    omikuji_result_name: "吉",
    colors: [
      { layer: 1, color: "#FF4500", horizontal_line: false, vertical_line: false },
      { layer: 2, color: "#FFD700", horizontal_line: false, vertical_line: false },
      { layer: 3, color: "#FFA500", horizontal_line: false, vertical_line: false },
      { layer: 4, color: "#FF6347", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#FFA500", horizontal_line: false, vertical_line: false }
    ]
  },
  {
    name: "ニホンマムシ（蝮）",
    omikuji_result_name: "凶",
    colors: [
      { layer: 1, color: "#948060", horizontal_line: false, vertical_line: true },
      { layer: 2, color: "#948060", horizontal_line: false, vertical_line: true },
      { layer: 3, color: "#948060", horizontal_line: false, vertical_line: true },
      { layer: 4, color: "#948060", horizontal_line: false, vertical_line: false },
      { layer: "tail-outer", color: "#948060", horizontal_line: false, vertical_line: false }
    ]
  }
]

snakes_data.each do |snake_data|
  omikuji_result = OmikujiResult.find_by!(name: snake_data[:omikuji_result_name])
  snake = Snake.find_or_create_by!(name: snake_data[:name], omikuji_result: omikuji_result)

  snake_data[:colors].each do |color_data|
    SnakeColor.find_or_create_by!(snake: snake, layer: color_data[:layer]) do |snake_color|
      snake_color.color = color_data[:color]
      snake_color.horizontal_line = color_data[:horizontal_line]
      snake_color.vertical_line = color_data[:vertical_line]
      snake_color.save!
    end
  end
end

puts "seedが完了しました！"
