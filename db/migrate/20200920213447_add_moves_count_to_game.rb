class AddMovesCountToGame < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.integer :number_of_moves, null: false, limit: 2
    end
    change_table :players do |t|
      t.integer :white_games_count, limit: 2, null: false, default: 0
      t.integer :black_games_count, limit: 2, null: false, default: 0
    end
  end
end
