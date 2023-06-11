class AddPgnToGames < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.string :pgn, limit: 1024, null: false
    end
  end
end
