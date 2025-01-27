class AddCircleToSnakeColors < ActiveRecord::Migration[8.0]
  def change
    add_column :snake_colors, :circle, :boolean
  end
end
