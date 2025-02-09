class CreateOmikujiHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :omikuji_histories do |t|
      t.references :snake, null: false, foreign_key: true

      t.timestamps
    end
  end
end
