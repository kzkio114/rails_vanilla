class AddLinesToSnakeColors < ActiveRecord::Migration[8.0]
  def change
    add_column :snake_colors, :horizontal_line, :boolean
    add_column :snake_colors, :vertical_line, :boolean
  end
end
