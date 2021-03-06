class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :finishing_place
      t.float :score
      t.integer :additional_expense, default: 0
      t.timestamp :finishing_time

      t.timestamps null: false
    end
  end
end
