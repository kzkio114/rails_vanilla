class CreateSnakeColors < ActiveRecord::Migration[8.0]
  def change
    create_table :snake_colors do |t|
      t.references :snake, null: false, foreign_key: true
      t.string :layer
      t.string :color

      t.timestamps
    end
  end
end
