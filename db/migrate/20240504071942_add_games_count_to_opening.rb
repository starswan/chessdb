class AddGamesCountToOpening < ActiveRecord::Migration[6.1]
  def change
    change_table :openings do |t|
      t.integer :games_count, null: false, default: 0
    end
    ChessOpening.find_each do |co|
      ChessOpening.reset_counters(co.id, :games_count)
    end
  end
end
