class CreateSnakes < ActiveRecord::Migration[8.0]
  def change
    create_table :snakes do |t|
      t.string :name
      t.references :omikuji_result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
