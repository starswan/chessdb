class AddPlayerRatingsToGame < ActiveRecord::Migration[4.2]
  def change
    change_table :games do |t|
      t.integer :white_elo, null: false
      t.integer :black_elo, null: false
    end
  end
end
