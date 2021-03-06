class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :season, foreign_key: true
      t.date :date
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end
