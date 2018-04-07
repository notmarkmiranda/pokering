class AddBuyInToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :buy_in, :integer, default: 0
  end
end
